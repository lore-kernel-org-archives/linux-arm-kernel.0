From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 12 Mar 2014 14:08:22 +0800
Subject: [PATCH v2][ 3/8] usb: chipidea: usbmisc: Add USB Host support
 for i.MX25/i.MX35 CPUs
In-Reply-To: <1394535304-10240-3-git-send-email-denis@eukrea.com>
References: <1394535304-10240-1-git-send-email-denis@eukrea.com>
 <1394535304-10240-3-git-send-email-denis@eukrea.com>
Message-ID: <20140312060821.GC16568@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 11, 2014 at 11:54:59AM +0100, Denis Carikli wrote:
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---

Add something at commit log please.

> Changelog v1->v2:
> - converted two remaining defines to BIT()
> - Removed a variable declaration that was not used in usbmisc_imx25_init
> ---
>  drivers/usb/chipidea/usbmisc_imx.c |   58 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
> index cd061ab..3523c09 100644
> --- a/drivers/usb/chipidea/usbmisc_imx.c
> +++ b/drivers/usb/chipidea/usbmisc_imx.c
> @@ -21,6 +21,26 @@
>  #define MX25_USB_PHY_CTRL_OFFSET	0x08
>  #define MX25_BM_EXTERNAL_VBUS_DIVIDER	BIT(23)
>  
> +#define MXC_EHCI_INTERFACE_SINGLE_UNI	(2 << 0)
> +#define MXC_EHCI_INTERFACE_DIFF_UNI	(0 << 0)
> +#define MXC_EHCI_INTERFACE_MASK		(0xf)
> +

Which SoCs will use above Macros?
If only imx25 and imx35, using prefix MX25 please.
Otherwise, adding prefix IMX_ for above Macros and
the comment for which SoC needs them.

> +#define MX25_OTG_SIC_SHIFT		29
> +#define MX25_OTG_SIC_MASK		(0x3 << MX25_OTG_SIC_SHIFT)
> +#define MX25_OTG_PM_BIT			BIT(24)
> +#define MX25_OTG_PP_BIT			BIT(11)
> +#define MX25_OTG_OCPOL_BIT		BIT(3)
> +
> +#define MX25_H1_SIC_SHIFT		21
> +#define MX25_H1_SIC_MASK		(0x3 << MX25_H1_SIC_SHIFT)
> +#define MX25_H1_PP_BIT			BIT(18)
> +#define MX25_H1_PM_BIT			BIT(16)
> +#define MX25_H1_IPPUE_UP_BIT		BIT(7)
> +#define MX25_H1_IPPUE_DOWN_BIT		BIT(6)
> +#define MX25_H1_TLL_BIT			BIT(5)
> +#define MX25_H1_USBTE_BIT		BIT(4)
> +#define MX25_H1_OCPOL_BIT		BIT(2)
> +
>  #define MX27_H1_PM_BIT			BIT(8)
>  #define MX27_H2_PM_BIT			BIT(16)
>  #define MX27_OTG_PM_BIT			BIT(24)
> @@ -50,6 +70,39 @@ struct imx_usbmisc {
>  
>  static struct imx_usbmisc *usbmisc;
>  
> +static int usbmisc_imx25_init(struct imx_usbmisc_data *data)
> +{
> +	unsigned long flags;
> +	u32 val = 0;
> +
> +	if (data->index > 1)
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&usbmisc->lock, flags);
> +	switch (data->index) {
> +	case 0:
> +		val = readl(usbmisc->base);
> +		val &= ~(MX25_OTG_SIC_MASK | MX25_OTG_PP_BIT);
> +		val |= (MXC_EHCI_INTERFACE_DIFF_UNI & MXC_EHCI_INTERFACE_MASK) << MX25_OTG_SIC_SHIFT;
> +		val |= (MX25_OTG_PM_BIT | MX25_OTG_OCPOL_BIT);
> +		writel(val, usbmisc->base);
> +		break;
> +	case 1:
> +		val = readl(usbmisc->base);
> +		val &= ~(MX25_H1_SIC_MASK | MX25_H1_PP_BIT |  MX25_H1_IPPUE_UP_BIT);
> +		val |= (MXC_EHCI_INTERFACE_SINGLE_UNI & MXC_EHCI_INTERFACE_MASK) << MX25_H1_SIC_SHIFT;
> +		val |= (MX25_H1_PM_BIT | MX25_H1_OCPOL_BIT | MX25_H1_TLL_BIT |
> +			MX25_H1_USBTE_BIT | MX25_H1_IPPUE_DOWN_BIT);
> +
> +		writel(val, usbmisc->base);
> +
> +		break;
> +	}
> +	spin_unlock_irqrestore(&usbmisc->lock, flags);
> +
> +	return 0;
> +}
> +
>  static int usbmisc_imx25_post(struct imx_usbmisc_data *data)
>  {
>  	void __iomem *reg;
> @@ -159,6 +212,7 @@ static int usbmisc_imx6q_init(struct imx_usbmisc_data *data)
>  }
>  
>  static const struct usbmisc_ops imx25_usbmisc_ops = {
> +	.init = usbmisc_imx25_init,
>  	.post = usbmisc_imx25_post,
>  };
>  
> @@ -200,6 +254,10 @@ static const struct of_device_id usbmisc_imx_dt_ids[] = {
>  		.data = &imx25_usbmisc_ops,
>  	},
>  	{
> +		.compatible = "fsl,imx35-usbmisc",
> +		.data = &imx25_usbmisc_ops,
> +	},
> +	{
>  		.compatible = "fsl,imx27-usbmisc",
>  		.data = &imx27_usbmisc_ops,
>  	},
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

-- 

Best Regards,
Peter Chen
