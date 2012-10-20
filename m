From: florian@openwrt.org (Florian Fainelli)
Date: Sat, 20 Oct 2012 15:01:18 +0200
Subject: [PATCH 1/2] USB: Update EHCI-platform driver to devicetree.
In-Reply-To: <1350703053-4661-2-git-send-email-linux@prisktech.co.nz>
References: <1350703053-4661-1-git-send-email-linux@prisktech.co.nz>
 <1350703053-4661-2-git-send-email-linux@prisktech.co.nz>
Message-ID: <2209384.BKaXW2gI8I@bender>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Saturday 20 October 2012 16:17:32 Tony Prisk wrote:
> This patch adds devicetree support to the EHCI-platform driver,
> and removes the now unneeded ehci-vt8500.c
> 
> Existing platform properties are maintained, with the exception
> the power_(on/off) and suspend function pointers.

Ok, so I have recently sent a bit patchset to remove most OHCI/EHCI drivers
that could be converted to the generic variants, series starts here:
1349701906-16481-1-git-send-email-florian at openwrt.org

in this patchset I added a new property to the EHCI platform data:
need_io_watchdog, which needs to be handled too from DT ideally.

Adding device tree bindings is on my TODO after having a generic way
to pass clocks to the ehci/ohci platform drivers, so you are right on time :)

[snip]

> +	if (np) {
> +		/*
> +		 * No platform data is being passed, so initalize pdata.
> +		 * Limitation: we can't support power_on, power_off or
> +		 * power_suspend function pointers from DT.
> +		 * TODO: The missing functions could be replaced with
> +		 * power sequence handlers.
> +		 */
> +		pdata = devm_kzalloc(&dev->dev, sizeof(*pdata), GFP_KERNEL);

Missing allocation failure handling here. And you should free this in
ehci_platform_remove() accordingly.

> +		dev->dev.platform_data = pdata;
> +
> +		/* Read the optional properties from DT node */
> +		of_property_read_u32(np, "caps-offset", &pdata->caps_offset);
> +		if (of_property_read_bool(np, "has-tt"))
> +			pdata->has_tt = 1;
> +		if (of_property_read_bool(np, "has-synopsys-hc-bug"))
> +			pdata->has_synopsys_hc_bug = 1;
> +		if (of_property_read_bool(np, "big-endian-desc"))
> +			pdata->big_endian_desc = 1;
> +		if (of_property_read_bool(np, "big-endian-mmio"))
> +			pdata->big_endian_mmio = 1;

I would rather we remain compatible with ehci-ppc-of, by handling the 
big-endian property you set big_endian_mmiod and big_endian_desc to 1, and
by setting them individually, you get what you expect.

> +
> +		/* Right now device-tree probed devices don't get dma_mask set.
> +		 * Since shared usb code relies on it, set it here for now.
> +		 * Once we have dma capability bindings this can go away.
> +		 */
> +		if (!dev->dev.dma_mask)
> +			dev->dev.dma_mask = &ehci_dma_mask;
> +	}
> +
>  	if (!pdata) {
>  		WARN_ON(1);
>  		return -ENODEV;
> @@ -215,6 +250,16 @@ static const struct platform_device_id ehci_platform_table[] = {
>  	{ "ehci-platform", 0 },
>  	{ }
>  };
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id ehci_platform_ids[] = {
> +	{ .compatible = "ehci-platform", },
> +	{}

ehci-platform is very linux-specific, so this should either be:
"linux,ehci-platform", or "usb-ehci", pretty much like the ppc-of ehci driver.
-- 
Florian
