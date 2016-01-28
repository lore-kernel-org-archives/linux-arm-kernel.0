From: jonathanh@nvidia.com (Jon Hunter)
Date: Thu, 28 Jan 2016 16:33:51 +0000
Subject: [PATCH V5 13/14] ARM64: tegra: Add audio PM domain device node for
 Tegra210
In-Reply-To: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <1453998832-27383-14-git-send-email-jonathanh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the audio power-domain for tegra210. Note that this also removes the
existing "#power-domain-cells" which was incorrectly included by
commit e53095857166 ("arm64: tegra: Add Tegra210 support").

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

---

So far I have only added the audio power-domain for tegra210 as this is
what I have been testing with to date. However, once this series is
accepted then we can begin to add more.
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index bc23f4dea002..cf78082f2a3e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -2,6 +2,7 @@
 #include <dt-bindings/gpio/tegra-gpio.h>
 #include <dt-bindings/memory/tegra210-mc.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
+#include <dt-bindings/power/tegra-powergate.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
@@ -581,7 +582,15 @@
 		clocks = <&tegra_car TEGRA210_CLK_PCLK>, <&clk32k_in>;
 		clock-names = "pclk", "clk32k_in";
 
-		#power-domain-cells = <1>;
+		powergates {
+			pd_audio: aud {
+				clocks = <&tegra_car TEGRA210_CLK_APE>,
+					 <&tegra_car TEGRA210_CLK_APB2APE>;
+				resets = <&tegra_car 198>;
+				nvidia,powergate = <TEGRA_POWERGATE_AUD>;
+				#power-domain-cells = <0>;
+			};
+		};
 	};
 
 	fuse at 0,7000f800 {
-- 
2.1.4
