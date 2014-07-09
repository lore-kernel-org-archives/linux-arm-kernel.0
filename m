From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  9 Jul 2014 15:40:18 +0200
Subject: [PATCHv2 14/17] cpuidle: mvebu: add Armada 38x support
In-Reply-To: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1404913221-17343-15-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the list of cpuidle states supported by the Armada
38x SoC in the cpuidle-mvebu-v7 driver, as well as the necessary logic
around it to support this SoC.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/cpuidle/cpuidle-mvebu-v7.c | 19 ++++++++++++++++++-
 include/linux/mvebu-v7-cpuidle.h   |  1 +
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-mvebu-v7.c b/drivers/cpuidle/cpuidle-mvebu-v7.c
index 5de147f..8bfac4d 100644
--- a/drivers/cpuidle/cpuidle-mvebu-v7.c
+++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
@@ -1,5 +1,5 @@
 /*
- * Marvell Armada 370 and Armada XP SoC cpuidle driver
+ * Marvell Armada 370, 38x and XP SoC cpuidle driver
  *
  * Copyright (C) 2014 Marvell
  *
@@ -88,6 +88,21 @@ static struct cpuidle_driver armada370_cpuidle_driver = {
 	.state_count = 2,
 };
 
+static struct cpuidle_driver armada38x_cpuidle_driver = {
+	.name			= "armada_38x_idle",
+	.states[0]		= ARM_CPUIDLE_WFI_STATE,
+	.states[1]		= {
+		.enter			= mvebu_v7_enter_idle,
+		.exit_latency		= 10,
+		.power_usage		= 5,
+		.target_residency	= 100,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "Idle",
+		.desc			= "CPU and SCU power down",
+	},
+	.state_count = 2,
+};
+
 static int mvebu_v7_cpuidle_probe(struct platform_device *pdev)
 {
 	struct cpuidle_driver *drv;
@@ -98,6 +113,8 @@ static int mvebu_v7_cpuidle_probe(struct platform_device *pdev)
 		drv = &armadaxp_cpuidle_driver;
 	else if (pcpuidle->type == CPUIDLE_ARMADA_370)
 		drv = &armada370_cpuidle_driver;
+	else if (pcpuidle->type == CPUIDLE_ARMADA_38X)
+		drv = &armada38x_cpuidle_driver;
 	else
 		return -EINVAL;
 
diff --git a/include/linux/mvebu-v7-cpuidle.h b/include/linux/mvebu-v7-cpuidle.h
index 6d54ae1..73f6d32 100644
--- a/include/linux/mvebu-v7-cpuidle.h
+++ b/include/linux/mvebu-v7-cpuidle.h
@@ -17,6 +17,7 @@
 enum mvebu_v7_cpuidle_types {
 	CPUIDLE_ARMADA_XP,
 	CPUIDLE_ARMADA_370,
+	CPUIDLE_ARMADA_38X,
 };
 
 struct mvebu_v7_cpuidle {
-- 
2.0.0
