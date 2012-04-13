From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 13 Apr 2012 16:42:06 -0600
Subject: [PATCH 5/5] ARM: tegra: add USB ULPI PHY reset GPIO to device tree
In-Reply-To: <1334356926-4275-1-git-send-email-swarren@wwwdotorg.org>
References: <1334356926-4275-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1334356926-4275-5-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

ULPI PHYs have a reset signal, and different boards use a different GPIO
for this task. Add a property to device tree to represent this.

I'm not sure if adding this property to the EHCI controller node is
entirely correct; perhaps eventually we should have explicit separate
nodes for the various PHYs. However, we don't have that right now, so this
binding seems like a reasonable choice.

Note: There is still some problem initializing the PHY on Harmony.
However, Seaboard, Ventana, Paz00 and TrimSlice all work OK.

Cc: <devicetree-discuss@lists.ozlabs.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 .../devicetree/bindings/usb/tegra-usb.txt          |    3 +++
 arch/arm/boot/dts/tegra-harmony.dts                |    4 ++++
 arch/arm/boot/dts/tegra-paz00.dts                  |    4 ++++
 arch/arm/boot/dts/tegra-seaboard.dts               |    4 ++++
 arch/arm/boot/dts/tegra-trimslice.dts              |    4 ++++
 arch/arm/boot/dts/tegra-ventana.dts                |    4 ++++
 arch/arm/mach-tegra/include/mach/usb_phy.h         |    4 ++--
 arch/arm/mach-tegra/usb_phy.c                      |   15 +++++++++++++--
 drivers/usb/host/ehci-tegra.c                      |    5 +++--
 9 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/tegra-usb.txt b/Documentation/devicetree/bindings/usb/tegra-usb.txt
index 007005d..e9b005d 100644
--- a/Documentation/devicetree/bindings/usb/tegra-usb.txt
+++ b/Documentation/devicetree/bindings/usb/tegra-usb.txt
@@ -12,6 +12,9 @@ Required properties :
  - nvidia,vbus-gpio : If present, specifies a gpio that needs to be
    activated for the bus to be powered.
 
+Required properties for phy_type == ulpi:
+  - nvidia,phy-reset-gpio : The GPIO used to reset the PHY.
+
 Optional properties:
   - dr_mode : dual role mode. Indicates the working mode for
    nvidia,tegra20-ehci compatible controllers.  Can be "host", "peripheral",
diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts
index 1a0b1f1..59bf1cf 100644
--- a/arch/arm/boot/dts/tegra-harmony.dts
+++ b/arch/arm/boot/dts/tegra-harmony.dts
@@ -336,4 +336,8 @@
 		power-gpios = <&gpio 70 0>; /* gpio PI6 */
 		support-8bit;
 	};
+
+	usb at c5004000 {
+		nvidia,phy-reset-gpio = <&gpio 169 0>; /* gpio PV1 */
+	};
 };
diff --git a/arch/arm/boot/dts/tegra-paz00.dts b/arch/arm/boot/dts/tegra-paz00.dts
index 10943fb..fad92f2 100644
--- a/arch/arm/boot/dts/tegra-paz00.dts
+++ b/arch/arm/boot/dts/tegra-paz00.dts
@@ -351,4 +351,8 @@
 			linux,default-trigger = "rfkill0";
 		};
 	};
+
+	usb at c5004000 {
+		nvidia,phy-reset-gpio = <&gpio 168 0>; /* gpio PV0 */
+	};
 };
diff --git a/arch/arm/boot/dts/tegra-seaboard.dts b/arch/arm/boot/dts/tegra-seaboard.dts
index ec33116..ed0a2f5 100644
--- a/arch/arm/boot/dts/tegra-seaboard.dts
+++ b/arch/arm/boot/dts/tegra-seaboard.dts
@@ -415,4 +415,8 @@
 				0x00000000 0x00000000 0x00000000 0x00000000 >;
 		};
 	};
+
+	usb at c5004000 {
+		nvidia,phy-reset-gpio = <&gpio 169 0>; /* gpio PV1 */
+	};
 };
diff --git a/arch/arm/boot/dts/tegra-trimslice.dts b/arch/arm/boot/dts/tegra-trimslice.dts
index 98efd5b..71b73aa 100644
--- a/arch/arm/boot/dts/tegra-trimslice.dts
+++ b/arch/arm/boot/dts/tegra-trimslice.dts
@@ -304,4 +304,8 @@
 		cd-gpios = <&gpio 121 0>;
 		wp-gpios = <&gpio 122 0>;
 	};
+
+	usb at c5004000 {
+		nvidia,phy-reset-gpio = <&gpio 168 0>; /* gpio PV0 */
+	};
 };
diff --git a/arch/arm/boot/dts/tegra-ventana.dts b/arch/arm/boot/dts/tegra-ventana.dts
index 71eb2e5..bd074cf 100644
--- a/arch/arm/boot/dts/tegra-ventana.dts
+++ b/arch/arm/boot/dts/tegra-ventana.dts
@@ -335,4 +335,8 @@
 	sdhci at c8000600 {
 		support-8bit;
 	};
+
+	usb at c5004000 {
+		nvidia,phy-reset-gpio = <&gpio 169 0>; /* gpio PV1 */
+	};
 };
diff --git a/arch/arm/mach-tegra/include/mach/usb_phy.h b/arch/arm/mach-tegra/include/mach/usb_phy.h
index de1a0f6..935ce9f 100644
--- a/arch/arm/mach-tegra/include/mach/usb_phy.h
+++ b/arch/arm/mach-tegra/include/mach/usb_phy.h
@@ -61,8 +61,8 @@ struct tegra_usb_phy {
 	struct usb_phy *ulpi;
 };
 
-struct tegra_usb_phy *tegra_usb_phy_open(int instance, void __iomem *regs,
-			void *config, enum tegra_usb_phy_mode phy_mode);
+struct tegra_usb_phy *tegra_usb_phy_open(struct device *dev, int instance,
+	void __iomem *regs, void *config, enum tegra_usb_phy_mode phy_mode);
 
 int tegra_usb_phy_power_on(struct tegra_usb_phy *phy);
 
diff --git a/arch/arm/mach-tegra/usb_phy.c b/arch/arm/mach-tegra/usb_phy.c
index d71d2fe..54e353c 100644
--- a/arch/arm/mach-tegra/usb_phy.c
+++ b/arch/arm/mach-tegra/usb_phy.c
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/of_gpio.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
 #include <asm/mach-types.h>
@@ -654,8 +655,8 @@ static void ulpi_phy_power_off(struct tegra_usb_phy *phy)
 	clk_disable(phy->clk);
 }
 
-struct tegra_usb_phy *tegra_usb_phy_open(int instance, void __iomem *regs,
-			void *config, enum tegra_usb_phy_mode phy_mode)
+struct tegra_usb_phy *tegra_usb_phy_open(struct device *dev, int instance,
+	void __iomem *regs, void *config, enum tegra_usb_phy_mode phy_mode)
 {
 	struct tegra_usb_phy *phy;
 	struct tegra_ulpi_config *ulpi_config;
@@ -711,6 +712,16 @@ struct tegra_usb_phy *tegra_usb_phy_open(int instance, void __iomem *regs,
 			err = -ENXIO;
 			goto err1;
 		}
+		if (!gpio_is_valid(ulpi_config->reset_gpio))
+			ulpi_config->reset_gpio =
+				of_get_named_gpio(dev->of_node,
+						  "nvidia,phy-reset-gpio", 0);
+		if (!gpio_is_valid(ulpi_config->reset_gpio)) {
+			pr_err("%s: invalid reset gpio: %d\n", __func__,
+			       ulpi_config->reset_gpio);
+			err = -EINVAL;
+			goto err1;
+		}
 		gpio_request(ulpi_config->reset_gpio, "ulpi_phy_reset_b");
 		gpio_direction_output(ulpi_config->reset_gpio, 0);
 		phy->ulpi = otg_ulpi_create(&ulpi_viewport_access_ops, 0);
diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
index 9692bef..14532fe 100644
--- a/drivers/usb/host/ehci-tegra.c
+++ b/drivers/usb/host/ehci-tegra.c
@@ -708,8 +708,9 @@ static int tegra_ehci_probe(struct platform_device *pdev)
 		}
 	}
 
-	tegra->phy = tegra_usb_phy_open(instance, hcd->regs, pdata->phy_config,
-						TEGRA_USB_PHY_MODE_HOST);
+	tegra->phy = tegra_usb_phy_open(&pdev->dev, instance, hcd->regs,
+					pdata->phy_config,
+					TEGRA_USB_PHY_MODE_HOST);
 	if (IS_ERR(tegra->phy)) {
 		dev_err(&pdev->dev, "Failed to open USB phy\n");
 		err = -ENXIO;
-- 
1.7.0.4
