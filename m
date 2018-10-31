From: jagan@amarulasolutions.com (Jagan Teki)
Date: Thu,  1 Nov 2018 00:06:34 +0530
Subject: [RFC PATCH 7/7] arm64: allwinner: h6: orangepi-liet2: Enable AP6356S
 WiFi support
In-Reply-To: <20181031183634.29640-1-jagan@amarulasolutions.com>
References: <20181031183634.29640-1-jagan@amarulasolutions.com>
Message-ID: <20181031183634.29640-7-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@openedev.com>

Enable AP6356S WiFi/BT combo chip on Orangepi Lite2 board:
- WiFi SDIO interface is connected to MMC1
- WiFi WL-PMU-EN pin connected to gpio PM3: attach to mmc-pwrseq
- WiFi WL-WAKE-AP pin connected to gpio PM0
- 32kHz external oscillator gate clock from RTC

Signed-off-by: Jagan Teki <jagan@openedev.com>
---
Note:
- chip detected, but failed to connect
[  129.084504] brcmfmac: brcmf_sdio_hostmail: mailbox indicates firmware halted
[  135.906409] brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout 

 .../allwinner/sun50i-h6-orangepi-lite2.dts    | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
index e098a2475f2d..b8012208c185 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
@@ -8,4 +8,31 @@
 / {
 	model = "OrangePi Lite2";
 	compatible = "xunlong,orangepi-lite2", "allwinner,sun50i-h6";
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&rtc 1>;
+		clock-names = "ext_clock";
+		reset-gpios = <&r_pio 1 3 GPIO_ACTIVE_LOW>; /* WL-REG-ON: PM3 */
+		post-power-on-delay-ms = <200>;
+	};
+};
+
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	vmmc-supply = <&reg_cldo2>;
+	vqmmc-supply = <&reg_bldo3>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	brcmf: wifi at 1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&r_pio>;
+		interrupts = <1 0 IRQ_TYPE_LEVEL_LOW>;	/* WL-WAKE-AP: PM0 */
+		interrupt-names = "host-wake";
+	};
 };
-- 
2.18.0.321.gffc6fa0e3
