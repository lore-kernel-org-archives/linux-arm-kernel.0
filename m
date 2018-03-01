From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Thu, 1 Mar 2018 11:53:40 +0100
Subject: [PATCH v2 3/6] ARM: dts: stm32: Enable sdio1 for stm32f746-eval
In-Reply-To: <1519901623-23216-1-git-send-email-patrice.chotard@st.com>
References: <1519901623-23216-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1519901623-23216-4-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Adds SDIO related DT nodes for stm32f746-eval board.

broken-cd property is needed as card detect signal is
connected to a GPIO expander which is not yet supported
in kernel linux.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

v2: _ rename sdio_pins / sdio_od_pins to sdio_pins_a / sdio_od_pins_a 

 arch/arm/boot/dts/stm32746g-eval.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/stm32746g-eval.dts b/arch/arm/boot/dts/stm32746g-eval.dts
index b2d4b8c46677..32b74d52d87f 100644
--- a/arch/arm/boot/dts/stm32746g-eval.dts
+++ b/arch/arm/boot/dts/stm32746g-eval.dts
@@ -91,6 +91,13 @@
 		clocks = <&rcc 0 STM32F7_AHB1_CLOCK(OTGHSULPI)>;
 		clock-names = "main_clk";
 	};
+
+	mmc_vcard: mmc_vcard {
+		compatible = "regulator-fixed";
+		regulator-name = "mmc_vcard";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 };
 
 &clk_hse {
@@ -113,6 +120,16 @@
 	status = "okay";
 };
 
+&sdio1 {
+	status = "okay";
+	vmmc-supply = <&mmc_vcard>;
+	broken-cd;
+	pinctrl-names = "default", "opendrain";
+	pinctrl-0 = <&sdio_pins_a>;
+	pinctrl-1 = <&sdio_pins_od_a>;
+	bus-width = <4>;
+};
+
 &usart1 {
 	pinctrl-0 = <&usart1_pins_a>;
 	pinctrl-names = "default";
-- 
1.9.1
