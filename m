From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 19 Mar 2013 00:10:21 +0900
Subject: [PATCH 03/03] ARM: shmobile: APE6EVM LAN9220 support
In-Reply-To: <20130318150953.28231.73454.sendpatchset@w520>
References: <20130318150953.28231.73454.sendpatchset@w520>
Message-ID: <20130318151021.28231.51294.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add LAN9220 support to the APE6EVM board using C and DT.
At this point the PFC lacks DT bindings so to configure
the pinmux we need to use C.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against "next" renesas.git 811689afc214564c4a5f238ecf4d8bdc0e52b615
 
 Depends on the following two series:
 [PATCH 00/04] ARM: shmobile: r8a73a4 SoC support V2
 [PATCH 00/02] sh-pfc: Initial r8a73a4 PFC support

 arch/arm/boot/dts/r8a73a4-ape6evm.dts  |   21 ++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig         |    1 
 arch/arm/mach-shmobile/board-ape6evm.c |   36 ++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

--- 0009/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ work/arch/arm/boot/dts/r8a73a4-ape6evm.dts	2013-03-18 22:13:31.000000000 +0900
@@ -23,4 +23,25 @@
 		device_type = "memory";
 		reg = <0x40000000 0x40000000>;
 	};
+
+	ape6evm_fixed_3v3: fixedregulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	ethernet at 8000000 {
+		compatible = "smsc,lan9118", "smsc,lan9115";
+		reg = <0x08000000 0x1000>;
+		interrupt-parent = <&irqc1>;
+		interrupts = <8 0x4>;
+		phy-mode = "mii";
+		reg-io-width = <4>;
+		smsc,irq-active-high;
+		smsc,irq-push-pull;
+		vdd33a-supply = <&ape6evm_fixed_3v3>;
+		vddvario-supply = <&ape6evm_fixed_3v3>;
+	};
 };
--- 0010/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-03-18 22:13:44.000000000 +0900
@@ -83,6 +83,7 @@ config MACH_APE6EVM
 	bool "APE6EVM board"
 	depends on ARCH_R8A73A4
 	select ARCH_REQUIRE_GPIOLIB
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select USE_OF
 
 config MACH_MACKEREL
--- 0010/arch/arm/mach-shmobile/board-ape6evm.c
+++ work/arch/arm/mach-shmobile/board-ape6evm.c	2013-03-18 22:13:31.000000000 +0900
@@ -23,11 +23,36 @@
 #include <linux/irqchip.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
+#include <linux/smsc911x.h>
 #include <mach/common.h>
+#include <mach/irqs.h>
 #include <mach/r8a73a4.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+/* Dummy supplies, where voltage doesn't matter */
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
+};
+
+/* SMSC LAN9220 */
+static const struct resource lan9220_res[] = {
+	DEFINE_RES_MEM(0x08000000, 0x1000),
+	{
+		.start	= irq_pin(40), /* IRQ40 */
+		.flags	= IORESOURCE_IRQ | IRQF_TRIGGER_HIGH,
+	},
+};
+
+static const struct smsc911x_platform_config lan9220_data = {
+	.flags		= SMSC911X_USE_32BIT,
+	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
+	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_HIGH,
+};
+
 static void __init ape6evm_add_standard_devices(void)
 {
 	r8a73a4_clock_init();
@@ -38,6 +63,17 @@ static void __init ape6evm_add_standard_
 	gpio_request(GPIO_FN_SCIFA0_RXD, NULL);
 
 	r8a73a4_add_standard_devices();
+
+	/* LAN9220 ethernet */
+	gpio_request(GPIO_FN_IRQ40, NULL);      /* smsc9220 IRQ */
+	gpio_request(GPIO_PORT270, NULL);       /* smsc9220 RESET */
+	gpio_direction_output(GPIO_PORT270, 1);
+
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+
+	platform_device_register_resndata(&platform_bus, "smsc911x", -1,
+					  lan9220_res, ARRAY_SIZE(lan9220_res),
+					  &lan9220_data, sizeof(lan9220_data));
 }
 
 static const char *ape6evm_boards_compat_dt[] __initdata = {
