From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 11 Aug 2015 19:03:35 +0200
Subject: [PATCH] ARM: mm: fix support for HW coherent systems in PL310 cache
Message-ID: <1439312615-6160-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nadav Haklai <nadavh@marvell.com>

When a PL310 cache is used in a system that provides hardware
coherency, the entire outer cache operations are useless, and can be
skipped.  Moreover, on some systems, it is harmful as it causes
deadlocks between the Marvell coherency mechanism, the Marvell PCIe
controller and the Cortex-A9.

This commit extends a previous commit:
98ea2dba65932ffc456b6d7b11b8a0624e2f7b95 which added the io-coherent
support for the PL310 cache by also disabling the outer cache flush
range operation.

In the current kernel implementation, the outer cache flush range
operation is triggered by the dma_alloc function.
This operation can be take place during runtime and in some
circumstances may lead to the PCIe/PL310 deadlock on Armada 375/38x
SoCs.

Signed-off-by: Nadav Haklai <nadavh@marvell.com>
Reviewed-by: Ofer Heifetz <oferh@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mm/cache-l2x0.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 71b3d3309024..5c3148675597 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1266,9 +1266,9 @@ static const struct l2c_init_data of_l2c310_data __initconst = {
 };
 
 /*
- * This is a variant of the of_l2c310_data with .sync set to
- * NULL. Outer sync operations are not needed when the system is I/O
- * coherent, and potentially harmful in certain situations (PCIe/PL310
+ * This is a variant of the of_l2c310_data with .sync and .flush_range set to
+ * NULL. Outer sync and flush range operations are not needed when the system
+ * is I/O coherent, and potentially harmful in certain situations (PCIe/PL310
  * deadlock on Armada 375/38x due to hardware I/O coherency). The
  * other operations are kept because they are infrequent (therefore do
  * not cause the deadlock in practice) and needed for secondary CPU
@@ -1287,7 +1287,6 @@ static const struct l2c_init_data of_l2c310_coherent_data __initconst = {
 	.outer_cache = {
 		.inv_range   = l2c210_inv_range,
 		.clean_range = l2c210_clean_range,
-		.flush_range = l2c210_flush_range,
 		.flush_all   = l2c210_flush_all,
 		.disable     = l2c310_disable,
 		.resume      = l2c310_resume,
-- 
2.1.0
