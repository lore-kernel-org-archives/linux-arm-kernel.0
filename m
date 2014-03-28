From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 28 Mar 2014 15:17:23 +0000
Subject: [PATCH 35/75] ARM: l2c: convert Broadcom L2C-310 to new code
In-Reply-To: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
Message-ID: <E1WTYX5-0007FE-88@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Broadcom L2C-310 devices use ARMs L2C-310 R2P3 or later.  These
require no errata workarounds, and so we can directly call the l2c210
functions from their methods.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index ee2134671699..b059b8d885dc 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1360,16 +1360,16 @@ static void bcm_inv_range(unsigned long start, unsigned long end)
 
 	/* normal case, no cross section between start and end */
 	if (likely(bcm_addr_is_sys_emi(end) || !bcm_addr_is_sys_emi(start))) {
-		l2x0_inv_range(new_start, new_end);
+		l2c210_inv_range(new_start, new_end);
 		return;
 	}
 
 	/* They cross sections, so it can only be a cross from section
 	 * 2 to section 3
 	 */
-	l2x0_inv_range(new_start,
+	l2c210_inv_range(new_start,
 		bcm_l2_phys_addr(BCM_VC_EMI_SEC3_START_ADDR-1));
-	l2x0_inv_range(bcm_l2_phys_addr(BCM_VC_EMI_SEC3_START_ADDR),
+	l2c210_inv_range(bcm_l2_phys_addr(BCM_VC_EMI_SEC3_START_ADDR),
 		new_end);
 }
 
@@ -1382,26 +1382,21 @@ static void bcm_clean_range(unsigned long start, unsigned long end)
 	if (unlikely(end <= start))
 		return;
 
-	if ((end - start) >= l2x0_size) {
-		l2x0_clean_all();
-		return;
-	}
-
 	new_start = bcm_l2_phys_addr(start);
 	new_end = bcm_l2_phys_addr(end);
 
 	/* normal case, no cross section between start and end */
 	if (likely(bcm_addr_is_sys_emi(end) || !bcm_addr_is_sys_emi(start))) {
-		l2x0_clean_range(new_start, new_end);
+		l2c210_clean_range(new_start, new_end);
 		return;
 	}
 
 	/* They cross sections, so it can only be a cross from section
 	 * 2 to section 3
 	 */
-	l2x0_clean_range(new_start,
+	l2c210_clean_range(new_start,
 		bcm_l2_phys_addr(BCM_VC_EMI_SEC3_START_ADDR-1));
-	l2x0_clean_range(bcm_l2_phys_addr(BCM_VC_EMI_SEC3_START_ADDR),
+	l2c210_clean_range(bcm_l2_phys_addr(BCM_VC_EMI_SEC3_START_ADDR),
 		new_end);
 }
 
@@ -1415,7 +1410,7 @@ static void bcm_flush_range(unsigned long start, unsigned long end)
 		return;
 
 	if ((end - start) >= l2x0_size) {
-		l2x0_flush_all();
+		outer_cache.flush_all();
 		return;
 	}
 
@@ -1424,24 +1419,24 @@ static void bcm_flush_range(unsigned long start, unsigned long end)
 
 	/* normal case, no cross section between start and end */
 	if (likely(bcm_addr_is_sys_emi(end) || !bcm_addr_is_sys_emi(start))) {
-		l2x0_flush_range(new_start, new_end);
+		l2c210_flush_range(new_start, new_end);
 		return;
 	}
 
 	/* They cross sections, so it can only be a cross from section
 	 * 2 to section 3
 	 */
-	l2x0_flush_range(new_start,
+	l2c210_flush_range(new_start,
 		bcm_l2_phys_addr(BCM_VC_EMI_SEC3_START_ADDR-1));
-	l2x0_flush_range(bcm_l2_phys_addr(BCM_VC_EMI_SEC3_START_ADDR),
+	l2c210_flush_range(bcm_l2_phys_addr(BCM_VC_EMI_SEC3_START_ADDR),
 		new_end);
 }
 
+/* Broadcom L2C-310 start from ARMs R3P2 or later, and require no fixups */
 static const struct l2c_init_data of_bcm_l2x0_data __initconst = {
 	.num_lock = 8,
 	.of_parse = l2c310_of_parse,
 	.enable = l2c_enable,
-	.fixup = l2c310_fixup,
 	.save  = l2c310_save,
 	.outer_cache = {
 		.inv_range   = bcm_inv_range,
-- 
1.8.3.1
