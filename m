From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed,  2 Jun 2010 10:40:48 +0300
Subject: [PATCH 3/5] [ARM] pxa: add PXA310 specific ULPI implementation
In-Reply-To: <1275464450-23003-3-git-send-email-grinberg@compulab.co.il>
References: <1275464450-23003-1-git-send-email-grinberg@compulab.co.il>
	<1275464450-23003-2-git-send-email-grinberg@compulab.co.il>
	<1275464450-23003-3-git-send-email-grinberg@compulab.co.il>
Message-ID: <1275464450-23003-4-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-pxa/Kconfig                    |    4 +
 arch/arm/mach-pxa/Makefile                   |    1 +
 arch/arm/mach-pxa/include/mach/pxa310-ulpi.h |   19 +++++
 arch/arm/mach-pxa/pxa310-ulpi.c              |  110 ++++++++++++++++++++++++++
 4 files changed, 134 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-pxa/include/mach/pxa310-ulpi.h
 create mode 100644 arch/arm/mach-pxa/pxa310-ulpi.c

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 5b6ee46..3c54cf0 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -616,6 +616,7 @@ config CPU_PXA300
 config CPU_PXA310
 	bool
 	select CPU_PXA300
+	select PXA310_ULPI if USB_ULPI
 	help
 	  PXA310 (codename Monahans-LV)
 
@@ -681,4 +682,7 @@ config PXA_HAVE_BOARD_IRQS
 config PXA_HAVE_ISA_IRQS
 	bool
 
+config PXA310_ULPI
+	bool
+
 endif
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index 86bc87b..4ab51dd 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_PXA25x)		+= mfp-pxa2xx.o pxa2xx.o pxa25x.o
 obj-$(CONFIG_PXA27x)		+= mfp-pxa2xx.o pxa2xx.o pxa27x.o
 obj-$(CONFIG_PXA3xx)		+= mfp-pxa3xx.o pxa3xx.o smemc.o
 obj-$(CONFIG_CPU_PXA300)	+= pxa300.o
+obj-$(CONFIG_PXA310_ULPI)	+= pxa310-ulpi.o
 obj-$(CONFIG_CPU_PXA320)	+= pxa320.o
 obj-$(CONFIG_CPU_PXA930)	+= pxa930.o
 
diff --git a/arch/arm/mach-pxa/include/mach/pxa310-ulpi.h b/arch/arm/mach-pxa/include/mach/pxa310-ulpi.h
new file mode 100644
index 0000000..b0f2062
--- /dev/null
+++ b/arch/arm/mach-pxa/include/mach/pxa310-ulpi.h
@@ -0,0 +1,19 @@
+/*
+ * PXA310 ULPI USB host header file.
+ *
+ * Copyright (C) 2010 CompuLab Ltd.
+ *
+ * Igor Grinberg <grinberg@compulab.co.il>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __PXA310_ULPI__
+#define __PXA310_ULPI__
+
+#include <linux/usb/ulpi.h>
+
+extern struct otg_io_access_ops pxa310_ulpi_access_ops;
+
+#endif /* __PXA310_ULPI__ */
diff --git a/arch/arm/mach-pxa/pxa310-ulpi.c b/arch/arm/mach-pxa/pxa310-ulpi.c
new file mode 100644
index 0000000..14b6a2e
--- /dev/null
+++ b/arch/arm/mach-pxa/pxa310-ulpi.c
@@ -0,0 +1,110 @@
+/*
+ * linux/arch/arm/mach-pxa/pxa310-ulpi.c
+ *
+ * PXA310 ULPI implementation.
+ *
+ * Copyright (C) 2010 CompuLab Ltd.
+ *
+ * Igor Grinberg <grinberg@compulab.co.il>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/usb/otg.h>
+
+#include <mach/regs-u2d.h>
+#include <mach/pxa310-ulpi.h>
+
+#define U2DOTGUCR_ADDR_S	(16)
+#define U2DOTGUCR_WDATA_S	(8)
+
+enum u2d_phy_mode {
+	SYNCH		= 0,
+	CARKIT		= (1 << 0),
+	SER_3PIN	= (1 << 1),
+	SER_6PIN	= (1 << 2),
+	LOWPOWER	= (1 << 3),
+};
+
+static inline u32 u2d_readl(struct otg_transceiver *otg, u32 off)
+{
+	void __iomem *u2d_mmio_base = otg->io_priv;
+
+	return __raw_readl(u2d_mmio_base + off);
+}
+
+static inline void u2d_writel(struct otg_transceiver *otg, u32 off, u32 val)
+{
+	void __iomem *u2d_mmio_base = otg->io_priv;
+
+	__raw_writel(val, u2d_mmio_base + off);
+}
+
+static inline enum u2d_phy_mode ulpi_get_phymode(struct otg_transceiver *otg)
+{
+	return (u2d_readl(otg, U2DOTGUSR) & 0xF0000000) >> 28;
+}
+
+static int ulpi_poll(struct otg_transceiver *otg)
+{
+	int timeout = 50000;
+
+	while (timeout--) {
+		if (!(u2d_readl(otg, U2DOTGUCR) & U2DOTGUCR_RUN))
+			return 0;
+
+		cpu_relax();
+	}
+
+	pr_warning("%s: ULPI access timed out!\n", __func__);
+
+	return -ETIMEDOUT;
+}
+
+static int ulpi_read(struct otg_transceiver *otg, u32 reg)
+{
+	int err;
+
+	if (ulpi_get_phymode(otg)) {
+		pr_warning("%s: PHY is not in SYNCH mode!\n", __func__);
+		return -EBUSY;
+	}
+
+	u2d_writel(otg, U2DOTGUCR,
+		   U2DOTGUCR_RUN | U2DOTGUCR_RNW | (reg << U2DOTGUCR_ADDR_S));
+	msleep(5);
+
+	err = ulpi_poll(otg);
+	if (err)
+		return err;
+
+	return u2d_readl(otg, U2DOTGUCR) & U2DOTGUCR_RDATA;
+}
+
+static int ulpi_write(struct otg_transceiver *otg, u32 val, u32 reg)
+{
+	if (ulpi_get_phymode(otg)) {
+		pr_warning("%s: PHY is not in SYNCH mode!\n", __func__);
+		return -EBUSY;
+	}
+
+	u2d_writel(otg, U2DOTGUCR, U2DOTGUCR_RUN | (reg << U2DOTGUCR_ADDR_S) |
+		   (val << U2DOTGUCR_WDATA_S));
+	msleep(5);
+
+	return ulpi_poll(otg);
+}
+
+struct otg_io_access_ops pxa310_ulpi_access_ops = {
+	.read	= ulpi_read,
+	.write	= ulpi_write,
+};
+EXPORT_SYMBOL_GPL(pxa310_ulpi_access_ops);
-- 
1.6.4.4
