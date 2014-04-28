From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 28 Apr 2014 20:30:27 +0100
Subject: [PATCH 50/97] ARM: l2c: add automatic enable of early BRESP
In-Reply-To: <20140428192419.GV26756@n2100.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Message-ID: <E1WerFz-0001Wu-F6@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AXI bus protocol requires that a write response should only be
sent back to the master when the last write has been accepted.  Early
BRESP allows the L2C-310 to send the write response as soon as the
store buffer accepts the write address.

Cortex-A9 processors can signal to the L2C-310 that they wish to be
notified early, and if this optimisation is enabled, the L2C-310 can
signal an early write response.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 3e2c22a12d87..db3f18a968b2 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -24,6 +24,7 @@
 #include <linux/of_address.h>
 
 #include <asm/cacheflush.h>
+#include <asm/cputype.h>
 #include <asm/hardware/cache-l2x0.h>
 #include "cache-tauros3.h"
 #include "cache-aurora-l2.h"
@@ -620,6 +621,24 @@ static void l2c310_resume(void)
 	}
 }
 
+static void __init l2c310_enable(void __iomem *base, u32 aux, unsigned num_lock)
+{
+	unsigned rev = readl_relaxed(base + L2X0_CACHE_ID) & L2X0_CACHE_ID_PART_MASK;
+	bool cortex_a9 = read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9;
+
+	if (rev >= L310_CACHE_ID_RTL_R2P0) {
+		if (cortex_a9) {
+			aux |= L310_AUX_CTRL_EARLY_BRESP;
+			pr_info("L2C-310 enabling early BRESP for Cortex-A9\n");
+		} else if (aux & L310_AUX_CTRL_EARLY_BRESP) {
+			pr_warn("L2C-310 early BRESP only supported with Cortex-A9\n");
+			aux &= ~L310_AUX_CTRL_EARLY_BRESP;
+		}
+	}
+
+	l2c_enable(base, aux, num_lock);
+}
+
 static void __init l2c310_fixup(void __iomem *base, u32 cache_id,
 	struct outer_cache_fns *fns)
 {
@@ -677,7 +696,7 @@ static const struct l2c_init_data l2c310_init_fns __initconst = {
 	.type = "L2C-310",
 	.way_size_0 = SZ_8K,
 	.num_lock = 8,
-	.enable = l2c_enable,
+	.enable = l2c310_enable,
 	.fixup = l2c310_fixup,
 	.save = l2c310_save,
 	.outer_cache = {
@@ -916,7 +935,7 @@ static const struct l2c_init_data of_l2c310_data __initconst = {
 	.way_size_0 = SZ_8K,
 	.num_lock = 8,
 	.of_parse = l2c310_of_parse,
-	.enable = l2c_enable,
+	.enable = l2c310_enable,
 	.fixup = l2c310_fixup,
 	.save  = l2c310_save,
 	.outer_cache = {
@@ -1264,7 +1283,7 @@ static const struct l2c_init_data of_bcm_l2x0_data __initconst = {
 	.way_size_0 = SZ_8K,
 	.num_lock = 8,
 	.of_parse = l2c310_of_parse,
-	.enable = l2c_enable,
+	.enable = l2c310_enable,
 	.save  = l2c310_save,
 	.outer_cache = {
 		.inv_range   = bcm_inv_range,
-- 
1.8.3.1
