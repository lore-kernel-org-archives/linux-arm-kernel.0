From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Tue, 10 Apr 2018 11:54:39 +0200
Subject: [PATCH v2 1/2] clk: at91: Added more information logging.
In-Reply-To: <20180410001621.GA62230@hak8or>
References: <20180410001621.GA62230@hak8or>
Message-ID: <20180410095439.GA2745@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/04/2018 20:16:21-0400, Marcin Ziemianowicz wrote:
> I noticed that when debugging some USB clocking issue that there weren't
> many ways to tell what the state of the USB clocking system was. This
> adds a few logging statements to see what the relevant code is trying to
> do.
> 
> Signed-off-by: Marcin Ziemianowicz <marcin@ziemianowicz.com>
> ---
>  drivers/clk/at91/clk-pll.c   |  6 +++++-
>  drivers/clk/at91/clk-usb.c   | 10 ++++++++--
>  drivers/usb/host/ohci-at91.c | 16 ++++++++++------
>  3 files changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-pll.c b/drivers/clk/at91/clk-pll.c
> index 7d3223fc7161..534961766ae5 100644
> --- a/drivers/clk/at91/clk-pll.c
> +++ b/drivers/clk/at91/clk-pll.c
> @@ -133,6 +133,7 @@ static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
>  {
>  	struct clk_pll *pll = to_clk_pll(hw);
>  	unsigned int pllr;
> +	unsigned long recalcedrate;
>  	u16 mul;
>  	u8 div;
>  
> @@ -144,7 +145,10 @@ static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
>  	if (!div || !mul)
>  		return 0;
>  
> -	return (parent_rate / div) * (mul + 1);
> +	recalcedrate = (parent_rate / div) * (mul + 1);
> +	pr_debug("clk-pll: calculating new rate, (%lu hz / %u) * %u = %lu hz\n",
> +		parent_rate, div, mul, recalcedrate);
This is not properly aligned. Also, I'm not a huge fan of adding that
kind of debug messages. Isn't the rate already present in debugfs ?

> +	return recalcedrate;
>  }
>  
>  static long clk_pll_get_best_div_mul(struct clk_pll *pll, unsigned long rate,
> diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
> index 791770a563fc..2fa877e99bac 100644
> --- a/drivers/clk/at91/clk-usb.c
> +++ b/drivers/clk/at91/clk-usb.c
> @@ -48,11 +48,15 @@ static unsigned long at91sam9x5_clk_usb_recalc_rate(struct clk_hw *hw,
>  	struct at91sam9x5_clk_usb *usb = to_at91sam9x5_clk_usb(hw);
>  	unsigned int usbr;
>  	u8 usbdiv;
> +	unsigned int calcdclock;
>  
>  	regmap_read(usb->regmap, AT91_PMC_USB, &usbr);
>  	usbdiv = (usbr & AT91_PMC_OHCIUSBDIV) >> SAM9X5_USB_DIV_SHIFT;
>  
> -	return DIV_ROUND_CLOSEST(parent_rate, (usbdiv + 1));
> +	calcdclock = DIV_ROUND_CLOSEST(parent_rate, (usbdiv + 1));
> +	pr_debug("clk-usb: calculating new rate, %lu hz / %u = %u hz\n",
> +		parent_rate, usbdiv + 1, calcdclock);
> +	return calcdclock;
>  }
>  
>  static int at91sam9x5_clk_usb_determine_rate(struct clk_hw *hw,
> @@ -98,7 +102,6 @@ static int at91sam9x5_clk_usb_determine_rate(struct clk_hw *hw,
>  		if (!best_diff)
>  			break;
>  	}
> -

Unrelated change

>  	if (best_rate < 0)
>  		return best_rate;
>  
> @@ -142,6 +145,9 @@ static int at91sam9x5_clk_usb_set_rate(struct clk_hw *hw, unsigned long rate,
>  	if (div > SAM9X5_USB_MAX_DIV + 1 || !div)
>  		return -EINVAL;
>  
> +	pr_debug("clk-usb: setting USB clock divider to %lu hz / %lu = %lu hz\n",
> +		parent_rate, div, rate);
> +
>  	regmap_update_bits(usb->regmap, AT91_PMC_USB, AT91_PMC_OHCIUSBDIV,
>  			   (div - 1) << SAM9X5_USB_DIV_SHIFT);
>  
> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
> index 5ad9e9bdc8ee..c57a239918f9 100644
> --- a/drivers/usb/host/ohci-at91.c
> +++ b/drivers/usb/host/ohci-at91.c
> @@ -70,11 +70,13 @@ static const struct ohci_driver_overrides ohci_at91_drv_overrides __initconst =
>  
>  /*-------------------------------------------------------------------------*/
>  
> -static void at91_start_clock(struct ohci_at91_priv *ohci_at91)
> +static void at91_start_clock(struct ohci_at91_priv *ohci_at91,
> +				struct device *dev)

This is not properly aligned either

>  {
>  	if (ohci_at91->clocked)
>  		return;
>  
> +	dev_dbg(dev, "Enabling hclk, iclk, and setting fclk to 48 Mhz\n");
>  	clk_set_rate(ohci_at91->fclk, 48000000);
>  	clk_prepare_enable(ohci_at91->hclk);
>  	clk_prepare_enable(ohci_at91->iclk);
> @@ -82,11 +84,13 @@ static void at91_start_clock(struct ohci_at91_priv *ohci_at91)
>  	ohci_at91->clocked = true;
>  }
>  
> -static void at91_stop_clock(struct ohci_at91_priv *ohci_at91)
> +static void at91_stop_clock(struct ohci_at91_priv *ohci_at91,
> +				struct device *dev)
>  {
>  	if (!ohci_at91->clocked)
>  		return;
>  
> +	dev_dbg(dev, "Disabling hclk, iclk, and fclk\n");
>  	clk_disable_unprepare(ohci_at91->fclk);
>  	clk_disable_unprepare(ohci_at91->iclk);
>  	clk_disable_unprepare(ohci_at91->hclk);
> @@ -104,7 +108,7 @@ static void at91_start_hc(struct platform_device *pdev)
>  	/*
>  	 * Start the USB clocks.
>  	 */
> -	at91_start_clock(ohci_at91);
> +	at91_start_clock(ohci_at91, &pdev->dev);
>  
>  	/*
>  	 * The USB host controller must remain in reset.
> @@ -128,7 +132,7 @@ static void at91_stop_hc(struct platform_device *pdev)
>  	/*
>  	 * Stop the USB clocks.
>  	 */
> -	at91_stop_clock(ohci_at91);
> +	at91_stop_clock(ohci_at91, &pdev->dev);
>  }
>  
>  
> @@ -623,7 +627,7 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
>  
>  		/* flush the writes */
>  		(void) ohci_readl (ohci, &ohci->regs->control);
> -		at91_stop_clock(ohci_at91);
> +		at91_stop_clock(ohci_at91, dev);
>  	}
>  
>  	return ret;
> @@ -638,7 +642,7 @@ ohci_hcd_at91_drv_resume(struct device *dev)
>  	if (ohci_at91->wakeup)
>  		disable_irq_wake(hcd->irq);
>  
> -	at91_start_clock(ohci_at91);
> +	at91_start_clock(ohci_at91, dev);
>  
>  	ohci_resume(hcd, false);
>  
> -- 
> 2.17.0
> 
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
