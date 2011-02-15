From: khilman@ti.com (Kevin Hilman)
Date: Mon, 14 Feb 2011 16:08:10 -0800
Subject: [PATCH] omap3: pm: Use exported set_cr() instead of a custom one.
In-Reply-To: <1297437132-1005-1-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Fri, 11 Feb 2011 20:42:11 +0530")
References: <1297437132-1005-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <871v3axiqd.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> Remove the custom restore_control_register() and use the exported
> set_cr() instead to set the system control register(SCTRL) value.
>
> No functional change.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>

Tested/validated on ?

Kevin

> ---
>  arch/arm/mach-omap2/pm34xx.c |    7 +------
>  1 files changed, 1 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 2f864e4..63a3e1d 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -311,11 +311,6 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -static void restore_control_register(u32 val)
> -{
> -	__asm__ __volatile__ ("mcr p15, 0, %0, c1, c0, 0" : : "r" (val));
> -}
> -
>  /* Function to restore the table entry that was modified for enabling MMU */
>  static void restore_table_entry(void)
>  {
> @@ -337,7 +332,7 @@ static void restore_table_entry(void)
>  	control_reg_value = __raw_readl(scratchpad_address
>  					+ OMAP343X_CONTROL_REG_VALUE_OFFSET);
>  	/* This will enable caches and prediction */
> -	restore_control_register(control_reg_value);
> +	set_cr(control_reg_value);
>  }
>  
>  void omap_sram_idle(void)
