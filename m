From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 28 Mar 2017 13:19:33 +0200
Subject: [PATCH v2 06/11] ARM: at91: pm: Workaround DDRSDRC self-refresh bug
 with LPDDR1 memories.
In-Reply-To: <20170328111938.21297-1-alexandre.belloni@free-electrons.com>
References: <20170328111938.21297-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170328111938.21297-7-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As already explained for pm_suspend.S, the DDRSDR controller fails to put
LPDDR1 memories in self-refresh. Force the controller to think it has DDR2
memories during the self-refresh period, as the DDR2 self-refresh spec is
equivalent to LPDDR1, and is correctly implemented in the controller.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/pm.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 3d68d93c11c7..488549bc2bed 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -241,12 +241,27 @@ static void at91_ddr_standby(void)
 	/* Those two values allow us to delay self-refresh activation
 	 * to the maximum. */
 	u32 lpr0, lpr1 = 0;
+	u32 mdr, saved_mdr0, saved_mdr1 = 0;
 	u32 saved_lpr0, saved_lpr1 = 0;
 
+	/* LPDDR1 --> force DDR2 mode during self-refresh */
+	saved_mdr0 = at91_ramc_read(0, AT91_DDRSDRC_MDR);
+	if ((saved_mdr0 & AT91_DDRSDRC_MD) == AT91_DDRSDRC_MD_LOW_POWER_DDR) {
+		mdr = saved_mdr0 & ~AT91_DDRSDRC_MD;
+		mdr |= AT91_DDRSDRC_MD_DDR2;
+		at91_ramc_write(0, AT91_DDRSDRC_MDR, mdr);
+	}
+
 	if (pm_data.ramc[1]) {
 		saved_lpr1 = at91_ramc_read(1, AT91_DDRSDRC_LPR);
 		lpr1 = saved_lpr1 & ~AT91_DDRSDRC_LPCB;
 		lpr1 |= AT91_DDRSDRC_LPCB_SELF_REFRESH;
+		saved_mdr1 = at91_ramc_read(1, AT91_DDRSDRC_MDR);
+		if ((saved_mdr1 & AT91_DDRSDRC_MD) == AT91_DDRSDRC_MD_LOW_POWER_DDR) {
+			mdr = saved_mdr1 & ~AT91_DDRSDRC_MD;
+			mdr |= AT91_DDRSDRC_MD_DDR2;
+			at91_ramc_write(1, AT91_DDRSDRC_MDR, mdr);
+		}
 	}
 
 	saved_lpr0 = at91_ramc_read(0, AT91_DDRSDRC_LPR);
@@ -260,9 +275,12 @@ static void at91_ddr_standby(void)
 
 	cpu_do_idle();
 
+	at91_ramc_write(0, AT91_DDRSDRC_MDR, saved_mdr0);
 	at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr0);
-	if (pm_data.ramc[1])
+	if (pm_data.ramc[1]) {
+		at91_ramc_write(0, AT91_DDRSDRC_MDR, saved_mdr1);
 		at91_ramc_write(1, AT91_DDRSDRC_LPR, saved_lpr1);
+	}
 }
 
 static void sama5d3_ddr_standby(void)
-- 
2.11.0
