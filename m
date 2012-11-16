From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Fri, 16 Nov 2012 15:22:34 +0200
Subject: [PATCH v2 6/7] usb: chipidea: usbmisc: add mx53 support
In-Reply-To: <1352981028-14312-7-git-send-email-m.grzeschik@pengutronix.de>
References: <1352981028-14312-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352981028-14312-7-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <87obix65t1.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Grzeschik <m.grzeschik@pengutronix.de> writes:

> This adds mx53 as the next user of the usbmisc driver and makes it
> possible to disable the overcurrent-detection of the internal phy.
>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/usb/chipidea/usbmisc_imx.c |   28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
> index 913e414..9718500 100644
> --- a/drivers/usb/chipidea/usbmisc_imx.c
> +++ b/drivers/usb/chipidea/usbmisc_imx.c
> @@ -54,6 +54,29 @@ static struct usbmisc_usb_device *get_usbdev(struct device *dev)
>  	return &usbmisc->usbdev[i];
>  }
>  
> +static int usbmisc_imx53_init(struct device *dev)
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
> +	reg = usbmisc->base + usbdev->index * 8;
> +
> +	if (usbdev->disable_oc) {
> +		spin_lock_irqsave(&usbmisc->lock, flags);
> +		val = readl(reg);
> +		writel(val | (1 << 5), reg);

We know now that (1 << 5) probably means "disable overcurrent
detection", but is there a definition for this register's bits
somewhere?

Regards,
--
Alex
