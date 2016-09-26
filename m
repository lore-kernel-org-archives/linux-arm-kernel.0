From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 26 Sep 2016 15:25:24 +0100
Subject: [PATCH v2] ARM/dt: Respect property size when parsing CPUs
In-Reply-To: <31c4684aa8ef7ef210cc74da5f1b02ff2882a099.1474645829.git.robin.murphy@arm.com>
References: <31c4684aa8ef7ef210cc74da5f1b02ff2882a099.1474645829.git.robin.murphy@arm.com>
Message-ID: <7955b34dcafcc20829c0521c0a0371c27d102f1f.1474898916.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Whilst MPIDR values themselves are less than 32 bits, it is still
perfectly valid for a DT to have #address-cells > 1 in the CPUs node,
resulting in the "reg" property having leading zero cell(s). In that
situation, the big-endian nature of the data conspires with the current
behaviour of only reading the first cell to cause the kernel to think
all CPUs have ID 0, and become resoundingly unhappy as a consequence.

Take the full property length into account when parsing CPUs so as to
be correct under any circumstances.

CC: Russell King <linux@armlinux.org.uk>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Check that any and all upper cells are zero rather than just
    ignoring them.

I think if we want to properly validate the DT as per Lorenzo's old
patch, that can follow on afterwards; here I'm really just concerned
with making sure the existing behaviour is actually robust and correct.

 arch/arm/kernel/devtree.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 40ecd5f514a2..f676febbb270 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -88,6 +88,8 @@ void __init arm_dt_init_cpu_maps(void)
 		return;
 
 	for_each_child_of_node(cpus, cpu) {
+		const __be32 *cell;
+		int prop_bytes;
 		u32 hwid;
 
 		if (of_node_cmp(cpu->type, "cpu"))
@@ -99,7 +101,8 @@ void __init arm_dt_init_cpu_maps(void)
 		 * properties is considered invalid to build the
 		 * cpu_logical_map.
 		 */
-		if (of_property_read_u32(cpu, "reg", &hwid)) {
+		cell = of_get_property(cpu, "reg", &prop_bytes);
+		if (!cell || prop_bytes < sizeof(*cell)) {
 			pr_debug(" * %s missing reg property\n",
 				     cpu->full_name);
 			of_node_put(cpu);
@@ -107,10 +110,15 @@ void __init arm_dt_init_cpu_maps(void)
 		}
 
 		/*
-		 * 8 MSBs must be set to 0 in the DT since the reg property
+		 * Bits n:24 must be set to 0 in the DT since the reg property
 		 * defines the MPIDR[23:0].
 		 */
-		if (hwid & ~MPIDR_HWID_BITMASK) {
+		do {
+			hwid = be32_to_cpu(*cell++);
+			prop_bytes -= sizeof(*cell);
+		} while (!hwid && prop_bytes > 0);
+
+		if (prop_bytes || (hwid & ~MPIDR_HWID_BITMASK)) {
 			of_node_put(cpu);
 			return;
 		}
-- 
2.8.1.dirty
