From: rob.lee@linaro.org (Robert Lee)
Date: Wed, 21 Mar 2012 11:48:25 -0500
Subject: [PATCH] ARM: davinci: Fix for cpuidle consolidation changes
Message-ID: <1332348505-28780-1-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recent cpuidle consolidation changes erroneously omitted one
critical line of code.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/mach-davinci/cpuidle.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpuidle.c
index 93ae096..9107691 100644
--- a/arch/arm/mach-davinci/cpuidle.c
+++ b/arch/arm/mach-davinci/cpuidle.c
@@ -55,10 +55,11 @@ static int davinci_enter_idle(struct cpuidle_device *dev,
 #define DAVINCI_CPUIDLE_FLAGS_DDR2_PWDN	BIT(0)
 
 static struct cpuidle_driver davinci_idle_driver = {
-	.name		= "cpuidle-davinci",
-	.owner		= THIS_MODULE,
-	.states[0]	= ARM_CPUIDLE_WFI_STATE,
-	.states[1]	= {
+	.name			= "cpuidle-davinci",
+	.owner			= THIS_MODULE,
+	.en_core_tk_irqen	= 1,
+	.states[0]		= ARM_CPUIDLE_WFI_STATE,
+	.states[1]		= {
 		.enter			= davinci_enter_idle,
 		.exit_latency		= 10,
 		.target_residency	= 100000,
-- 
1.7.4.1
