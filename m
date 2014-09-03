From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed,  3 Sep 2014 09:42:06 -0600
Subject: [PATCH] ARM: tegra: rely on bootloader pinmux programming on Tegra124
Message-ID: <1409758926-22966-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The defined mechanism for programming the Tegra pinmux is to perform all
of the following at once in order, before using any I/O controller that
is affected by the pinmux:

- Set the CLAMP_INPUTS_WHEN_TRISTATED PMC register bit.
- Set up any GPIO pins to their "initial" state.
- Program all pinmux settings in one go.

Other methods such as:

- Not setting CLAMP_INPUTS_WHEN_TRISTATED.
- Not setting GPIOs to their "initial" state before programming the
  pinmux settings of the related pin, in particular the mux function.
- Not programming the entire pinmux at once, in order to avoid
  possible conflicting settings.

... are not qualified or supported by NVIDIA ASIC/syseng. They could
cause glitches or undesired output levels on some pins, or controller
malfunction.

While we've been getting away with doing something different on many
Tegra boards without issue, I believe we've just been getting lucky.
I'd like to switch all Tegra124 systems to the correct scheme now so
they provide the right example to follow, and require that any new
boards we support upstream work in the same fashion.

While it would be nice to update boards containing older SoCs for
consistency, I don't anticipate doing so. It's too much churn to change
at this time. At least with all Tegra124 boards converted, the most
recent boards provide the correct example.

Since the bootloader needs to reprogram the pinmux to access certain
peripherals, it must program the entire pinmux due to the supported
rules above. As such, there is no need to program any part of the pinmux
from the kernel, unless dynamic pinmuxing is used. Given this, we couuld
simply remove the pinmux "default" state from the DT entirely. However,
some bootloaders parse the DT to perform their initial pinmux setup, so
it's useful to keep the pinmux data in DT. To allow this while avoiding
redundant work in the kernel, rename the "default" state to "boot". The
kernel won't apply this, but bootloaders can still look for this state
name and apply it. Note however that the DT provides zero information
about the required initial GPIO setup, so bootloaders using this approach
are not likely to operate correctly without an additional GPIO
initialization table somewhere. Previous discussions on the DT mailing
list have rejected adding such a table to DT...

The following U-Boot commits fully initialize the pinmux:

Jetson TK1: 4ff213b8e478 ARM: tegra: clamp inputs on Jetson TK1
Venice2: 3365479ce78a ARM: tegra: Venice2 pinmux spreadsheet updates
Both are part of U-Boot v2014.07 and later.

Without those commits, the only fallout I see from this change is that
HDMI on Venice2 no longer works. Given the very small user-base of this
platform, I feel that requiring a bootloader update is reasonable.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra124-jetson-tk1.dts | 6 +++---
 arch/arm/boot/dts/tegra124-venice2.dts    | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index 3ea41534334d..64828c265414 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -31,10 +31,10 @@
 	};
 
 	pinmux: pinmux at 0,70000868 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&state_default>;
+		pinctrl-names = "boot";
+		pinctrl-0 = <&state_boot>;
 
-		state_default: pinmux {
+		state_boot: pinmux {
 			clk_32k_out_pa0 {
 				nvidia,pins = "clk_32k_out_pa0";
 				nvidia,function = "soc";
diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index dcbe5858faf1..b95891b7c9b9 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -43,10 +43,10 @@
 	};
 
 	pinmux: pinmux at 0,70000868 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinmux_default>;
+		pinctrl-names = "boot";
+		pinctrl-0 = <&pinmux_boot>;
 
-		pinmux_default: common {
+		pinmux_boot: common {
 			dap_mclk1_pw4 {
 				nvidia,pins = "dap_mclk1_pw4";
 				nvidia,function = "extperiph1";
-- 
1.9.1
