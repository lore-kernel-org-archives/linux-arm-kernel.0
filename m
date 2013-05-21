From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 21 May 2013 12:33:31 +0200
Subject: [PATCH 6/9] arm: mvebu: move cache and mvebu-mbus initialization later
In-Reply-To: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1369132414-18959-7-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current, the L2 cache and the mvebu-mbus drivers are initialized at
->init_early() time. However, at ->init_early() time, ioremap() only
works if a static I/O mapping has already been put in place. If it's
not the case, it tries to do a memory allocation with kmalloc() which
is not possible so early at this stage of the initialization.

Since we want to get rid of the static I/O mapping, we cannot
initialize the L2 cache driver and the mvebu-mbus driver so early. So,
we move their initialization to the ->init_time() level, which is
slightly later (so ioremap() works properly), but sufficiently early
to be before the call of the ->smp_prepare_cpus() hook, which creates
an address decoding window for the BootROM, which requires the
mvebu-mbus driver to be properly initialized.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/armada-370-xp.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index 3af5628..23cdabd 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -45,21 +45,11 @@ static void __init armada_370_xp_map_io(void)
 
 static void __init armada_370_xp_timer_and_clk_init(void)
 {
+	char *mbus_soc_name;
+
 	mvebu_clocks_init();
 	armada_370_xp_timer_init();
 	coherency_init();
-}
-
-static void __init armada_370_xp_init_early(void)
-{
-	char *mbus_soc_name;
-
-	/*
-	 * Some Armada 370/XP devices allocate their coherent buffers
-	 * from atomic context. Increase size of atomic coherent pool
-	 * to make sure such the allocations won't fail.
-	 */
-	init_dma_coherent_pool_size(SZ_1M);
 
 	/*
 	 * This initialization will be replaced by a DT-based
@@ -81,6 +71,16 @@ static void __init armada_370_xp_init_early(void)
 #endif
 }
 
+static void __init armada_370_xp_init_early(void)
+{
+	/*
+	 * Some Armada 370/XP devices allocate their coherent buffers
+	 * from atomic context. Increase size of atomic coherent pool
+	 * to make sure such the allocations won't fail.
+	 */
+	init_dma_coherent_pool_size(SZ_1M);
+}
+
 static void __init armada_370_xp_dt_init(void)
 {
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-- 
1.7.9.5
