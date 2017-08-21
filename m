From: yong.wu@mediatek.com (Yong Wu)
Date: Mon, 21 Aug 2017 19:00:15 +0800
Subject: [PATCH v2 2/8] iommu/mediatek: Move MTK_M4U_TO_LARB/PORT into
 mtk_iommu.c
In-Reply-To: <1503313221-26453-1-git-send-email-yong.wu@mediatek.com>
References: <1503313221-26453-1-git-send-email-yong.wu@mediatek.com>
Message-ID: <1503313221-26453-3-git-send-email-yong.wu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The definition of MTK_M4U_TO_LARB and MTK_M4U_TO_PORT are shared by
all the gen2 M4U HWs. Thus, Move them out from mt8173-larb-port.h,
and put them into the c file.

Suggested-by: Honghui Zhang <honghui.zhang@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
This patch only moves the position of the MACRO MTK_M4U_TO_LARB/PORT.
---
 drivers/iommu/mtk_iommu.c                     | 8 +++++++-
 include/dt-bindings/memory/mt8173-larb-port.h | 4 ----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 91c6d36..4db6c8f 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -31,7 +31,6 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <asm/barrier.h>
-#include <dt-bindings/memory/mt8173-larb-port.h>
 #include <soc/mediatek/smi.h>
 
 #include "mtk_iommu.h"
@@ -93,6 +92,13 @@
 
 #define MTK_PROTECT_PA_ALIGN			128
 
+/*
+ * Get the local arbiter ID and the portid within the larb arbiter
+ * from mtk_m4u_id which is defined by MTK_M4U_ID.
+ */
+#define MTK_M4U_TO_LARB(id)		(((id) >> 5) & 0x7)
+#define MTK_M4U_TO_PORT(id)		((id) & 0x1f)
+
 struct mtk_iommu_domain {
 	spinlock_t			pgtlock; /* lock for page table */
 
diff --git a/include/dt-bindings/memory/mt8173-larb-port.h b/include/dt-bindings/memory/mt8173-larb-port.h
index 5fef5d1..111b4b0 100644
--- a/include/dt-bindings/memory/mt8173-larb-port.h
+++ b/include/dt-bindings/memory/mt8173-larb-port.h
@@ -15,10 +15,6 @@
 #define __DTS_IOMMU_PORT_MT8173_H
 
 #define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
-/* Local arbiter ID */
-#define MTK_M4U_TO_LARB(id)		(((id) >> 5) & 0x7)
-/* PortID within the local arbiter */
-#define MTK_M4U_TO_PORT(id)		((id) & 0x1f)
 
 #define M4U_LARB0_ID			0
 #define M4U_LARB1_ID			1
-- 
1.9.1
