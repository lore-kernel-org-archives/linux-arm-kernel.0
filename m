From: keescook@chromium.org (Kees Cook)
Date: Fri, 26 May 2017 08:41:55 -0700
Subject: arm64 test_user_copy crash on copy_from_user(uptr, kptr, size)
In-Reply-To: <CAK8P3a1tyU8J4VEWVwLOHWM+of9bnWvm+SXBxkfsZA7yfEei9A@mail.gmail.com>
References: <CAK8P3a1tyU8J4VEWVwLOHWM+of9bnWvm+SXBxkfsZA7yfEei9A@mail.gmail.com>
Message-ID: <CAGXu5jLy66PXCG99xmSNG-C7F8OjCrOm5WaKEWcSV9SYB2gAqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 26, 2017 at 8:24 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> A kselftest run on arm64 on an older 4.4.y stable kernel ran into an
> unexpectedly trapping user space access:
>
> [ 1277.857738] Internal error: Accessing user space memory outside
> uaccess.h routines: 96000045 [#1] PREEMPT SMP
>
> Apparently the same thing happens on x86 as well, and it still happens on
> the latest kernels, see https://bugs.linaro.org/show_bug.cgi?id=3011
>
> The problem here is this test
>
>        ret |= test(!copy_from_user(bad_usermem, (char __user *)kmem,
>                                    PAGE_SIZE),
>                    "illegal reversed copy_from_user passed");

Hi! Yes, I removed that test from the current code:

#if 0
        /*
         * When running with SMAP/PAN/etc, this will Oops the kernel
         * due to the zeroing of userspace memory on failure. This needs
         * to be tested in LKDTM instead, since this test module does not
         * expect to explode.
         */
        ret |= test(!copy_from_user(bad_usermem, (char __user *)kmem,
                                    PAGE_SIZE),
                    "illegal reversed copy_from_user passed");
#endif

We can send a patch to -stable?

-Kees

>
> where the destination kernel pointer intentionally points into user space
> memory, while copy_from_user checks the second argument for being
> a valid user space, which it also is not.:
>
> static inline unsigned long __must_check copy_from_user(void *to,
> const void __user *from, unsigned long n)
> {
>         unsigned long res = n;
>         kasan_check_write(to, n);
>
>         if (access_ok(VERIFY_READ, from, n)) {
>                 check_object_size(to, n, false);
>                 res = __arch_copy_from_user(to, from, n);
>         }
>         if (unlikely(res))
>                 memset(to + (n - res), 0, res);
>         return res;
> }
>
> The memset here will now try to clear user space data, and the
> architecture notices that the fault did not come from a proper
> uaccess function.
>
> I think this will only happen when CONFIG_ARM64_PAN,
>  X86_SMAP or an equivalent feature on another architecture is
> enabled, otherwise we just do the access anyway. I don't have
> a good idea for avoiding the problem though, other than
> removing the specific test that causes it.
>
>        Arnd



-- 
Kees Cook
Pixel Security
