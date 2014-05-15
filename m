From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 15 May 2014 11:18:38 +0200
Subject: [PATCHv3 2/3] ARM: mm: add support for HW coherent systems in PL310
In-Reply-To: <1400145519-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400145519-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1400145519-28530-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a PL310 cache is used on a system that provides hardware
coherency, the outer cache sync operation is useless, and can be
skipped. Moreover, on some systems, it is harmful as it causes
deadlocks between the Marvell coherency mechanism, the Marvell PCIe
controller and the Cortex-A9.

To avoid this, this commit introduces a new Device Tree property
'dma-coherent' for the L2 cache controller node, valid only for the
PL310 cache. It identifies the usage of the PL310 cache in an I/O
coherent configuration. Internally, it makes the driver use a
different set of l2x0_of_data, in which the ->sync operation is NULL.

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
 Documentation/devicetree/bindings/arm/l2cc.txt |  3 +++
 arch/arm/mm/cache-l2x0.c                       | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
index b513cb8..077d837 100644
--- a/Documentation/devicetree/bindings/arm/l2cc.txt
+++ b/Documentation/devicetree/bindings/arm/l2cc.txt
@@ -40,6 +40,9 @@ Optional properties:
 - arm,filter-ranges : <start length> Starting address and length of window to
   filter. Addresses in the filter window are directed to the M1 port. Other
   addresses will go to the M0 port.
+- dma-coherent : indicates that the system is operating in an hardware
+  I/O coherent mode. Valid only when the arm,pl310-cache compatible
+  string is used.
 - interrupts : 1 combined interrupt.
 - cache-id-part: cache id part number to be used if it is not present
   on hardware
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 7abde2ce..cf0c037 100644
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
@@ -989,6 +1009,10 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 
 	data = of_match_node(l2x0_ids, np)->data;
 
+	if (of_device_is_compatible(np, "arm,pl310-cache") &&
+	    of_property_read_bool(np, "dma-coherent"))
+		data = &pl310_coherent_data;
+
 	/* L2 configuration can only be changed if the cache is disabled */
 	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)) {
 		if (data->setup)
-- 
1.9.3
