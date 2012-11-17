From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 17 Nov 2012 09:51:05 +0100
Subject: [PATCH v3 2/3] ARM: Kirkwood: Convert DNSKW to use gpio-poweroff.
In-Reply-To: <1353142266-1289-1-git-send-email-andrew@lunn.ch>
References: <1353142266-1289-1-git-send-email-andrew@lunn.ch>
Message-ID: <1353142266-1289-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also enable the gpio-poweroff driver when DT is used.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Jamie Lentin <jm@lentin.co.uk>
---
 arch/arm/boot/dts/kirkwood-dnskw.dtsi |    5 +++++
 arch/arm/mach-kirkwood/Kconfig        |    4 ++++
 arch/arm/mach-kirkwood/board-dnskw.c  |   12 ------------
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-dnskw.dtsi b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
index 9b32d02..22aa07a 100644
--- a/arch/arm/boot/dts/kirkwood-dnskw.dtsi
+++ b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
@@ -35,6 +35,11 @@
 				      6000 2>;
 	};
 
+	gpio_poweroff {
+		compatible = "gpio-poweroff";
+		gpios = <&gpio1 4 0>;
+	};
+
 	ocp at f1000000 {
 		sata at 80000 {
 			status = "okay";
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 50bca50..e0d26fe 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -46,7 +46,11 @@ config MACH_GURUPLUG
 
 config ARCH_KIRKWOOD_DT
 	bool "Marvell Kirkwood Flattened Device Tree"
+	select POWER_SUPPLY
+	select POWER_RESET
+	select POWER_RESET_GPIO
 	select USE_OF
+
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell Kirkwood using flattened device tree.
diff --git a/arch/arm/mach-kirkwood/board-dnskw.c b/arch/arm/mach-kirkwood/board-dnskw.c
index 43d16d6..549369e 100644
--- a/arch/arm/mach-kirkwood/board-dnskw.c
+++ b/arch/arm/mach-kirkwood/board-dnskw.c
@@ -57,11 +57,6 @@ static unsigned int dnskw_mpp_config[] __initdata = {
 	0
 };
 
-static void dnskw_power_off(void)
-{
-	gpio_set_value(36, 1);
-}
-
 /* Register any GPIO for output and set the value */
 static void __init dnskw_gpio_register(unsigned gpio, char *name, int def)
 {
@@ -81,13 +76,6 @@ void __init dnskw_init(void)
 	kirkwood_ehci_init();
 	kirkwood_ge00_init(&dnskw_ge00_data);
 
-	/* Register power-off GPIO. */
-	if (gpio_request(36, "dnskw:power:off") == 0
-	    && gpio_direction_output(36, 0) == 0)
-		pm_power_off = dnskw_power_off;
-	else
-		pr_err("dnskw: failed to configure power-off GPIO\n");
-
 	/* Ensure power is supplied to both HDDs */
 	dnskw_gpio_register(39, "dnskw:power:sata0", 1);
 	dnskw_gpio_register(40, "dnskw:power:sata1", 1);
-- 
1.7.10.4
