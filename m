From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon, 22 Oct 2012 18:04:16 -0700
Subject: OMAP baseline test results for v3.7-rc2
In-Reply-To: <alpine.DEB.2.00.1210202125300.774@utopia.booyaka.com> (Paul
 Walmsley's message of "Sat, 20 Oct 2012 21:26:32 +0000 (UTC)")
References: <alpine.DEB.2.00.1210202125300.774@utopia.booyaka.com>
Message-ID: <87r4oqc833.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Igor

Paul Walmsley <paul@pwsan.com> writes:

> Here are some basic OMAP test results for Linux v3.7-rc2.
> Logs and other details at:
>
>     http://www.pwsan.com/omap/testlogs/test_v3.7-rc2/20121020134755/

[...]

> * 37xx EVM: CORE not entering dynamic off-idle
>   - Cause unknown; dynamic retention-idle seems to work; system suspend to 
>     off works

I got a start on this one, and discovered (using CM_IDLEST1_CORE) that
SPI1 was not idle when going off.  A quick hack disabling the
touchscreen showed that after that, core was hitting idle just fine.

I ran out of time today debugging this, but it's definitely realted to
the GPIO debounce setting for the touchscreen.  Changing it to zero[1]
makes CORE hit retention again in idle.

Igor, I'm hoping you might know what's going on here since we already
had some problems with this ads7846 init stuff and you're more familiar
with this debounce init.

Kevin

[1]
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index b9b776b..3afdc50 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -734,7 +734,7 @@ static void __init omap3_evm_init(void)
 	omap_nand_flash_init(NAND_BUSWIDTH_16, omap3evm_nand_partitions,
 			     ARRAY_SIZE(omap3evm_nand_partitions));
 
-	omap_ads7846_init(1, OMAP3_EVM_TS_GPIO, 310, NULL);
+	omap_ads7846_init(1, OMAP3_EVM_TS_GPIO, 0, NULL);
 	omap3evm_init_smsc911x();
 	omap3_evm_display_init();
 	omap3_evm_wl12xx_init();
