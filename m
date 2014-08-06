From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Aug 2014 23:07:18 +0200
Subject: [PATCH v3 2/6] usb: host: ehci-st: Add EHCI support for ST STB
 devices
In-Reply-To: <1407344589-24863-3-git-send-email-peter.griffin@linaro.org>
References: <1407344589-24863-1-git-send-email-peter.griffin@linaro.org>
 <1407344589-24863-3-git-send-email-peter.griffin@linaro.org>
Message-ID: <201408062307.18851.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 August 2014, Peter Griffin wrote:

> +static int st_ehci_platform_reset(struct usb_hcd *hcd)
> +{
> +	struct platform_device *pdev = to_platform_device(hcd->self.controller);
> +	struct usb_ehci_pdata *pdata = dev_get_platdata(&pdev->dev);
> +	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
> +	int retval;
> +
> +	if (pdata->pre_setup) {
> +		retval = pdata->pre_setup(hcd);
> +		if (retval < 0)
> +			return retval;
> +	}

What is the point in going through a platform data function pointer here?
Can't you just open-code st_ehci_configure_bus() here?

> +static int st_ehci_platform_probe(struct platform_device *dev)
> +{
> +	struct usb_hcd *hcd;
> +	struct resource *res_mem;
> +	struct usb_ehci_pdata *pdata = dev_get_platdata(&dev->dev);
> +	struct st_platform_priv *priv;
> +	struct ehci_hcd *ehci;
> +	int err, irq, clk = 0;
> +
> +	if (usb_disabled())
> +		return -ENODEV;
> +
> +	/*
> +	 * Use reasonable defaults so platforms don't have to provide these
> +	 * with DT probing on ARM.
> +	 */
> +	if (!pdata)
> +		pdata = &ehci_platform_defaults;

How would you ever get here with pdata set?

> +	err = dma_coerce_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32));
> +	if (err)
> +		return err;

Remove this here, and rely on the correct mask to be set from the DT scan.

	Arnd
