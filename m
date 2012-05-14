From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 14 May 2012 16:06:16 +0200
Subject: [PATCH 1/2] ARM: s3c64xx: cpuidle - declare the states with the new
 api
In-Reply-To: <1337004377-17732-1-git-send-email-daniel.lezcano@linaro.org>
References: <1337004377-17732-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1337004377-17732-2-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The states are now part of the cpuidle_driver structure, so we can
declare the states in this structure directly. That saves us an extra
variable declaration and a memcpy.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-s3c64xx/cpuidle.c |   33 ++++++++++++++-------------------
 1 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/cpuidle.c b/arch/arm/mach-s3c64xx/cpuidle.c
index 179460f..2750e54 100644
--- a/arch/arm/mach-s3c64xx/cpuidle.c
+++ b/arch/arm/mach-s3c64xx/cpuidle.c
@@ -51,33 +51,28 @@ static int s3c64xx_enter_idle(struct cpuidle_device *dev,
 	return index;
 }
 
-static struct cpuidle_state s3c64xx_cpuidle_set[] = {
-	[0] = {
-		.enter			= s3c64xx_enter_idle,
-		.exit_latency		= 1,
-		.target_residency	= 1,
-		.flags			= CPUIDLE_FLAG_TIME_VALID,
-		.name			= "IDLE",
-		.desc			= "System active, ARM gated",
-	},
-};
+static DEFINE_PER_CPU(struct cpuidle_device, s3c64xx_cpuidle_device);
 
 static struct cpuidle_driver s3c64xx_cpuidle_driver = {
-	.name		= "s3c64xx_cpuidle",
-	.owner		= THIS_MODULE,
-	.state_count	= ARRAY_SIZE(s3c64xx_cpuidle_set),
-};
-
-static struct cpuidle_device s3c64xx_cpuidle_device = {
-	.state_count	= ARRAY_SIZE(s3c64xx_cpuidle_set),
+	.name	= "s3c64xx_cpuidle",
+	.owner  = THIS_MODULE,
+	.states = {
+		{
+			.enter            = s3c64xx_enter_idle,
+			.exit_latency     = 1,
+			.target_residency = 1,
+			.flags            = CPUIDLE_FLAG_TIME_VALID,
+			.name             = "IDLE",
+			.desc             = "System active, ARM gated",
+		},
+	},
+	.state_count = 1,
 };
 
 static int __init s3c64xx_init_cpuidle(void)
 {
 	int ret;
 
-	memcpy(s3c64xx_cpuidle_driver.states, s3c64xx_cpuidle_set,
-	       sizeof(s3c64xx_cpuidle_set));
 	cpuidle_register_driver(&s3c64xx_cpuidle_driver);
 
 	ret = cpuidle_register_device(&s3c64xx_cpuidle_device);
-- 
1.7.5.4
