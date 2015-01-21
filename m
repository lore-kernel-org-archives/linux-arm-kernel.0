From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Wed, 21 Jan 2015 09:44:26 +0100
Subject: [PATCH RFC] ARM: BCM5301X: add restart support
Message-ID: <1421829866-9769-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
As you can see in the patch code, restarting BCM5301X devices requires
performing some operation on its bcma bus.
That of course requires getting a reference to it which I do by calling
of_find_compatible_node with two NULLs.

Unfortuantely this may not be preferred way to do that. I remember Arnd
saying following thing when I was looking for chipcommon reference in
another patch of mine:
> This doesn't: you are now searching through all nodes starting at the
> axi node rather than searching just through the children.

Is there any better way to get reference to the bus node?
---
 arch/arm/mach-bcm/bcm_5301x.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/mach-bcm/bcm_5301x.c b/arch/arm/mach-bcm/bcm_5301x.c
index e9bcbdb..5b8cd05 100644
--- a/arch/arm/mach-bcm/bcm_5301x.c
+++ b/arch/arm/mach-bcm/bcm_5301x.c
@@ -12,9 +12,26 @@
 #include <asm/siginfo.h>
 #include <asm/signal.h>
 
+#include <linux/bcma/bcma.h>
 
 static bool first_fault = true;
 
+static struct bcma_bus *bcm5301x_get_bcma_bus(void)
+{
+	struct device_node *np;
+	struct platform_device *pdev;
+
+	np = of_find_compatible_node(NULL, NULL, "brcm,bus-axi");
+	if (!np)
+		return NULL;
+
+	pdev = of_find_device_by_node(np);
+	if (!pdev)
+		return NULL;
+
+	return platform_get_drvdata(pdev);
+}
+
 static int bcm5301x_abort_handler(unsigned long addr, unsigned int fsr,
 				 struct pt_regs *regs)
 {
@@ -43,6 +60,19 @@ static void __init bcm5301x_init_early(void)
 			"imprecise external abort");
 }
 
+static void bcm5301x_restart(enum reboot_mode mode, const char *cmd)
+{
+	struct bcma_bus *bus = bcm5301x_get_bcma_bus();
+
+	if (bus)
+		bcma_chipco_watchdog_timer_set(&bus->drv_cc, 1);
+	else
+		pr_warn("Unable to access bcma bus\n");
+
+	while (1)
+		;
+}
+
 static const char __initconst *bcm5301x_dt_compat[] = {
 	"brcm,bcm4708",
 	NULL,
@@ -52,5 +82,6 @@ DT_MACHINE_START(BCM5301X, "BCM5301X")
 	.l2c_aux_val	= 0,
 	.l2c_aux_mask	= ~0,
 	.init_early	= bcm5301x_init_early,
+	.restart	= bcm5301x_restart,
 	.dt_compat	= bcm5301x_dt_compat,
 MACHINE_END
-- 
1.8.4.5
