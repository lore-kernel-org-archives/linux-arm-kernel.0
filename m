From: danindrey@mail.ru (Andrey Danin)
Date: Mon, 20 Jul 2015 23:35:46 +0300
Subject: [PATCH v3 4/4] dt: paz00: define nvec as child of i2c bus
In-Reply-To: <1437424546-30405-1-git-send-email-danindrey@mail.ru>
References: <1437424546-30405-1-git-send-email-danindrey@mail.ru>
Message-ID: <1437424546-30405-5-git-send-email-danindrey@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NVEC driver was reimplemented to use tegra i2c. Use common i2c bindings
for NVEC node.

Signed-off-by: Andrey Danin <danindrey@mail.ru>
---
No changes for v3:

Changes for v2:
- swap reg and request-gpios properties
- use nvec-slave instead of nvec to keep ABI compatibility
- place doc in separate patch

Signed-off-by: Andrey Danin <danindrey@mail.ru>
---
 arch/arm/boot/dts/tegra20-paz00.dts | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index ed7e100..cd5e6ef 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -288,20 +288,16 @@
 		clock-frequency = <100000>;
 	};
 
-	nvec at 7000c500 {
-		compatible = "nvidia,nvec";
-		reg = <0x7000c500 0x100>;
-		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
+	i2c at 7000c500 {
+		status = "okay";
 		clock-frequency = <80000>;
-		request-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
-		slave-addr = <138>;
-		clocks = <&tegra_car TEGRA20_CLK_I2C3>,
-		         <&tegra_car TEGRA20_CLK_PLL_P_OUT3>;
-		clock-names = "div-clk", "fast-clk";
-		resets = <&tegra_car 67>;
-		reset-names = "i2c";
+
+		nvec: nvec at 45 {
+			compatible = "nvidia,nvec-slave";
+			reg = <0x45>;
+			request-gpios = <&gpio TEGRA_GPIO(V, 2)
+				GPIO_ACTIVE_HIGH>;
+		};
 	};
 
 	i2c at 7000d000 {
-- 
1.9.1
