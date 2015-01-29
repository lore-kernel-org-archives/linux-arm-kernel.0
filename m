From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 29 Jan 2015 14:44:42 +0800
Subject: [PATCH v5 13/13] pm: at91: amend the pm_suspend entry for
 at91_cpuidle_device
In-Reply-To: <1422513316-21509-1-git-send-email-wenyou.yang@atmel.com>
References: <1422513316-21509-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1422513882-27602-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because the at91_xxx_standby() function is substitued by the at91_pm_suspend(),
the pm_suspend entry for at91_cpuidle_device changes as well.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/pm.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index f915f4b..657b9ba 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -41,7 +41,6 @@ static struct {
 	int memctrl;
 } at91_pm_data;
 
-static void (*at91_pm_standby)(void);
 void __iomem *at91_ramc_base[2];
 
 static int at91_pm_valid_state(suspend_state_t state)
@@ -216,12 +215,15 @@ static struct platform_device at91_cpuidle_device = {
 	.name = "cpuidle-at91",
 };
 
-void at91_pm_set_standby(void (*at91_standby)(void))
+static void at91_cpuidle_set_suspend(void (*at91_suspend)(void))
 {
-	if (at91_standby) {
-		at91_cpuidle_device.dev.platform_data = at91_standby;
-		at91_pm_standby = at91_standby;
-	}
+	if (at91_suspend)
+		at91_cpuidle_device.dev.platform_data = at91_suspend;
+}
+
+static void at91_cpuidle_suspend(void)
+{
+	at91_pm_suspend(PM_SUSPEND_STANDBY);
 }
 
 static struct of_device_id ramc_ids[] = {
@@ -298,6 +300,8 @@ static void __init at91_pm_init(void)
 {
 	at91_pm_sram_init();
 
+	at91_cpuidle_set_suspend(at91_cpuidle_suspend);
+
 	if (at91_cpuidle_device.dev.platform_data)
 		platform_device_register(&at91_cpuidle_device);
 
-- 
1.7.9.5
