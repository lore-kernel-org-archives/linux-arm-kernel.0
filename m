From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Tue, 21 Jan 2014 16:26:13 +0100
Subject: [PATCH] ARM: moxart: DT fixups
Message-ID: <1390317973-24110-1-git-send-email-jonas.jensen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change DT files to remain coherent with changes in
accompanying drivers.

1. replace "sdhci" with "mmc"
2. add bus-width property to mmc node
3. drop device_type property
4. replace "mac@" with "ethernet@"
5. replace CONFIG_MMC_SDHCI_MOXART with CONFIG_MMC_MOXART

Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>
---

Notes:
    Applies on top of:
    
    "[PATCH] ARM: moxart: move fixed rate clock child node to board level dts"
    http://lists.infradead.org/pipermail/linux-arm-kernel/2014-January/226141.html
    
    Applies to next-20140121

 arch/arm/boot/dts/moxart-uc7112lx.dts | 5 ++---
 arch/arm/boot/dts/moxart.dtsi         | 8 ++++----
 arch/arm/configs/moxart_defconfig     | 2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/moxart-uc7112lx.dts b/arch/arm/boot/dts/moxart-uc7112lx.dts
index 10d088d..ee6ef7c 100644
--- a/arch/arm/boot/dts/moxart-uc7112lx.dts
+++ b/arch/arm/boot/dts/moxart-uc7112lx.dts
@@ -80,15 +80,15 @@
 	clocks = <&ref12>;
 };
 
-&sdhci {
+&mmc {
 	status = "okay";
+	bus-width = <4>;
 };
 
 &mdio0 {
 	status = "okay";
 
 	ethphy0: ethernet-phy at 1 {
-		device_type = "ethernet-phy";
 		compatible = "moxa,moxart-rtl8201cp", "ethernet-phy-ieee802.3-c22";
 		reg = <1>;
 	};
@@ -98,7 +98,6 @@
 	status = "okay";
 
 	ethphy1: ethernet-phy at 1 {
-		device_type = "ethernet-phy";
 		compatible = "moxa,moxart-rtl8201cp", "ethernet-phy-ieee802.3-c22";
 		reg = <1>;
 	};
diff --git a/arch/arm/boot/dts/moxart.dtsi b/arch/arm/boot/dts/moxart.dtsi
index 1fd27ed..97c8084 100644
--- a/arch/arm/boot/dts/moxart.dtsi
+++ b/arch/arm/boot/dts/moxart.dtsi
@@ -90,8 +90,8 @@
 			clocks = <&clk_apb>;
 		};
 
-		sdhci: sdhci at 98e00000 {
-			compatible = "moxa,moxart-sdhci";
+		mmc: mmc at 98e00000 {
+			compatible = "moxa,moxart-mmc";
 			reg = <0x98e00000 0x5C>;
 			interrupts = <5 0>;
 			clocks = <&clk_apb>;
@@ -117,7 +117,7 @@
 			status = "disabled";
 		};
 
-		mac0: mac at 90900000 {
+		mac0: ethernet at 90900000 {
 			compatible = "moxa,moxart-mac";
 			reg = <0x90900000 0x90>;
 			interrupts = <25 0>;
@@ -126,7 +126,7 @@
 			status = "disabled";
 		};
 
-		mac1: mac at 92000000 {
+		mac1: ethernet at 92000000 {
 			compatible = "moxa,moxart-mac";
 			reg = <0x92000000 0x90>;
 			interrupts = <27 0>;
diff --git a/arch/arm/configs/moxart_defconfig b/arch/arm/configs/moxart_defconfig
index a3cb76c..708c0cf 100644
--- a/arch/arm/configs/moxart_defconfig
+++ b/arch/arm/configs/moxart_defconfig
@@ -107,7 +107,7 @@ CONFIG_WATCHDOG_NOWAYOUT=y
 CONFIG_MOXART_WDT=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
-CONFIG_MMC_SDHCI_MOXART=y
+CONFIG_MMC_MOXART=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
-- 
1.8.2.1
