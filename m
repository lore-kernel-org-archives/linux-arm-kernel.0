From: balbi@ti.com (Felipe Balbi)
Date: Tue, 22 Oct 2013 08:50:40 -0500
Subject: [PATCH 1/4] Input: twl4030-pwrbutton - add device tree support
In-Reply-To: <1382446504-27837-2-git-send-email-sre@debian.org>
References: <1382446504-27837-1-git-send-email-sre@debian.org>
 <1382446504-27837-2-git-send-email-sre@debian.org>
Message-ID: <20131022135040.GN9340@gimli>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 22, 2013 at 02:55:01PM +0200, Sebastian Reichel wrote:
> Add device tree support for twl4030 power button driver.
> 
> Signed-off-by: Sebastian Reichel <sre@debian.org>
> ---
>  drivers/input/misc/twl4030-pwrbutton.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
> index b9a05fd..e450947 100644
> --- a/drivers/input/misc/twl4030-pwrbutton.c
> +++ b/drivers/input/misc/twl4030-pwrbutton.c
> @@ -52,7 +52,7 @@ static irqreturn_t powerbutton_irq(int irq, void *_pwr)
>  	return IRQ_HANDLED;
>  }
>  
> -static int __init twl4030_pwrbutton_probe(struct platform_device *pdev)
> +static int twl4030_pwrbutton_probe(struct platform_device *pdev)
>  {
>  	struct input_dev *pwr;
>  	int irq = platform_get_irq(pdev, 0);
> @@ -106,16 +106,27 @@ static int __exit twl4030_pwrbutton_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#if IS_ENABLED(CONFIG_OF)
> +static const struct of_device_id twl4030_pwrbutton_dt_match_table[] = {
> +       { .compatible = "ti,twl4030-pwrbutton" },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, twl4030_pwrbutton_dt_match_table);
> +#define twl4030_pwrbutton_dt_match of_match_ptr(twl4030_pwrbutton_dt_match_table)
> +#else
> +#define twl4030_pwrbutton_dt_match NULL
> +#endif

you don't ned this trickery.. just always device the match table.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131022/9835b2e0/attachment.sig>
