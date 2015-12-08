From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 8 Dec 2015 10:26:49 +0000
Subject: [PATCH] ARM: tegra: Fix suspend hang on Tegra124 Chromebooks
Message-ID: <1449570409-30244-1-git-send-email-jonathanh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabling CPUFreq support for Tegra124 Chromebooks is causing the Tegra124
to hang when resuming from suspend.

When CPUFreq is enabled, the CPU clock is changed from the PLLX clock to
the DFLL clock during kernel boot. When resuming from suspend the CPU
clock is temporarily changed back to the PLLX clock before switching back
to the DFLL. If the DFLL is operating at a much lower frequency than the
PLLX when we enter suspend, and so the CPU voltage rail is at a voltage
too low for the CPUs to operate at the PLLX frequency, then the device
will hang.

Please note that the PLLX is used in the resume sequence to switch the CPU
clock from the very slow 32K clock to a faster clock during early resume
to speed up the resume sequence before the DFLL is resumed.

Ideally, we should fix this by setting the suspend frequency so that it
matches the PLLX frequency, however, that would be a bigger change. For
now simply disable CPUFreq support for Tegra124 Chromebooks to avoid the
hang when resuming from suspend.

Fixes: 9a0baee960a7 ("ARM: tegra: Enable CPUFreq support for Tegra124
		      Chromebooks")

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---

Please note that this fix is required for v4.4

 arch/arm/boot/dts/tegra124-nyan.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index 40c23a0b7cfc..ec1aa64ded68 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -399,7 +399,7 @@
 
 	/* CPU DFLL clock */
 	clock at 0,70110000 {
-		status = "okay";
+		status = "disabled";
 		vdd-cpu-supply = <&vdd_cpu>;
 		nvidia,i2c-fs-rate = <400000>;
 	};
-- 
2.1.4
