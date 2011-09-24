From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Sat, 24 Sep 2011 13:32:32 +0530
Subject: [PATCH] gpio/omap: fix debounce clock handling
Message-ID: <mailman.151.1316860919.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO debounce clock can gate the PER power domain transition
and needs to be disabled in GPIO driver suspend.

The debounce clock is not getting disabled in runtime_suspend
callback because of an un-necessary bank->mod_usage check.
In omap_gpio_suspend/resume too, there is no need to do
any operation if the gpio bank is not used.

Remove the un-necessary bank->mod_usage check from
suspend callbacks.

Thanks to Kevin Hilman for pointing out this issue.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/gpio/gpio-omap.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index c597303..349e774 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1107,6 +1107,9 @@ static int omap_gpio_suspend(struct device *dev)
 	void __iomem *wake_status;
 	unsigned long flags;

+	if (!bank->mod_usage || !bank->loses_context)
+		return 0;
+
 	if (!bank->regs->wkup_en || !bank->suspend_wakeup)
 		return 0;

@@ -1128,6 +1131,9 @@ static int omap_gpio_resume(struct device *dev)
 	void __iomem *base =3D bank->base;
 	unsigned long flags;

+	if (!bank->mod_usage || !bank->loses_context)
+		return 0;
+
 	if (!bank->regs->wkup_en || !bank->saved_wakeup)
 		return 0;

@@ -1151,9 +1157,6 @@ static int omap_gpio_runtime_suspend(struct device *d=
ev)
 	int j;
 	unsigned long flags;

-	if (!bank->mod_usage)
-		return 0;
-
 	spin_lock_irqsave(&bank->lock, flags);
 	/*
 	 * If going to OFF, remove triggering for all
@@ -1199,9 +1202,6 @@ static int omap_gpio_runtime_resume(struct device *de=
v)
 	int j;
 	unsigned long flags;

-	if (!bank->mod_usage)
-		return 0;
-
 	spin_lock_irqsave(&bank->lock, flags);
 	for (j =3D 0; j < hweight_long(bank->dbck_enable_mask); j++)
 		clk_enable(bank->dbck);
--=20
1.7.0.4
