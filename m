From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 2 Aug 2017 12:06:57 +0530
Subject: [PATCH v2 5/6] phy: Add USB3 PHY support for Broadcom NS2 SoC
In-Reply-To: <1501109787-15489-6-git-send-email-jon.mason@broadcom.com>
References: <1501109787-15489-1-git-send-email-jon.mason@broadcom.com>
 <1501109787-15489-6-git-send-email-jon.mason@broadcom.com>
Message-ID: <9f25daa0-13b3-2a56-34bb-f3705672fae5@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 27 July 2017 04:26 AM, Jon Mason wrote:
> From: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
> 
> This patch adds support for Broadcom NS2 USB3 PHY
> 
> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
> ---
>  drivers/phy/broadcom/Kconfig            |   9 +
>  drivers/phy/broadcom/Makefile           |   1 +
>  drivers/phy/broadcom/phy-bcm-ns2-usb3.c | 580 ++++++++++++++++++++++++++++++++
>  3 files changed, 590 insertions(+)
>  create mode 100644 drivers/phy/broadcom/phy-bcm-ns2-usb3.c
> 
> diff --git a/drivers/phy/broadcom/Kconfig b/drivers/phy/broadcom/Kconfig
> index 37371b89b14f..e7d238efd539 100644
> --- a/drivers/phy/broadcom/Kconfig
> +++ b/drivers/phy/broadcom/Kconfig
> @@ -45,6 +45,15 @@ config PHY_NS2_PCIE
>  	  Enable this to support the Broadcom Northstar2 PCIe PHY.
>  	  If unsure, say N.
>  
> +config PHY_NS2_USB3
> +	tristate "Broadcom NorthStar2 USB3 PHY driver"
> +	depends on OF && (ARCH_BCM_IPROC || COMPILE_TEST)
> +	select GENERIC_PHY

depends on MDIO_BUS?
> +	default ARCH_BCM_IPROC
> +	help
> +	  Enable this to support the Broadcom Northstar2 USB3 PHY.
> +	  If unsure, say N.
> +
>  config PHY_NS2_USB_DRD
>  	tristate "Broadcom Northstar2 USB DRD PHY support"
>  	depends on OF && (ARCH_BCM_IPROC || COMPILE_TEST)
> diff --git a/drivers/phy/broadcom/Makefile b/drivers/phy/broadcom/Makefile
> index 4eb82ec8d491..a40e6e6f56b8 100644
> --- a/drivers/phy/broadcom/Makefile
> +++ b/drivers/phy/broadcom/Makefile
> @@ -3,5 +3,6 @@ obj-$(CONFIG_BCM_KONA_USB2_PHY)		+= phy-bcm-kona-usb2.o
>  obj-$(CONFIG_PHY_BCM_NS_USB2)		+= phy-bcm-ns-usb2.o
>  obj-$(CONFIG_PHY_BCM_NS_USB3)		+= phy-bcm-ns-usb3.o
>  obj-$(CONFIG_PHY_NS2_PCIE)		+= phy-bcm-ns2-pcie.o
> +obj-$(CONFIG_PHY_NS2_USB3)		+= phy-bcm-ns2-usb3.o
>  obj-$(CONFIG_PHY_NS2_USB_DRD)		+= phy-bcm-ns2-usbdrd.o
>  obj-$(CONFIG_PHY_BRCM_SATA)		+= phy-brcm-sata.o
> diff --git a/drivers/phy/broadcom/phy-bcm-ns2-usb3.c b/drivers/phy/broadcom/phy-bcm-ns2-usb3.c
> new file mode 100644
> index 000000000000..7f272757434b
> --- /dev/null
> +++ b/drivers/phy/broadcom/phy-bcm-ns2-usb3.c
> @@ -0,0 +1,580 @@
> +/*
> + * Copyright (C) 2016 Broadcom
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/mdio.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/phy/phy.h>
> +
> +#define NS2_USB3_PHY_MAX			0x02
> +
> +#define NS2_USB3_PHY_CONFIG_CTRL_REG		0x10
> +#define NS2_USB3_PHY_CONFIG_CTRL_MASK		(BIT(3) | BIT(4) | BIT(5))
> +#define NS2_USB3_PHY_CONFIG_CTRL_PLL_SEQ_START	BIT(6)
> +
> +#define NS2_USB3_PHY_P0CTL_REG			0x14
> +#define NS2_USB3_PHY_P1CTL_REG			0x18
> +#define NS2_USB3_PHY_PXCTL_I_BIT		BIT(1)
> +
> +#define NS2_USB3_PHY_MISC_STATUS_REG		0x20
> +
> +#define NS2_IDM_RST_CTRL_P0_OFFSET		0x800
> +#define NS2_IDM_RST_CTRL_P1_OFFSET		0x1800
> +#define NS2_IDM_RESET_CONTROL_BIT		BIT(0)
> +
> +#define NS2_IDM_IO_CTRL_P0_OFFSET		0x408
> +#define NS2_IDM_IO_CTRL_P1_OFFSET		0x1408
> +/* Bit 23 for PPC Polarity, Bit 24 for PPC NANDNOR select */
> +#define NS2_IDM_IO_CTRL_PPC_CFG			(BIT(23) | BIT(24))
> +
> +#define NS2_PHY_RESET_BIT			BIT(5)
> +#define NS2_PHY_PLL_RESET_BIT			BIT(6)
> +
> +/* NS2 USB3 MDIO */
> +#define NS2_USB3_MDIO_PLL30_ADDR		0x8000
> +#define NS2_USB3_MDIO_BLK_ACCESS		0x1F
> +#define NS2_USB3_MDIO_PLL30_ANAPLL_CTRL		0x14
> +#define NS2_USB3_MDIO_PLL30_ANAPLL_CTRL_VAL	0x23
> +#define NS2_USB3_MDIO_PLL30_GEN_PLL		0xF
> +#define NS2_USB3_MDIO_PLL30_GEN_PLL_PCLK_SEL	BIT(11)
> +#define NS2_USB3_MDIO_P0_AFE30_ADDR		0x8080
> +#define NS2_USB3_MDIO_P1_AFE30_ADDR		0x9080
> +#define NS2_USB3_MDIO_AFE30_RX_SIG_DETECT	0x5
> +#define NS2_USB3_MDIO_AFE30_RX_SIG_DETECT_VAL	0xAC0D
> +
> +#define NS2_USB3_MDIO_P0_PIPE_BLK_ADDR		0x8060
> +#define NS2_USB3_MDIO_P1_PIPE_BLK_ADDR		0x9060
> +#define NS2_USB3_MDIO_PIPE_BLK_REG_1_OFFSET	0x1
> +#define NS2_USB3_MDIO_PIPE_BLK_REG_1_VAL	0x207
> +
> +#define NS2_USB3_MDIO_P0_AEQ_BLK_ADDR		0x80E0
> +#define NS2_USB3_MDIO_P1_AEQ_BLK_ADDR		0x90E0

Looking at the register offsets, P0 and P1 can be abstracted IMO. i.e you can
simply have 'NS2_USB3_MDIO_PIPE_BLK_ADDR_OFFSET 0x60' and the base address can
come from dt. For P0 it should be 0x8000 and P1 it should be 0x9000.

Then when the consumer requests for initialization of P0, it can be just
P0 base address + S2_USB3_MDIO_PIPE_BLK_ADDR_OFFSET and likewise for P1.

Same thing is applicable for NS2_USB3_MDIO_P0_AEQ_BLK_ADDR,
NS2_USB3_MDIO_P0_AFE30_ADDR etc.

Thanks
Kishon
