From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Thu, 6 Sep 2018 14:13:41 -0700
Subject: [PATCH v6 11/11] arm64: annotate user pointers casts detected by
 sparse
In-Reply-To: <5d54526e5ff2e5ad63d0dfdd9ab17cf359afa4f2.1535629099.git.andreyknvl@google.com>
References: <cover.1535629099.git.andreyknvl@google.com>
 <5d54526e5ff2e5ad63d0dfdd9ab17cf359afa4f2.1535629099.git.andreyknvl@google.com>
Message-ID: <CA+55aFyW9N2tSb2bQvkthbVVyY6nt5yFeWQRLHp1zruBmb5ocw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2018 at 4:41 AM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> This patch adds __force annotations for __user pointers casts detected by
> sparse with the -Wcast-from-as flag enabled (added in [1]).

No, several of these are wrong, and just silence a warning that shows a problem.

So for example:

>  static inline compat_uptr_t ptr_to_compat(void __user *uptr)
>  {
> -       return (u32)(unsigned long)uptr;
> +       return (u32)(__force unsigned long)uptr;
>  }

this actually looks correct.

But:

> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -76,7 +76,7 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
>  {
>         unsigned long ret, limit = current_thread_info()->addr_limit;
>
> -       __chk_user_ptr(addr);
> +       __chk_user_ptr((void __force *)addr);

This looks actively wrong. The whole - and only - point of
"__chk_user_ptr()" is that it warns about a lack of a "__user *" type.

So the above makes no sense at all.

There are other similar "that makes no sense what-so-ever", like this one:

> -               struct compat_group_req __user *gr32 = (void *)optval;
> +               struct compat_group_req __user *gr32 = (__force void *)optval;

no, the additionl of __force is not the right thing, the problem, is
that a __user pointer is cast to a non-user 'void *' only to be
assigned to another user type.

The fix should have been to use (void __user *) as the cast instead,
no __force needed.

In general, I think the patch shows all the signs of "mindlessly just
add casts", which is exactly the wrong thing to do to sparse warnings.

                   Linus
