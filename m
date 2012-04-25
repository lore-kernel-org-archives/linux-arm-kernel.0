From: balbi@ti.com (Felipe Balbi)
Date: Wed, 25 Apr 2012 14:25:20 +0300
Subject: [PATCHv3 1/4] ARM: tegra: Add AHB driver
In-Reply-To: <1335352072-4001-1-git-send-email-hdoyu@nvidia.com>
References: <1335352072-4001-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <20120425112519.GB3564@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2012 at 02:07:36PM +0300, Hiroshi DOYU wrote:
> The AHB Bus conforms to the AMBA Specification (Rev 2.0) Advanced
> High-performance Bus (AHB) architecture.
> 
> The AHB Arbiter controls AHB bus master arbitration. This effectively
> forms a second level of arbitration for access to the memory
> controller through the AHB Slave Memory device. The AHB pre-fetch
> logic can be configured to enhance performance for devices doing
> sequential access. Each AHB master is assigned to either the high or
> low priority bin. Both Tegra20/30 have this AHB bus.
> 
> Some of configuration param could be passed from DT too.
> 
> Signed-off-by: Hiroshi DOYU <hdoyu@nvidia.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
> v4:
> Fixed the comments from Felipe/Russell.
> This is now located under drivers/platform/arm.
> v3:
> Use platform_device to get info from dt dynamically.(Felipe/Arnd)
> 
> Signed-off-by: Hiroshi DOYU <hdoyu@nvidia.com>

Just one thing, you seem to have missed Russell's comment about this
driver being generic. You still add a TEGRA_AHB driver, also, you don't
need <mach/iomap.h>. Apart from those, you can add:

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/platform/Kconfig         |    5 +
>  drivers/platform/Makefile        |    1 +
>  drivers/platform/arm/Kconfig     |    8 +
>  drivers/platform/arm/Makefile    |    5 +
>  drivers/platform/arm/tegra-ahb.c |  278 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 297 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
> index 8390dca..8b96a77 100644
> --- a/drivers/platform/Kconfig
> +++ b/drivers/platform/Kconfig
> @@ -1,3 +1,8 @@
>  if X86
>  source "drivers/platform/x86/Kconfig"
>  endif
> +
> +if ARM
> +source "drivers/platform/arm/Kconfig"
> +endif
> +
> diff --git a/drivers/platform/Makefile b/drivers/platform/Makefile
> index 782953a..7a2b16f 100644
> --- a/drivers/platform/Makefile
> +++ b/drivers/platform/Makefile
> @@ -3,3 +3,4 @@
>  #
>  
>  obj-$(CONFIG_X86)		+= x86/
> +obj-$(CONFIG_ARM)		+= arm/
> diff --git a/drivers/platform/arm/Kconfig b/drivers/platform/arm/Kconfig
> new file mode 100644
> index 0000000..0af31db
> --- /dev/null
> +++ b/drivers/platform/arm/Kconfig
> @@ -0,0 +1,8 @@
> +config TEGRA_AHB
> +	bool "Enable AHB driver for NVIDIA Tegra SoCs"
> +	depends on ARCH_TEGRA
> +	default y
> +	help
> +	  Adds AHB configuration functionality for NVIDIA Tegra SoCs,
> +	  which controls AHB bus master arbitration and some
> +	  perfomance parameters(priority, prefech size).
> diff --git a/drivers/platform/arm/Makefile b/drivers/platform/arm/Makefile
> new file mode 100644
> index 0000000..3535f56
> --- /dev/null
> +++ b/drivers/platform/arm/Makefile
> @@ -0,0 +1,5 @@
> +#
> +# Makefile for linux/drivers/platform/arm
> +# ARM Platform-Specific Drivers
> +#
> +obj-$(CONFIG_TEGRA_AHB)		+= tegra-ahb.o
> diff --git a/drivers/platform/arm/tegra-ahb.c b/drivers/platform/arm/tegra-ahb.c
> new file mode 100644
> index 0000000..dcad2ec
> --- /dev/null
> +++ b/drivers/platform/arm/tegra-ahb.c
> @@ -0,0 +1,278 @@
> +/*
> + * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
> + * Copyright (C) 2011 Google, Inc.
> + *
> + * Author:
> + *	Jay Cheng <jacheng@nvidia.com>
> + *	James Wylder <james.wylder@motorola.com>
> + *	Benoit Goby <benoit@android.com>
> + *	Colin Cross <ccross@android.com>
> + *	Hiroshi DOYU <hdoyu@nvidia.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +
> +#include <mach/iomap.h>

why do you need mach/iomap.h ?

> +#define DRV_NAME "tegra-ahb"
> +
> +#define AHB_ARBITRATION_DISABLE		0x00
> +#define AHB_ARBITRATION_PRIORITY_CTRL	0x04
> +#define   AHB_PRIORITY_WEIGHT(x)	(((x) & 0x7) << 29)
> +#define   PRIORITY_SELECT_USB BIT(6)
> +#define   PRIORITY_SELECT_USB2 BIT(18)
> +#define   PRIORITY_SELECT_USB3 BIT(17)
> +
> +#define AHB_GIZMO_AHB_MEM		0x0c
> +#define   ENB_FAST_REARBITRATE BIT(2)
> +#define   DONT_SPLIT_AHB_WR     BIT(7)
> +
> +#define AHB_GIZMO_APB_DMA		0x10
> +#define AHB_GIZMO_IDE			0x18
> +#define AHB_GIZMO_USB			0x1c
> +#define AHB_GIZMO_AHB_XBAR_BRIDGE	0x20
> +#define AHB_GIZMO_CPU_AHB_BRIDGE	0x24
> +#define AHB_GIZMO_COP_AHB_BRIDGE	0x28
> +#define AHB_GIZMO_XBAR_APB_CTLR		0x2c
> +#define AHB_GIZMO_VCP_AHB_BRIDGE	0x30
> +#define AHB_GIZMO_NAND			0x3c
> +#define AHB_GIZMO_SDMMC4		0x44
> +#define AHB_GIZMO_XIO			0x48
> +#define AHB_GIZMO_BSEV			0x60
> +#define AHB_GIZMO_BSEA			0x70
> +#define AHB_GIZMO_NOR			0x74
> +#define AHB_GIZMO_USB2			0x78
> +#define AHB_GIZMO_USB3			0x7c
> +#define   IMMEDIATE	BIT(18)
> +
> +#define AHB_GIZMO_SDMMC1		0x80
> +#define AHB_GIZMO_SDMMC2		0x84
> +#define AHB_GIZMO_SDMMC3		0x88
> +#define AHB_MEM_PREFETCH_CFG_X		0xd8
> +#define AHB_ARBITRATION_XBAR_CTRL	0xdc
> +#define AHB_MEM_PREFETCH_CFG3		0xe0
> +#define AHB_MEM_PREFETCH_CFG4		0xe4
> +#define AHB_MEM_PREFETCH_CFG1		0xec
> +#define AHB_MEM_PREFETCH_CFG2		0xf0
> +#define   PREFETCH_ENB	BIT(31)
> +#define   MST_ID(x)	(((x) & 0x1f) << 26)
> +#define   AHBDMA_MST_ID	MST_ID(5)
> +#define   USB_MST_ID	MST_ID(6)
> +#define   USB2_MST_ID	MST_ID(18)
> +#define   USB3_MST_ID	MST_ID(17)
> +#define   ADDR_BNDRY(x)	(((x) & 0xf) << 21)
> +#define   INACTIVITY_TIMEOUT(x)	(((x) & 0xffff) << 0)
> +
> +#define AHB_ARBITRATION_AHB_MEM_WRQUE_MST_ID	0xf8
> +
> +static u32 tegra_ahb_gizmo[] = {
> +	AHB_ARBITRATION_DISABLE,
> +	AHB_ARBITRATION_PRIORITY_CTRL,
> +	AHB_GIZMO_AHB_MEM,
> +	AHB_GIZMO_APB_DMA,
> +	AHB_GIZMO_IDE,
> +	AHB_GIZMO_USB,
> +	AHB_GIZMO_AHB_XBAR_BRIDGE,
> +	AHB_GIZMO_CPU_AHB_BRIDGE,
> +	AHB_GIZMO_COP_AHB_BRIDGE,
> +	AHB_GIZMO_XBAR_APB_CTLR,
> +	AHB_GIZMO_VCP_AHB_BRIDGE,
> +	AHB_GIZMO_NAND,
> +	AHB_GIZMO_SDMMC4,
> +	AHB_GIZMO_XIO,
> +	AHB_GIZMO_BSEV,
> +	AHB_GIZMO_BSEA,
> +	AHB_GIZMO_NOR,
> +	AHB_GIZMO_USB2,
> +	AHB_GIZMO_USB3,
> +	AHB_GIZMO_SDMMC1,
> +	AHB_GIZMO_SDMMC2,
> +	AHB_GIZMO_SDMMC3,
> +	AHB_MEM_PREFETCH_CFG_X,
> +	AHB_ARBITRATION_XBAR_CTRL,
> +	AHB_MEM_PREFETCH_CFG3,
> +	AHB_MEM_PREFETCH_CFG4,
> +	AHB_MEM_PREFETCH_CFG1,
> +	AHB_MEM_PREFETCH_CFG2,
> +	AHB_ARBITRATION_AHB_MEM_WRQUE_MST_ID,
> +};
> +
> +struct tegra_ahb {
> +	void __iomem	*regs;
> +	void		*ctx;
> +	struct device	*dev;
> +};
> +
> +static inline u32 gizmo_readl(struct tegra_ahb *ahb, u32 offset)
> +{
> +	return readl(ahb->regs + offset);
> +}
> +
> +static inline void gizmo_writel(struct tegra_ahb *ahb, u32 value, u32 offset)
> +{
> +	writel(value, ahb->regs + offset);
> +}
> +
> +static int tegra_ahb_suspend(struct device *dev)
> +{
> +	int i;
> +	struct tegra_ahb *ahb = dev_get_drvdata(dev);
> +	u32 *p = ahb->ctx;
> +
> +	for (i = 0; i < ARRAY_SIZE(tegra_ahb_gizmo); i++)
> +		p[i] = gizmo_readl(ahb, tegra_ahb_gizmo[i]);
> +	return 0;
> +}
> +
> +static int tegra_ahb_resume(struct device *dev)
> +{
> +	int i;
> +	struct tegra_ahb *ahb = dev_get_drvdata(dev);
> +	u32 *p = ahb->ctx;
> +
> +	for (i = 0; i < ARRAY_SIZE(tegra_ahb_gizmo); i++)
> +		gizmo_writel(ahb, p[i], tegra_ahb_gizmo[i]);
> +	return 0;
> +}
> +
> +static UNIVERSAL_DEV_PM_OPS(tegra_ahb_pm,
> +			    tegra_ahb_suspend,
> +			    tegra_ahb_resume, NULL);
> +
> +static void tegra_ahb_gizmo_init(struct tegra_ahb *ahb)
> +{
> +	u32 val;
> +
> +	val = gizmo_readl(ahb, AHB_GIZMO_AHB_MEM);
> +	val |= ENB_FAST_REARBITRATE | IMMEDIATE | DONT_SPLIT_AHB_WR;
> +	gizmo_writel(ahb, val, AHB_GIZMO_AHB_MEM);
> +
> +	val = gizmo_readl(ahb, AHB_GIZMO_USB);
> +	val |= IMMEDIATE;
> +	gizmo_writel(ahb, val, AHB_GIZMO_USB);
> +
> +	val = gizmo_readl(ahb, AHB_GIZMO_USB2);
> +	val |= IMMEDIATE;
> +	gizmo_writel(ahb, val, AHB_GIZMO_USB2);
> +
> +	val = gizmo_readl(ahb, AHB_GIZMO_USB3);
> +	val |= IMMEDIATE;
> +	gizmo_writel(ahb, val, AHB_GIZMO_USB3);
> +
> +	val = gizmo_readl(ahb, AHB_ARBITRATION_PRIORITY_CTRL);
> +	val |= PRIORITY_SELECT_USB |
> +		PRIORITY_SELECT_USB2 |
> +		PRIORITY_SELECT_USB3 |
> +		AHB_PRIORITY_WEIGHT(7);
> +	gizmo_writel(ahb, val, AHB_ARBITRATION_PRIORITY_CTRL);
> +
> +	val = gizmo_readl(ahb, AHB_MEM_PREFETCH_CFG1);
> +	val &= ~MST_ID(~0);
> +	val |= PREFETCH_ENB |
> +		AHBDMA_MST_ID |
> +		ADDR_BNDRY(0xc) |
> +		INACTIVITY_TIMEOUT(0x1000);
> +	gizmo_writel(ahb, val, AHB_MEM_PREFETCH_CFG1);
> +
> +	val = gizmo_readl(ahb, AHB_MEM_PREFETCH_CFG2);
> +	val &= ~MST_ID(~0);
> +	val |= PREFETCH_ENB |
> +		USB_MST_ID |
> +		ADDR_BNDRY(0xc) |
> +		INACTIVITY_TIMEOUT(0x1000);
> +	gizmo_writel(ahb, val, AHB_MEM_PREFETCH_CFG2);
> +
> +	val = gizmo_readl(ahb, AHB_MEM_PREFETCH_CFG3);
> +	val &= ~MST_ID(~0);
> +	val |= PREFETCH_ENB |
> +		USB3_MST_ID |
> +		ADDR_BNDRY(0xc) |
> +		INACTIVITY_TIMEOUT(0x1000);
> +	gizmo_writel(ahb, val, AHB_MEM_PREFETCH_CFG3);
> +
> +	val = gizmo_readl(ahb, AHB_MEM_PREFETCH_CFG4);
> +	val &= ~MST_ID(~0);
> +	val |= PREFETCH_ENB |
> +		USB2_MST_ID |
> +		ADDR_BNDRY(0xc) |
> +		INACTIVITY_TIMEOUT(0x1000);
> +	gizmo_writel(ahb, val, AHB_MEM_PREFETCH_CFG4);
> +}
> +
> +static int __devinit tegra_ahb_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct tegra_ahb *ahb;
> +	size_t bytes;
> +
> +	bytes = sizeof(*ahb) + sizeof(u32) * ARRAY_SIZE(tegra_ahb_gizmo);
> +	ahb = devm_kzalloc(&pdev->dev, bytes, GFP_KERNEL);
> +	if (!ahb)
> +		return -ENOMEM;
> +	ahb->ctx = ahb + 1;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +	ahb->regs = devm_request_and_ioremap(&pdev->dev, res);
> +	if (!ahb->regs)
> +		return -EBUSY;
> +
> +	ahb->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, ahb);
> +	tegra_ahb_gizmo_init(ahb);
> +	return 0;
> +}
> +
> +static int __devexit tegra_ahb_remove(struct platform_device *pdev)
> +{
> +	platform_set_drvdata(pdev, NULL);
> +	return 0;
> +}
> +
> +static const struct of_device_id tegra_ahb_of_match[] __devinitconst = {
> +	{ .compatible = "nvidia,tegra30-ahb", },
> +	{ .compatible = "nvidia,tegra20-ahb", },
> +	{},
> +};
> +
> +static struct platform_driver tegra_ahb_driver = {
> +	.probe = tegra_ahb_probe,
> +	.remove = __devexit_p(tegra_ahb_remove),
> +	.driver = {
> +		.name = DRV_NAME,
> +		.owner = THIS_MODULE,
> +		.of_match_table = tegra_ahb_of_match,
> +		.pm = &tegra_ahb_pm,
> +	},
> +};
> +
> +static int __init tegra_ahb_init(void)
> +{
> +	return platform_driver_register(&tegra_ahb_driver);
> +}
> +postcore_initcall(tegra_ahb_init);
> +
> +static void __exit tegra_ahb_exit(void)
> +{
> +	platform_driver_unregister(&tegra_ahb_driver);
> +}
> +module_exit(tegra_ahb_exit);
> +
> +MODULE_AUTHOR("Hiroshi DOYU <hdoyu@nvidia.com>");
> +MODULE_DESCRIPTION("Tegra AHB driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:" DRV_NAME);
> -- 
> 1.7.5.4
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120425/9032deba/attachment-0001.sig>
