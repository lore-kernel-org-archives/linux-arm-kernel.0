From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Mon, 19 Feb 2018 16:12:52 +0100
Subject: [PATCH] ARM: tegra: fix ulpi regression on tegra20
Message-ID: <20180219151252.29289-1-marcel@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Since commit f8f8f1d04494 ("clk: Don't touch hardware when reparenting
during registration") ULPI has been broken on Tegra20 leading to the
following error message during boot:

[    1.974698] ulpi_phy_power_on: ulpi write failed
[    1.979384] tegra-ehci c5004000.usb: Failed to power on the phy
[    1.985434] tegra-ehci: probe of c5004000.usb failed with error -110

Debugging through the changes and finally also consulting the TRM
revealed that rather than the CDEV2 clock off OSC requiring such pin
muxing actually the PLL_P_OUT4 clock is in use. It looks like so far it
just worked by chance of that one having been enabled which Stephen's
commit now changed when reparenting sclk away from pll_p_out4 leaving
that one disabled. Fix this by properly assigning the PLL_P_OUT4 clock
as the ULPI PHY clock.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra20.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 864a95872b8d..e05b6bb2599f 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -741,7 +741,7 @@
 		phy_type = "ulpi";
 		clocks = <&tegra_car TEGRA20_CLK_USB2>,
 			 <&tegra_car TEGRA20_CLK_PLL_U>,
-			 <&tegra_car TEGRA20_CLK_CDEV2>;
+			 <&tegra_car TEGRA20_CLK_PLL_P_OUT4>;
 		clock-names = "reg", "pll_u", "ulpi-link";
 		resets = <&tegra_car 58>, <&tegra_car 22>;
 		reset-names = "usb", "utmi-pads";
-- 
2.14.3
