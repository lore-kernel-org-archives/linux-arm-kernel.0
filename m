From: keescook@chromium.org (Kees Cook)
Date: Tue, 7 Feb 2017 10:27:52 -0800
Subject: [PATCH] arm64: uaccess: consistently check object sizes
In-Reply-To: <1486470835-25956-1-git-send-email-mark.rutland@arm.com>
References: <1486470835-25956-1-git-send-email-mark.rutland@arm.com>
Message-ID: <CAGXu5jJ2UR4FVikrFgmkNEL81LYr+Htw0OokZFmfJEKq5BuQOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 7, 2017 at 4:33 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> Currently in arm64's copy_{to,from}_user, we only check the
> source/destination object size if access_ok() tells us the user access
> is permissible.
>
> However, in copy_from_user() we'll subsequently zero any remainder on
> the destination object. If we failed the access_ok() check, that applies
> to the whole object size, which we didn't check.
>
> To ensure that we catch that case, this patch hoists check_object_size()
> to the start of copy_from_user(), matching __copy_from_user() and
> __copy_to_user(). To make all of our uaccess copy primitives consistent,
> the same is done to copy_to_user().
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/uaccess.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Kees, Was there any rationale for not handling the !access_ok() case?

So, when I pulled the similar code for other architectures out of PaX,
I retained this pattern. When I reworked x86 and added arm64, it
seemed sensible to optimize the check to follow access_ok(), since if
that failed, why do the checking work... but yes, in copy_from_user(),
we'll wipe the destination without having done the check. Ewww.
Excellent catch.

> I note that other architectures follow the same pattern, and may need a similar
> fixup.

I would agree. It will need some fiddling, though. If you look at ARM,
it's implicitly after the access_ok() check because
check_object_size() is only run in __copy_*_user().

(I still think the whole memset(to, 0, n) thing is a bit dangerous...
it's kind of a "write 0 anywhere" primitive if an attacker can control
the kernel address at all...)

-Kees

>
> Thanks,
> Mark.
>
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index 46da3ea..5308d69 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -379,9 +379,9 @@ static inline unsigned long __must_check copy_from_user(void *to, const void __u
>  {
>         unsigned long res = n;
>         kasan_check_write(to, n);
> +       check_object_size(to, n, false);
>
>         if (access_ok(VERIFY_READ, from, n)) {
> -               check_object_size(to, n, false);
>                 res = __arch_copy_from_user(to, from, n);
>         }
>         if (unlikely(res))
> @@ -392,9 +392,9 @@ static inline unsigned long __must_check copy_from_user(void *to, const void __u
>  static inline unsigned long __must_check copy_to_user(void __user *to, const void *from, unsigned long n)
>  {
>         kasan_check_read(from, n);
> +       check_object_size(from, n, true);
>
>         if (access_ok(VERIFY_WRITE, to, n)) {
> -               check_object_size(from, n, true);
>                 n = __arch_copy_to_user(to, from, n);
>         }
>         return n;
> --
> 1.9.1
>



-- 
Kees Cook
Pixel Security
