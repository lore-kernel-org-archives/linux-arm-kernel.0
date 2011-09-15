From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 15 Sep 2011 15:32:57 -0400 (EDT)
Subject: READ THIS: the next mach-types update
In-Reply-To: <20110915191134.GL6267@n2100.arm.linux.org.uk>
References: <20110915102528.GI6267@n2100.arm.linux.org.uk>
	<201109151726.02445.arnd@arndb.de>
	<20110915191134.GL6267@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1109151524080.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Sep 2011, Russell King - ARM Linux wrote:

> On Thu, Sep 15, 2011 at 05:26:02PM +0200, Arnd Bergmann wrote:
> > On Thursday 15 September 2011, Russell King - ARM Linux wrote:
> > > Moreover, entries older than 12 months which have not been merged will
> > > be removed.  It is not possible to automatically check for machine_is_xxx()
> > > usages as these could conflict with other architectures, and I'm
> > > certainly NOT checking for them by hand (I estimate that'd take a
> > > significant amount of manual effort to do.)  What that means is that it
> > > is important to get the core platform support in first before any
> > > drivers which may make use of this.
> > 
> > Hi Russell,
> > 
> > I've just tried checking the machine_is_xxx() values in the kernel for
> > the list you posted and found just two that are actually being used:
> > 
> > arch/arm/mach-orion5x/ts209-setup.c:    if (machine_is_ts_x09())
> > arch/arm/mach-kirkwood/sheevaplug-setup.c:      if (machine_is_sheeva_esata())
> > 
> > Would it be possible to just fix these to use the correct form instead,
> > along with the respective mach-types change?
> 
> That would of course be the preferred way, but I need to know which
> way they're supposed to be - the current disagreement in the names
> doesn't suggest which is the right one.

Here's what I'd suggest:

diff --git a/arch/arm/mach-kirkwood/sheevaplug-setup.c b/arch/arm/mach-kirkwood/sheevaplug-setup.c
index 17de0bf53c..d989c0d1f9 100644
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
index c9831614e3..8588c08bbd 100644
--- a/arch/arm/mach-orion5x/ts209-setup.c
+++ b/arch/arm/mach-orion5x/ts209-setup.c
@@ -179,7 +179,7 @@ static struct hw_pci qnap_ts209_pci __initdata = {
 
 static int __init qnap_ts209_pci_init(void)
 {
-	if (machine_is_ts_x09())
+	if (machine_is_ts209())
 		pci_common_init(&qnap_ts209_pci);
 
 	return 0;
diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index fff68d0d52..fae8c3b527 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -268,7 +268,7 @@ dns323			MACH_DNS323		DNS323			1542
 omap3_beagle		MACH_OMAP3_BEAGLE	OMAP3_BEAGLE		1546
 nokia_n810		MACH_NOKIA_N810		NOKIA_N810		1548
 pcm038			MACH_PCM038		PCM038			1551
-ts_x09			MACH_TS209		TS209			1565
+ts209			MACH_TS209		TS209			1565
 at91cap9adk		MACH_AT91CAP9ADK	AT91CAP9ADK		1566
 mx31moboard		MACH_MX31MOBOARD	MX31MOBOARD		1574
 terastation_pro2	MACH_TERASTATION_PRO2	TERASTATION_PRO2	1584
@@ -449,7 +449,7 @@ guruplug		MACH_GURUPLUG		GURUPLUG		2659
 spear310		MACH_SPEAR310		SPEAR310		2660
 spear320		MACH_SPEAR320		SPEAR320		2661
 aquila			MACH_AQUILA		AQUILA			2676
-sheeva_esata		MACH_ESATA_SHEEVAPLUG	ESATA_SHEEVAPLUG	2678
+esata_sheevaplug	MACH_ESATA_SHEEVAPLUG	ESATA_SHEEVAPLUG	2678
 msm7x30_surf		MACH_MSM7X30_SURF	MSM7X30_SURF		2679
 ea2478devkit		MACH_EA2478DEVKIT	EA2478DEVKIT		2683
 terastation_wxl		MACH_TERASTATION_WXL	TERASTATION_WXL		2697


Nicolas
