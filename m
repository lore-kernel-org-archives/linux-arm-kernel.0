From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 30 Jan 2017 12:05:07 +0100
Subject: [PATCH 1/6] ARM: prima2: Register with kernel restart handler
In-Reply-To: <20170130110512.6943-1-thierry.reding@gmail.com>
References: <20170130110512.6943-1-thierry.reding@gmail.com>
Message-ID: <20170130110512.6943-2-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guenter Roeck <linux@roeck-us.net>

Register with kernel restart handler instead of setting arm_pm_restart
directly. By doing this, the prima2 reset handler can be prioritized
among other restart methods available on a particular board.

Select a high priority of 192 since the original code overwrites the
default arm restart handler.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/mach-prima2/rstc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-prima2/rstc.c b/arch/arm/mach-prima2/rstc.c
index 7c251eb11d01..1639997c5b49 100644
--- a/arch/arm/mach-prima2/rstc.c
+++ b/arch/arm/mach-prima2/rstc.c
@@ -65,11 +65,18 @@ static struct reset_controller_dev sirfsoc_reset_controller = {
 
 #define SIRFSOC_SYS_RST_BIT  BIT(31)
 
-static void sirfsoc_restart(enum reboot_mode mode, const char *cmd)
+static int sirfsoc_restart(struct notifier_block *nb, unsigned long action,
+			   void *data)
 {
 	writel(SIRFSOC_SYS_RST_BIT, sirfsoc_rstc_base);
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block sirfsoc_restart_nb = {
+	.notifier_call  = sirfsoc_restart,
+	.priority       = 192,
+};
+
 static int sirfsoc_rstc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -80,7 +87,7 @@ static int sirfsoc_rstc_probe(struct platform_device *pdev)
 	}
 
 	sirfsoc_reset_controller.of_node = np;
-	arm_pm_restart = sirfsoc_restart;
+	register_restart_handler(&sirfsoc_restart_nb);
 
 	if (IS_ENABLED(CONFIG_RESET_CONTROLLER))
 		reset_controller_register(&sirfsoc_reset_controller);
-- 
2.11.0
