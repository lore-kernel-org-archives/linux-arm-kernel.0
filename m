From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 12 Nov 2009 11:42:04 +0100
Subject: [PATCH 8/9] MXC: Add a digital audio multiplexer (DAM) driver
In-Reply-To: <1258022525-21078-8-git-send-email-s.hauer@pengutronix.de>
References: <1258022525-21078-1-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-2-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-3-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-4-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-5-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-6-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-7-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-8-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1258022525-21078-9-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx2/Kconfig            |    2 +
 arch/arm/mach-mx3/Kconfig            |    2 +
 arch/arm/plat-mxc/Kconfig            |    7 ++++
 arch/arm/plat-mxc/Makefile           |    2 +
 arch/arm/plat-mxc/dam-v1.c           |   33 ++++++++++++++++++++
 arch/arm/plat-mxc/dam-v2.c           |   56 ++++++++++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/dam.h |   45 +++++++++++++++++++++++++++
 7 files changed, 147 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-mxc/dam-v1.c
 create mode 100644 arch/arm/plat-mxc/dam-v2.c
 create mode 100644 arch/arm/plat-mxc/include/mach/dam.h

diff --git a/arch/arm/mach-mx2/Kconfig b/arch/arm/mach-mx2/Kconfig
index c8a2eac..43f07b9 100644
--- a/arch/arm/mach-mx2/Kconfig
+++ b/arch/arm/mach-mx2/Kconfig
@@ -6,11 +6,13 @@ choice
 
 config MACH_MX21
 	bool "i.MX21 support"
+	select ARCH_MXC_DAM_V1
 	help
 	  This enables support for Freescale's MX2 based i.MX21 processor.
 
 config MACH_MX27
 	bool "i.MX27 support"
+	select ARCH_MXC_DAM_V1
 	help
 	  This enables support for Freescale's MX2 based i.MX27 processor.
 
diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 851f245..7b9fcbb 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -2,11 +2,13 @@ if ARCH_MX3
 
 config ARCH_MX31
 	select ARCH_HAS_RNGA
+	select ARCH_MXC_DAM_V2
 	bool
 
 config ARCH_MX35
 	bool
 	select ARCH_MXC_IOMUX_V3
+	select ARCH_MXC_DAM_V2
 
 comment "MX3 platforms:"
 
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index e8e92cb..eb3f847 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -78,4 +78,11 @@ config ARCH_HAS_RNGA
 
 config ARCH_MXC_IOMUX_V3
 	bool
+
+config ARCH_MXC_DAM_V1
+	bool
+
+config ARCH_MXC_DAM_V2
+	bool
+
 endif
diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index 545412f..e0f987f 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -10,3 +10,5 @@ obj-$(CONFIG_ARCH_MX2) += iomux-mx1-mx2.o dma-mx1-mx2.o
 obj-$(CONFIG_ARCH_MXC_IOMUX_V3) += iomux-v3.o
 obj-$(CONFIG_MXC_PWM)  += pwm.o
 obj-$(CONFIG_MXC_ULPI) += ulpi.o
+obj-$(CONFIG_ARCH_MXC_DAM_V1) += dam-v1.o
+obj-$(CONFIG_ARCH_MXC_DAM_V2) += dam-v2.o
diff --git a/arch/arm/plat-mxc/dam-v1.c b/arch/arm/plat-mxc/dam-v1.c
new file mode 100644
index 0000000..0733361
--- /dev/null
+++ b/arch/arm/plat-mxc/dam-v1.c
@@ -0,0 +1,33 @@
+
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <mach/dam.h>
+#include <mach/hardware.h>
+
+static void __iomem *dam_base;
+
+#define MXC_DAM_V1_PCR(x)	((x) * 4)
+
+int mxc_dam_v1_configure_port(unsigned int port, unsigned int pcr)
+{
+	if (!dam_base) {
+		printk("%s: not configured\n", __func__);
+		return -ENOSYS;
+	}
+
+	writel(pcr, dam_base + MXC_DAM_V1_PCR(port));
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mxc_dam_v1_configure_port);
+
+static int mxc_dam_v1_init(void)
+{
+	if (cpu_is_mx27() || cpu_is_mx21())
+		dam_base = IO_ADDRESS(AUDMUX_BASE_ADDR);
+	return 0;
+}
+
+postcore_initcall(mxc_dam_v1_init);
diff --git a/arch/arm/plat-mxc/dam-v2.c b/arch/arm/plat-mxc/dam-v2.c
new file mode 100644
index 0000000..a9c8d10
--- /dev/null
+++ b/arch/arm/plat-mxc/dam-v2.c
@@ -0,0 +1,56 @@
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <mach/dam.h>
+#include <mach/hardware.h>
+
+static struct clk *dam_clk;
+static void __iomem *dam_base;
+
+#define MXC_DAM_V2_PTCR(x)		((x) * 8)
+#define MXC_DAM_V2_PDCR(x)		((x) * 8 + 4)
+
+int mxc_dam_v2_configure_port(unsigned int port, unsigned int ptcr,
+		unsigned int pdcr)
+{
+	if (!dam_base)
+		return -ENOSYS;
+
+	if (dam_clk)
+		clk_enable(dam_clk);
+
+	writel(ptcr, dam_base + MXC_DAM_V2_PTCR(port));
+	writel(pdcr, dam_base + MXC_DAM_V2_PDCR(port));
+
+	if (dam_clk)
+		clk_disable(dam_clk);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mxc_dam_v2_configure_port);
+
+static int mxc_dam_v2_init(void)
+{
+	int ret;
+
+	if (cpu_is_mx31() || cpu_is_mx35())
+		dam_base = IO_ADDRESS(AUDMUX_BASE_ADDR);
+	else
+		return 0;
+
+	if (cpu_is_mx35()) {
+		dam_clk = clk_get(NULL, "audmux");
+		if (IS_ERR(dam_clk)) {
+			dam_base = NULL;
+			ret = PTR_ERR(dam_clk);
+			printk(KERN_ERR "%s: cannot get clock: %d\n", __func__,
+					ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+postcore_initcall(mxc_dam_v2_init);
diff --git a/arch/arm/plat-mxc/include/mach/dam.h b/arch/arm/plat-mxc/include/mach/dam.h
new file mode 100644
index 0000000..385b54a
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/dam.h
@@ -0,0 +1,45 @@
+#ifndef __MACH_DAM_H
+#define __MACH_DAM_H
+
+#define MX27_HPCR1_SSI0         0
+#define MX27_HPCR2_SSI1		1
+#define MX27_HPCR3_SSI_PINS_4	2
+#define MX27_PPCR1_SSI_PINS_1   3
+#define MX27_PPCR2_SSI_PINS_2   4
+#define MX27_PPCR3_SSI_PINS_3   5
+
+/* Register definitions for the i.MX21/27 Digital Audio Multiplexer */
+#define MXC_DAM_V1_PCR_INMMASK(x)	((x) & 0xff)
+#define MXC_DAM_V1_PCR_INMEN		(1 << 8)
+#define MXC_DAM_V1_PCR_TXRXEN		(1 << 10)
+#define MXC_DAM_V1_PCR_SYN		(1 << 12)
+#define MXC_DAM_V1_PCR_RXDSEL(x)	(((x) & 0x7) << 13)
+#define MXC_DAM_V1_PCR_RFCSEL(x)	(((x) & 0xf) << 20)
+#define MXC_DAM_V1_PCR_RCLKDIR		(1 << 24)
+#define MXC_DAM_V1_PCR_RFSDIR		(1 << 25)
+#define MXC_DAM_V1_PCR_TFCSEL(x)	(((x) & 0xf) << 26)
+#define MXC_DAM_V1_PCR_TCLKDIR		(1 << 30)
+#define MXC_DAM_V1_PCR_TFSDIR		(1 << 31)
+
+/* Register definitions for the i.MX25/31/35 Digital Audio Multiplexer */
+#define MXC_DAM_V2_PTCR_TFSDIR		(1 << 31)
+#define MXC_DAM_V2_PTCR_TFSEL(x)	(((x) & 0xf) << 27)
+#define MXC_DAM_V2_PTCR_TCLKDIR		(1 << 26)
+#define MXC_DAM_V2_PTCR_TCSEL(x)	(((x) & 0xf) << 22)
+#define MXC_DAM_V2_PTCR_RFSDIR		(1 << 21)
+#define MXC_DAM_V2_PTCR_RFSEL(x)	(((x) & 0xf) << 17)
+#define MXC_DAM_V2_PTCR_RCLKDIR		(1 << 16)
+#define MXC_DAM_V2_PTCR_RCSEL(x)	(((x) & 0xf) << 12)
+#define MXC_DAM_V2_PTCR_SYN		(1 << 11)
+
+#define MXC_DAM_V2_PDCR_RXDSEL(x)	(((x) & 0x7) << 13)
+#define MXC_DAM_V2_PDCR_TXRXEN		(1 << 12)
+#define MXC_DAM_V2_PDCR_MODE(x)		(((x) & 0x3) << 8)
+#define MXC_DAM_V2_PDCR_INMMASK(x)	((x) & 0xff)
+
+int mxc_dam_v1_configure_port(unsigned int port, unsigned int pcr);
+
+int mxc_dam_v2_configure_port(unsigned int port, unsigned int ptcr,
+		unsigned int pdcr);
+
+#endif
-- 
1.6.5.2
