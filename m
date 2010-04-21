From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 21 Apr 2010 18:28:06 +1000
Subject: [RFC/PATCH] dns323: Support for HW rev C1
Message-ID: <1271838486.2330.139.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for HW rev C1 of this critter. I have figured
out -most- of the GPIO layout, though there are still some unknowns.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Some of it is a tad hackish, so I'm open to suggestions as to how to do
it better and I'm happy to split the drivers/net part upon request, this
is really just [RFC] at this stage. 

 - Identifying the board requires the ethernet PHY ID as far as I can
tell (at least that's how d-link userspace tools do it). I've put some
code in dns323_setup.c to do it, it's a bit gross but I don't think
trying to tie links with the ethernet driver would be any cleaner.

 - I'm not totally sure what's the right approach for changing the
config of the PHY LEDs... the PHY drivers have no hooks for that and no
way that I have in mind to pass some platform data or something driver
specific like that over. Of course a device-tree would help a lot here
but you guys don't have that yet :-)

 - I whack the SATA LED control register directly from dns323_setup.c, a
bit gross but whatever code is already in sata_mv.c doesn't make my LEDs
blink :-) I think it fails to set bit 0 but I'm not 100% sure, I haven't
had a chance to debug further).

So here's my current patch. I'm a bit swamped at the moment so I may not
be able to do much more reverse eng. on that but I'm happy to react to
cleanup requests as long as they are reasonable :-)

Enjoy !

Cheers,
Ben.

diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
index 421b82f..c3a65e0 100644
--- a/arch/arm/mach-orion5x/dns323-setup.c
+++ b/arch/arm/mach-orion5x/dns323-setup.c
@@ -3,6 +3,10 @@
  *
  * Copyright (C) 2007 Herbert Valerio Riedel <hvr@gnu.org>
  *
+ * Support for HW Rev C1:
+ *
+ * Copyright (C) 2010 Benjamin Herrenschmidt <benh@kernel.crashing.org>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU Lesser General Public License as
  * published by the Free Software Foundation; either version 2 of the
@@ -31,6 +35,7 @@
 #include "common.h"
 #include "mpp.h"
 
+/* Rev A1 and B1 */
 #define DNS323_GPIO_LED_RIGHT_AMBER	1
 #define DNS323_GPIO_LED_LEFT_AMBER	2
 #define DNS323_GPIO_SYSTEM_UP		3
@@ -42,6 +47,87 @@
 #define DNS323_GPIO_KEY_POWER		9
 #define DNS323_GPIO_KEY_RESET		10
 
+/* Rev C1 */
+#define DNS323C_GPIO_KEY_POWER		1
+#define DNS323C_GPIO_POWER_OFF		2
+#define DNS323C_GPIO_LED_RIGHT_AMBER	8
+#define DNS323C_GPIO_LED_LEFT_AMBER	9
+#define DNS323C_GPIO_LED_POWER		17
+#define DNS323C_GPIO_FAN_BIT1		18
+#define DNS323C_GPIO_FAN_BIT0		19
+
+static enum {
+	DNS323_REV_A1,
+	DNS323_REV_B1,
+	DNS323_REV_C1,
+} dns323_rev;
+
+static int dns323_identify_rev(void)
+{
+	u32 dev, rev, i, reg;
+
+	pr_debug("DNS-323: Identifying board ... \n");
+
+	/* Rev A1 has a 5181 */
+	orion5x_pcie_id(&dev, &rev);
+	if (dev == MV88F5181_DEV_ID) {
+		pr_debug("DNS-323: 5181 found, board is A1\n");
+		return DNS323_REV_A1;
+	}
+	pr_debug("DNS-323: 5182 found, board is B1 or C1, checking PHY...\n");
+
+	/* Rev B1 and C1 both have 5182, let's poke at the eth PHY. This is
+	 * a bit gross but we want to do that without links into the eth
+	 * driver so let's poke at it directly. We default to rev B1 in
+	 * case the accesses fail
+	 */
+
+#define ETH_SMI_REG		(ORION5X_ETH_VIRT_BASE + 0x2000 + 0x004)
+#define  SMI_BUSY		0x10000000
+#define  SMI_READ_VALID		0x08000000
+#define  SMI_OPCODE_READ	0x04000000
+#define  SMI_OPCODE_WRITE	0x00000000
+
+	for (i = 0; i < 1000; i++) {
+		reg = readl(ETH_SMI_REG);
+		if (!(reg & SMI_BUSY))
+			break;
+	}
+	if (i >= 1000) {
+		pr_warning("DNS-323: Timeout accessing PHY, assuming rev B1\n");
+		return DNS323_REV_B1;
+	}
+	writel((3 << 21)	/* phy ID reg */ |
+	       (8 << 16)	/* phy addr */ |
+	       SMI_OPCODE_READ, ETH_SMI_REG);
+	for (i = 0; i < 1000; i++) {
+		reg = readl(ETH_SMI_REG);
+		if (reg & SMI_READ_VALID)
+			break;
+	}
+	if (i >= 1000) {
+		pr_warning("DNS-323: Timeout reading PHY, assuming rev B1\n");
+		return DNS323_REV_B1;
+	}
+	pr_debug("DNS-323: Ethernet PHY ID 0x%x\n", reg & 0xffff);
+
+	/* Note: the Marvell tools mask the ID with 0x3f0 before comparison
+	 * but I don't see that making a difference here, at least with
+	 * any known Marvell PHY ID
+	 */
+	switch(reg & 0xfff0) {
+	case 0x0cc0: /* MV88E1111 */
+		return DNS323_REV_B1;
+	case 0x0e10: /* MV88E1118 */
+		return DNS323_REV_C1;
+	default:
+		pr_warning("DNS-323: Unknown PHY ID 0x%04x, assuming rev B1\n",
+			   reg & 0xffff);
+	}
+	return DNS323_REV_B1;
+}
+
+
 /****************************************************************************
  * PCI setup
  */
@@ -68,21 +154,12 @@ static struct hw_pci dns323_pci __initdata = {
 	.map_irq	= dns323_pci_map_irq,
 };
 
-static int __init dns323_dev_id(void)
-{
-	u32 dev, rev;
-
-	orion5x_pcie_id(&dev, &rev);
-
-	return dev;
-}
-
 static int __init dns323_pci_init(void)
 {
-	/* The 5182 doesn't really use its PCI bus, and initialising PCI
+	/* Rev B1 and C1 doesn't really use its PCI bus, and initialising PCI
 	 * gets in the way of initialising the SATA controller.
 	 */
-	if (machine_is_dns323() && dns323_dev_id() != MV88F5182_DEV_ID)
+	if (machine_is_dns323() && dns323_rev == DNS323_REV_A1)
 		pci_common_init(&dns323_pci);
 
 	return 0;
@@ -221,7 +298,7 @@ static int __init dns323_read_mac_addr(void)
 	}
 
 	iounmap(mac_page);
-	printk("DNS323: Found ethernet MAC address: ");
+	printk("DNS-323: Found ethernet MAC address: ");
 	for (i = 0; i < 6; i++)
 		printk("%.2x%s", addr[i], (i < 5) ? ":" : ".\n");
 
@@ -258,7 +335,7 @@ static int dns323_gpio_blink_set(unsigned gpio,
 	return -EINVAL;
 }
 
-static struct gpio_led dns323_leds[] = {
+static struct gpio_led dns323ab_leds[] = {
 	{
 		.name = "power:blue",
 		.gpio = DNS323_GPIO_LED_POWER2,
@@ -274,9 +351,33 @@ static struct gpio_led dns323_leds[] = {
 	},
 };
 
-static struct gpio_led_platform_data dns323_led_data = {
-	.num_leds	= ARRAY_SIZE(dns323_leds),
-	.leds		= dns323_leds,
+
+static struct gpio_led dns323c_leds[] = {
+	{
+		.name = "power:blue",
+		.gpio = DNS323C_GPIO_LED_POWER,
+		.default_trigger = "timer",
+	}, {
+		.name = "right:amber",
+		.gpio = DNS323C_GPIO_LED_RIGHT_AMBER,
+		.active_low = 1,
+	}, {
+		.name = "left:amber",
+		.gpio = DNS323C_GPIO_LED_LEFT_AMBER,
+		.active_low = 1,
+	},
+};
+
+
+static struct gpio_led_platform_data dns323ab_led_data = {
+	.num_leds	= ARRAY_SIZE(dns323ab_leds),
+	.leds		= dns323ab_leds,
+	.gpio_blink_set = dns323_gpio_blink_set,
+};
+
+static struct gpio_led_platform_data dns323c_led_data = {
+	.num_leds	= ARRAY_SIZE(dns323c_leds),
+	.leds		= dns323c_leds,
 	.gpio_blink_set = dns323_gpio_blink_set,
 };
 
@@ -284,7 +385,7 @@ static struct platform_device dns323_gpio_leds = {
 	.name		= "leds-gpio",
 	.id		= -1,
 	.dev		= {
-		.platform_data	= &dns323_led_data,
+		.platform_data	= &dns323ab_led_data,
 	},
 };
 
@@ -292,7 +393,7 @@ static struct platform_device dns323_gpio_leds = {
  * GPIO Attached Keys
  */
 
-static struct gpio_keys_button dns323_buttons[] = {
+static struct gpio_keys_button dns323ab_buttons[] = {
 	{
 		.code		= KEY_RESTART,
 		.gpio		= DNS323_GPIO_KEY_RESET,
@@ -306,9 +407,23 @@ static struct gpio_keys_button dns323_buttons[] = {
 	},
 };
 
-static struct gpio_keys_platform_data dns323_button_data = {
-	.buttons	= dns323_buttons,
-	.nbuttons	= ARRAY_SIZE(dns323_buttons),
+static struct gpio_keys_platform_data dns323ab_button_data = {
+	.buttons	= dns323ab_buttons,
+	.nbuttons	= ARRAY_SIZE(dns323ab_buttons),
+};
+
+static struct gpio_keys_button dns323c_buttons[] = {
+	{
+		.code		= KEY_POWER,
+		.gpio		= DNS323C_GPIO_KEY_POWER,
+		.desc		= "Power Button",
+		.active_low	= 1,
+	},
+};
+
+static struct gpio_keys_platform_data dns323c_button_data = {
+	.buttons	= dns323c_buttons,
+	.nbuttons	= ARRAY_SIZE(dns323c_buttons),
 };
 
 static struct platform_device dns323_button_device = {
@@ -316,7 +431,7 @@ static struct platform_device dns323_button_device = {
 	.id		= -1,
 	.num_resources	= 0,
 	.dev		= {
-		.platform_data	= &dns323_button_data,
+		.platform_data	= &dns323ab_button_data,
 	},
 };
 
@@ -330,7 +445,7 @@ static struct mv_sata_platform_data dns323_sata_data = {
 /****************************************************************************
  * General Setup
  */
-static struct orion5x_mpp_mode dns323_mv88f5181_mpp_modes[] __initdata = {
+static struct orion5x_mpp_mode dns323a_mpp_modes[] __initdata = {
 	{  0, MPP_PCIE_RST_OUTn },
 	{  1, MPP_GPIO },		/* right amber LED (sata ch0) */
 	{  2, MPP_GPIO },		/* left amber LED (sata ch1) */
@@ -354,7 +469,7 @@ static struct orion5x_mpp_mode dns323_mv88f5181_mpp_modes[] __initdata = {
 	{ -1 },
 };
 
-static struct orion5x_mpp_mode dns323_mv88f5182_mpp_modes[] __initdata = {
+static struct orion5x_mpp_mode dns323b_mpp_modes[] __initdata = {
 	{  0, MPP_UNUSED },
 	{  1, MPP_GPIO },		/* right amber LED (sata ch0) */
 	{  2, MPP_GPIO },		/* left amber LED (sata ch1) */
@@ -378,15 +493,57 @@ static struct orion5x_mpp_mode dns323_mv88f5182_mpp_modes[] __initdata = {
 	{ -1 },
 };
 
+static struct orion5x_mpp_mode dns323c_mpp_modes[] __initdata = {
+	{  0, MPP_GPIO },		/* ? input */
+	{  1, MPP_GPIO },		/* input power switch (0 = pressed) */
+	{  2, MPP_GPIO },		/* output power off */
+	{  3, MPP_UNUSED },		/* ? output */
+	{  4, MPP_UNUSED },		/* ? output */
+	{  5, MPP_UNUSED },		/* ? output */
+	{  6, MPP_UNUSED },		/* ? output */
+	{  7, MPP_UNUSED },		/* ? output */
+	{  8, MPP_GPIO },		/* i/o right amber LED */
+	{  9, MPP_GPIO },		/* i/o left amber LED */
+	{ 10, MPP_GPIO },		/* input */
+	{ 11, MPP_UNUSED },
+	{ 12, MPP_SATA_LED },
+	{ 13, MPP_SATA_LED },
+	{ 14, MPP_SATA_LED },
+	{ 15, MPP_SATA_LED },
+	{ 16, MPP_UNUSED },
+	{ 17, MPP_GPIO },		/* power button LED */
+	{ 18, MPP_GPIO },		/* fan speed bit 0 */
+	{ 19, MPP_GPIO },		/* fan speed bit 1 */
+	{ -1 },
+};
+
+/* Rev C1 Fan speed notes:
+ *
+ * The fan is controlled by 2 GPIOs on this board. The settings
+ * of the bits is as follow:
+ *
+ *  GPIO 18    GPIO 19    Fan
+ *
+ *    0          0        stopped
+ *    0          1        low speed
+ *    1          0        high speed
+ *    1          1        don't do that (*)
+ *
+ * (*) I think the two bits control two feed-in resistors into a fixed
+ *     PWN circuit, setting both bits will basically go a 'bit' faster
+ *     than high speed, but d-link doesn't do it and you may get out of
+ *     HW spec so don't do it.
+ */
+
 /*
- * On the DNS-323 the following devices are attached via I2C:
+ * On the DNS-323 A1 and B1 the following devices are attached via I2C:
  *
  *  i2c addr | chip        | description
  *  0x3e     | GMT G760Af  | fan speed PWM controller
  *  0x48     | GMT G751-2f | temp. sensor and therm. watchdog (LM75 compatible)
  *  0x68     | ST M41T80   | RTC w/ alarm
  */
-static struct i2c_board_info __initdata dns323_i2c_devices[] = {
+static struct i2c_board_info __initdata dns323ab_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("g760a", 0x3e),
 	}, {
@@ -396,6 +553,21 @@ static struct i2c_board_info __initdata dns323_i2c_devices[] = {
 	},
 };
 
+/*
+ * On the DNS-323 C1 the following devices are attached via I2C:
+ *
+ *  i2c addr | chip        | description
+ *  0x48     | GMT G751-2f | temp. sensor and therm. watchdog (LM75 compatible)
+ *  0x68     | ST M41T80   | RTC w/ alarm
+ */
+static struct i2c_board_info __initdata dns323c_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("lm75", 0x48),
+	}, {
+		I2C_BOARD_INFO("m41t80", 0x68),
+	},
+};
+
 /* DNS-323 rev. A specific power off method */
 static void dns323a_power_off(void)
 {
@@ -413,19 +585,38 @@ static void dns323b_power_off(void)
 	gpio_set_value(DNS323_GPIO_POWER_OFF, 0);
 }
 
+/* DNS-323 rev. C specific power off method */
+static void dns323c_power_off(void)
+{
+	pr_info("%s: triggering power-off...\n", __func__);
+	gpio_set_value(DNS323C_GPIO_POWER_OFF, 1);
+}
+
 static void __init dns323_init(void)
 {
+        console_loglevel = 10;
+
 	/* Setup basic Orion functions. Need to be called early. */
 	orion5x_init();
 
+	/* Identify revision */
+	dns323_rev = dns323_identify_rev();
+	pr_info("DNS-323: Identified HW revision %c1\n", 'A' + dns323_rev);
+
 	/* Just to be tricky, the 5182 has a completely different
 	 * set of MPP modes to the 5181.
 	 */
-	if (dns323_dev_id() == MV88F5182_DEV_ID)
-		orion5x_mpp_conf(dns323_mv88f5182_mpp_modes);
-	else {
-		orion5x_mpp_conf(dns323_mv88f5181_mpp_modes);
+	switch(dns323_rev) {
+	case DNS323_REV_A1:
+		orion5x_mpp_conf(dns323a_mpp_modes);
 		writel(0, MPP_DEV_CTRL);		/* DEV_D[31:16] */
+		break;
+	case DNS323_REV_B1:
+		orion5x_mpp_conf(dns323b_mpp_modes);
+		break;
+	case DNS323_REV_C1:
+		orion5x_mpp_conf(dns323c_mpp_modes);
+		break;
 	}
 
 	/* setup flash mapping
@@ -434,52 +625,100 @@ static void __init dns323_init(void)
 	orion5x_setup_dev_boot_win(DNS323_NOR_BOOT_BASE, DNS323_NOR_BOOT_SIZE);
 	platform_device_register(&dns323_nor_flash);
 
-	/* The 5181 power LED is active low and requires
-	 * DNS323_GPIO_LED_POWER1 to also be low.
-	 */
-	if (dns323_dev_id() == MV88F5181_DEV_ID) {
-		dns323_leds[0].active_low = 1;
-		gpio_direction_output(DNS323_GPIO_LED_POWER1, 0);
+	/* Sort out LEDs, Buttons and i2c devices */
+	switch(dns323_rev) {
+	case DNS323_REV_A1:
+		/* The 5181 power LED is active low and requires
+		 * DNS323_GPIO_LED_POWER1 to also be low.
+		 */
+		if (dns323_rev == DNS323_REV_A1) {
+			dns323ab_leds[0].active_low = 1;
+			gpio_direction_output(DNS323_GPIO_LED_POWER1, 0);
+		}
+		/* Fall through */
+	case DNS323_REV_B1:
+		i2c_register_board_info(0, dns323ab_i2c_devices,
+				ARRAY_SIZE(dns323ab_i2c_devices));
+		break;
+	case DNS323_REV_C1:
+		/* Fixup LEDs & Buttons */
+		dns323_gpio_leds.dev.platform_data = &dns323c_led_data;
+		dns323_button_device.dev.platform_data = &dns323c_button_data;
+
+		/* Set default GPIO directions for user GPIOs
+		 *
+		 * We boot with the fan set to low speed, userspace can
+		 * adjust it later.
+		 */
+		gpio_direction_output(DNS323C_GPIO_FAN_BIT0, 1);
+		gpio_direction_output(DNS323C_GPIO_FAN_BIT1, 0);
+		gpio_export(DNS323C_GPIO_FAN_BIT0, false);
+		gpio_export(DNS323C_GPIO_FAN_BIT1, false);
+
+		i2c_register_board_info(0, dns323c_i2c_devices,
+				ARRAY_SIZE(dns323c_i2c_devices));
 	}
 
 	platform_device_register(&dns323_gpio_leds);
-
 	platform_device_register(&dns323_button_device);
 
-	i2c_register_board_info(0, dns323_i2c_devices,
-				ARRAY_SIZE(dns323_i2c_devices));
-
 	/*
 	 * Configure peripherals.
 	 */
 	if (dns323_read_mac_addr() < 0)
-		printk("DNS323: Failed to read MAC address\n");
-
+		printk("DNS-323: Failed to read MAC address\n");
 	orion5x_ehci0_init();
 	orion5x_eth_init(&dns323_eth_data);
 	orion5x_i2c_init();
 	orion5x_uart0_init();
 
-	/* The 5182 has its SATA controller on-chip, and needs its own little
-	 * init routine.
-	 */
-	if (dns323_dev_id() == MV88F5182_DEV_ID)
+	/* Remaining GPIOs */
+	switch(dns323_rev) {
+	case DNS323_REV_A1:
+		/* Poweroff GPIO */
+		if (gpio_request(DNS323_GPIO_POWER_OFF, "POWEROFF") != 0 ||
+		    gpio_direction_output(DNS323_GPIO_POWER_OFF, 0) != 0)
+			pr_err("DNS-323: failed to setup power-off GPIO\n");
+		pm_power_off = dns323a_power_off;
+		break;
+	case DNS323_REV_B1:
+		/* 5182 built-in SATA init */
 		orion5x_sata_init(&dns323_sata_data);
 
-	/* The 5182 has flag to indicate the system is up. Without this flag
-	 * set, power LED will flash and cannot be controlled via leds-gpio.
-	 */
-	if (dns323_dev_id() == MV88F5182_DEV_ID)
-		gpio_set_value(DNS323_GPIO_SYSTEM_UP, 1);
-
-	/* Register dns323 specific power-off method */
-	if (gpio_request(DNS323_GPIO_POWER_OFF, "POWEROFF") != 0 ||
-	    gpio_direction_output(DNS323_GPIO_POWER_OFF, 0) != 0)
-		pr_err("DNS323: failed to setup power-off GPIO\n");
-	if (dns323_dev_id() == MV88F5182_DEV_ID)
+		/* The DNS323 rev B1 has flag to indicate the system is up.
+		 * Without this flag set, power LED will flash and cannot be
+		 * controlled via leds-gpio.
+		 */
+		if (gpio_request(DNS323_GPIO_SYSTEM_UP, "SYS_READY") == 0)
+			gpio_direction_output(DNS323_GPIO_SYSTEM_UP, 1);
+
+		/* Poweroff GPIO */
+		if (gpio_request(DNS323_GPIO_POWER_OFF, "POWEROFF") != 0 ||
+		    gpio_direction_output(DNS323_GPIO_POWER_OFF, 0) != 0)
+			pr_err("DNS-323: failed to setup power-off GPIO\n");
 		pm_power_off = dns323b_power_off;
-	else
-		pm_power_off = dns323a_power_off;
+		break;
+	case DNS323_REV_C1:
+		/* 5182 built-in SATA init */
+		orion5x_sata_init(&dns323_sata_data);
+
+		/* Poweroff GPIO */
+		if (gpio_request(DNS323C_GPIO_POWER_OFF, "POWEROFF") != 0 ||
+		    gpio_direction_output(DNS323C_GPIO_POWER_OFF, 0) != 0)
+			pr_err("DNS-323: failed to setup power-off GPIO\n");
+		pm_power_off = dns323c_power_off;
+
+		/* Now, -this- should theorically be done by the sata_mv driver
+		 * once I figure out what's going on there. Maybe the behaviour
+		 * of the LEDs should be somewhat passed via the platform_data.
+		 * for now, just whack the register and make the LEDs happy
+		 *
+		 * Note: AFAIK, rev B1 needs the same treatement but I'll let
+		 * somebody else test it.
+		 */
+		writel(0x5, ORION5X_SATA_VIRT_BASE | 0x2c);
+		break;
+	}
 }
 
 /* Warning: D-Link uses a wrong mach-type (=526) in their bootloader */
diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 64c7fbe..22b1efa 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -34,6 +34,10 @@
 #include <asm/irq.h>
 #include <asm/uaccess.h>
 
+#ifdef CONFIG_ARM
+#include <asm/mach-types.h>
+#endif
+
 #define MII_M1011_IEVENT		0x13
 #define MII_M1011_IEVENT_CLEAR		0x0000
 
@@ -350,7 +354,14 @@ static int m88e1118_config_init(struct phy_device *phydev)
 		return err;
 
 	/* Adjust LED Control */
+#ifdef CONFIG_MACH_DNS323
+	/* The DNS-323 needs a special value in here for the LED to work */
+	if (machine_is_dns323())
+		err = phy_write(phydev, 0x10, 0x1100);
+	else
+#else
 	err = phy_write(phydev, 0x10, 0x021e);
+#endif
 	if (err < 0)
 		return err;
 
