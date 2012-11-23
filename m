From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 23 Nov 2012 14:59:38 +0800
Subject: [PATCH v3 7/7] usb: chipidea: usbmisc: add post handling and
 errata fix for mx25
In-Reply-To: <1353506793-8354-8-git-send-email-m.grzeschik@pengutronix.de>
References: <1353506793-8354-1-git-send-email-m.grzeschik@pengutronix.de>
 <1353506793-8354-8-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <20121123065937.GE22420@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 03:06:33PM +0100, Michael Grzeschik wrote:
> This adds a post handling routine which is called after
> ci13xxx_add_device was called. The first user is the mx25, which has to
> disable the external-vbus-divider after the ude has started.
udc has started?
> 
>  
> +static int usbmisc_imx25_post(struct device *dev)
> +{
> +	struct usbmisc_usb_device *usbdev;
> +	void __iomem *reg;
> +	unsigned long flags;
> +	u32 val;
> +
> +	usbdev = get_usbdev(dev);
> +	if (IS_ERR(usbdev))
> +		return PTR_ERR(usbdev);
> +
> +	reg = usbmisc->base + MX25_USB_PHY_CTRL_OFFSET;
> +
> +	if (usbdev->evdo) {
> +		spin_lock_irqsave(&usbmisc->lock, flags);
> +		val = readl(reg);
> +		writel(val | MX25_BM_EXTERNAL_VBUS_DIVIDER, reg);
> +		spin_unlock_irqrestore(&usbmisc->lock, flags);
> +		mdelay(5); /* needed to stabilize voltage */
better use usleep_range to avoid busy-wait.
> +	}
> +
> +	return 0;
> +}
> +
>  static int usbmisc_imx53_init(struct device *dev)
>  {
>  	struct usbmisc_usb_device *usbdev;
> @@ -122,6 +150,10 @@ static int usbmisc_imx6q_init(struct device *dev)
>  	return 0;
>  }
>  
> +static const struct usbmisc_ops imx25_usbmisc_ops = {
> +	.post = usbmisc_imx25_post,
> +};
> +
>  static const struct usbmisc_ops imx53_usbmisc_ops = {
>  	.init = usbmisc_imx53_init,
>  };
> @@ -131,6 +163,7 @@ static const struct usbmisc_ops imx6q_usbmisc_ops = {
>  };
>  
>  static const struct of_device_id usbmisc_imx_dt_ids[] = {
> +	{ .compatible = "fsl,imx25-usbmisc", .data = (void *)&imx25_usbmisc_ops },
>  	{ .compatible = "fsl,imx53-usbmisc", .data = (void *)&imx53_usbmisc_ops },
>  	{ .compatible = "fsl,imx6q-usbmisc", .data = (void *)&imx6q_usbmisc_ops },
>  	{ /* sentinel */ }
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 

Best Regards,
Peter Chen
