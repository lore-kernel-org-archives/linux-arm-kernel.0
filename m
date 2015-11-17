From: shannon.zhao@linaro.org (shannon.zhao at linaro.org)
Date: Tue, 17 Nov 2015 17:40:20 +0800
Subject: [PATCH v3 21/62] arm/gic-v2: Refactor gicv2_init into generic and dt
 specific parts
In-Reply-To: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1447753261-7552-22-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Refactor gic-v2 related functions into dt and generic parts. This will be
helpful when adding acpi support for gic.

Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 xen/arch/arm/gic-v2.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/xen/arch/arm/gic-v2.c b/xen/arch/arm/gic-v2.c
index 01e36b5..e31d38e 100644
--- a/xen/arch/arm/gic-v2.c
+++ b/xen/arch/arm/gic-v2.c
@@ -628,13 +628,12 @@ static bool_t gicv2_is_aliased(paddr_t cbase, paddr_t csize)
     return ((val_low & 0xfff0fff) == 0x0202043B && val_low == val_high);
 }
 
-static int __init gicv2_init(void)
+static paddr_t __initdata hbase, dbase, cbase, csize, vbase;
+
+static void __init dt_gicv2_init(void)
 {
     int res;
-    paddr_t hbase, dbase;
-    paddr_t cbase, csize;
-    paddr_t vbase, vsize;
-    uint32_t aliased_offset = 0;
+    paddr_t vsize;
     const struct dt_device_node *node = gicv2_info.node;
 
     res = dt_device_get_address(node, 0, &dbase, NULL);
@@ -680,6 +679,13 @@ static int __init gicv2_init(void)
     if ( csize != vsize )
         panic("GICv2: Sizes of GICC (%#"PRIpaddr") and GICV (%#"PRIpaddr") don't match\n",
                csize, vsize);
+}
+
+static int __init gicv2_init(void)
+{
+    uint32_t aliased_offset = 0;
+
+    dt_gicv2_init();
 
     printk("GICv2 initialization:\n"
               "        gic_dist_addr=%"PRIpaddr"\n"
@@ -765,7 +771,8 @@ const static struct gic_hw_operations gicv2_ops = {
 };
 
 /* Set up the GIC */
-static int __init gicv2_preinit(struct dt_device_node *node, const void *data)
+static int __init dt_gicv2_preinit(struct dt_device_node *node,
+                                   const void *data)
 {
     gicv2_info.hw_version = GIC_V2;
     gicv2_info.node = node;
@@ -783,7 +790,7 @@ static const struct dt_device_match gicv2_dt_match[] __initconst =
 
 DT_DEVICE_START(gicv2, "GICv2", DEVICE_GIC)
         .dt_match = gicv2_dt_match,
-        .init = gicv2_preinit,
+        .init = dt_gicv2_preinit,
 DT_DEVICE_END
 
 /*
-- 
2.1.0
