From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  3 Apr 2013 11:08:20 +0900
Subject: [PATCH 05/11] ARM: shmobile: APE6EVM LAN9220 support
In-Reply-To: <1364954906-16014-1-git-send-email-horms+renesas@verge.net.au>
References: <1364954906-16014-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364954906-16014-6-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add LAN9220 support to the APE6EVM board using C and DT.
At this point the PFC driver lacks DT bindings so to
configure the PFC we use PINCTRL in C board code.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts  |   23 ++++++++++++++++++-
 arch/arm/mach-shmobile/board-ape6evm.c |   38 ++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index 833f703..f603c69 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -16,7 +16,7 @@
 	compatible = "renesas,ape6evm", "renesas,r8a73a4";
 
 	chosen {
-		bootargs = "console=ttySC0,115200 ignore_loglevel";
+		bootargs = "console=ttySC0,115200 ignore_loglevel root=/dev/nfs ip=dhcp";
 	};
 
 	memory at 40000000 {
@@ -24,8 +24,29 @@
 		reg = <0 0x40000000 0 0x40000000>;
 	};
 
+	ape6evm_fixed_3v3: fixedregulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
 	lbsc {
 		#address-cells = <1>;
 		#size-cells = <1>;
+
+		ethernet at 8000000 {
+			compatible = "smsc,lan9118", "smsc,lan9115";
+			reg = <0x08000000 0x1000>;
+			interrupt-parent = <&irqc1>;
+			interrupts = <8 0x4>;
+			phy-mode = "mii";
+			reg-io-width = <4>;
+			smsc,irq-active-high;
+			smsc,irq-push-pull;
+			vdd33a-supply = <&ape6evm_fixed_3v3>;
+			vddvario-supply = <&ape6evm_fixed_3v3>;
+		};
 	};
 };
diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index 33a8a62..55b8c9f 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -18,20 +18,49 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/irqchip.h>
 #include <linux/kernel.h>
 #include <linux/pinctrl/machine.h>
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
 static const struct pinctrl_map ape6evm_pinctrl_map[] = {
 	/* SCIFA0 console */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a73a4",
 				  "scifa0_data", "scifa0"),
+	/* SMSC */
+	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x", "pfc-r8a73a4",
+				  "irqc_irq40", "irqc"),
 };
 
 static void __init ape6evm_add_standard_devices(void)
@@ -41,6 +70,15 @@ static void __init ape6evm_add_standard_devices(void)
 				  ARRAY_SIZE(ape6evm_pinctrl_map));
 	r8a73a4_pinmux_init();
 	r8a73a4_add_standard_devices();
+
+	/* LAN9220 ethernet */
+	gpio_request_one(270, GPIOF_OUT_INIT_HIGH, NULL); /* smsc9220 RESET */
+
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+
+	platform_device_register_resndata(&platform_bus, "smsc911x", -1,
+					  lan9220_res, ARRAY_SIZE(lan9220_res),
+					  &lan9220_data, sizeof(lan9220_data));
 }
 
 static const char *ape6evm_boards_compat_dt[] __initdata = {
-- 
1.7.10.4
