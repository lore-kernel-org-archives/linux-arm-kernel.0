From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Mon, 14 Jul 2014 17:36:17 +0530
Subject: [PATCH] ARM: dts: Add mask-tpm-reset DT node to the
 exynos5800-peach-pi
Message-ID: <1405339577-7878-1-git-send-email-vikas.sajjan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mask-tpm-reset GPIO is used by the kernel to prevent the TPM from
being reset across sleep/wake.  If we don't set it to anything then
the TPM will be reset.  U-Boot will detect this as invalid
and will reset the system on resume time. This GPIO can always be low
and not hurt anything.  It will get pulled back high again during a
normal warm reset when it will default back to an input.

To properly preserve the TPM state across suspend/resume and to make
the chrome U-Boot happy, properly set the GPIO to mask the
reset to the TPM.

Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
---
 arch/arm/boot/dts/exynos5800-peach-pi.dts |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 28f2a25..caa8952 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -209,6 +209,18 @@
 
 
 &pinctrl_0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mask_tpm_reset>;
+
+	/* We need GPX0_6 to be low at sleep time; just keep it low always */
+	mask_tpm_reset: mask-tpm-reset {
+		samsung,pins = "gpx0-6";
+		samsung,pin-function = <1>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+		samsung,pin-val = <0>;
+	};
+
 	max98091_irq: max98091-irq {
 		samsung,pins = "gpx0-2";
 		samsung,pin-function = <0>;
-- 
1.7.9.5
