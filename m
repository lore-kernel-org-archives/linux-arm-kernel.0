From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon,  8 Apr 2013 21:46:03 +0200
Subject: [PATCH] ARM i.MX53: remove platform ahci support
In-Reply-To: <1365431039.1830.102.camel@x61.thuisdomein>
References: <1365431039.1830.102.camel@x61.thuisdomein>
Message-ID: <1365450363-6582-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX53 ahci platform support is unused in mainline. To demotivate
people using it just remove it from the tree.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---

Paul, with this one applied you could also remove config ARCH_MX53.

 arch/arm/plat-mxc/devices/Kconfig               |   4 -
 arch/arm/plat-mxc/devices/Makefile              |   1 -
 arch/arm/plat-mxc/devices/platform-ahci-imx.c   | 156 ------------------------
 arch/arm/plat-mxc/include/mach/devices-common.h |  10 --
 4 files changed, 171 deletions(-)
 delete mode 100644 arch/arm/plat-mxc/devices/platform-ahci-imx.c

diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index a35d984..02404d0 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -83,7 +83,3 @@ config IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 
 config IMX_HAVE_PLATFORM_SPI_IMX
 	bool
-
-config IMX_HAVE_PLATFORM_AHCI
-	bool
-	default y if ARCH_MX53
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index 76f3195..cd8d572 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -27,4 +27,3 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_RTC) += platform-mxc_rtc.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_W1) += platform-mxc_w1.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX) += platform-sdhci-esdhc-imx.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_SPI_IMX) +=  platform-spi_imx.o
-obj-$(CONFIG_IMX_HAVE_PLATFORM_AHCI) +=  platform-ahci-imx.o
diff --git a/arch/arm/plat-mxc/devices/platform-ahci-imx.c b/arch/arm/plat-mxc/devices/platform-ahci-imx.c
deleted file mode 100644
index ade4a1c..0000000
--- a/arch/arm/plat-mxc/devices/platform-ahci-imx.c
+++ /dev/null
@@ -1,156 +0,0 @@
-/*
- * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
- */
-
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
-
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
-
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#include <linux/io.h>
-#include <linux/clk.h>
-#include <linux/err.h>
-#include <linux/device.h>
-#include <linux/dma-mapping.h>
-#include <asm/sizes.h>
-#include <mach/hardware.h>
-#include <mach/devices-common.h>
-
-#define imx_ahci_imx_data_entry_single(soc, _devid)		\
-	{								\
-		.devid = _devid,					\
-		.iobase = soc ## _SATA_BASE_ADDR,			\
-		.irq = soc ## _INT_SATA,				\
-	}
-
-#ifdef CONFIG_SOC_IMX53
-const struct imx_ahci_imx_data imx53_ahci_imx_data __initconst =
-	imx_ahci_imx_data_entry_single(MX53, "imx53-ahci");
-#endif
-
-enum {
-	HOST_CAP = 0x00,
-	HOST_CAP_SSS = (1 << 27), /* Staggered Spin-up */
-	HOST_PORTS_IMPL	= 0x0c,
-	HOST_TIMER1MS = 0xe0, /* Timer 1-ms */
-};
-
-static struct clk *sata_clk, *sata_ref_clk;
-
-/* AHCI module Initialization, if return 0, initialization is successful. */
-static int imx_sata_init(struct device *dev, void __iomem *addr)
-{
-	u32 tmpdata;
-	int ret = 0;
-	struct clk *clk;
-
-	sata_clk = clk_get(dev, "ahci");
-	if (IS_ERR(sata_clk)) {
-		dev_err(dev, "no sata clock.\n");
-		return PTR_ERR(sata_clk);
-	}
-	ret = clk_prepare_enable(sata_clk);
-	if (ret) {
-		dev_err(dev, "can't prepare/enable sata clock.\n");
-		goto put_sata_clk;
-	}
-
-	/* Get the AHCI SATA PHY CLK */
-	sata_ref_clk = clk_get(dev, "ahci_phy");
-	if (IS_ERR(sata_ref_clk)) {
-		dev_err(dev, "no sata ref clock.\n");
-		ret = PTR_ERR(sata_ref_clk);
-		goto release_sata_clk;
-	}
-	ret = clk_prepare_enable(sata_ref_clk);
-	if (ret) {
-		dev_err(dev, "can't prepare/enable sata ref clock.\n");
-		goto put_sata_ref_clk;
-	}
-
-	/* Get the AHB clock rate, and configure the TIMER1MS reg later */
-	clk = clk_get(dev, "ahci_dma");
-	if (IS_ERR(clk)) {
-		dev_err(dev, "no dma clock.\n");
-		ret = PTR_ERR(clk);
-		goto release_sata_ref_clk;
-	}
-	tmpdata = clk_get_rate(clk) / 1000;
-	clk_put(clk);
-
-	writel(tmpdata, addr + HOST_TIMER1MS);
-
-	tmpdata = readl(addr + HOST_CAP);
-	if (!(tmpdata & HOST_CAP_SSS)) {
-		tmpdata |= HOST_CAP_SSS;
-		writel(tmpdata, addr + HOST_CAP);
-	}
-
-	if (!(readl(addr + HOST_PORTS_IMPL) & 0x1))
-		writel((readl(addr + HOST_PORTS_IMPL) | 0x1),
-			addr + HOST_PORTS_IMPL);
-
-	return 0;
-
-release_sata_ref_clk:
-	clk_disable_unprepare(sata_ref_clk);
-put_sata_ref_clk:
-	clk_put(sata_ref_clk);
-release_sata_clk:
-	clk_disable_unprepare(sata_clk);
-put_sata_clk:
-	clk_put(sata_clk);
-
-	return ret;
-}
-
-static void imx_sata_exit(struct device *dev)
-{
-	clk_disable_unprepare(sata_ref_clk);
-	clk_put(sata_ref_clk);
-
-	clk_disable_unprepare(sata_clk);
-	clk_put(sata_clk);
-
-}
-struct platform_device *__init imx_add_ahci_imx(
-		const struct imx_ahci_imx_data *data,
-		const struct ahci_platform_data *pdata)
-{
-	struct resource res[] = {
-		{
-			.start = data->iobase,
-			.end = data->iobase + SZ_4K - 1,
-			.flags = IORESOURCE_MEM,
-		}, {
-			.start = data->irq,
-			.end = data->irq,
-			.flags = IORESOURCE_IRQ,
-		},
-	};
-
-	return imx_add_platform_device_dmamask(data->devid, 0,
-			res, ARRAY_SIZE(res),
-			pdata, sizeof(*pdata),  DMA_BIT_MASK(32));
-}
-
-struct platform_device *__init imx53_add_ahci_imx(void)
-{
-	struct ahci_platform_data pdata = {
-		.init = imx_sata_init,
-		.exit = imx_sata_exit,
-	};
-
-	return imx_add_ahci_imx(&imx53_ahci_imx_data, &pdata);
-}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index eaf79d2..ab5f88c 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -329,13 +329,3 @@ struct platform_device *__init imx_add_spi_imx(
 struct platform_device *imx_add_imx_dma(void);
 struct platform_device *imx_add_imx_sdma(char *name,
 	resource_size_t iobase, int irq, struct sdma_platform_data *pdata);
-
-#include <linux/ahci_platform.h>
-struct imx_ahci_imx_data {
-	const char *devid;
-	resource_size_t iobase;
-	resource_size_t irq;
-};
-struct platform_device *__init imx_add_ahci_imx(
-		const struct imx_ahci_imx_data *data,
-		const struct ahci_platform_data *pdata);
-- 
1.8.2.rc2
