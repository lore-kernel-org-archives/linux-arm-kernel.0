From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 3 May 2017 11:51:56 +0100
Subject: [PATCH] arm64: Fix multiple 'asm-operand-widths' warnings
In-Reply-To: <20170502185212.GY128305@google.com>
References: <20170501212622.153720-1-mka@chromium.org>
 <20170502172948.GE28132@leverpostej>
 <20170502185212.GY128305@google.com>
Message-ID: <20170503105156.GB4951@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 02, 2017 at 11:52:12AM -0700, Matthias Kaehlcke wrote:
> El Tue, May 02, 2017 at 06:29:48PM +0100 Mark Rutland ha dit:
> > On Mon, May 01, 2017 at 02:26:22PM -0700, Matthias Kaehlcke wrote:
> > > diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> > > index 5308d696311b..7db143689694 100644
> > > --- a/arch/arm64/include/asm/uaccess.h
> > > +++ b/arch/arm64/include/asm/uaccess.h
> > > @@ -302,7 +302,7 @@ do {									\
> > >  	"	.previous\n"						\
> > >  	_ASM_EXTABLE(1b, 3b)						\
> > >  	: "+r" (err)							\
> > > -	: "r" (x), "r" (addr), "i" (-EFAULT))
> > > +	: "r" ((__u64)x), "r" (addr), "i" (-EFAULT))
> > >  
> > 
> > For reference, do you have the warning for this case to hand?
> > 
> > In __put_user_err() we make __pu_val the same type as *ptr, then we
> > switch on sizeof(*ptr), and pass __pu_val to __put_user_asm(), as x.
> > For cases 1, 2, and 4, we use "%w" as the register template.
> > 
> > So I can't see why we'd  need this cast in __put_user_err().
> > 
> > I must be missing something.
> 
> This is one of many instances:
> 
> ./include/linux/pagemap.h:554:10: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
>                 return __put_user(0, end);
>                        ^
> ./arch/arm64/include/asm/uaccess.h:338:2: note: expanded from macro '__put_user'
>         __put_user_err((x), (ptr), __pu_err);                           \
>         ^
> ./arch/arm64/include/asm/uaccess.h:326:38: note: expanded from macro '__put_user_err'
>                 __put_user_asm("str", "sttr", "%", __pu_val, (ptr),     \
>                                                    ^
> ./include/linux/pagemap.h:554:10: note: use constraint modifier "w"
> ./arch/arm64/include/asm/uaccess.h:338:2: note: expanded from macro '__put_user'
>         __put_user_err((x), (ptr), __pu_err);                           \
>         ^
> ./arch/arm64/include/asm/uaccess.h:326:34: note: expanded from macro '__put_user_err'
>                 __put_user_asm("str", "sttr", "%", __pu_val, (ptr),     \
>                                                ^

Thanks for the log above!

> 'end' is a char pointer, it is not clear to me why we would end up in
> the width == 8 branch.

Indeed.

I took a look, and I think the issue is that clang instantiates the
assembly in all cases, producing the warning, *then* optimizes away the
unreachable cases.

If you ask clang to build the following:

----
#define __put_user(val, ptr)						\
do {									\
	__typeof__(*(ptr)) __pu_val = (val);				\
	switch (sizeof(*(ptr))) { 					\
	case 1:								\
		asm volatile ("strb %w1, %0"				\
				: "+Q" (*(ptr)) : "r" (__pu_val));	\
		break;							\
	case 2:								\
		asm volatile ("strh %1, %0"				\
				: "+Q" (*(ptr)) : "r" (__pu_val));	\
		break;							\
	case 4:								\
		asm volatile ("str %1, %0"				\
				: "+Q" (*(ptr)) : "r" (__pu_val));	\
		break;							\
	case 8:								\
		asm volatile ("str %1, %0"				\
				: "+Q" (*(ptr)) : "r" (__pu_val));	\
		break;							\
	}								\
} while (0)

void put_char(char in, char *ptr)
{
	__put_user(in, ptr);
}
----

It complains for all of the unmatched cases:

----
size-switch.c:26:2: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
        __put_user(in, ptr);
        ^
size-switch.c:11:28: note: expanded from macro '__put_user'
                                : "+Q" (*(ptr)) : "r" (__pu_val));      \
                                                       ^
size-switch.c:26:2: note: use constraint modifier "w"
size-switch.c:10:23: note: expanded from macro '__put_user'
                asm volatile ("strh %1, %0"                             \
                                    ^
size-switch.c:26:2: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
        __put_user(in, ptr);
        ^
size-switch.c:15:28: note: expanded from macro '__put_user'
                                : "+Q" (*(ptr)) : "r" (__pu_val));      \
                                                       ^
size-switch.c:26:2: note: use constraint modifier "w"
size-switch.c:14:22: note: expanded from macro '__put_user'
                asm volatile ("str %1, %0"                              \
                                   ^
size-switch.c:26:2: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
        __put_user(in, ptr);
        ^
size-switch.c:19:28: note: expanded from macro '__put_user'
                                : "+Q" (*(ptr)) : "r" (__pu_val));      \
                                                       ^
size-switch.c:26:2: note: use constraint modifier "w"
size-switch.c:18:22: note: expanded from macro '__put_user'
                asm volatile ("str %1, %0"                              \
                                   ^
3 warnings generated.
----

AFAICT, in all other cases where we switch(sizeof(...)), we (will) use
an explicit cast on the parameter, which placates clang.

I think the best option is to get rid of __pu_val, and have an explicit
cast of x in each case of the switch statement. I'll add that to my asm
fixups series, with your Reported-by.

Thanks,
Mark.
