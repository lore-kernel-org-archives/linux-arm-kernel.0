From: ndesaulniers@google.com (Nick Desaulniers)
Date: Tue, 25 Sep 2018 13:24:06 -0700
Subject: [PATCH] arm64: percpu: Initialize ret in the default case
In-Reply-To: <20180925194459.13088-1-natechancellor@gmail.com>
References: <20180925194459.13088-1-natechancellor@gmail.com>
Message-ID: <CAKwvOdnzN0E0HD--3GmC9b=20fx3AE-8-x0iZ04-LEXnxh=YoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2018 at 12:45 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns that if the default case is taken, ret will be
> uninitialized.
>
> ./arch/arm64/include/asm/percpu.h:196:2: warning: variable 'ret' is used
> uninitialized whenever switch default is taken
> [-Wsometimes-uninitialized]
>         default:
>         ^~~~~~~
> ./arch/arm64/include/asm/percpu.h:200:9: note: uninitialized use occurs
> here
>         return ret;
>                ^~~
> ./arch/arm64/include/asm/percpu.h:157:19: note: initialize the variable
> 'ret' to silence this warning
>         unsigned long ret, loop;
>                          ^
>                           = 0
>
> This warning appears several times while building the erofs filesystem.
> While it's not strictly wrong, the BUILD_BUG will prevent this from
> becoming a true problem. Initialize ret to 0 in the default case right
> before the BUILD_BUG to silence all of these warnings.

Clang does semantic analysis BEFORE inlining/optimizations, so I can't
determine that default is never reachable.  Nathan, thanks for this
patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Reported-by: Prasad Sodagudi <psodagud@codeaurora.org>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  arch/arm64/include/asm/percpu.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
> index 9234013e759e..21a81b59a0cc 100644
> --- a/arch/arm64/include/asm/percpu.h
> +++ b/arch/arm64/include/asm/percpu.h
> @@ -96,6 +96,7 @@ static inline unsigned long __percpu_##op(void *ptr,                  \
>                 : [val] "Ir" (val));                                    \
>                 break;                                                  \
>         default:                                                        \
> +               ret = 0;                                                \
>                 BUILD_BUG();                                            \
>         }                                                               \
>                                                                         \
> @@ -125,6 +126,7 @@ static inline unsigned long __percpu_read(void *ptr, int size)
>                 ret = READ_ONCE(*(u64 *)ptr);
>                 break;
>         default:
> +               ret = 0;
>                 BUILD_BUG();
>         }
>
> @@ -194,6 +196,7 @@ static inline unsigned long __percpu_xchg(void *ptr, unsigned long val,
>                 : [val] "r" (val));
>                 break;
>         default:
> +               ret = 0;
>                 BUILD_BUG();
>         }
>
> --
> 2.19.0
>


-- 
Thanks,
~Nick Desaulniers
