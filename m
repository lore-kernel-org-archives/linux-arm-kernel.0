From: ykk@rock-chips.com (Yakir Yang)
Date: Tue,  1 Sep 2015 13:58:52 +0800
Subject: [PATCH v4 06/16] Documentation: drm/bridge: add document for
 analogix_dp
In-Reply-To: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1441087132-25295-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Analogix dp driver is split from exynos dp driver, so we just
make an copy of exynos_dp.txt, and then simplify exynos_dp.txt

Beside update some exynos dtsi file with the latest change
according to the devicetree binding documents.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v4:
- Take Krzysztof suggest, split all DTS changes, and provide backward compatibility.
  Mark old properties as deprecated but still support them.
- Take Rob suggest, update "analogix,hpd-gpio" to "hpd-gpios" prop name.
- Take Thierry suggest, deprecated some properties which could parsed from Edid/Mode/DPCD.
    "analogix,color-space" & "analogix,color-depth"   &
    "analogix,link-rate"   & "analogix,lane-count"    &
    "analogix,ycbcr-coeff" & "analogix,dynamic-range" &
    "vsync-active-high"    & "hsync-active-high"      & "interlaces"

Changes in v3:
- Take Heiko suggest, add devicetree binding documents.
- Take Thierry Reding suggest, remove sync pol & colorimetry properies
  from the new analogix dp driver devicetree binding.
- Update the exist exynos dtsi file with the latest DP DT properies.

Changes in v2: None

 .../devicetree/bindings/drm/bridge/analogix_dp.txt | 50 +++++++++++++++++
 .../devicetree/bindings/video/exynos_dp.txt        | 63 ++++++++--------------
 2 files changed, 71 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/drm/bridge/analogix_dp.txt

diff --git a/Documentation/devicetree/bindings/drm/bridge/analogix_dp.txt b/Documentation/devicetree/bindings/drm/bridge/analogix_dp.txt
new file mode 100644
index 0000000..f54dc3e
--- /dev/null
+++ b/Documentation/devicetree/bindings/drm/bridge/analogix_dp.txt
@@ -0,0 +1,50 @@
+Analogix Display Port bridge bindings
+
+Required properties for dp-controller:
+	-compatible:
+		platform specific such as:
+		 * "samsung,exynos5-dp"
+		 * "rockchip,rk3288-dp"
+	-reg:
+		physical base address of the controller and length
+		of memory mapped region.
+	-interrupts:
+		interrupt combiner values.
+	-clocks:
+		from common clock binding: handle to dp clock.
+	-clock-names:
+		from common clock binding: Shall be "dp".
+	-interrupt-parent:
+		phandle to Interrupt combiner node.
+	-phys:
+		from general PHY binding: the phandle for the PHY device.
+	-phy-names:
+		from general PHY binding: Should be "dp".
+
+Optional properties for dp-controller:
+	-hpd-gpios:
+		Hotplug detect GPIO.
+		Indicates which GPIO should be used for hotplug detection
+	-port@[X]: SoC specific port nodes with endpoint definitions as defined
+		in Documentation/devicetree/bindings/media/video-interfaces.txt,
+		please refer to the SoC specific binding document:
+		* Documentation/devicetree/bindings/video/exynos_dp.txt
+		* Documentation/devicetree/bindings/video/analogix_dp-rockchip.txt
+
+
+[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
+-------------------------------------------------------------------------------
+
+Example:
+
+	dp-controller {
+		compatible = "samsung,exynos5-dp";
+		reg = <0x145b0000 0x10000>;
+		interrupts = <10 3>;
+		interrupt-parent = <&combiner>;
+		clocks = <&clock 342>;
+		clock-names = "dp";
+
+		phys = <&dp_phy>;
+		phy-names = "dp";
+	};
diff --git a/Documentation/devicetree/bindings/video/exynos_dp.txt b/Documentation/devicetree/bindings/video/exynos_dp.txt
index 7a3a9cd..ea03b3a 100644
--- a/Documentation/devicetree/bindings/video/exynos_dp.txt
+++ b/Documentation/devicetree/bindings/video/exynos_dp.txt
@@ -31,45 +31,31 @@ Required properties for dp-controller:
 		from general PHY binding: the phandle for the PHY device.
 	-phy-names:
 		from general PHY binding: Should be "dp".
-	-samsung,color-space:
-		input video data format.
-			COLOR_RGB = 0, COLOR_YCBCR422 = 1, COLOR_YCBCR444 = 2
-	-samsung,dynamic-range:
-		dynamic range for input video data.
-			VESA = 0, CEA = 1
-	-samsung,ycbcr-coeff:
-		YCbCr co-efficients for input video.
-			COLOR_YCBCR601 = 0, COLOR_YCBCR709 = 1
-	-samsung,color-depth:
-		number of bits per colour component.
-			COLOR_6 = 0, COLOR_8 = 1, COLOR_10 = 2, COLOR_12 = 3
-	-samsung,link-rate:
-		link rate supported by the panel.
-			LINK_RATE_1_62GBPS = 0x6, LINK_RATE_2_70GBPS = 0x0A
-	-samsung,lane-count:
-		number of lanes supported by the panel.
-			LANE_COUNT1 = 1, LANE_COUNT2 = 2, LANE_COUNT4 = 4
+
+Optional properties for dp-controller:
 	- display-timings: timings for the connected panel as described by
 		Documentation/devicetree/bindings/video/display-timing.txt
 
-Optional properties for dp-controller:
-	-interlaced:
-		interlace scan mode.
-			Progressive if defined, Interlaced if not defined
-	-vsync-active-high:
-		VSYNC polarity configuration.
-			High if defined, Low if not defined
-	-hsync-active-high:
-		HSYNC polarity configuration.
-			High if defined, Low if not defined
-	-samsung,hpd-gpio:
-		Hotplug detect GPIO.
-			Indicates which GPIO should be used for hotplug
-			detection
-	-video interfaces: Device node can contain video interface port
-			    nodes according to [1].
+For the below properties, please refer to Analogix DP binding document:
+ * Documentation/devicetree/bindings/drm/bridge/analogix_dp.txt
+	-phys (required)
+	-phy-names (required)
+	-hpd-gpios (optional)
+	-video interfaces (optional)
 
-[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
+Deprecated properties for DisplayPort:
+-interlaced:            deprecated prop that can parsed frm drm_display_mode.
+-vsync-active-high:     deprecated prop that can parsed frm drm_display_mode.
+-hsync-active-high:     deprecated prop that can parsed frm drm_display_mode.
+-samsung,ycbcr-coeff:   deprecated prop that can parsed frm drm_display_mode.
+-samsung,dynamic-range: deprecated prop that can parsed frm drm_display_mode.
+-samsung,color-space:   deprecated prop that can parsed from drm_display_info.
+-samsung,color-depth:   deprecated prop that can parsed from drm_display_info.
+-samsung,link-rate:     deprecated prop that can reading from monitor by dpcd method.
+-samsung,lane-count:    deprecated prop that can reading from monitor by dpcd method.
+-samsung,hpd-gpio:      deprecated name for hpd-gpios.
+
+-------------------------------------------------------------------------------
 
 Example:
 
@@ -88,13 +74,6 @@ SOC specific portion:
 
 Board Specific portion:
 	dp-controller {
-		samsung,color-space = <0>;
-		samsung,dynamic-range = <0>;
-		samsung,ycbcr-coeff = <0>;
-		samsung,color-depth = <1>;
-		samsung,link-rate = <0x0a>;
-		samsung,lane-count = <4>;
-
 		display-timings {
 			native-mode = <&lcd_timing>;
 			lcd_timing: 1366x768 {
-- 
2.1.2
