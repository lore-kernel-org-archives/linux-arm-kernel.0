From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Mon, 26 Jan 2015 17:45:47 +0800
Subject: [PATCH v2 12/12] pm: at91: amend the pm_suspend entry for
 at91_cpuidle_device
In-Reply-To: <1422265005-22937-1-git-send-email-wenyou.yang@atmel.com>
References: <1422265005-22937-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1422265547-23479-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because the at91_xxx_standby() function is substitued by the at91_pm_suspend(),
the pm_suspend entry for at91_cpuidle_device changes as well.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/pm.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 68cd3ce..7473978 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -40,8 +40,6 @@ static struct {
 	int memctrl;
 } at91_pm_data;
 
-static void (*at91_pm_standby)(void);
-
 static int at91_pm_valid_state(suspend_state_t state)
 {
 	switch (state) {
@@ -214,12 +212,15 @@ static struct platform_device at91_cpuidle_device = {
 	.name = "cpuidle-at91",
 };
 
-void at91_pm_set_standby(void (*at91_standby)(void))
+static void at91_cpuidle_suspend(void)
 {
-	if (at91_standby) {
-		at91_cpuidle_device.dev.platform_data = at91_standby;
-		at91_pm_standby = at91_standby;
-	}
+	at91_pm_suspend(PM_SUSPEND_STANDBY);
+}
+
+static void at91_cpuidle_set_suspend(void (*at91_suspend)(void))
+{
+	if (at91_suspend)
+		at91_cpuidle_device.dev.platform_data = at91_suspend;
 }
 
 static void __init at91_pm_sram_init(void)
@@ -270,6 +271,8 @@ static void __init at91_pm_init(void)
 {
 	at91_pm_sram_init();
 
+	at91_cpuidle_set_suspend(at91_cpuidle_suspend);
+
 	if (at91_cpuidle_device.dev.platform_data)
 		platform_device_register(&at91_cpuidle_device);
 
-- 
1.7.9.5
