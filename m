From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 21 Feb 2012 16:04:53 +0200
Subject: [PATCHv5 09/14] arm: omap4: use pmic params for calculating pmic
 setup times
In-Reply-To: <1329833098-19900-1-git-send-email-t-kristo@ti.com>
References: <1329833098-19900-1-git-send-email-t-kristo@ti.com>
Message-ID: <1329833098-19900-10-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As voltdm->pmic now contains startup and shutdown times for PMIC, use
these for calculating the fields in the PMICSETUPTIME register.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/vc.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 2fe4ce2..0971221 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -461,6 +461,17 @@ static void omap4_set_timings(struct voltagedomain *voltdm, bool off_mode)
 		OMAP4_DOWNTIME_MASK);
 
 	__raw_writel(val, OMAP4_SCRM_CLKSETUPTIME);
+
+	tstart = voltdm->pmic->startup_time;
+	tshut = voltdm->pmic->shutdown_time;
+
+	if (tstart && tshut) {
+		val = omap4_usec_to_val_scrm(tstart, OMAP4_WAKEUPTIME_SHIFT,
+			OMAP4_WAKEUPTIME_MASK);
+		val |= omap4_usec_to_val_scrm(tshut, OMAP4_SLEEPTIME_SHIFT,
+			OMAP4_SLEEPTIME_MASK);
+		__raw_writel(val, OMAP4_SCRM_PMICSETUPTIME);
+	}
 }
 
 /* OMAP4 specific voltage init functions */
-- 
1.7.4.1
