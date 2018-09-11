From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Tue, 11 Sep 2018 23:12:51 +0900
Subject: [PATCH] ARM: linker script: GCOV kernel may refers data in __exit
In-Reply-To: <153580549235.10130.1495077983569784123.stgit@devbox>
References: <20180901185017.0a81bc3e61f5d021664f13f3@kernel.org>
 <153580549235.10130.1495077983569784123.stgit@devbox>
Message-ID: <20180911231251.ee101eec63dceceed8243ad5@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please drop it, since Peter's patch fixes this problem better way.

https://lkml.org/lkml/2018/9/6/403

Thank you,

On Sat,  1 Sep 2018 21:38:13 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> GCOV kernel embeds counters in the kernel for each line
> and a part of that embed in __exit text. So we need to
> keep the __exit text if CONFIG_GCOV_KERNEL=y.
> 
> Without this patch, if we discards __exit text (e.g.
> disables CONFIG_GENERIC_BUG, CONFIG_JUMP_LABEL and
> CONFIG_SMP_ON_UP) but enables CONFIG_GCOV_PROFILE_FTRACE,
> ld will error like below on ARM.
> 
> `.text.exit' referenced in section `.ARM.exidx.text.exit' of
> kernel/trace/trace_clock.o: defined in discarded section `.text.exit'
> of kernel/trace/trace_clock.o
> 
> To fix this issue, we keep __exit when CONFIG_GCOV_KERNEL=y.
> 
> The reason why not depending CONFIG_GCOV_PROFILE_X, is
> that the Documentation/dev-tools/gcov.rst says that the
> developer can enable gcov profile on a file or a directory
> by customizing Makefile, and that will only depend on
> CONFIG_GCOV_KERNEL.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/kernel/vmlinux.lds.h |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/vmlinux.lds.h b/arch/arm/kernel/vmlinux.lds.h
> index ae5fdff18406..baaacee9f5ce 100644
> --- a/arch/arm/kernel/vmlinux.lds.h
> +++ b/arch/arm/kernel/vmlinux.lds.h
> @@ -9,7 +9,8 @@
>  #endif
>  
>  #if (defined(CONFIG_SMP_ON_UP) && !defined(CONFIG_DEBUG_SPINLOCK)) || \
> -	defined(CONFIG_GENERIC_BUG) || defined(CONFIG_JUMP_LABEL)
> +	defined(CONFIG_GENERIC_BUG) || defined(CONFIG_JUMP_LABEL) || \
> +	defined(CONFIG_GCOV_KERNEL)
>  #define ARM_EXIT_KEEP(x)	x
>  #define ARM_EXIT_DISCARD(x)
>  #else
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
