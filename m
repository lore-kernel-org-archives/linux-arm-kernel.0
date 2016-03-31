From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 31 Mar 2016 22:54:08 +0200
Subject: [PATCH 2/5] ARM: dts: rockchip: fix missing usbphy unit-names
In-Reply-To: <1459457651-4727-1-git-send-email-heiko@sntech.de>
References: <1459457651-4727-1-git-send-email-heiko@sntech.de>
Message-ID: <1459457651-4727-3-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The usbphy subnodes do have a reg property but no unitname, add them.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a.dtsi | 4 ++--
 arch/arm/boot/dts/rk3188.dtsi  | 4 ++--
 arch/arm/boot/dts/rk3288.dtsi  | 6 +++---
 drivers/spi/spi.c              | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index cb0a552..c84a306 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -207,7 +207,7 @@
 		#size-cells = <0>;
 		status = "disabled";
 
-		usbphy0: usb-phy0 {
+		usbphy0: usb-phy at 17c {
 			#phy-cells = <0>;
 			reg = <0x17c>;
 			clocks = <&cru SCLK_OTGPHY0>;
@@ -215,7 +215,7 @@
 			#clock-cells = <0>;
 		};
 
-		usbphy1: usb-phy1 {
+		usbphy1: usb-phy at 188 {
 			#phy-cells = <0>;
 			reg = <0x188>;
 			clocks = <&cru SCLK_OTGPHY1>;
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 9271833..c44c318 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -166,7 +166,7 @@
 		#size-cells = <0>;
 		status = "disabled";
 
-		usbphy0: usb-phy0 {
+		usbphy0: usb-phy at 10c {
 			#phy-cells = <0>;
 			reg = <0x10c>;
 			clocks = <&cru SCLK_OTGPHY0>;
@@ -174,7 +174,7 @@
 			#clock-cells = <0>;
 		};
 
-		usbphy1: usb-phy1 {
+		usbphy1: usb-phy at 11c {
 			#phy-cells = <0>;
 			reg = <0x11c>;
 			clocks = <&cru SCLK_OTGPHY1>;
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index f445d19..ee4085d 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -967,7 +967,7 @@
 		#size-cells = <0>;
 		status = "disabled";
 
-		usbphy0: usb-phy0 {
+		usbphy0: usb-phy at 320 {
 			#phy-cells = <0>;
 			reg = <0x320>;
 			clocks = <&cru SCLK_OTGPHY0>;
@@ -975,7 +975,7 @@
 			#clock-cells = <0>;
 		};
 
-		usbphy1: usb-phy1 {
+		usbphy1: usb-phy at 334 {
 			#phy-cells = <0>;
 			reg = <0x334>;
 			clocks = <&cru SCLK_OTGPHY1>;
@@ -983,7 +983,7 @@
 			#clock-cells = <0>;
 		};
 
-		usbphy2: usb-phy2 {
+		usbphy2: usb-phy at 348 {
 			#phy-cells = <0>;
 			reg = <0x348>;
 			clocks = <&cru SCLK_OTGPHY2>;
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index de2f2f9..0239b45 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1209,7 +1209,7 @@ static void spi_pump_messages(struct kthread_work *work)
 	struct spi_master *master =
 		container_of(work, struct spi_master, pump_messages);
 
-	__spi_pump_messages(master, true, false);
+	__spi_pump_messages(master, true, master->bus_lock_flag);
 }
 
 static int spi_init_queue(struct spi_master *master)
@@ -2853,7 +2853,7 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message,
  */
 int spi_sync(struct spi_device *spi, struct spi_message *message)
 {
-	return __spi_sync(spi, message, 0);
+	return __spi_sync(spi, message, spi->master->bus_lock_flag);
 }
 EXPORT_SYMBOL_GPL(spi_sync);
 
-- 
2.6.4
