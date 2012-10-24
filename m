From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 24 Oct 2012 16:25:23 +0200
Subject: [PATCH 4/5] ARM: Dove: Make use of pinctrl driver
In-Reply-To: <1351088724-11142-1-git-send-email-andrew@lunn.ch>
References: <1351088724-11142-1-git-send-email-andrew@lunn.ch>
Message-ID: <1351088724-11142-5-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Allow ARCH_DOVE to select pinctrl-mvebu with support for Dove SoC.
With the now enabled pinctrl driver also add the corresponding DT node
to Dove DT.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/Kconfig            |    2 ++
 arch/arm/boot/dts/dove.dtsi |    5 +++++
 drivers/pinctrl/Kconfig     |    2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0203af8..b12d1dd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -537,6 +537,8 @@ config ARCH_DOVE
 	select GENERIC_CLOCKEVENTS
 	select MIGHT_HAVE_PCI
 	select PLAT_ORION_LEGACY
+	select PINCTRL
+	select PINCTRL_DOVE
 	select USB_ARCH_HAS_EHCI
 	help
 	  Support for the Marvell Dove SoC 88AP510
diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 5a00022..1617c0c 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -67,6 +67,11 @@
 			status = "disabled";
 		};
 
+		pinctrl: pinctrl at d0200 {
+			compatible = "marvell,dove-pinctrl";
+			reg = <0xd0200 0x20>;
+		};
+
 		gpio0: gpio at d0400 {
 			compatible = "marvell,orion-gpio";
 			#gpio-cells = <2>;
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 5682c96..463100c 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -188,7 +188,7 @@ config PINCTRL_EXYNOS4
 
 config PINCTRL_MVEBU
 	bool
-	depends on ARCH_MVEBU || ARCH_KIRKWOOD
+	depends on ARCH_MVEBU || ARCH_KIRKWOOD || ARCH_DOVE
 	select PINMUX
 	select PINCONF
 
-- 
1.7.10.4
