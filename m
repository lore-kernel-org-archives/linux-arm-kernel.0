From: robherring2@gmail.com (Rob Herring)
Date: Tue,  3 Dec 2013 12:58:23 -0600
Subject: [PATCH] ARM: highbank: add soft power and reset key event handling
Message-ID: <1386097103-26025-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Power and reset keys come from management processor via ipc messages.
Passing them to userspace does not work in a non-desktop environment
as acpid is used in that case. So we handle the keys directly.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
Olof, Kevin,

This is something that has been in some distro kernels for some time
and fell thru the cracks to upstream being dependent on pl320 driver.
I would like this to be tagged for stable, so it gets picked up by
distros where it has been inadvertently dropped.

Rob

 arch/arm/mach-highbank/highbank.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index b3d7e56..bd3bf66 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -17,12 +17,15 @@
 #include <linux/clkdev.h>
 #include <linux/clocksource.h>
 #include <linux/dma-mapping.h>
+#include <linux/input.h>
 #include <linux/io.h>
 #include <linux/irqchip.h>
+#include <linux/mailbox.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/of_address.h>
+#include <linux/reboot.h>
 #include <linux/amba/bus.h>
 #include <linux/platform_device.h>
 
@@ -130,6 +133,24 @@ static struct platform_device highbank_cpuidle_device = {
 	.name = "cpuidle-calxeda",
 };
 
+static int hb_keys_notifier(struct notifier_block *nb, unsigned long event, void *data)
+{
+	u32 key = *(u32 *)data;
+
+	if (event != 0x1000)
+		return 0;
+
+	if (key == KEY_POWER)
+		orderly_poweroff(false);
+	else if (key == 0xffff)
+		ctrl_alt_del();
+
+	return 0;
+}
+static struct notifier_block hb_keys_nb = {
+	.notifier_call = hb_keys_notifier,
+};
+
 static void __init highbank_init(void)
 {
 	struct device_node *np;
@@ -145,6 +166,8 @@ static void __init highbank_init(void)
 	bus_register_notifier(&platform_bus_type, &highbank_platform_nb);
 	bus_register_notifier(&amba_bustype, &highbank_amba_nb);
 
+	pl320_ipc_register_notifier(&hb_keys_nb);
+
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	if (psci_ops.cpu_suspend)
-- 
1.8.3.2
