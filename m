From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Fri, 18 Jun 2010 12:16:26 +0200
Subject: [PATCH v2] input/imx_keypad: add PM support
In-Reply-To: <1276801147-4103-1-git-send-email-eric@eukrea.com>
References: <1276801147-4103-1-git-send-email-eric@eukrea.com>
Message-ID: <1276856186.3146.5.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On gio, 2010-06-17 at 20:59 +0200, Eric B?nard wrote:
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
> +	return 0;
> +}
> +
> +static int mxc_kpp_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct imx_keypad *keypad = platform_get_drvdata(pdev);
> +
> +	keypad->enabled = true;
> +	clk_enable(keypad->clk);
> +	enable_irq(keypad->irq);
> +
> +	return 0;
> +}

Ok, so with this patch the keypad cannot wake the system?
It is scheduled another patch?


-- 
Alberto!

        Be Persistent!
                - Greg Kroah-Hartman (FOSDEM 2010)
