From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Wed, 10 Nov 2010 12:28:00 -0800
Subject: [PATCH] ARM: Common GIC entry macro code
In-Reply-To: <20101110070043.18735.53764.sendpatchset@t400s>
References: <20101110070043.18735.53764.sendpatchset@t400s>
Message-ID: <4CDB0050.3090509@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Magnus,

   The patch assumes that PPI's could be nothing but timers. On msm we 
have other interrupts which are PPI's.

   I have tested this and doesn't work for msm. The reason being we treat
PPI timer interrupts as usual interrupts, meaning use do_asm_IRQ() 
instead of do_local_timer(). Besides there are other non timer 
interrupts that are PPIs and we need do_asm_IRQ() to be called for them.

   You might want to exclude msm from this patch.

> +++ work/arch/arm/include/asm/hardware/entry-macro-gic.S	2010-11-10 15:20:15.000000000 +0900

> +	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
> +
> +	ldr     \irqstat, [\base, #GIC_CPU_INTACK]
> +	/* bits 12-10 = src CPU, 9-0 = int # */
> +
> +	ldr	\tmp, =1021
> +	bic     \irqnr, \irqstat, #0x1c00
> +	cmp     \irqnr, #29

Not all the PPI's are timer interrupts on MSM. MSM would need this to be 
compared to 15 rather than 29.

> --- 0001/arch/arm/mach-msm/include/mach/entry-macro-qgic.S
> +++ work/arch/arm/mach-msm/include/mach/entry-macro-qgic.S	2010-11-10 15:27:06.000000000 +0900
> -	 */
> -
> -	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
> -
> -	ldr  \irqstat, [\base, #GIC_CPU_INTACK] /* bits 12-10 =srcCPU,
> -						   9-0 =int # */
> -
> -	bic     \irqnr, \irqstat, #0x1c00	@mask src
> -	cmp     \irqnr, #15
See above line

Thanks,
Abhijeet

--
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
--
