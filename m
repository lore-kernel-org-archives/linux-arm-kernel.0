From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Jan 2016 11:30:57 +0000
Subject: linux-next: build failure after merge of the aio tree
In-Reply-To: <20160127134024.0fababf6@canb.auug.org.au>
References: <20160112164034.0fe945a7@canb.auug.org.au>
 <20160112163835.GD347@kvack.org>
 <20160127134024.0fababf6@canb.auug.org.au>
Message-ID: <20160129113056.GP10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 01:40:24PM +1100, Stephen Rothwell wrote:
> Hi Benjamin,
> 
> On Tue, 12 Jan 2016 11:38:35 -0500 Benjamin LaHaise <bcrl@kvack.org> wrote:
> >
> > On Tue, Jan 12, 2016 at 04:40:34PM +1100, Stephen Rothwell wrote:
> > > 
> > > After merging the aio tree, today's linux-next build (arm
> > > multi_v7_defconfig) failed like this:
> > > 
> > > fs/built-in.o: In function `aio_thread_op_foo_at':
> > > file.c:(.text+0x43808): undefined reference to `__get_user_bad'
> > > file.c:(.text+0x43838): undefined reference to `__get_user_bad'  
> > 
> > This is very strange.  It seems to imply that __get_user() doesn't 
> > handle 64 bit values, which is completely broken behaviour on the 
> > architecture's part if true.  Can any ARM folks comment on the right 
> > fix here?
> 
> Well, probably only if you cc them :-)
> 
> Indeed, __get_user on arm does not handle 64 bit objects, where as
> get_user does ...

I believe adding 64-bit support to __get_user() is going to be a really
painful exercise.  It took long enough to make get_user() accept it
without creating any new warnings, and then bug fix it for big endian.
__get_user() has the added complexity that it's inline assembler, and
we can't play the same games that we used in __get_user().

It's not a simple case of:

 #define __get_user_err(x, ptr, err)					\
 do {									\
 	unsigned long __gu_addr = (unsigned long)(ptr); 		\
-	unsigned long __gu_val; 					\
+	unsigned long long __gu_val; 					\
 	unsigned int __ua_flags;					\
 	__chk_user_ptr(ptr);						\
 	might_fault();							\
 	__ua_flags = uaccess_save_and_enable(); 			\
 	switch (sizeof(*(ptr))) {					\
 	case 1: __get_user_asm_byte(__gu_val, __gu_addr, err);	break;	\
 	case 2: __get_user_asm_half(__gu_val, __gu_addr, err);	break;	\
 	case 4: __get_user_asm_word(__gu_val, __gu_addr, err);	break;	\
+	case 8: __get_user_asm_dword(__gu_val, __gu_addr, err); break;	\
 	default: (__gu_val) = __get_user_bad(); 			\
 	}								\
 	uaccess_restore(__ua_flags);					\
 	(x) = (__typeof__(*(ptr)))__gu_val;				\
 } while (0)

as, while that works for integer 'x', it doesn't work when 'x' is a
pointer type, as the cast on the last line creates a GCC warning
about casting to a different size.

You can't move the cast into the switch to eliminate that, because
GCC still warns even though the code is unreachable.  Same problem
exists if you move the variable declaration inside the switch.

> Background: new aio code is adding __get_user() calls referencing 64
> bit quantities (__u64 and __s64).

There's lots more architectures which do not support 64-bit get_user()
_or_ __get_user(): avr32, blackfin, metag for example, and m68k which
has this interesting thing "/* case 8: disabled because gcc-4.1 has a
broken typeof \" in its *get_user() implementation.

Even x86-32 doesn't support it:

#define __get_user(x, ptr)                                              \
        __get_user_nocheck((x), (ptr), sizeof(*(ptr)))

#define __get_user_nocheck(x, ptr, size)                                \
({                                                                      \
        int __gu_err;                                                   \
        unsigned long __gu_val;                                         \
        __uaccess_begin();                                              \
        __get_user_size(__gu_val, (ptr), (size), __gu_err, -EFAULT);    \
        __uaccess_end();                                                \
        (x) = (__force __typeof__(*(ptr)))__gu_val;                     \
        __builtin_expect(__gu_err, 0);                                  \
})

#define __get_user_size(x, ptr, size, retval, errret)                   \
do {                                                                    \
        retval = 0;                                                     \
        __chk_user_ptr(ptr);                                            \
        switch (size) {                                                 \
...
        case 8:                                                         \
                __get_user_asm_u64(x, ptr, retval, errret);             \
                break;                                                  \
        default:                                                        \
                (x) = __get_user_bad();                                 \
        }                                                               \
} while (0)

#ifdef CONFIG_X86_32
#define __get_user_asm_u64(x, ptr, retval, errret)      (x) = __get_user_bad()
#define __get_user_asm_ex_u64(x, ptr)                   (x) = __get_user_bad()

Note that __get_user_nocheck() above always uses a 32-bit integer for
__gu_val, so fixing x86-32 will not be a case of just providing a
better __get_user_asm_u64() - it's the same problem that I have on ARM.

The problem for 32-bit architectures is being able to cope sanely with:
* different endians on the same arch
* gcc warning about casting to different sizes, even when the code is
  unreachable
* preserving proper and correct typechecking in get_user() and friends

So, I suspect if AIO were to run a test build on x86-32, they would find
the same errors.

Anyone working on this needs to ensure that any implementation builds
without warning on all of these:

int test_8(unsigned char *v, unsigned char *p)
{
        return __get_user(*v, p);
}

int test_8_constp(unsigned char *v, const unsigned char *p)
{
        return __get_user(*v, p);
}

int test_8_volatilep(unsigned char *v, volatile unsigned char *p)
{
        return __get_user(*v, p);
}

int test_16(unsigned short *v, unsigned short *p)
{
        return __get_user(*v, p);
}

int test_16_constp(unsigned short *v, const unsigned short *p)
{
        return __get_user(*v, p);
}

int test_32(unsigned int *v, unsigned int *p)
{
        return __get_user(*v, p);
}

int test_32_constp(unsigned int *v, const unsigned int *p)
{
        return __get_user(*v, p);
}

int test_64(unsigned long long *v, unsigned long long *p)
{
        return __get_user(*v, p);
}

int test_64_constp(unsigned long long *v, const unsigned long long *p)
{
        return __get_user(*v, p);
}

int test_ptr(unsigned int **v, unsigned int **p)
{
        return __get_user(*v, p);
}

int test_const(unsigned int *v, const unsigned int *p)
{
        return __get_user(*v, p);
}

int test_64_narrow(unsigned long *v, unsigned long long *p)
{
        return __get_user(*v, p);
}

int test_32_wide(unsigned long long *v, unsigned long *p)
{
        return __get_user(*v, p);
}

except for this which must warn:

int test_wrong(char **v, const char **p)
{
        return __get_user(*v, p);
}

which comes from my test set for when get_user() was being worked on.

So, in summary, it seems that the 32-bit architectures I've looked at
so far do not support 64-bit __get_user(), even the popular ones.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
