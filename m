From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Thu, 26 Jun 2014 14:45:27 +0530
Subject: [PATCH] ARM: dts: Add mask-tpm-reset to the device tree
Message-ID: <1403774127-21892-1-git-send-email-vikas.sajjan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Doug Anderson <dianders@chromium.org>

The mask-tpm-reset GPIO is used by the kernel to prevent the TPM from
being reset across sleep/wake.  If we don't set it to anything then
the TPM will be reset.  U-Boot will detect this as invalid
and will reset the system on resume time. This GPIO can always be low
and not hurt anything.  It will get pulled back high again during a
normal warm reset when it will default back to an input.

To properly preserve the TPM state across suspend/resume and to make
the chrome U-Boot happy, properly set the GPIO to mask the
reset to the TPM.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 7649982..8fd990a 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -87,6 +87,18 @@
 		pinctrl-0 = <&usb301_vbus_en>;
 		enable-active-high;
 	};
+
+	/* We need GPX0_6 to be low at sleep time; just keep it low always */
+	mask_tpm_reset_regulator: mask-tpm-reset-regulator {
+	compatible = "regulator-fixed";
+	regulator-name = "mask-tpm-reset ";
+		gpio = <&gpx0 6 0>;
+		enable-active-low;
+		regulator-boot-on;
+		regulator-always-on;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mask_tpm_reset>;
+	};
 };
 
 &dp {
@@ -210,6 +222,14 @@
 
 
 &pinctrl_0 {
+
+	mask_tpm_reset: mask-tpm-reset {
+		samsung,pins = "gpx0-6";
+		samsung,pin-function = <1>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
 	max98090_irq: max98090-irq {
 		samsung,pins = "gpx0-2";
 		samsung,pin-function = <0>;
-- 
1.7.9.5
