From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 11:25:53 +0100
Subject: [PATCH 21/33] ARM: sa1100: provide infrastructure to support generic
 CF sockets
In-Reply-To: <20160829102328.GA28796@n2100.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
Message-ID: <E1beJlJ-0000nl-3j@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide the SoC-level infrastructure to support the generic CF sockets.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/clock.c   |  2 ++
 arch/arm/mach-sa1100/generic.c | 14 +++++++++++++-
 arch/arm/mach-sa1100/generic.h |  3 +++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sa1100/clock.c b/arch/arm/mach-sa1100/clock.c
index 0db46895c82a..f6f75c9325bf 100644
--- a/arch/arm/mach-sa1100/clock.c
+++ b/arch/arm/mach-sa1100/clock.c
@@ -137,6 +137,8 @@ static struct clk_lookup sa11xx_clkregs[] = {
 	CLKDEV_INIT("sa1100-rtc", NULL, NULL),
 	CLKDEV_INIT("sa11x0-fb", NULL, &clk_cpu),
 	CLKDEV_INIT("sa11x0-pcmcia", NULL, &clk_cpu),
+	CLKDEV_INIT("sa11x0-pcmcia.0", NULL, &clk_cpu),
+	CLKDEV_INIT("sa11x0-pcmcia.1", NULL, &clk_cpu),
 	/* sa1111 names devices using internal offsets, PCMCIA is at 0x1800 */
 	CLKDEV_INIT("1800", NULL, &clk_cpu),
 	CLKDEV_INIT(NULL, "OSTIMER0", &clk_36864),
diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index 3e09beddb6e8..a005eef1a24e 100644
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
@@ -232,11 +233,19 @@ void sa11x0_register_lcd(struct sa1100fb_mach_info *inf)
 	sa11x0_register_device(&sa11x0fb_device, inf);
 }
 
+static bool sa11x0pcmcia_legacy = true;
 static struct platform_device sa11x0pcmcia_device = {
 	.name		= "sa11x0-pcmcia",
 	.id		= -1,
 };
 
+void sa11x0_register_pcmcia(int socket, struct gpiod_lookup_table *table)
+{
+	gpiod_add_lookup_table(table);
+	platform_device_register_simple("sa11x0-pcmcia", socket, NULL, 0);
+	sa11x0pcmcia_legacy = false;
+}
+
 static struct platform_device sa11x0mtd_device = {
 	.name		= "sa1100-mtd",
 	.id		= -1,
@@ -311,7 +320,6 @@ static struct platform_device *sa11x0_devices[] __initdata = {
 	&sa11x0uart1_device,
 	&sa11x0uart3_device,
 	&sa11x0ssp_device,
-	&sa11x0pcmcia_device,
 	&sa11x0rtc_device,
 	&sa11x0dma_device,
 };
@@ -319,6 +327,10 @@ static struct platform_device *sa11x0_devices[] __initdata = {
 static int __init sa1100_init(void)
 {
 	pm_power_off = sa1100_power_off;
+
+	if (sa11x0pcmcia_legacy)
+		platform_device_register(&sa11x0pcmcia_device);
+
 	return platform_add_devices(sa11x0_devices, ARRAY_SIZE(sa11x0_devices));
 }
 
diff --git a/arch/arm/mach-sa1100/generic.h b/arch/arm/mach-sa1100/generic.h
index 68199b603ff7..22c432979150 100644
--- a/arch/arm/mach-sa1100/generic.h
+++ b/arch/arm/mach-sa1100/generic.h
@@ -46,3 +46,6 @@ static inline int sa11x0_pm_init(void) { return 0; }
 #endif
 
 int sa11xx_clk_init(void);
+
+struct gpiod_lookup_table;
+void sa11x0_register_pcmcia(int socket, struct gpiod_lookup_table *);
-- 
2.1.0
