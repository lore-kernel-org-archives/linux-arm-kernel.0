From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 24 Jun 2010 09:39:07 -0700
Subject: [PATCH v2] input/imx_keypad: add PM support
In-Reply-To: <1276801147-4103-1-git-send-email-eric@eukrea.com>
References: <1276801147-4103-1-git-send-email-eric@eukrea.com>
Message-ID: <20100624163907.GB25119@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 17, 2010 at 08:59:01PM +0200, Eric B?nard wrote:
> We use keypad_data to enable wakeup from platform data
> 
> suspend/resume is tested on an i.MX27 when keypad is not
> in use and when it's is in use (in which case we immediatly
> get the key pressed at wakeup)
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> Cc: maramaopercheseimorto at gmail.com
> Cc: linux-input at vger.kernel.org
> Cc: dmitry.torokhov at gmail.com
> Cc: linux-arm-kernel at lists.infradead.org
> ---
> v2 :
> 	- simplify suspend & resume functions
> 	- convert to pm_ops
> 
>  drivers/input/keyboard/imx_keypad.c |   40 +++++++++++++++++++++++++++++++++-
>  1 files changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
> index d92c15c..9aa0005 100644
> --- a/drivers/input/keyboard/imx_keypad.c
> +++ b/drivers/input/keyboard/imx_keypad.c
> @@ -364,6 +364,38 @@ static void imx_keypad_inhibit(struct imx_keypad *keypad)
>  	writew(0xff00, keypad->mmio_base + KPCR);
>  }
>  
> +#ifdef CONFIG_PM
> +static int mxc_kpp_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct imx_keypad *keypad = platform_get_drvdata(pdev);
> +
> +	keypad->enabled = false;
> +	synchronize_irq(keypad->irq);
> +	disable_irq(keypad->irq);
> +	clk_disable(keypad->clk);
> +

This is not correct. imx_keypad_probe() keypad->enabled = false, waiting for
imx_keypad_open() to be called. However if nobody opens the device and
you go through suspend/resume cycle you'll leave keypad->enabled = true.


BTW, why do you call new functions mxc_kpp_XXX  while the rest of the
driver uses imx_keypad_XXX naming?

Thanks.

-- 
Dmitry
