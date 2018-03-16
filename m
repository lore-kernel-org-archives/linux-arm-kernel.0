From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 16 Mar 2018 19:56:45 +0000
Subject: [PATCH 2/8] ARM: sa1100: provide infrastructure to support generic CF
 sockets
In-Reply-To: <20180316195552.GS9418@n2100.armlinux.org.uk>
References: <20180316195552.GS9418@n2100.armlinux.org.uk>
Message-ID: <E1ewvT3-0004Xh-5o@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide the SoC-level infrastructure to support the generic CF sockets.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/clock.c   |  2 ++
 arch/arm/mach-sa1100/generic.c | 44 +++++++++++++++++++++++++++++++++++++++++-
 arch/arm/mach-sa1100/generic.h |  8 ++++++++
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sa1100/clock.c b/arch/arm/mach-sa1100/clock.c
index b2eb3d232e39..6199e87447ca 100644
--- a/arch/arm/mach-sa1100/clock.c
+++ b/arch/arm/mach-sa1100/clock.c
@@ -163,6 +163,8 @@ static struct clk_lookup sa11xx_clkregs[] = {
 	CLKDEV_INIT("sa1100-rtc", NULL, NULL),
 	CLKDEV_INIT("sa11x0-fb", NULL, &clk_cpu),
 	CLKDEV_INIT("sa11x0-pcmcia", NULL, &clk_cpu),
+	CLKDEV_INIT("sa11x0-pcmcia.0", NULL, &clk_cpu),
+	CLKDEV_INIT("sa11x0-pcmcia.1", NULL, &clk_cpu),
 	/* sa1111 names devices using internal offsets, PCMCIA is at 0x1800 */
 	CLKDEV_INIT("1800", NULL, &clk_cpu),
 	CLKDEV_INIT(NULL, "OSTIMER0", &clk_36864),
diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index 2eb00691b07d..7167ddf84a0e 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -10,6 +10,7 @@
  * published by the Free Software Foundation.
  */
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -20,6 +21,8 @@
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 #include <linux/irqchip/irq-sa11x0.h>
 
 #include <video/sa1100fb.h>
@@ -232,11 +235,20 @@ void sa11x0_register_lcd(struct sa1100fb_mach_info *inf)
 	sa11x0_register_device(&sa11x0fb_device, inf);
 }
 
+static bool sa11x0pcmcia_legacy = true;
 static struct platform_device sa11x0pcmcia_device = {
 	.name		= "sa11x0-pcmcia",
 	.id		= -1,
 };
 
+void sa11x0_register_pcmcia(int socket, struct gpiod_lookup_table *table)
+{
+	if (table)
+		gpiod_add_lookup_table(table);
+	platform_device_register_simple("sa11x0-pcmcia", socket, NULL, 0);
+	sa11x0pcmcia_legacy = false;
+}
+
 static struct platform_device sa11x0mtd_device = {
 	.name		= "sa1100-mtd",
 	.id		= -1,
@@ -311,7 +323,6 @@ static struct platform_device *sa11x0_devices[] __initdata = {
 	&sa11x0uart1_device,
 	&sa11x0uart3_device,
 	&sa11x0ssp_device,
-	&sa11x0pcmcia_device,
 	&sa11x0rtc_device,
 	&sa11x0dma_device,
 };
@@ -319,6 +330,12 @@ static struct platform_device *sa11x0_devices[] __initdata = {
 static int __init sa1100_init(void)
 {
 	pm_power_off = sa1100_power_off;
+
+	if (sa11x0pcmcia_legacy)
+		platform_device_register(&sa11x0pcmcia_device);
+
+	regulator_has_full_constraints();
+
 	return platform_add_devices(sa11x0_devices, ARRAY_SIZE(sa11x0_devices));
 }
 
@@ -329,6 +346,31 @@ void __init sa11x0_init_late(void)
 	sa11x0_pm_init();
 }
 
+int __init sa11x0_register_fixed_regulator(int n,
+	struct fixed_voltage_config *cfg,
+	struct regulator_consumer_supply *supplies, unsigned num_supplies)
+{
+	struct regulator_init_data *id;
+
+	cfg->init_data = id = kzalloc(sizeof(*cfg->init_data), GFP_KERNEL);
+	if (!cfg->init_data)
+		return -ENOMEM;
+
+	if (cfg->gpio < 0)
+		id->constraints.always_on = 1;
+	id->constraints.name = cfg->supply_name;
+	id->constraints.min_uV = cfg->microvolts;
+	id->constraints.max_uV = cfg->microvolts;
+	id->constraints.valid_modes_mask = REGULATOR_MODE_NORMAL;
+	id->constraints.valid_ops_mask = REGULATOR_CHANGE_STATUS;
+	id->consumer_supplies = supplies;
+	id->num_consumer_supplies = num_supplies;
+
+	platform_device_register_resndata(NULL, "reg-fixed-voltage", n,
+					  NULL, 0, cfg, sizeof(*cfg));
+	return 0;
+}
+
 /*
  * Common I/O mapping:
  *
diff --git a/arch/arm/mach-sa1100/generic.h b/arch/arm/mach-sa1100/generic.h
index 97502922a15d..5f3cb52fa6ab 100644
--- a/arch/arm/mach-sa1100/generic.h
+++ b/arch/arm/mach-sa1100/generic.h
@@ -47,3 +47,11 @@ static inline int sa11x0_pm_init(void) { return 0; }
 #endif
 
 int sa11xx_clk_init(void);
+
+struct gpiod_lookup_table;
+void sa11x0_register_pcmcia(int socket, struct gpiod_lookup_table *);
+
+struct fixed_voltage_config;
+struct regulator_consumer_supply;
+int sa11x0_register_fixed_regulator(int n, struct fixed_voltage_config *cfg,
+	struct regulator_consumer_supply *supplies, unsigned num_supplies);
-- 
2.7.4
