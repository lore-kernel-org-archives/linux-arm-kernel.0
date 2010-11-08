From: hzhuang1@marvell.com (Haojian Zhuang)
Date: Mon, 8 Nov 2010 05:05:59 -0800
Subject: [PATCH 1/2] ARM: mmp2: add mmc resource
In-Reply-To: <AANLkTimh8=ahG4itkAScyUwVfe0Q0uHS7ssiTVbD9mrq@mail.gmail.com>
References: <AANLkTimh8=ahG4itkAScyUwVfe0Q0uHS7ssiTVbD9mrq@mail.gmail.com>
Message-ID: <25B60CDC2F704E4E9D88FFD52780CB4C0598642CE7@SC-VEXCH1.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked by Haojian Zhuang

>-----Original Message-----
>From: zhangfei gao [mailto:zhangfei.gao at gmail.com]
>Sent: 2010?11?3? 5:06 PM
>To: linux-arm-kernel at lists.infradead.org
>Cc: Eric Miao; Haojian Zhuang; Chris Ball
>Subject: [PATCH 1/2] ARM: mmp2: add mmc resource
>
>From ee7c1135164abd1f7652462f17972cad3d96c795 Mon Sep 17 00:00:00 2001
>From: Zhangfei Gao <zhangfei.gao@marvell.com>
>Date: Wed, 29 Sep 2010 16:18:51 -0400
>Subject: [PATCH 1/2] ARM: mmp2: add mmc resource
>
>Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>---
> arch/arm/mach-mmp/include/mach/mmp2.h      |   22 +++++++++++++++++
> arch/arm/mach-mmp/include/mach/regs-apmu.h |    2 +
> arch/arm/mach-mmp/mmp2.c                   |   35 ++++++++++++++++++++++++++++
> 3 files changed, 59 insertions(+), 0 deletions(-)
>
>diff --git a/arch/arm/mach-mmp/include/mach/mmp2.h
>b/arch/arm/mach-mmp/include/mach/mmp2.h
>index dbba6e8..3c09cfb 100644
>--- a/arch/arm/mach-mmp/include/mach/mmp2.h
>+++ b/arch/arm/mach-mmp/include/mach/mmp2.h
>@@ -1,6 +1,8 @@
> #ifndef __ASM_MACH_MMP2_H
> #define __ASM_MACH_MMP2_H
>
>+#include <plat/sdhci.h>
>+
> struct sys_timer;
>
> extern struct sys_timer mmp2_timer;
>@@ -22,6 +24,10 @@ extern struct pxa_device_desc mmp2_device_twsi3;
> extern struct pxa_device_desc mmp2_device_twsi4;
> extern struct pxa_device_desc mmp2_device_twsi5;
> extern struct pxa_device_desc mmp2_device_twsi6;
>+extern struct pxa_device_desc mmp2_device_sdh0;
>+extern struct pxa_device_desc mmp2_device_sdh1;
>+extern struct pxa_device_desc mmp2_device_sdh2;
>+extern struct pxa_device_desc mmp2_device_sdh3;
>
> static inline int mmp2_add_uart(int id)
> {
>@@ -63,5 +69,21 @@ static inline int mmp2_add_twsi(int id, struct
>i2c_pxa_platform_data *data,
> 	return pxa_register_device(d, data, sizeof(*data));
> }
>
>+static inline int mmp2_add_sdh(int id, struct sdhci_pxa_platdata *data)
>+{
>+	struct pxa_device_desc *d = NULL;
>+
>+	switch (id) {
>+	case 0: d = &mmp2_device_sdh0; break;
>+	case 1: d = &mmp2_device_sdh1; break;
>+	case 2: d = &mmp2_device_sdh2; break;
>+	case 3: d = &mmp2_device_sdh3; break;
>+	default:
>+		return -EINVAL;
>+	}
>+
>+	return pxa_register_device(d, data, sizeof(*data));
>+}
>+
> #endif /* __ASM_MACH_MMP2_H */
>
>diff --git a/arch/arm/mach-mmp/include/mach/regs-apmu.h
>b/arch/arm/mach-mmp/include/mach/regs-apmu.h
>index ac47023..f7011ef 100644
>--- a/arch/arm/mach-mmp/include/mach/regs-apmu.h
>+++ b/arch/arm/mach-mmp/include/mach/regs-apmu.h
>@@ -27,6 +27,8 @@
> #define APMU_DMA	APMU_REG(0x064)
> #define APMU_GEU	APMU_REG(0x068)
> #define APMU_BUS	APMU_REG(0x06c)
>+#define APMU_SDH2	APMU_REG(0x0e8)
>+#define APMU_SDH3	APMU_REG(0x0ec)
>
> #define APMU_FNCLK_EN	(1 << 4)
> #define APMU_AXICLK_EN	(1 << 3)
>diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
>index daf3993..9ed3cd2 100644
>--- a/arch/arm/mach-mmp/mmp2.c
>+++ b/arch/arm/mach-mmp/mmp2.c
>@@ -115,6 +115,29 @@ void __init mmp2_init_irq(void)
> 	mmp2_init_gpio();
> }
>
>+static void sdhc_clk_enable(struct clk *clk)
>+{
>+	uint32_t clk_rst;
>+
>+	clk_rst  =  __raw_readl(clk->clk_rst);
>+	clk_rst |= clk->enable_val;
>+	__raw_writel(clk_rst, clk->clk_rst);
>+}
>+
>+static void sdhc_clk_disable(struct clk *clk)
>+{
>+	uint32_t clk_rst;
>+
>+	clk_rst  =  __raw_readl(clk->clk_rst);
>+	clk_rst &= ~clk->enable_val;
>+	__raw_writel(clk_rst, clk->clk_rst);
>+}
>+
>+struct clkops sdhc_clk_ops = {
>+	.enable		= sdhc_clk_enable,
>+	.disable	= sdhc_clk_disable,
>+};
>+
> /* APB peripheral clocks */
> static APBC_CLK(uart1, MMP2_UART1, 1, 26000000);
> static APBC_CLK(uart2, MMP2_UART2, 1, 26000000);
>@@ -129,6 +152,10 @@ static APBC_CLK(twsi6, MMP2_TWSI6, 0, 26000000);
> static APBC_CLK(rtc, MMP2_RTC, 0, 32768);
>
> static APMU_CLK(nand, NAND, 0xbf, 100000000);
>+static APMU_CLK_OPS(sdh0, SDH0, 0x1b, 200000000, &sdhc_clk_ops);
>+static APMU_CLK_OPS(sdh1, SDH1, 0x1b, 200000000, &sdhc_clk_ops);
>+static APMU_CLK_OPS(sdh2, SDH2, 0x1b, 200000000, &sdhc_clk_ops);
>+static APMU_CLK_OPS(sdh3, SDH3, 0x1b, 200000000, &sdhc_clk_ops);
>
> static struct clk_lookup mmp2_clkregs[] = {
> 	INIT_CLKREG(&clk_uart1, "pxa2xx-uart.0", NULL),
>@@ -142,6 +169,10 @@ static struct clk_lookup mmp2_clkregs[] = {
> 	INIT_CLKREG(&clk_twsi5, "pxa2xx-i2c.4", NULL),
> 	INIT_CLKREG(&clk_twsi6, "pxa2xx-i2c.5", NULL),
> 	INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
>+	INIT_CLKREG(&clk_sdh0, "sdhci-pxa.0", "PXA-SDHCLK"),
>+	INIT_CLKREG(&clk_sdh1, "sdhci-pxa.1", "PXA-SDHCLK"),
>+	INIT_CLKREG(&clk_sdh2, "sdhci-pxa.2", "PXA-SDHCLK"),
>+	INIT_CLKREG(&clk_sdh3, "sdhci-pxa.3", "PXA-SDHCLK"),
> };
>
> static int __init mmp2_init(void)
>@@ -192,4 +223,8 @@ MMP2_DEVICE(twsi4, "pxa2xx-i2c", 3, TWSI4,
>0xd4033000, 0x70);
> MMP2_DEVICE(twsi5, "pxa2xx-i2c", 4, TWSI5, 0xd4033800, 0x70);
> MMP2_DEVICE(twsi6, "pxa2xx-i2c", 5, TWSI6, 0xd4034000, 0x70);
> MMP2_DEVICE(nand, "pxa3xx-nand", -1, NAND, 0xd4283000, 0x100, 28, 29);
>+MMP2_DEVICE(sdh0, "sdhci-pxa", 0, MMC, 0xd4280000, 0x120);
>+MMP2_DEVICE(sdh1, "sdhci-pxa", 1, MMC2, 0xd4280800, 0x120);
>+MMP2_DEVICE(sdh2, "sdhci-pxa", 2, MMC3, 0xd4281000, 0x120);
>+MMP2_DEVICE(sdh3, "sdhci-pxa", 3, MMC4, 0xd4281800, 0x120);
>
>--
>1.7.0.4
