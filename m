From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Thu, 18 Jan 2018 15:34:25 +0100
Subject: [PATCH v3 09/14] ARM: dts: stm32: Enable SDIO controller on stm32f469
 disco board
In-Reply-To: <1516286070-24927-1-git-send-email-patrice.chotard@st.com>
References: <1516286070-24927-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1516286070-24927-10-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrea Merello <andrea.merello@gmail.com>

This patch adds SDIO-related DT nodes required by stm32f469 board

There is a hardware issue on these boards, it misses a pullup on
the GPIO line used as card detect to allow correct SD card
detection. To allow correct card detection "broken-cd" property
is used.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

v3: _ none

v2: _ none


 arch/arm/boot/dts/stm32f469-disco.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index 318fb12..ebb97c3 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -66,6 +66,13 @@
 		serial0 = &usart3;
 	};
 
+	mmc_vcard: mmc_vcard {
+		compatible = "regulator-fixed";
+		regulator-name = "mmc_vcard";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	soc {
 		dma-ranges = <0xc0000000 0x0 0x10000000>;
 	};
@@ -120,6 +127,18 @@
 	};
 };
 
+&sdio {
+	status = "okay";
+	vmmc-supply = <&mmc_vcard>;
+	cd-gpios = <&gpiog 2 0>;
+	cd-inverted;
+	broken-cd;
+	pinctrl-names = "default", "opendrain";
+	pinctrl-0 = <&sdio_pins>;
+	pinctrl-1 = <&sdio_pins_od>;
+	bus-width = <4>;
+};
+
 &usart3 {
 	pinctrl-0 = <&usart3_pins_a>;
 	pinctrl-names = "default";
-- 
1.9.1
