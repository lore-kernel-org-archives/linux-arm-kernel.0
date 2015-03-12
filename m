From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 12 Mar 2015 16:34:12 -0400 (EDT)
Subject: [RFT/RFC PATCH 6/6] ARM: keep .text and .fixup regions
 together
In-Reply-To: <1426181892-15440-7-git-send-email-ard.biesheuvel@linaro.org>
References: <1426181892-15440-1-git-send-email-ard.biesheuvel@linaro.org>
 <1426181892-15440-7-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <alpine.LFD.2.11.1503121633410.27567@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 Mar 2015, Ard Biesheuvel wrote:

> Fixup snippets are put into a dedicated section so that they don't
> bloat cache lines with instructions that are usually not executed.
> But there is no reason to put all these snippets together at the far
> end of the .text output region, where the branch instruction they
> contain could go out of range if the kernel grows in size.
> 
> Instead, emit .text and .fixup regions together for each input object.
> They should still be out of the way, but not so far that they go out
> of range.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
> 
> Note that the TEXT_TEXT macro will emit *(.text) again but this should be
> harmless.
> 
>  arch/arm/kernel/vmlinux.lds.S | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index 2e7b2220ef5f..01630c38fd6c 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -108,13 +108,13 @@ SECTIONS
>  			*(.exception.text)
>  			__exception_text_end = .;
>  			IRQENTRY_TEXT
> +#ifdef CONFIG_MMU
> +			*(.text .fixup)
> +#endif
>  			TEXT_TEXT
>  			SCHED_TEXT
>  			LOCK_TEXT
>  			KPROBES_TEXT
> -#ifdef CONFIG_MMU
> -			*(.fixup)
> -#endif
>  			*(.gnu.warning)
>  			*(.glue_7)
>  			*(.glue_7t)
> -- 
> 1.8.3.2
> 
> 
