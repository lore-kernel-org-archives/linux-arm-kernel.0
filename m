From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 4 Feb 2016 14:12:53 +0000
Subject: linux-next: build failure after merge of the aio tree
In-Reply-To: <20160204140822.GB16315@kvack.org>
References: <20160112164034.0fe945a7@canb.auug.org.au>
 <20160112163835.GD347@kvack.org>
 <20160127134024.0fababf6@canb.auug.org.au>
 <20160129113056.GP10826@n2100.arm.linux.org.uk>
 <CAMuHMdUy-cqeN8COO4rdpY-mOH+6gth40wB31-edkj8CO5PFCw@mail.gmail.com>
 <20160204131959.6695c7bf@canb.auug.org.au>
 <20160204134142.GA16315@kvack.org>
 <20160204135056.GE10826@n2100.arm.linux.org.uk>
 <20160204140822.GB16315@kvack.org>
Message-ID: <20160204141253.GF10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 09:08:22AM -0500, Benjamin LaHaise wrote:
> On Thu, Feb 04, 2016 at 01:50:56PM +0000, Russell King - ARM Linux wrote:
> > > I am still convinced that this is an architecture issue.  Given that 64 bit 
> > > values work in the *get_user implementations on other architectures, I see 
> > > no reason there should need to be a workaround for this in common code.
> > 
> > So you're happy to break x86-32 then...
> 
> x86-32 works fine.

Let me repeat the quote from my previous email:

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
        case 1:                                                         \
                __get_user_asm(x, ptr, retval, "b", "b", "=q", errret); \
                break;                                                  \
        case 2:                                                         \
                __get_user_asm(x, ptr, retval, "w", "w", "=r", errret); \
                break;                                                  \
        case 4:                                                         \
                __get_user_asm(x, ptr, retval, "l", "k", "=r", errret); \
                break;                                                  \
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
#else
#define __get_user_asm_u64(x, ptr, retval, errret) \
         __get_user_asm(x, ptr, retval, "q", "", "=r", errret)
#define __get_user_asm_ex_u64(x, ptr) \
         __get_user_asm_ex(x, ptr, "q", "", "=r")
#endif

Hence, __get_user() on x86-32 with a 64-bit quantity results in
__get_user_bad() being called, which is an undefined function.
Only if you build with x86-64 support enabled (iow, CONFIG_X86_32 not
defined) then you get the 64-bit __get_user() support.

Given this, I fail to see how x86-32 can possibly work.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
