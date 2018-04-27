From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Sat, 28 Apr 2018 02:46:13 +0800
Subject: [PATCH 1/4] soc: imx: add mu library functions support
In-Reply-To: <1524854776-14863-1-git-send-email-aisheng.dong@nxp.com>
References: <1524854776-14863-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1524854776-14863-2-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is used for i.MX multi core communication.
e.g. A core to SCU firmware(M core) on MX8.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/soc/imx/Kconfig  |   3 ++
 drivers/soc/imx/Makefile |   1 +
 drivers/soc/imx/imx_mu.c | 125 +++++++++++++++++++++++++++++++++++++++++++++++
 include/soc/imx/mu.h     |  21 ++++++++
 4 files changed, 150 insertions(+)
 create mode 100644 drivers/soc/imx/imx_mu.c
 create mode 100644 include/soc/imx/mu.h

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index a5b86a2..4858cd7 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -7,4 +7,7 @@ config IMX7_PM_DOMAINS
 	select PM_GENERIC_DOMAINS
 	default y if SOC_IMX7D
 
+config HAVE_IMX_MU
+	bool
+
 endmenu
diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index aab41a5c..113dc7f 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
 obj-$(CONFIG_IMX7_PM_DOMAINS) += gpcv2.o
+obj-$(CONFIG_HAVE_IMX_MU) += imx_mu.o
diff --git a/drivers/soc/imx/imx_mu.c b/drivers/soc/imx/imx_mu.c
new file mode 100644
index 0000000..e5f3f47
--- /dev/null
+++ b/drivers/soc/imx/imx_mu.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+
+#define MU_ATR0			0x0
+#define MU_ARR0			0x10
+#define MU_ASR			0x20
+#define MU_ACR			0x24
+
+#define MU_CR_GIEn_MASK		(0xf << 28)
+#define MU_CR_RIEn_MASK		(0xf << 24)
+#define MU_CR_TIEn_MASK		(0xf << 20)
+#define MU_CR_GIRn_MASK		(0xf << 16)
+#define MU_CR_NMI_MASK		(1 << 3)
+#define MU_CR_Fn_MASK		0x7
+
+#define MU_SR_TE0_MASK		BIT(23)
+#define MU_SR_RF0_MASK		BIT(27)
+
+#define MU_CR_RIE0_MASK		BIT(27)
+#define MU_CR_GIE0_MASK		BIT(31)
+
+/*
+ * This function sets the Flag n of the MU.
+ */
+int32_t mu_set_fn(void __iomem *base, uint32_t fn)
+{
+	uint32_t reg;
+
+	reg = fn & (~MU_CR_Fn_MASK);
+	if (reg > 0)
+		return -EINVAL;
+
+	reg = readl_relaxed(base + MU_ACR);
+	/*  Clear ABFn. */
+	reg &= ~MU_CR_Fn_MASK;
+	reg |= fn;
+	writel_relaxed(reg, base + MU_ACR);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mu_set_fn);
+
+/*
+ * This function reads the status from status register.
+ */
+uint32_t mu_read_status(void __iomem *base)
+{
+	return readl_relaxed(base + MU_ASR);
+}
+EXPORT_SYMBOL_GPL(mu_read_status);
+
+/*
+ * This function enables specific RX full interrupt.
+ */
+void mu_enable_rx_full_int(void __iomem *base, uint32_t index)
+{
+	uint32_t reg;
+
+	reg = readl_relaxed(base + MU_ACR);
+	reg &= ~(MU_CR_GIRn_MASK | MU_CR_NMI_MASK);
+	reg |= MU_CR_RIE0_MASK >> index;
+	writel_relaxed(reg, base + MU_ACR);
+}
+EXPORT_SYMBOL_GPL(mu_enable_rx_full_int);
+
+/*
+ * This function enables specific general purpose interrupt.
+ */
+void mu_enable_general_int(void __iomem *base, uint32_t index)
+{
+	uint32_t reg;
+
+	reg = readl_relaxed(base + MU_ACR);
+	reg &= ~(MU_CR_GIRn_MASK | MU_CR_NMI_MASK);
+	reg |= MU_CR_GIE0_MASK >> index;
+	writel_relaxed(reg, base + MU_ACR);
+}
+EXPORT_SYMBOL_GPL(mu_enable_general_int);
+
+/*
+ * Wait and send message to the other core.
+ */
+void mu_send_msg(void __iomem *base, uint32_t index, uint32_t msg)
+{
+	uint32_t mask = MU_SR_TE0_MASK >> index;
+
+	/* Wait TX register to be empty. */
+	while (!(readl_relaxed(base + MU_ASR) & mask))
+		;
+	writel_relaxed(msg, base + MU_ATR0  + (index * 4));
+}
+EXPORT_SYMBOL_GPL(mu_send_msg);
+
+/*
+ * Wait to receive message from the other core.
+ */
+void mu_receive_msg(void __iomem *base, uint32_t index, uint32_t *msg)
+{
+	uint32_t mask = MU_SR_RF0_MASK >> index;
+
+	/* Wait RX register to be full. */
+	while (!(readl_relaxed(base + MU_ASR) & mask))
+		;
+	*msg = readl_relaxed(base + MU_ARR0 + (index * 4));
+}
+EXPORT_SYMBOL_GPL(mu_receive_msg);
+
+void mu_init(void __iomem *base)
+{
+	uint32_t reg;
+
+	reg = readl_relaxed(base + MU_ACR);
+	/* Clear GIEn, RIEn, TIEn, GIRn and ABFn. */
+	reg &= ~(MU_CR_GIEn_MASK | MU_CR_RIEn_MASK | MU_CR_TIEn_MASK
+		 | MU_CR_GIRn_MASK | MU_CR_NMI_MASK | MU_CR_Fn_MASK);
+	writel_relaxed(reg, base + MU_ACR);
+}
+EXPORT_SYMBOL_GPL(mu_init);
diff --git a/include/soc/imx/mu.h b/include/soc/imx/mu.h
new file mode 100644
index 0000000..1f54667
--- /dev/null
+++ b/include/soc/imx/mu.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017-2018 NXP
+ */
+
+#ifndef IMX_MU_H
+#define IMX_MU_H
+
+#define MU_SIZE			0x10000
+#define MU_TR_COUNT		4
+#define MU_RR_COUNT		4
+
+void mu_init(void __iomem *base);
+void mu_send_msg(void __iomem *base, uint32_t index, uint32_t msg);
+void mu_receive_msg(void __iomem *base, uint32_t index, uint32_t *msg);
+void mu_enable_general_int(void __iomem *base, uint32_t index);
+void mu_enable_rx_full_int(void __iomem *base, uint32_t index);
+uint32_t mu_read_status(void __iomem *base);
+int32_t mu_set_fn(void __iomem *base, uint32_t Fn);
+#endif
-- 
2.7.4
