From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 20 Oct 2016 13:42:56 +0200
Subject: [PATCH 3/4] ARM64: dts: meson-gxbb: Add P20x Wifi SDIO support
In-Reply-To: <1476963777-1804-1-git-send-email-narmstrong@baylibre.com>
References: <1476963777-1804-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1476963777-1804-4-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Wifi module support on the Amlogic P20x boards on the SDIO port.
The Wifi module also needs a 32768Hz clock provided by the PWM E port
through a pwm-clock node in it's power sequence.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index 6861b0a..203be28 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -118,6 +118,13 @@
 		clock-frequency = <32768>;
 		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
 	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
+		clocks = <&wifi32k>;
+		clock-names = "ext_clock";
+	};
 };
 
 /* This UART is brought out to the DB9 connector */
@@ -171,8 +178,15 @@
 	non-removable;
 	disable-wp;
 
+	mmc-pwrseq = <&sdio_pwrseq>;
+
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_boot>;
+
+	brcmf: bcrmf at 1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
 };
 
 /* SD card */
-- 
1.9.1
