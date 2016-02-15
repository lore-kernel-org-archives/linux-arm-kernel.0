From: ykk@rock-chips.com (Yakir Yang)
Date: Mon, 15 Feb 2016 19:10:26 +0800
Subject: [PATCH v14 07/17] dt-bindings: add document for analogix display port
 driver
In-Reply-To: <1455534485-1154-1-git-send-email-ykk@rock-chips.com>
References: <1455534485-1154-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1455534626-1781-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Analogix dp driver is split from exynos dp driver, so we just
make an copy of exynos_dp.txt, and then simplify exynos_dp.txt

Beside update some exynos dtsi file with the latest change
according to the devicetree binding documents.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v14: None
Changes in v13: None
Changes in v12: None
Changes in v11: None
Changes in v10:
- Add the ack from Rob Herring

Changes in v9: None
Changes in v8:
- Correct the right document path of display-timing.txt (Heiko)
- Correct the misspell of 'from' to 'frm'. (Heiko)

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4:
- Split all DTS changes, and provide backward compatibility. Mark old
  properties as deprecated but still support them. (Krzysztof)
- Update "analogix,hpd-gpio" to "hpd-gpios" prop name. (Rob)
- Deprecated some properties which could parsed from Edid/Mode/DPCD. (Thierry)
    "analogix,color-space" & "analogix,color-depth"   &
    "analogix,link-rate"   & "analogix,lane-count"    &
    "analogix,ycbcr-coeff" & "analogix,dynamic-range" &
    "vsync-active-high"    & "hsync-active-high"      & "interlaces"

Changes in v3:
- Add devicetree binding documents. (Heiko)
- Remove sync pol & colorimetry properies from the new analogix dp driver
  devicetree binding. (Thierry)
- Update the exist exynos dtsi file with the latest DP DT properies.

Changes in v2: None

 .../bindings/display/bridge/analogix_dp.txt        | 50 ++++++++++++
 .../bindings/display/exynos/exynos_dp.txt          | 92 ++++++----------------
 2 files changed, 76 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/analogix_dp.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/analogix_dp.txt b/Documentation/devicetree/bindings/display/bridge/analogix_dp.txt
new file mode 100644
index 0000000..7659a7a
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/analogix_dp.txt
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
+		* Documentation/devicetree/bindings/display/exynos/exynos_dp.txt
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
diff --git a/Documentation/devicetree/bindings/display/exynos/exynos_dp.txt b/Documentation/devicetree/bindings/display/exynos/exynos_dp.txt
index fe4a7a2..4fa8aca 100644
--- a/Documentation/devicetree/bindings/display/exynos/exynos_dp.txt
+++ b/Documentation/devicetree/bindings/display/exynos/exynos_dp.txt
@@ -1,20 +1,3 @@
-Device-Tree bindings for Samsung Exynos Embedded DisplayPort Transmitter(eDP)
-
-DisplayPort is industry standard to accommodate the growing board adoption
-of digital display technology within the PC and CE industries.
-It consolidates the internal and external connection methods to reduce device
-complexity and cost. It also supports necessary features for important cross
-industry applications and provides performance scalability to enable the next
-generation of displays that feature higher color depths, refresh rates, and
-display resolutions.
-
-eDP (embedded display port) device is compliant with Embedded DisplayPort
-standard as follows,
-- DisplayPort standard 1.1a for Exynos5250 and Exynos5260.
-- DisplayPort standard 1.3 for Exynos5422s and Exynos5800.
-
-eDP resides between FIMD and panel or FIMD and bridge such as LVDS.
-
 The Exynos display port interface should be configured based on
 the type of panel connected to it.
 
@@ -48,26 +31,6 @@ Required properties for dp-controller:
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
-	- display-timings: timings for the connected panel as described by
-		Documentation/devicetree/bindings/display/display-timing.txt
 
 Optional properties for dp-controller:
 	-interlaced:
@@ -83,17 +46,30 @@ Optional properties for dp-controller:
 		Hotplug detect GPIO.
 			Indicates which GPIO should be used for hotplug
 			detection
-Video interfaces:
-  Device node can contain video interface port nodes according to [1].
-  The following are properties specific to those nodes:
-
-  endpoint node connected to bridge or panel node:
-   - remote-endpoint: specifies the endpoint in panel or bridge node.
-		      This node is required in all kinds of exynos dp
-		      to represent the connection between dp and bridge
-		      or dp and panel.
-
-[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
+	-video interfaces: Device node can contain video interface port
+			nodes according to [1].
+	- display-timings: timings for the connected panel as described by
+		Documentation/devicetree/bindings/display/panel/display-timing.txt
+
+For the below properties, please refer to Analogix DP binding document:
+ * Documentation/devicetree/bindings/display/bridge/analogix_dp.txt
+	-phys (required)
+	-phy-names (required)
+	-hpd-gpios (optional)
+
+Deprecated properties for DisplayPort:
+-interlaced:            deprecated prop that can parsed from drm_display_mode.
+-vsync-active-high:     deprecated prop that can parsed from drm_display_mode.
+-hsync-active-high:     deprecated prop that can parsed from drm_display_mode.
+-samsung,ycbcr-coeff:   deprecated prop that can parsed from drm_display_mode.
+-samsung,dynamic-range: deprecated prop that can parsed from drm_display_mode.
+-samsung,color-space:   deprecated prop that can parsed from drm_display_info.
+-samsung,color-depth:   deprecated prop that can parsed from drm_display_info.
+-samsung,link-rate:     deprecated prop that can reading from monitor by dpcd method.
+-samsung,lane-count:    deprecated prop that can reading from monitor by dpcd method.
+-samsung,hpd-gpio:      deprecated name for hpd-gpios.
+
+-------------------------------------------------------------------------------
 
 Example:
 
@@ -112,13 +88,6 @@ SOC specific portion:
 
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
@@ -135,18 +104,9 @@ Board Specific portion:
 		};
 
 		ports {
-			port {
+			port at 0 {
 				dp_out: endpoint {
-					remote-endpoint = <&dp_in>;
-				};
-			};
-		};
-
-		panel {
-			...
-			port {
-				dp_in: endpoint {
-					remote-endpoint = <&dp_out>;
+					remote-endpoint = <&bridge_in>;
 				};
 			};
 		};
-- 
1.9.1
