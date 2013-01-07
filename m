From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  7 Jan 2013 23:56:37 +0100
Subject: [PATCH 07/11] ARM: nomadik: convert SMSC91x ethernet to device tree
Message-ID: <1357599397-7555-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This converts the SMSC91x ethernet controller to use device
tree. The existing solution from the board file, to request the
GPIO triggering the ethernet IRQ from the board file is kept
for the time being, but the GPIO number assignment is moved
over to the device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-s8815.dts    |  9 ++++++++
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 12 +++++++++++
 arch/arm/mach-nomadik/board-nhk8815.c      |  2 ++
 arch/arm/mach-nomadik/cpu-8815.c           | 34 ++++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+)

diff --git a/arch/arm/boot/dts/ste-nomadik-s8815.dts b/arch/arm/boot/dts/ste-nomadik-s8815.dts
index b698bc2..ff8a440 100644
--- a/arch/arm/boot/dts/ste-nomadik-s8815.dts
+++ b/arch/arm/boot/dts/ste-nomadik-s8815.dts
@@ -15,4 +15,13 @@
 	chosen {
 		bootargs = "root=/dev/ram0 console=ttyAMA1,115200n8 earlyprintk";
 	};
+
+	/* The S8815 is using this very GPIO pin for the SMSC91x IRQs */
+	external-bus at 34000000 {
+		ethernet at 300 {
+			gpios = <&gpio3 19 0x1>;
+			interrupts = <19 0x1>;
+			interrupt-parent = <&gpio3>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index df60e08..43b6d8c 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -122,6 +122,18 @@
 		};
 	};
 
+	external-bus at 34000000 {
+		compatible = "simple-bus";
+		reg = <0x34000000 0x1000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x34000000 0x1000000>;
+		ethernet at 300 {
+			compatible = "smsc,lan91c111";
+			reg = <0x300 0x0fd00>;
+		};
+	};
+
 	amba {
 		compatible = "arm,amba-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/mach-nomadik/board-nhk8815.c b/arch/arm/mach-nomadik/board-nhk8815.c
index 33ce566..4bc5a97 100644
--- a/arch/arm/mach-nomadik/board-nhk8815.c
+++ b/arch/arm/mach-nomadik/board-nhk8815.c
@@ -240,6 +240,8 @@ static int __init nhk8815_eth_init(void)
 	int gpio_nr = 115; /* hardwired in the board */
 	int err;
 
+	if (!machine_is_nomadik())
+		return 0;
 	err = gpio_request(gpio_nr, "eth_irq");
 	if (!err) err = gpio_direction_input(gpio_nr);
 	if (err)
diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index 543e2c0..06f9a5b 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -30,9 +30,11 @@
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/clocksource-nomadik-mtu.h>
 #include <linux/of_irq.h>
+#include <linux/of_gpio.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/mtd/fsmc.h>
+#include <linux/gpio.h>
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
@@ -276,6 +278,38 @@ static struct fsmc_nand_platform_data cpu8815_nand_data = {
 	.nand_timings = &cpu8815_nand_timings,
 };
 
+/*
+ * The SMSC911x IRQ is connected to a GPIO pin, but the driver expects
+ * to simply request an IRQ passed as a resource. So the GPIO pin needs
+ * to be requested by this hog and set as input.
+ */
+static int __init cpu8815_eth_init(void)
+{
+	struct device_node *eth;
+	int gpio, irq, err;
+
+	eth = of_find_node_by_path("/external-bus at 34000000/ethernet at 300");
+	if (!eth) {
+		pr_info("could not find any ethernet controller\n");
+		return 0;
+	}
+	gpio = of_get_gpio(eth, 0);
+	err = gpio_request(gpio, "eth_irq");
+	if (err) {
+		pr_info("failed to request ethernet GPIO\n");
+		return -ENODEV;
+	}
+	err = gpio_direction_input(gpio);
+	if (err) {
+		pr_info("failed to set ehernet GPIO as input\n");
+		return -ENODEV;
+	}
+	irq = gpio_to_irq(gpio);
+	pr_info("enabled ethernet GPIO %d, IRQ %d\n", gpio, irq);
+	return 0;
+}
+device_initcall(cpu8815_eth_init);
+
 /* These are mostly to get the right device names for the clock lookups */
 static struct of_dev_auxdata cpu8815_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("st,nomadik-gpio", NOMADIK_GPIO0_BASE,
-- 
1.7.11.7
