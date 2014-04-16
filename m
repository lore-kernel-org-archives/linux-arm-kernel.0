From: tony@atomide.com (Tony Lindgren)
Date: Wed, 16 Apr 2014 09:35:27 -0700
Subject: [PATCH] power: twl4030_charger: clear IRQs after handling them
In-Reply-To: <1397661299-31342-1-git-send-email-balbi@ti.com>
References: <1397661299-31342-1-git-send-email-balbi@ti.com>
Message-ID: <20140416163526.GA3049@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [140416 08:18]:
> TRM says we *must* write 1 to each bit we're handling
> in order to clear the IRQ status and bring IRQ line
> low. This patch implements that.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> Russell, I don't have HW to test, but this should
> solve the problem you saw when not using battery
> with Zoom board. Let me know if it doesn't.

BTW, looks like we're enabling BCI automatically in twl4030.dtsi
while the legacy booting does not have TWL_COMMON_PDATA_BCI
enabled for LDP. Anyways, for LDP BCI should be enabled for
sure, that's the only way to power at least the earlier LDP
revisions.

>  drivers/power/twl4030_charger.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
> index f141088..b090842 100644
> --- a/drivers/power/twl4030_charger.c
> +++ b/drivers/power/twl4030_charger.c
> @@ -301,12 +301,24 @@ static irqreturn_t twl4030_bci_interrupt(int irq, void *arg)
>  	ret = twl_i2c_read_u8(TWL4030_MODULE_INTERRUPTS, &irqs1,
>  			      TWL4030_INTERRUPTS_BCIISR1A);
>  	if (ret < 0)
> -		return IRQ_HANDLED;
> +		return IRQ_NONE;
> +
> +	/* clear IRQs early */
> +	ret = twl_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, irqs1,
> +			TWL4030_INTERRUPTS_BCIISR1A);
> +	if (ret < 0)
> +		return IRQ_NONE;
>  
>  	ret = twl_i2c_read_u8(TWL4030_MODULE_INTERRUPTS, &irqs2,
>  			      TWL4030_INTERRUPTS_BCIISR2A);
>  	if (ret < 0)
> -		return IRQ_HANDLED;
> +		return IRQ_NONE;
> +
> +	/* clear IRQs early */
> +	ret = twl_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, irqs2,
> +			      TWL4030_INTERRUPTS_BCIISR2A);
> +	if (ret < 0)
> +		return IRQ_NONE;
>  
>  	dev_dbg(bci->dev, "BCI irq %02x %02x\n", irqs2, irqs1);
>  
> -- 
> 1.9.1.286.g5172cb3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
