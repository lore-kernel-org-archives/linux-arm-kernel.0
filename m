From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Fri, 22 Jun 2018 22:11:57 +0800
Subject: [PATCH V3 2/5] soc: imx: add mu library functions support
In-Reply-To: <1529676720-7533-1-git-send-email-aisheng.dong@nxp.com>
References: <1529676720-7533-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1529676720-7533-3-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is used for i.MX multi core communication.
e.g. A core to SCU firmware(M core) on MX8.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v2->v3:
 * introduce timeout mechanism
 * uint32_t and int32_t changed to u32 and int
 * Change readl/writel_relaxed to readl/writel

v1->v2:
 * introduce struct mu_priv to keep the private iomem info
 * add the corresponding mu_exit()
---
 drivers/soc/imx/Kconfig  |   3 +
 drivers/soc/imx/Makefile |   1 +
 drivers/soc/imx/imx_mu.c | 184 +++++++++++++++++++++++++++++++++++++++++++++++
 include/soc/imx/mu.h     |  24 +++++++
 4 files changed, 212 insertions(+)
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
index 0000000..1ab4095
--- /dev/null
+++ b/drivers/soc/imx/imx_mu.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
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
+#define MU_DATA_TIME_OUT_US	(100 * USEC_PER_MSEC)
+
+struct mu_priv {
+	struct device_node *np;
+	void __iomem *base;
+};
+
+/*
+ * This function sets the Flag n of the MU.
+ */
+int mu_set_fn(struct mu_priv *priv, u32 fn)
+{
+	u32 reg;
+
+	reg = fn & (~MU_CR_Fn_MASK);
+	if (reg > 0)
+		return -EINVAL;
+
+	reg = readl(priv->base + MU_ACR);
+	/*  Clear ABFn. */
+	reg &= ~MU_CR_Fn_MASK;
+	reg |= fn;
+	writel(reg, priv->base + MU_ACR);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mu_set_fn);
+
+/*
+ * This function reads the status from status register.
+ */
+u32 mu_read_status(struct mu_priv *priv)
+{
+	return readl(priv->base + MU_ASR);
+}
+EXPORT_SYMBOL_GPL(mu_read_status);
+
+/*
+ * This function enables specific RX full interrupt.
+ */
+void mu_enable_rx_full_int(struct mu_priv *priv, u32 index)
+{
+	u32 reg;
+
+	reg = readl(priv->base + MU_ACR);
+	reg &= ~(MU_CR_GIRn_MASK | MU_CR_NMI_MASK);
+	reg |= MU_CR_RIE0_MASK >> index;
+	writel(reg, priv->base + MU_ACR);
+}
+EXPORT_SYMBOL_GPL(mu_enable_rx_full_int);
+
+/*
+ * This function enables specific general purpose interrupt.
+ */
+void mu_enable_general_int(struct mu_priv *priv, u32 index)
+{
+	u32 reg;
+
+	reg = readl(priv->base + MU_ACR);
+	reg &= ~(MU_CR_GIRn_MASK | MU_CR_NMI_MASK);
+	reg |= MU_CR_GIE0_MASK >> index;
+	writel(reg, priv->base + MU_ACR);
+}
+EXPORT_SYMBOL_GPL(mu_enable_general_int);
+
+/*
+ * Wait and send message to the other core.
+ */
+int mu_send_msg(struct mu_priv *priv, u32 index, u32 msg)
+{
+	u32 mask, asr;
+	int ret;
+
+	mask = MU_SR_TE0_MASK >> index;
+
+	/* Wait TX register to be empty. */
+	ret = readl_poll_timeout_atomic(priv->base + MU_ASR, asr, asr & mask,
+					0, MU_DATA_TIME_OUT_US);
+	if (ret)
+		return ret;
+
+	writel(msg, priv->base + MU_ATR0  + (index * 4));
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mu_send_msg);
+
+/*
+ * Wait to receive message from the other core.
+ */
+int mu_receive_msg(struct mu_priv *priv, u32 index, u32 *msg)
+{
+	u32 mask, asr;
+	int ret;
+
+	mask = MU_SR_RF0_MASK >> index;
+
+	/* Wait RX register to be full. */
+	ret = readl_poll_timeout_atomic(priv->base + MU_ASR, asr, asr & mask,
+					0, MU_DATA_TIME_OUT_US);
+	if (ret)
+		return ret;
+
+	*msg = readl(priv->base + MU_ARR0 + (index * 4));
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mu_receive_msg);
+
+struct device_node *mu_node(struct mu_priv *priv)
+{
+	return priv ? priv->np : NULL;
+}
+EXPORT_SYMBOL_GPL(mu_node);
+
+struct mu_priv *mu_init(struct device_node *np)
+{
+	struct mu_priv *priv;
+	u32 reg;
+
+	if (WARN_ON(!np))
+		return NULL;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return ERR_PTR(-ENOMEM);
+
+	priv->np = np;
+	priv->base = of_iomap(np, 0);
+	if (!priv->base) {
+		kfree(priv);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	reg = readl(priv->base + MU_ACR);
+	/* Clear GIEn, RIEn, TIEn, GIRn and ABFn. */
+	reg &= ~(MU_CR_GIEn_MASK | MU_CR_RIEn_MASK | MU_CR_TIEn_MASK
+		 | MU_CR_GIRn_MASK | MU_CR_NMI_MASK | MU_CR_Fn_MASK);
+	writel(reg, priv->base + MU_ACR);
+
+	return priv;
+}
+EXPORT_SYMBOL_GPL(mu_init);
+
+void mu_exit(struct mu_priv *priv)
+{
+	if (WARN_ON(!priv))
+		return;
+
+	iounmap(priv->base);
+	kfree(priv);
+}
+EXPORT_SYMBOL_GPL(mu_exit);
diff --git a/include/soc/imx/mu.h b/include/soc/imx/mu.h
new file mode 100644
index 0000000..44537b8
--- /dev/null
+++ b/include/soc/imx/mu.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017-2018 NXP
+ */
+
+#ifndef IMX_MU_H
+#define IMX_MU_H
+
+#define MU_TR_COUNT		4
+#define MU_RR_COUNT		4
+
+struct mu_priv;
+
+void mu_exit(struct mu_priv *priv);
+struct mu_priv *mu_init(struct device_node *np);
+struct device_node *mu_node(struct mu_priv *priv);
+int mu_send_msg(struct mu_priv *priv, u32 index, u32 msg);
+int mu_receive_msg(struct mu_priv *priv, u32 index, u32 *msg);
+void mu_enable_general_int(struct mu_priv *priv, u32 index);
+void mu_enable_rx_full_int(struct mu_priv *priv, u32 index);
+u32 mu_read_status(struct mu_priv *priv);
+int mu_set_fn(struct mu_priv *priv, u32 Fn);
+#endif
-- 
2.7.4
