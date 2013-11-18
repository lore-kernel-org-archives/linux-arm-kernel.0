From: tony@atomide.com (Tony Lindgren)
Date: Mon, 18 Nov 2013 13:58:55 -0800
Subject: [PATCH] ARM: OMAP2+: Fix undefined reference to set_cntfreq
Message-ID: <20131118215855.GW10317@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_SOC_HAS_REALTIME_COUNTER is not selected for omap5
or dra7xx, we can get the following error:

arch/arm/mach-omap2/built-in.o: In function `omap4_secondary_init':
:(.text+0x7ab0): undefined reference to `set_cntfreq'

Fix the issue by not trying to initalize the realtime counter
unles CONFIG_SOC_HAS_REALTIME_COUNTER is selected.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -65,12 +65,14 @@ static void omap4_secondary_init(unsigned int cpu)
 		omap_secure_dispatcher(OMAP4_PPA_CPU_ACTRL_SMP_INDEX,
 							4, 0, 0, 0, 0, 0);
 
+#ifdef CONFIG_SOC_HAS_REALTIME_COUNTER
 	/*
 	 * Configure the CNTFRQ register for the secondary cpu's which
 	 * indicates the frequency of the cpu local timers.
 	 */
 	if (soc_is_omap54xx() || soc_is_dra7xx())
 		set_cntfreq();
+#endif
 
 	/*
 	 * Synchronise with the boot thread.
