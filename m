From: b-cousson@ti.com (Benoit Cousson)
Date: Mon, 13 Feb 2012 17:30:24 +0100
Subject: [PATCH 3/4] ARM: OMAP2+: pm: Do not init statically the SR and
 voltage layer with DT
In-Reply-To: <1329150625-8604-2-git-send-email-b-cousson@ti.com>
References: <1329150625-8604-2-git-send-email-b-cousson@ti.com>
Message-ID: <1329150625-8604-4-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the case of DT, the PMIC and SR initialization will be done using
a completely different mechanism.

Disable this part if a DT blob is available.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Acked-by: Kevin Hilman <khilman@ti.com>
Acked-by: Rob Herring <rob.herring@calxeda.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/mach-omap2/pm.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 1881fe9..ad4f693 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -227,6 +227,14 @@ postcore_initcall(omap2_common_pm_init);
 
 static int __init omap2_common_pm_late_init(void)
 {
+	/*
+	 * In the case of DT, the PMIC and SR initialization will be done using
+	 * a completely different mechanism.
+	 * Disable this part if a DT blob is available.
+	 */
+	if (of_have_populated_dt())
+		return 0;
+
 	/* Init the voltage layer */
 	omap_pmic_late_init();
 	omap_voltage_late_init();
-- 
1.7.0.4
