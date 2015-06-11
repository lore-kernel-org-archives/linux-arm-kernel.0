From: vthakkar1994@gmail.com (Vaishali Thakkar)
Date: Thu, 11 Jun 2015 10:57:35 +0530
Subject: [PATCH] ARM: pxa: Use setup_timer
Message-ID: <20150611052734.GA3943@vaishali-Ideapad-Z570>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the timer API function setup_timer instead of structure field
assignments to initialize a timer.

A simplified version of the Coccinelle semantic patch that performs
this transformation is as follows:

@change@
expression e1, e2, a;
@@

-init_timer(&e1);
+setup_timer(&e1, a, 0UL);
... when != a = e2
-e1.function = a;

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
---
 arch/arm/mach-pxa/sharpsl_pm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
index 051a655..bdc0c41 100644
--- a/arch/arm/mach-pxa/sharpsl_pm.c
+++ b/arch/arm/mach-pxa/sharpsl_pm.c
@@ -841,11 +841,9 @@ static int sharpsl_pm_probe(struct platform_device *pdev)
 	sharpsl_pm.charge_mode = CHRG_OFF;
 	sharpsl_pm.flags = 0;
 
-	init_timer(&sharpsl_pm.ac_timer);
-	sharpsl_pm.ac_timer.function = sharpsl_ac_timer;
+	setup_timer(&sharpsl_pm.ac_timer, sharpsl_ac_timer, 0UL);
 
-	init_timer(&sharpsl_pm.chrg_full_timer);
-	sharpsl_pm.chrg_full_timer.function = sharpsl_chrg_full_timer;
+	setup_timer(&sharpsl_pm.chrg_full_timer, sharpsl_chrg_full_timer, 0UL);
 
 	led_trigger_register_simple("sharpsl-charge", &sharpsl_charge_led_trigger);
 
-- 
1.9.1
