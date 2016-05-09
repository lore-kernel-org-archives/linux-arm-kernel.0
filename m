From: honghui.zhang@mediatek.com (honghui.zhang at mediatek.com)
Date: Mon, 9 May 2016 16:00:13 +0800
Subject: [PATCH 2/5] iommu/mediatek: move the common struct into header file
In-Reply-To: <1462780816-5288-1-git-send-email-honghui.zhang@mediatek.com>
References: <1462780816-5288-1-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <1462780816-5288-3-git-send-email-honghui.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

Move the struct defines of mtk iommu into a new header files for
common use.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 62 +-------------------------------
 drivers/iommu/mtk_iommu.h | 90 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 61 deletions(-)
 create mode 100644 drivers/iommu/mtk_iommu.h

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index db74553..a6b7846 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -34,7 +34,7 @@
 #include <dt-bindings/memory/mt8173-larb-port.h>
 #include <soc/mediatek/smi.h>
 
-#include "io-pgtable.h"
+#include "mtk_iommu.h"
 
 #define REG_MMU_PT_BASE_ADDR			0x000
 
@@ -93,49 +93,8 @@
 
 #define MTK_PROTECT_PA_ALIGN			128
 
-struct mtk_iommu_suspend_reg {
-	u32				standard_axi_mode;
-	u32				dcm_dis;
-	u32				ctrl_reg;
-	u32				int_control0;
-	u32				int_main_control;
-};
-
-struct mtk_iommu_client_priv {
-	struct list_head		client;
-	unsigned int			mtk_m4u_id;
-	struct device			*m4udev;
-};
-
-struct mtk_iommu_domain {
-	spinlock_t			pgtlock; /* lock for page table */
-
-	struct io_pgtable_cfg		cfg;
-	struct io_pgtable_ops		*iop;
-
-	struct iommu_domain		domain;
-};
-
-struct mtk_iommu_data {
-	void __iomem			*base;
-	int				irq;
-	struct device			*dev;
-	struct clk			*bclk;
-	phys_addr_t			protect_base; /* protect memory base */
-	struct mtk_iommu_suspend_reg	reg;
-	struct mtk_iommu_domain		*m4u_dom;
-	struct iommu_group		*m4u_group;
-	struct mtk_smi_iommu		smi_imu;      /* SMI larb iommu info */
-	bool                            enable_4GB;
-};
-
 static struct iommu_ops mtk_iommu_ops;
 
-static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
-{
-	return container_of(dom, struct mtk_iommu_domain, domain);
-}
-
 static void mtk_iommu_tlb_flush_all(void *cookie)
 {
 	struct mtk_iommu_data *data = cookie;
@@ -552,25 +511,6 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 	return 0;
 }
 
-static int compare_of(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
-static int mtk_iommu_bind(struct device *dev)
-{
-	struct mtk_iommu_data *data = dev_get_drvdata(dev);
-
-	return component_bind_all(dev, &data->smi_imu);
-}
-
-static void mtk_iommu_unbind(struct device *dev)
-{
-	struct mtk_iommu_data *data = dev_get_drvdata(dev);
-
-	component_unbind_all(dev, &data->smi_imu);
-}
-
 static const struct component_master_ops mtk_iommu_com_ops = {
 	.bind		= mtk_iommu_bind,
 	.unbind		= mtk_iommu_unbind,
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
new file mode 100644
index 0000000..5656355
--- /dev/null
+++ b/drivers/iommu/mtk_iommu.h
@@ -0,0 +1,90 @@
+/*
+ * Copyright (c) 2015-2016 MediaTek Inc.
+ * Author: Yong Wu <yong.wu@mediatek.com>
+ *       : Honghui Zhang <honghui.zhang@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _MTK_IOMMU_H_
+#define _MTK_IOMMU_H_
+
+#include <linux/clk.h>
+#include <linux/component.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/iommu.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <soc/mediatek/smi.h>
+
+#include "io-pgtable.h"
+
+struct mtk_iommu_suspend_reg {
+	u32				standard_axi_mode;
+	u32				dcm_dis;
+	u32				ctrl_reg;
+	u32				int_control0;
+	u32				int_main_control;
+};
+
+struct mtk_iommu_client_priv {
+	struct list_head		client;
+	unsigned int			mtk_m4u_id;
+	struct device			*m4udev;
+};
+
+struct mtk_iommu_domain {
+	spinlock_t			pgtlock; /* lock for page table */
+
+	struct io_pgtable_cfg		cfg;
+	struct io_pgtable_ops		*iop;
+
+	struct iommu_domain		domain;
+};
+
+struct mtk_iommu_data {
+	void __iomem			*base;
+	int				irq;
+	struct device			*dev;
+	struct clk			*bclk;
+	phys_addr_t			protect_base; /* protect memory base */
+	struct mtk_iommu_suspend_reg	reg;
+	struct mtk_iommu_domain		*m4u_dom;
+	struct iommu_group		*m4u_group;
+	struct mtk_smi_iommu		smi_imu;      /* SMI larb iommu info */
+	bool                            enable_4GB;
+};
+
+static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct mtk_iommu_domain, domain);
+}
+
+static int compare_of(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
+static int mtk_iommu_bind(struct device *dev)
+{
+	struct mtk_iommu_data *data = dev_get_drvdata(dev);
+
+	return component_bind_all(dev, &data->smi_imu);
+}
+
+static void mtk_iommu_unbind(struct device *dev)
+{
+	struct mtk_iommu_data *data = dev_get_drvdata(dev);
+
+	component_unbind_all(dev, &data->smi_imu);
+}
+
+#endif
-- 
1.8.1.1.dirty
