From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 13 May 2014 12:10:38 +0200
Subject: [PATCHv2 3/4] ARM: mm: add support for HW coherent systems in PL310
In-Reply-To: <1399975839-5311-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399975839-5311-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1399975839-5311-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a PL310 cache is used on a system that provides hardware
coherency, the outer cache sync operation is useless, and can be
skipped. Moreover, on some systems, it is harmful as it causes
deadlocks between the Marvell coherency mechanism, the Marvell PCIe
controller and the Cortex-A9.

To avoid this, this commit introduces a separate
'arm,pl310-coherent-cache' compatible string, which identifies a PL310
cache in an I/O coherent configuration. This compatible string is
associated with a different set of l2x0_of_data, in which the ->sync
operation is NULL.

Note that technically speaking, a fully coherent system wouldn't
require any of the other .outer_cache operations. However, in
practice, when booting secondary CPUs, these are not yet coherent, and
therefore a set of cache maintenance operations are necessary at this
point. This explains why we keep the other .outer_cache operations and
only ->sync is disabled.

While in theory any write to a PL310 register could cause the
deadlock, in practice, disabling ->sync is sufficient to workaround
the deadlock, since the other cache maintenance operations are only
used in very specific situations.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/l2cc.txt |  2 ++
 arch/arm/mm/cache-l2x0.c                       | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
index b513cb8..41953b3 100644
--- a/Documentation/devicetree/bindings/arm/l2cc.txt
+++ b/Documentation/devicetree/bindings/arm/l2cc.txt
@@ -8,6 +8,8 @@ Required properties:
 
 - compatible : should be one of:
   "arm,pl310-cache"
+  "arm,pl310-coherent-cache", used for I/O coherent platforms using
+     the PL310 cache
   "arm,l220-cache"
   "arm,l210-cache"
   "bcm,bcm11351-a2-pl310-cache": DEPRECATED by "brcm,bcm11351-a2-pl310-cache"
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 7abde2ce..ae19540 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -889,6 +889,26 @@ static const struct l2x0_of_data pl310_data = {
 	},
 };
 
+/*
+ * PL310 operations used on I/O coherent systems. Theoretically, no
+ * outer cache operations would be needed, except that for secondary
+ * processors bring up, a few cache maintenance operations are needed
+ * because secondary processors are not directly coherent with the L2
+ * cache when they start up.
+ */
+static const struct l2x0_of_data pl310_coherent_data = {
+	.setup = pl310_of_setup,
+	.save  = pl310_save,
+	.outer_cache = {
+		.resume      = pl310_resume,
+		.inv_range   = l2x0_inv_range,
+		.clean_range = l2x0_clean_range,
+		.flush_range = l2x0_flush_range,
+		.flush_all   = l2x0_flush_all,
+		.inv_all     = l2x0_inv_all,
+	},
+};
+
 static const struct l2x0_of_data l2x0_data = {
 	.setup = l2x0_of_setup,
 	.save  = NULL,
@@ -955,6 +975,7 @@ static const struct of_device_id l2x0_ids[] __initconst = {
 	{ .compatible = "arm,l210-cache", .data = (void *)&l2x0_data },
 	{ .compatible = "arm,l220-cache", .data = (void *)&l2x0_data },
 	{ .compatible = "arm,pl310-cache", .data = (void *)&pl310_data },
+	{ .compatible = "arm,pl310-coherent-cache", .data = (void *)&pl310_coherent_data },
 	{ .compatible = "bcm,bcm11351-a2-pl310-cache", /* deprecated name */
 	  .data = (void *)&bcm_l2x0_data},
 	{ .compatible = "brcm,bcm11351-a2-pl310-cache",
-- 
1.9.2
