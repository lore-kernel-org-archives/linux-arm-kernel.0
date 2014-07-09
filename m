From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  9 Jul 2014 15:40:17 +0200
Subject: [PATCHv2 13/17] cpuidle: mvebu: add Armada 370 support
In-Reply-To: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1404913221-17343-14-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the list of cpuidle states supported by the Armada
370 SoC in the cpuidle-mvebu-v7 driver, as well as the necessary logic
around it to support this SoC.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/cpuidle/cpuidle-mvebu-v7.c | 18 ++++++++++++++++++
 include/linux/mvebu-v7-cpuidle.h   |  1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-mvebu-v7.c b/drivers/cpuidle/cpuidle-mvebu-v7.c
index 82c545bb..5de147f 100644
--- a/drivers/cpuidle/cpuidle-mvebu-v7.c
+++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
@@ -72,6 +72,22 @@ static struct cpuidle_driver armadaxp_cpuidle_driver = {
 	.state_count = 3,
 };
 
+static struct cpuidle_driver armada370_cpuidle_driver = {
+	.name			= "armada_370_idle",
+	.states[0]		= ARM_CPUIDLE_WFI_STATE,
+	.states[1]		= {
+		.enter			= mvebu_v7_enter_idle,
+		.exit_latency		= 100,
+		.power_usage		= 5,
+		.target_residency	= 1000,
+		.flags			= (CPUIDLE_FLAG_TIME_VALID |
+					   MVEBU_V7_FLAG_DEEP_IDLE),
+		.name			= "Deep Idle",
+		.desc			= "CPU and L2 Fabric power down",
+	},
+	.state_count = 2,
+};
+
 static int mvebu_v7_cpuidle_probe(struct platform_device *pdev)
 {
 	struct cpuidle_driver *drv;
@@ -80,6 +96,8 @@ static int mvebu_v7_cpuidle_probe(struct platform_device *pdev)
 
 	if (pcpuidle->type == CPUIDLE_ARMADA_XP)
 		drv = &armadaxp_cpuidle_driver;
+	else if (pcpuidle->type == CPUIDLE_ARMADA_370)
+		drv = &armada370_cpuidle_driver;
 	else
 		return -EINVAL;
 
diff --git a/include/linux/mvebu-v7-cpuidle.h b/include/linux/mvebu-v7-cpuidle.h
index 00fde86..6d54ae1 100644
--- a/include/linux/mvebu-v7-cpuidle.h
+++ b/include/linux/mvebu-v7-cpuidle.h
@@ -16,6 +16,7 @@
 
 enum mvebu_v7_cpuidle_types {
 	CPUIDLE_ARMADA_XP,
+	CPUIDLE_ARMADA_370,
 };
 
 struct mvebu_v7_cpuidle {
-- 
2.0.0
