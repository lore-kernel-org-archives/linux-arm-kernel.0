From: mka@chromium.org (Matthias Kaehlcke)
Date: Tue, 2 May 2017 11:52:12 -0700
Subject: [PATCH] arm64: Fix multiple 'asm-operand-widths' warnings
In-Reply-To: <20170502172948.GE28132@leverpostej>
References: <20170501212622.153720-1-mka@chromium.org>
 <20170502172948.GE28132@leverpostej>
Message-ID: <20170502185212.GY128305@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

El Tue, May 02, 2017 at 06:29:48PM +0100 Mark Rutland ha dit:

> On Mon, May 01, 2017 at 02:26:22PM -0700, Matthias Kaehlcke wrote:
> > diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> > index 5308d696311b..7db143689694 100644
> > --- a/arch/arm64/include/asm/uaccess.h
> > +++ b/arch/arm64/include/asm/uaccess.h
> > @@ -302,7 +302,7 @@ do {									\
> >  	"	.previous\n"						\
> >  	_ASM_EXTABLE(1b, 3b)						\
> >  	: "+r" (err)							\
> > -	: "r" (x), "r" (addr), "i" (-EFAULT))
> > +	: "r" ((__u64)x), "r" (addr), "i" (-EFAULT))
> >  
> 
> For reference, do you have the warning for this case to hand?
> 
> In __put_user_err() we make __pu_val the same type as *ptr, then we
> switch on sizeof(*ptr), and pass __pu_val to __put_user_asm(), as x.
> For cases 1, 2, and 4, we use "%w" as the register template.
> 
> So I can't see why we'd  need this cast in __put_user_err().
> 
> I must be missing something.

This is one of many instances:

./include/linux/pagemap.h:554:10: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
                return __put_user(0, end);
                       ^
./arch/arm64/include/asm/uaccess.h:338:2: note: expanded from macro '__put_user'
        __put_user_err((x), (ptr), __pu_err);                           \
        ^
./arch/arm64/include/asm/uaccess.h:326:38: note: expanded from macro '__put_user_err'
                __put_user_asm("str", "sttr", "%", __pu_val, (ptr),     \
                                                   ^
./include/linux/pagemap.h:554:10: note: use constraint modifier "w"
./arch/arm64/include/asm/uaccess.h:338:2: note: expanded from macro '__put_user'
        __put_user_err((x), (ptr), __pu_err);                           \
        ^
./arch/arm64/include/asm/uaccess.h:326:34: note: expanded from macro '__put_user_err'
                __put_user_asm("str", "sttr", "%", __pu_val, (ptr),     \
                                               ^

'end' is a char pointer, it is not clear to me why we would end up in
the width == 8 branch.

Matthias
