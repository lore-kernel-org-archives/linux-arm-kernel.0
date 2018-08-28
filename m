From: julien.thierry@arm.com (Julien Thierry)
Date: Tue, 28 Aug 2018 16:51:18 +0100
Subject: [PATCH v5 08/27] irqchip/gic: Unify GIC priority definitions
In-Reply-To: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1535471497-38854-9-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LPIs use the same priority value as other GIC interrupts.

Make the GIC default priority definition visible to ITS implementation
and use this same definition for LPI priorities.

Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c       | 2 +-
 include/linux/irqchip/arm-gic-common.h | 6 ++++++
 include/linux/irqchip/arm-gic.h        | 5 -----
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 316a575..f5391f2 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -64,7 +64,7 @@
 #define LPI_PROPBASE_SZ		ALIGN(BIT(LPI_NRBITS), SZ_64K)
 #define LPI_PENDBASE_SZ		ALIGN(BIT(LPI_NRBITS) / 8, SZ_64K)

-#define LPI_PROP_DEFAULT_PRIO	0xa0
+#define LPI_PROP_DEFAULT_PRIO	GICD_INT_DEF_PRI

 /*
  * Collection structure - just an ID, and a redistributor address to
diff --git a/include/linux/irqchip/arm-gic-common.h b/include/linux/irqchip/arm-gic-common.h
index 0a83b43..9a1a479 100644
--- a/include/linux/irqchip/arm-gic-common.h
+++ b/include/linux/irqchip/arm-gic-common.h
@@ -13,6 +13,12 @@
 #include <linux/types.h>
 #include <linux/ioport.h>

+#define GICD_INT_DEF_PRI		0xa0
+#define GICD_INT_DEF_PRI_X4		((GICD_INT_DEF_PRI << 24) |\
+					(GICD_INT_DEF_PRI << 16) |\
+					(GICD_INT_DEF_PRI << 8) |\
+					GICD_INT_DEF_PRI)
+
 enum gic_type {
 	GIC_V2,
 	GIC_V3,
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 6c4aaf0..6261790 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -65,11 +65,6 @@
 #define GICD_INT_EN_CLR_X32		0xffffffff
 #define GICD_INT_EN_SET_SGI		0x0000ffff
 #define GICD_INT_EN_CLR_PPI		0xffff0000
-#define GICD_INT_DEF_PRI		0xa0
-#define GICD_INT_DEF_PRI_X4		((GICD_INT_DEF_PRI << 24) |\
-					(GICD_INT_DEF_PRI << 16) |\
-					(GICD_INT_DEF_PRI << 8) |\
-					GICD_INT_DEF_PRI)

 #define GICD_IIDR_IMPLEMENTER_SHIFT	0
 #define GICD_IIDR_IMPLEMENTER_MASK	(0xfff << GICD_IIDR_IMPLEMENTER_SHIFT)
--
1.9.1
