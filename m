From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 23 May 2013 15:30:51 +0200
Subject: [PATCH v2 3/6] arm: mvebu: move cache and mvebu-mbus initialization
 later
In-Reply-To: <1369315854-32724-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369315854-32724-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1369315854-32724-4-git-send-email-thomas.petazzoni@free-electrons.com>
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
 arch/arm/mach-mvebu/armada-370-xp.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index b9319c4..75ebf56 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -44,14 +44,11 @@ static void __init armada_370_xp_map_io(void)
 
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
 
 	/*
 	 * This initialization will be replaced by a DT-based
@@ -87,7 +84,6 @@ DT_MACHINE_START(ARMADA_XP_DT, "Marvell Armada 370/XP (Device Tree)")
 	.smp		= smp_ops(armada_xp_smp_ops),
 	.init_machine	= armada_370_xp_dt_init,
 	.map_io		= armada_370_xp_map_io,
-	.init_early	= armada_370_xp_init_early,
 	.init_time	= armada_370_xp_timer_and_clk_init,
 	.restart	= mvebu_restart,
 	.dt_compat	= armada_370_xp_dt_compat,
-- 
1.7.9.5
