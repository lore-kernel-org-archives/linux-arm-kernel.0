From: balbi@kernel.org (Felipe Balbi)
Date: Tue, 08 Nov 2016 11:12:10 +0200
Subject: [PATCH 01/30] usb: dwc2: Deprecate g-use-dma binding
In-Reply-To: <e99e9d8df77884671f94734109a1a8d76a0222c1.1478558343.git.johnyoun@synopsys.com>
References: <cover.1478558343.git.johnyoun@synopsys.com>
 <e99e9d8df77884671f94734109a1a8d76a0222c1.1478558343.git.johnyoun@synopsys.com>
Message-ID: <87wpgeibdh.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

John Youn <johnyoun@synopsys.com> writes:
> Add a vendor prefix and make the name more consistent by renaming it to
> "snps,gadget-dma-enable".
>
> Signed-off-by: John Youn <johnyoun@synopsys.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc2.txt | 5 ++++-
>  arch/arm/boot/dts/rk3036.dtsi                  | 2 +-
>  arch/arm/boot/dts/rk3288.dtsi                  | 2 +-
>  arch/arm/boot/dts/rk3xxx.dtsi                  | 2 +-
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi      | 2 +-
>  arch/arm64/boot/dts/rockchip/rk3368.dtsi       | 2 +-
>  drivers/usb/dwc2/params.c                      | 9 ++++++++-
>  drivers/usb/dwc2/pci.c                         | 2 +-
>  8 files changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
> index 9472111..389a461 100644
> --- a/Documentation/devicetree/bindings/usb/dwc2.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc2.txt
> @@ -26,11 +26,14 @@ Refer to phy/phy-bindings.txt for generic phy consumer properties
>  - dr_mode: shall be one of "host", "peripheral" and "otg"
>    Refer to usb/generic.txt
>  - snps,host-dma-disable: disable host DMA mode.
> -- g-use-dma: enable dma usage in gadget driver.
> +- snps,gadget-dma-enable: enable gadget DMA mode.

I don't see why you even have this binding. Looking through the code,
you have:

#define GHWCFG2_SLAVE_ONLY_ARCH			0
#define GHWCFG2_EXT_DMA_ARCH			1
#define GHWCFG2_INT_DMA_ARCH			2

void dwc2_set_param_dma_enable(struct dwc2_hsotg *hsotg, int val)
{
	int valid = 1;

	if (val > 0 && hsotg->hw_params.arch == GHWCFG2_SLAVE_ONLY_ARCH)
		valid = 0;
	if (val < 0)
		valid = 0;

	if (!valid) {
		if (val >= 0)
			dev_err(hsotg->dev,
				"%d invalid for dma_enable parameter. Check HW configuration.\n",
				val);
		val = hsotg->hw_params.arch != GHWCFG2_SLAVE_ONLY_ARCH;
		dev_dbg(hsotg->dev, "Setting dma_enable to %d\n", val);
	}

	hsotg->core_params->dma_enable = val;
}

which seems to hint that DMA support is discoverable. If there is DMA,
why would disable it?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161108/28908c8d/attachment-0001.sig>
