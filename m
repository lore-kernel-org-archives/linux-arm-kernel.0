From: balbi@ti.com (Felipe Balbi)
Date: Mon, 17 Nov 2014 17:12:40 -0600
Subject: [PATCH V5 09/12] usb: xhci: Add NVIDIA Tegra xHCI
 host-controller driver
In-Reply-To: <1416264102-1323-10-git-send-email-abrestic@chromium.org>
References: <1416264102-1323-1-git-send-email-abrestic@chromium.org>
 <1416264102-1323-10-git-send-email-abrestic@chromium.org>
Message-ID: <20141117231240.GB9716@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 17, 2014 at 02:41:39PM -0800, Andrew Bresticker wrote:
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index a3ca137..e2415d3 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -50,6 +50,15 @@ config USB_XHCI_RCAR
>  	  Say 'Y' to enable the support for the xHCI host controller
>  	  found in Renesas R-Car ARM SoCs.
>  
> +config USB_XHCI_TEGRA
> +	tristate "xHCI support for NVIDIA Tegra SoCs"
> +	depends on ARCH_TEGRA

it would be nice if you could still leave || COMPILE_TEST here.

[snip]

> +static const struct {
> +	const char *name;
> +	unsigned int num;
> +} tegra_xhci_phy_types[] = {
> +	{
> +		.name = "usb3",
> +		.num = TEGRA_XUSB_USB3_PHYS,
> +	}, {
> +		.name = "utmi",
> +		.num = TEGRA_XUSB_UTMI_PHYS,
> +	}, {
> +		.name = "hsic",
> +		.num = TEGRA_XUSB_HSIC_PHYS,
> +	},

these should be using the generic PHY subsystem (drivers/phy).

> +static int tegra_xhci_load_firmware(struct tegra_xhci_hcd *tegra)
> +{
> +	struct device *dev = tegra->dev;
> +	struct tegra_xhci_fw_cfgtbl *cfg_tbl;
> +	struct tm fw_tm;
> +	u32 val, code_tag_blocks, code_size_blocks;
> +	u64 fw_base;
> +	time_t fw_time;
> +	unsigned long timeout;
> +
> +	if (csb_readl(tegra, XUSB_CSB_MP_ILOAD_BASE_LO) != 0) {
> +		dev_info(dev, "Firmware already loaded, Falcon state 0x%x\n",
> +			 csb_readl(tegra, XUSB_FALC_CPUCTL));
> +		return 0;
> +	}

won't this prevent rmmod && insmod from succeeding ? Maybe not, as you
return 0 anyway, but if the firmware side craps out, it might be useful
to reload the firmware and reset that block. I wonder if this prevents
that.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141117/daf8af31/attachment.sig>
