From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed,  4 Apr 2012 22:12:51 +0200
Subject: [PATCH 17/17][V2] ARM: OMAP3: cpuidle - set global variables static
In-Reply-To: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
References: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1333570371-1389-18-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

and check the powerdomain lookup is successful.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 882d349..413aac4 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -75,7 +75,7 @@ static struct omap3_idle_statedata omap3_idle_data[OMAP3_NUM_STATES] = {
 	},
 };
 
-struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
+static struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
 
 static int _cpuidle_allow_idle(struct powerdomain *pwrdm,
 				struct clockdomain *clkdm)
@@ -364,6 +364,9 @@ int __init omap3_idle_init(void)
 	per_pd = pwrdm_lookup("per_pwrdm");
 	cam_pd = pwrdm_lookup("cam_pwrdm");
 
+	if (!mpu_pd || !core_pd || !per_pd || !cam_pd)
+		return -ENODEV;
+
 	/*
 	 * Erratum i583: implementation for ES rev < Es1.2 on 3630. We cannot
 	 * enable OFF mode in a stable form for previous revisions.
-- 
1.7.5.4
