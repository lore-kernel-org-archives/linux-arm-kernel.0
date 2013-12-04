From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 4 Dec 2013 21:58:44 +0800
Subject: [PATCH v2 1/2] usb: chipidea: usbmisc: Add support for
 i.MX27/i.MX31 CPUs
In-Reply-To: <1385480210-9349-1-git-send-email-shc_work@mail.ru>
References: <1385480210-9349-1-git-send-email-shc_work@mail.ru>
Message-ID: <20131204135844.GE1573@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 07:36:49PM +0400, Alexander Shiyan wrote:
> This adds i.MX27 and i.MX31 as the next user of the usbmisc driver.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/usb/chipidea/usbmisc_imx.c | 42 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
> index 8a1094b..4381c5a6 100644
> --- a/drivers/usb/chipidea/usbmisc_imx.c
> +++ b/drivers/usb/chipidea/usbmisc_imx.c
> @@ -21,6 +21,10 @@
>  #define MX25_USB_PHY_CTRL_OFFSET	0x08
>  #define MX25_BM_EXTERNAL_VBUS_DIVIDER	BIT(23)
>  
> +#define MX27_H1_PM_BIT			BIT(8)
> +#define MX27_H2_PM_BIT			BIT(16)
> +#define MX27_OTG_PM_BIT			BIT(24)
> +
>  #define MX53_USB_OTG_PHY_CTRL_0_OFFSET	0x08
>  #define MX53_USB_UH2_CTRL_OFFSET	0x14
>  #define MX53_USB_UH3_CTRL_OFFSET	0x18
> @@ -68,6 +72,36 @@ static int usbmisc_imx25_post(struct imx_usbmisc_data *data)
>  	return 0;
>  }
>  
> +static int usbmisc_imx27_init(struct imx_usbmisc_data *data)
> +{
> +	unsigned long flags;
> +	u32 val;
> +
> +	switch (data->index) {
> +	case 0:
> +		val = MX27_OTG_PM_BIT;
> +		break;
> +	case 1:
> +		val = MX27_H1_PM_BIT;
> +		break;
> +	case 2:
> +		val = MX27_H2_PM_BIT;
> +		break;
> +	default:
> +		return -EINVAL;
> +	};
> +
> +	spin_lock_irqsave(&usbmisc->lock, flags);
> +	if (data->disable_oc)
> +		val = readl(usbmisc->base) | val;
> +	else
> +		val = readl(usbmisc->base) & ~val;
> +	writel(val, usbmisc->base);
> +	spin_unlock_irqrestore(&usbmisc->lock, flags);
> +
> +	return 0;
> +}
> +
>  static int usbmisc_imx53_init(struct imx_usbmisc_data *data)
>  {
>  	void __iomem *reg = NULL;
> @@ -128,6 +162,10 @@ static const struct usbmisc_ops imx25_usbmisc_ops = {
>  	.post = usbmisc_imx25_post,
>  };
>  
> +static const struct usbmisc_ops imx27_usbmisc_ops = {
> +	.init = usbmisc_imx27_init,
> +};
> +
>  static const struct usbmisc_ops imx53_usbmisc_ops = {
>  	.init = usbmisc_imx53_init,
>  };
> @@ -162,6 +200,10 @@ static const struct of_device_id usbmisc_imx_dt_ids[] = {
>  		.data = &imx25_usbmisc_ops,
>  	},
>  	{
> +		.compatible = "fsl,imx27-usbmisc",
> +		.data = &imx27_usbmisc_ops,
> +	},
> +	{
>  		.compatible = "fsl,imx53-usbmisc",
>  		.data = &imx53_usbmisc_ops,
>  	},
> -- 
> 1.8.3.2
> 
> 

Applied, thanks.

-- 

Best Regards,
Peter Chen
