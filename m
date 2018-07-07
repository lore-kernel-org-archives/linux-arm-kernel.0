From: pawel.mikolaj.chmiel@gmail.com (=?UTF-8?q?Pawe=C5=82=20Chmiel?=)
Date: Sat,  7 Jul 2018 12:09:40 +0200
Subject: [PATCH v4 2/5] ARM: dts: s5pv210: Add initial DTS for Samsung Galaxy
 S phone
In-Reply-To: <1530958183-10956-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1530958183-10956-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Message-ID: <1530958183-10956-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This DTS file have initial support Samsung Galaxy S phone,
also known as i9000.
It belongs to Samsung Aries devices family.
Initial version have support for:
- sdcard
- internal memory
- max8998 pmic and rtc
- max17040 fuel gauge
- gpio keys
- fimd (no panel driver yet)
- usb (peripherial mode)
- wifi

Signed-off-by: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>

--
Changes from v1:
  - Added missing commit msg
  - Removed duplicated and unneeded headers
  - Added stdout-path
  - Added information why we hardcode bootargs
---
---
 arch/arm/boot/dts/Makefile            |  1 +
 arch/arm/boot/dts/s5pv210-galaxys.dts | 77 +++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 arch/arm/boot/dts/s5pv210-galaxys.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7e2424957809..522ebdca1d3d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -846,6 +846,7 @@ dtb-$(CONFIG_ARCH_S3C64XX) += \
 	s3c6410-smdk6410.dtb
 dtb-$(CONFIG_ARCH_S5PV210) += \
 	s5pv210-aquila.dtb \
+	s5pv210-galaxys.dtb \
 	s5pv210-goni.dtb \
 	s5pv210-smdkc110.dtb \
 	s5pv210-smdkv210.dtb \
diff --git a/arch/arm/boot/dts/s5pv210-galaxys.dts b/arch/arm/boot/dts/s5pv210-galaxys.dts
new file mode 100644
index 000000000000..842276749717
--- /dev/null
+++ b/arch/arm/boot/dts/s5pv210-galaxys.dts
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include "s5pv210-aries.dtsi"
+
+/ {
+	model = "Samsung Galaxy S1 (GT-I9000) based on S5PV210";
+	compatible = "samsung,galaxys", "samsung,aries", "samsung,s5pv210";
+
+	chosen {
+		stdout-path = &uart2;
+		/*
+		 * It's hard to change those parameters in stock bootloader,
+		 * since it requires special hardware/cable.
+		 * Let's hardocde bootargs for now, till u-boot port is finished,
+		 * with which it should be easier.
+		 */
+		bootargs = "root=/dev/mmcblk2p1 rw rootwait ignore_loglevel earlyprintk";
+	};
+
+	nand_pwrseq: nand-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpj2 7 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&massmemory_en>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		power {
+			label = "power";
+			gpios = <&gph2 6 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+
+		vol-down {
+			label = "volume_down";
+			gpios = <&gph3 1 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+
+		vol-up {
+			label = "volume_up";
+			gpios = <&gph3 2 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+
+		home {
+			label = "home";
+			gpios = <&gph3 5 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_HOME>;
+			wakeup-source;
+		};
+	};
+};
+
+&pinctrl0 {
+	massmemory_en: massmemory-en {
+		samsung,pins = "gpj2-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+};
+
+&sdhci0 {
+	bus-width = <4>;
+	non-removable;
+	mmc-pwrseq = <&nand_pwrseq>;
+	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4>;
+	pinctrl-names = "default";
+	status = "okay";
+};
-- 
2.7.4
