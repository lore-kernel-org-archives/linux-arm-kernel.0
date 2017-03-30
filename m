From: keescook@chromium.org (Kees Cook)
Date: Thu, 30 Mar 2017 13:06:59 -0700
Subject: [RESEND] arm: ftrace: fix dynamic ftrace with DEBUG_RODATA and
 !FRAME_POINTER
In-Reply-To: <1490543749-20376-1-git-send-email-abelvesa@linux.com>
References: <1490543749-20376-1-git-send-email-abelvesa@linux.com>
Message-ID: <CAGXu5jKFu2vPQf1PHGZEzmrZO=BbzETrPCVc8x0Xo2EximG9HA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 26, 2017 at 8:55 AM, Abel Vesa <abelvesa@linux.com> wrote:
> The support for dynamic ftrace with CONFIG_DEBUG_RODATA involves
> overriding the weak arch_ftrace_update_code() with a variant which makes
> the kernel text writable around the patching.
>
> This override was however added under the CONFIG_OLD_MCOUNT ifdef, and
> CONFIG_OLD_MCOUNT is only enabled if frame pointers are enabled.
>
> This leads to non-functional dynamic ftrace (ftrace triggers a
> WARN_ON()) when CONFIG_DEBUG_RODATA is enabled and CONFIG_FRAME_POINTER
> is not.
>
> Move the override out of that ifdef and into the CONFIG_DYNAMIC_FTRACE
> ifdef where it belongs.
>
> Fixes: 80d6b0c2eed2a ("ARM: mm: allow text and rodata sections to be read-only")
>
> Suggested-by: Nicolai Stange <nicstange@gmail.com>
> Suggested-by: Rabin Vincent <rabin@rab.in>
> Signed-off-by: Abel Vesa <abelvesa@linux.com>
> Acked-by: Rabin Vincent <rabin@rab.in>

This looks fine to me. I'd send it to the ARM patch tracker since
you've gotten an Ack:
http://www.arm.linux.org.uk/developer/patches/info.php

-Kees

> ---
>  arch/arm/kernel/ftrace.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
> index 3f17594..414e60e 100644
> --- a/arch/arm/kernel/ftrace.c
> +++ b/arch/arm/kernel/ftrace.c
> @@ -29,11 +29,6 @@
>  #endif
>
>  #ifdef CONFIG_DYNAMIC_FTRACE
> -#ifdef CONFIG_OLD_MCOUNT
> -#define OLD_MCOUNT_ADDR        ((unsigned long) mcount)
> -#define OLD_FTRACE_ADDR ((unsigned long) ftrace_caller_old)
> -
> -#define        OLD_NOP         0xe1a00000      /* mov r0, r0 */
>
>  static int __ftrace_modify_code(void *data)
>  {
> @@ -51,6 +46,12 @@ void arch_ftrace_update_code(int command)
>         stop_machine(__ftrace_modify_code, &command, NULL);
>  }
>
> +#ifdef CONFIG_OLD_MCOUNT
> +#define OLD_MCOUNT_ADDR        ((unsigned long) mcount)
> +#define OLD_FTRACE_ADDR ((unsigned long) ftrace_caller_old)
> +
> +#define        OLD_NOP         0xe1a00000      /* mov r0, r0 */
> +
>  static unsigned long ftrace_nop_replace(struct dyn_ftrace *rec)
>  {
>         return rec->arch.old_mcount ? OLD_NOP : NOP;
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
