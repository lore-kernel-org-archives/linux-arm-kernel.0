From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 May 2017 22:37:02 +0200
Subject: arm64 test_user_copy crash on copy_from_user(uptr, kptr, size)
In-Reply-To: <CAGXu5jLy66PXCG99xmSNG-C7F8OjCrOm5WaKEWcSV9SYB2gAqA@mail.gmail.com>
References: <CAK8P3a1tyU8J4VEWVwLOHWM+of9bnWvm+SXBxkfsZA7yfEei9A@mail.gmail.com>
 <CAGXu5jLy66PXCG99xmSNG-C7F8OjCrOm5WaKEWcSV9SYB2gAqA@mail.gmail.com>
Message-ID: <CAK8P3a2pQ_enY-Vp5wBBSJxdRb3G8HWf6MAazkUez0vam28E+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 26, 2017 at 5:41 PM, Kees Cook <keescook@chromium.org> wrote:
> On Fri, May 26, 2017 at 8:24 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> A kselftest run on arm64 on an older 4.4.y stable kernel ran into an
>> unexpectedly trapping user space access:
>>
>> [ 1277.857738] Internal error: Accessing user space memory outside
>> uaccess.h routines: 96000045 [#1] PREEMPT SMP
>>
>> Apparently the same thing happens on x86 as well, and it still happens on
>> the latest kernels, see https://bugs.linaro.org/show_bug.cgi?id=3011
>>
>> The problem here is this test
>>
>>        ret |= test(!copy_from_user(bad_usermem, (char __user *)kmem,
>>                                    PAGE_SIZE),
>>                    "illegal reversed copy_from_user passed");
>
> Hi! Yes, I removed that test from the current code:
>
> #if 0
>         /*
>          * When running with SMAP/PAN/etc, this will Oops the kernel
>          * due to the zeroing of userspace memory on failure. This needs
>          * to be tested in LKDTM instead, since this test module does not
>          * expect to explode.
>          */
>         ret |= test(!copy_from_user(bad_usermem, (char __user *)kmem,
>                                     PAGE_SIZE),
>                     "illegal reversed copy_from_user passed");
> #endif
>
> We can send a patch to -stable?

Ok, good. I've prepared a backport since it doesn't apply cleanly otherwise.

        Arnd
