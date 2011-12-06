From: yxit@yxit.co.uk (Tixy)
Date: Tue, 06 Dec 2011 09:52:10 +0000
Subject: Patch 7193/1: Fix machine_is_xxx() naming for eSata SheevaPlug and
 QNAP TS-209
In-Reply-To: <alpine.LFD.2.02.1112031247230.2357@xanadu.home>
References: <1322737480.9622.5.camel@phoenix>
 <1322912383.2378.79.camel@computer2>
 <alpine.LFD.2.02.1112031247230.2357@xanadu.home>
Message-ID: <1323165130.2730.14.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell

I have submitted the patch below to your patch system, this adds two
boards back into mach-types, together with fixing the reasons I believe
they were removed. The mach-types file has a header which says "Please
do not send patches to this file; it is automatically generated!" so I'm
not sure if I should have included mach-file in the patch. Either way, I
believe the master list of mach types also needs updating.

Please advice if I should have done things differently.

Thanks

-- 
Tixy

----------------------------------------------------------------

Fix machine_is_xxx() naming for eSata SheevaPlug and QNAP TS-209

The eSata SheevaPlug and QNAP TS-209 devices were removed from
mach-types due to naming mismatches between machine_is_xxx(), CONFIG_XXX
and MACH_TYPE_XXX.

This patch fixes those mismatches and adds the devices back into
mach-types.

Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/mach-kirkwood/sheevaplug-setup.c |    6 +++---
 arch/arm/mach-orion5x/ts209-setup.c       |    2 +-
 arch/arm/tools/mach-types                 |    2 ++
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-kirkwood/sheevaplug-setup.c b/arch/arm/mach-kirkwood/sheevaplug-setup.c
index 85bff6b..4ea70e5 100644
--- a/arch/arm/mach-kirkwood/sheevaplug-setup.c
+++ b/arch/arm/mach-kirkwood/sheevaplug-setup.c
@@ -107,7 +107,7 @@ static void __init sheevaplug_init(void)
 	kirkwood_init();
 
 	/* setup gpio pin select */
-	if (machine_is_sheeva_esata())
+	if (machine_is_esata_sheevaplug())
 		kirkwood_mpp_conf(sheeva_esata_mpp_config);
 	else
 		kirkwood_mpp_conf(sheevaplug_mpp_config);
@@ -123,11 +123,11 @@ static void __init sheevaplug_init(void)
 	kirkwood_ge00_init(&sheevaplug_ge00_data);
 
 	/* honor lower power consumption for plugs with out eSATA */
-	if (machine_is_sheeva_esata())
+	if (machine_is_esata_sheevaplug())
 		kirkwood_sata_init(&sheeva_esata_sata_data);
 
 	/* enable sd wp and sd cd on plugs with esata */
-	if (machine_is_sheeva_esata())
+	if (machine_is_esata_sheevaplug())
 		kirkwood_sdio_init(&sheeva_esata_mvsdio_data);
 	else
 		kirkwood_sdio_init(&sheevaplug_mvsdio_data);
diff --git a/arch/arm/mach-orion5x/ts209-setup.c b/arch/arm/mach-orion5x/ts209-setup.c
index 62c156b..5d64087 100644
--- a/arch/arm/mach-orion5x/ts209-setup.c
+++ b/arch/arm/mach-orion5x/ts209-setup.c
@@ -178,7 +178,7 @@ static struct hw_pci qnap_ts209_pci __initdata = {
 
 static int __init qnap_ts209_pci_init(void)
 {
-	if (machine_is_ts_x09())
+	if (machine_is_ts209())
 		pci_common_init(&qnap_ts209_pci);
 
 	return 0;
diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index 459d114..7f9809a 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -269,6 +269,7 @@ dns323			MACH_DNS323		DNS323			1542
 omap3_beagle		MACH_OMAP3_BEAGLE	OMAP3_BEAGLE		1546
 nokia_n810		MACH_NOKIA_N810		NOKIA_N810		1548
 pcm038			MACH_PCM038		PCM038			1551
+ts209			MACH_TS209		TS209			1565
 at91cap9adk		MACH_AT91CAP9ADK	AT91CAP9ADK		1566
 mx31moboard		MACH_MX31MOBOARD	MX31MOBOARD		1574
 vision_ep9307		MACH_VISION_EP9307	VISION_EP9307		1578
@@ -457,6 +458,7 @@ guruplug		MACH_GURUPLUG		GURUPLUG		2659
 spear310		MACH_SPEAR310		SPEAR310		2660
 spear320		MACH_SPEAR320		SPEAR320		2661
 aquila			MACH_AQUILA		AQUILA			2676
+esata_sheevaplug	MACH_ESATA_SHEEVAPLUG	ESATA_SHEEVAPLUG	2678
 msm7x30_surf		MACH_MSM7X30_SURF	MSM7X30_SURF		2679
 ea2478devkit		MACH_EA2478DEVKIT	EA2478DEVKIT		2683
 terastation_wxl		MACH_TERASTATION_WXL	TERASTATION_WXL		2697
-- 
1.7.2.5
