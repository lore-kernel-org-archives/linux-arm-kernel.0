From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 24 Feb 2014 15:09:58 +0530
Subject: [PATCH v3 1/4] ARM: sunxi: Add driver for sunxi usb phy
In-Reply-To: <1393157352-21104-2-git-send-email-hdegoede@redhat.com>
References: <1393157352-21104-1-git-send-email-hdegoede@redhat.com>
 <1393157352-21104-2-git-send-email-hdegoede@redhat.com>
Message-ID: <530B136E.8080702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sunday 23 February 2014 05:39 PM, Hans de Goede wrote:
> The Allwinner A1x / A2x SoCs have 2 or 3 usb phys which are all accessed
> through a single set of registers. Besides this there are also some other
> phy related bits which need poking, which are per phy, but shared between the
> ohci and ehci controllers, so these are also controlled from this new phy
> driver.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../devicetree/bindings/phy/sun4i-usb-phy.txt      |  26 ++
>  drivers/phy/Kconfig                                |  11 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/phy-sun4i-usb.c                        | 329 +++++++++++++++++++++
>  4 files changed, 367 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
>  create mode 100644 drivers/phy/phy-sun4i-usb.c
> 
> diff --git a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
> new file mode 100644
> index 0000000..a82361b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
> @@ -0,0 +1,26 @@
> +Allwinner sun4i USB PHY
> +-----------------------
> +
> +Required properties:
> +- compatible : should be one of "allwinner,sun4i-a10-usb-phy",
> +  "allwinner,sun5i-a13-usb-phy" or "allwinner,sun7i-a20-usb-phy"
> +- reg : a list of offset + length pairs
> +- reg-names : "phy_ctrl", "pmu1" and for sun4i or sun7i "pmu2"
> +- #phy-cells : from the generic phy bindings, must be 1
> +- clocks : phandle + clock specifier for the phy clock
> +- clock-names : "usb_phy"
> +- resets : a list of phandle + reset specifier pairs
> +- reset-names : "usb0_reset", "usb1_reset" and for sun4i or sun7i "usb2_reset"
> +
> +Example:
> +	usbphy: phy at 0x01c13400 {
> +		#phy-cells = <1>;
> +		compatible = "allwinner,sun4i-a10-usb-phy";
> +		/* phy base regs, phy1 pmu reg, phy2 pmu reg */
> +		reg = <0x01c13400 0x10 0x01c14800 0x4 0x01c1c800 0x4>;
> +		reg-names = "phy_ctrl", "pmu1", "pmu2";
> +		clocks = <&usb_clk 8>;
> +		clock-names = "usb_phy";
> +		resets = <&usb_clk 1>, <&usb_clk 2>;
> +		reset-names = "usb1_reset", "usb2_reset";
> +	};
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 4ef8755..6e336b4 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -64,4 +64,15 @@ config BCM_KONA_USB2_PHY
>  	help
>  	  Enable this to support the Broadcom Kona USB 2.0 PHY.
>  
> +config PHY_SUN4I_USB
> +	tristate "Allwinner sunxi SoC USB PHY driver"
> +	depends on ARCH_SUNXI
> +	select GENERIC_PHY

recently some errors have been reported if you don't have depends on HAS_IOMEM.
Also add depends on CONFIG_OF.


> +	help
> +	  Enable this to support the transceiver that is part of Allwinner
> +	  sunxi SoCs.
> +
> +	  This driver controls the entire USB PHY block, both the USB OTG
> +	  parts, as well as the 2 regular USB 2 host PHYs.
> +
>  endmenu
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index b57c253..9d4f8bb 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_PHY_EXYNOS_MIPI_VIDEO)	+= phy-exynos-mipi-video.o
>  obj-$(CONFIG_PHY_MVEBU_SATA)		+= phy-mvebu-sata.o
>  obj-$(CONFIG_OMAP_USB2)			+= phy-omap-usb2.o
>  obj-$(CONFIG_TWL4030_USB)		+= phy-twl4030-usb.o
> +obj-$(CONFIG_PHY_SUN4I_USB)		+= phy-sun4i-usb.o
> diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
> new file mode 100644
> index 0000000..31c4611
> --- /dev/null
> +++ b/drivers/phy/phy-sun4i-usb.c
> @@ -0,0 +1,329 @@
> +/*
> + * Allwinner sun4i USB phy driver
> + *
> + * Copyright (C) 2014 Hans de Goede <hdegoede@redhat.com>
> + *
> + * Based on code from
> + * Allwinner Technology Co., Ltd. <www.allwinnertech.com>
> + *
> + * Modelled after: Samsung S5P/EXYNOS SoC series MIPI CSIS/DSIM DPHY driver
> + * Copyright (C) 2013 Samsung Electronics Co., Ltd.
> + * Author: Sylwester Nawrocki <s.nawrocki@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
> +
> +#define REG_ISCR			0x00
> +#define REG_PHYCTL			0x04
> +#define REG_PHYBIST			0x08
> +#define REG_PHYTUNE			0x0c
> +
> +#define SUNXI_AHB_ICHR8_EN		BIT(10)
> +#define SUNXI_AHB_INCR4_BURST_EN	BIT(9)
> +#define SUNXI_AHB_INCRX_ALIGN_EN	BIT(8)
> +#define SUNXI_ULPI_BYPASS_EN		BIT(0)
> +
> +/* Common Control Bits for Both PHYs */
> +#define PHY_PLL_BW			0x03
> +#define PHY_RES45_CAL_EN		0x0c
> +
> +/* Private Control Bits for Each PHY */
> +#define PHY_TX_AMPLITUDE_TUNE		0x20
> +#define PHY_TX_SLEWRATE_TUNE		0x22
> +#define PHY_VBUSVALID_TH_SEL		0x25
> +#define PHY_PULLUP_RES_SEL		0x27
> +#define PHY_OTG_FUNC_EN			0x28
> +#define PHY_VBUS_DET_EN			0x29
> +#define PHY_DISCON_TH_SEL		0x2a
> +
> +#define MAX_PHYS			3
> +
> +struct sun4i_usb_phy_data {
> +	struct clk *clk;
> +	void __iomem *base;
> +	struct mutex mutex;
> +	int num_phys;
> +	u32 disc_thresh;
> +	struct sun4i_usb_phy {
> +		struct phy *phy;
> +		void __iomem *pmu;
> +		struct regulator *vbus;
> +		struct reset_control *reset;
> +		int index;
> +	} phys[MAX_PHYS];
> +};
> +
> +#define to_sun4i_usb_phy_data(phy) \
> +	container_of((phy), struct sun4i_usb_phy_data, phys[(phy)->index])
> +
> +static void sun4i_usb_phy_write(struct sun4i_usb_phy *phy, u32 addr, u32 data,
> +				int len)
> +{
> +	struct sun4i_usb_phy_data *phy_data = to_sun4i_usb_phy_data(phy);
> +	u32 temp, usbc_bit = BIT(phy->index * 2);
> +	int i;
> +
> +	mutex_lock(&phy_data->mutex);
> +
> +	for (i = 0; i < len; i++) {
> +		temp = readl(phy_data->base + REG_PHYCTL);
> +
> +		/* clear the address portion */
> +		temp &= ~(0xff << 8);
> +
> +		/* set the address */
> +		temp |= ((addr + i) << 8);
> +		writel(temp, phy_data->base + REG_PHYCTL);
> +
> +		/* set the data bit and clear usbc bit*/
> +		temp = readb(phy_data->base + REG_PHYCTL);
> +		if (data & 0x1)
> +			temp |= BIT(7);

>From the comment, I assume it to be a data bit. Let's add a macro for it?

If you can fix these minor comments while changing the $subject (PHY: sunxi) it
should be good to get merged.

Thanks
Kishon
