From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 01 Sep 2010 14:18:11 -0700
Subject: [PATCH] ARM: Implement cpu_v7_reset.
In-Reply-To: <1283349719-21115-1-git-send-email-linus.walleij@stericsson.com>
References: <1283349719-21115-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4C7EC313.7050705@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/2010 07:01 AM, Linus Walleij wrote:
> From: Per Fransson <per.xx.fransson@stericsson.com>
> 
> This implementation of cpu_v7_reset flushes the L1 cache
> and turns off the MMU.
> 
> Signed-off-by: Per Fransson <per.xx.fransson@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---

Is this needed to make kexec work on v7? It would be nice if something
like that was noted in the commit message besides what the patch is doing.

> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index d5d9b58..f2e2c92 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -63,7 +63,18 @@ ENDPROC(cpu_v7_proc_fin)
>   */
>  	.align	5
>  ENTRY(cpu_v7_reset)
> -	mov	pc, r0
> +	mov     r4, r0
> +	mov     ip, #0
> +	bl      v7_flush_kern_cache_all         @ invalidate I,D caches
> +	dsb                                     @ drain WB

Is this necessary considering that machine_kexec.c calls
flush_cache_all() right before calling cpu_reset()?

> +#ifdef CONFIG_MMU
> +	mcr     p15, 0, ip, c8, c7, 0           @ invalidate I & D TLBs
> +#endif
> +	mrc     p15, 0, ip, c1, c0, 0           @ ctrl register
> +	bic     ip, ip, #0x000f                 @ ............wcam
> +	bic     ip, ip, #0x1100                 @ ...i...s........
> +	mcr     p15, 0, ip, c1, c0, 0           @ ctrl register

On a related note, I was always a bit confused since proc-v6 and proc-v7
don't turn off the MMU in their cpu_reset functions, which doesn't seem
correct with respect to Documentation/arm/Booting. Is it necessary to
turn off the MMU when kexec'ing the kernel? Last time I tried kexec'ing
on a v6 it worked fine without turning off the MMU.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
