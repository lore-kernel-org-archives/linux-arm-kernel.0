From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 11 Dec 2014 11:46:15 +0100
Subject: [PATCH] ARM: zynq: Simplify SLCR initialization
Message-ID: <ecea997783301834c1bd39ea32e3ac3f3141620f.1418294772.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on
"mfd: syscon: Decouple syscon interface from platform devices"
(sha1: bdb0066df96e74a4002125467ebe459feff1ebef)
SLCR driver can use syscon/regmap drivers directly.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/mach-zynq/common.c |  2 --
 arch/arm/mach-zynq/slcr.c   | 35 +++++++----------------------------
 2 files changed, 7 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 26f92c28d22b..c887196cfdbe 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -146,8 +146,6 @@ out:

 	platform_device_register(&zynq_cpuidle_device);
 	platform_device_register_full(&devinfo);
-
-	zynq_slcr_init();
 }

 static void __init zynq_timer_init(void)
diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
index d4cb50cf97c0..c3c24fd8b306 100644
--- a/arch/arm/mach-zynq/slcr.c
+++ b/arch/arm/mach-zynq/slcr.c
@@ -47,11 +47,6 @@ static struct regmap *zynq_slcr_regmap;
  */
 static int zynq_slcr_write(u32 val, u32 offset)
 {
-	if (!zynq_slcr_regmap) {
-		writel(val, zynq_slcr_base + offset);
-		return 0;
-	}
-
 	return regmap_write(zynq_slcr_regmap, offset, val);
 }

@@ -65,12 +60,7 @@ static int zynq_slcr_write(u32 val, u32 offset)
  */
 static int zynq_slcr_read(u32 *val, u32 offset)
 {
-	if (zynq_slcr_regmap)
-		return regmap_read(zynq_slcr_regmap, offset, val);
-
-	*val = readl(zynq_slcr_base + offset);
-
-	return 0;
+	return regmap_read(zynq_slcr_regmap, offset, val);
 }

 /**
@@ -196,23 +186,6 @@ void zynq_slcr_cpu_state_write(int cpu, bool die)
 }

 /**
- * zynq_slcr_init - Regular slcr driver init
- * Return:	0 on success, negative errno otherwise.
- *
- * Called early during boot from platform code to remap SLCR area.
- */
-int __init zynq_slcr_init(void)
-{
-	zynq_slcr_regmap = syscon_regmap_lookup_by_compatible("xlnx,zynq-slcr");
-	if (IS_ERR(zynq_slcr_regmap)) {
-		pr_err("%s: failed to find zynq-slcr\n", __func__);
-		return -ENODEV;
-	}
-
-	return 0;
-}
-
-/**
  * zynq_early_slcr_init - Early slcr init function
  *
  * Return:	0 on success, negative errno otherwise.
@@ -237,6 +210,12 @@ int __init zynq_early_slcr_init(void)

 	np->data = (__force void *)zynq_slcr_base;

+	zynq_slcr_regmap = syscon_regmap_lookup_by_compatible("xlnx,zynq-slcr");
+	if (IS_ERR(zynq_slcr_regmap)) {
+		pr_err("%s: failed to find zynq-slcr\n", __func__);
+		return -ENODEV;
+	}
+
 	/* unlock the SLCR so that registers can be changed */
 	zynq_slcr_unlock();

--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141211/07584cba/attachment.sig>
