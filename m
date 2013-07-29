From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 29 Jul 2013 16:38:59 -0600
Subject: [PATCH 1/8] ARM: tegra: add common resume handling code for LP1
 resuming
In-Reply-To: <1374830110-30685-2-git-send-email-josephl@nvidia.com>
References: <1374830110-30685-1-git-send-email-josephl@nvidia.com>
 <1374830110-30685-2-git-send-email-josephl@nvidia.com>
Message-ID: <51F6EF03.9000003@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/26/2013 03:15 AM, Joseph Lo wrote:
> The common LP1 resuming procedures of LP1 on Tegra was checking the LP1
> mask first. The LP1 mask indicated that the Tegra device was in LP1 then
> we need to resume the Tegra from the LP1 reset handler.
> 
> And the LP1 was putting the SDRAM to self-refresh mode, the SDRAM wasn't
> accessible when resuming from LP1. We need to copy the LP1 reset handler
> to IRAM before suspending. That's why you can see the address of LP1
> reset handler was located in IRAM.

That's rather hard to understand. How about:

==========
Add support to the Tegra CPU reset vector to detect whether the CPU is
resuming from LP1 suspend state. If it is, branch to the LP1-specific
resume code.

When Tegra enters the LP1 suspend state, the SDRAM controller is placed
into a self-refresh state. For this reason, we must place the LP1 resume
code into IRAM, so that it is accessible before SDRAM access has been
re-enabled.
==========

Talking about *copying* the LP1 resume code to IRAM isn't appropriate
here, since nothing in this patch performs any copying of the resume code.

> diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S

> @@ -182,6 +182,19 @@ after_errata:
>  1:
>  #endif
>  
> +	/* Waking up from LP1? */
> +	ldr	r8, [r12, #RESET_DATA(MASK_LP1)]
> +	tst	r8, r11				@ if in_lp1
> +	beq	__is_not_lp1
> +	cmp	r10, #0
> +	bne	__die				@ only CPU0 can be here
> +	ldr	lr, [r12, #RESET_DATA(STARTUP_LP1)]
> + THUMB(	add	lr, lr, #1 )			@ switch to Thumb mode
> +	cmp	lr, #0
> +	bleq	__die				@ no LP1 startup handler

On thumb, lr==#1 at this point. I think you want to move the THUMB()
instruction after the bleq.

> diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h

> +#define TEGRA_IRAM_CODE_AREA	(TEGRA_IRAM_BASE + SZ_4K)

The layout of IRAM should be described in irammap.h not sleep.h.
