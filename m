From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 24 Apr 2012 16:05:39 +0200
Subject: [PATCH 18/18][V3] ARM: OMAP3: cpuidle - set global variables static
In-Reply-To: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1335276339-11135-19-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

and check the powerdomain lookup is successful.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 0d28596..116a0d8 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -73,7 +73,7 @@ static struct omap3_idle_statedata omap3_idle_data[] = {
 	},
 };
 
-struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
+static struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
 
 static int _cpuidle_allow_idle(struct powerdomain *pwrdm,
 				struct clockdomain *clkdm)
@@ -252,6 +252,9 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	 *        its own code.
 	 */
 
+	if (!mpu_pd || !core_pd || !per_pd || !cam_pd)
+		return -ENODEV;
+
 	/*
 	 * Prevent PER off if CORE is not in retention or off as this
 	 * would disable PER wakeups completely.
-- 
1.7.5.4
