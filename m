From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Fri, 13 Dec 2013 13:59:00 +0100
Subject: [PATCH 02/12] dt-bindings: document s3c24xx controller for external
 clock output
In-Reply-To: <201312131356.40755.heiko@sntech.de>
References: <201312131356.40755.heiko@sntech.de>
Message-ID: <201312131359.00450.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock settings are distributed over a regular register and parts
of the misccr register.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../bindings/clock/samsung,s3c2410-dclk.txt        |   53 ++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,s3c2410-dclk.txt

diff --git a/Documentation/devicetree/bindings/clock/samsung,s3c2410-dclk.txt b/Documentation/devicetree/bindings/clock/samsung,s3c2410-dclk.txt
new file mode 100644
index 0000000..0a1f7b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/samsung,s3c2410-dclk.txt
@@ -0,0 +1,53 @@
+* Samsung S3C24XX External Clock Output Controller
+
+The S3C24XX series can generate clock signals on two clock output pads.
+The clock binding described here is applicable to all SoCs in
+the s3c24x family.
+
+Required Properties:
+
+- compatible: should be one of the following.
+  - "samsung,s3c2410-dclk" - controller in S3C2410 SoCs.
+  - "samsung,s3c2412-dclk" - controller in S3C2412 SoCs.
+  - "samsung,s3c2440-dclk" - controller in S3C2440 and S3C2442 SoCs.
+  - "samsung,s3c2443-dclk" - controller in S3C2443 and later SoCs.
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- #clock-cells: should be 1.
+- samsung,misccr: phandle to the syscon managing the misccr register, which
+  holds configuration settings for different soc-components (clocks, usb, ...).
+
+Each clock is assigned an identifier and client nodes can use this identifier
+to specify the clock which they consume.
+
+All available clocks are defined as preprocessor macros in
+dt-bindings/clock/samsung,s3c2410-dclk.h header and can be used in device
+tree sources.
+
+To enable the clock outputs it is necessary to configure the pins accordingly
+using the pinctrl framework.
+
+Example:
+
+&pinctrl_0 {
+	clkout0: clkout0 {
+		samsung,pins = "gph-9";
+		samsung,pin-function = <2>;
+	};
+	clkout1: clkout1 {
+		samsung,pins = "gph-10";
+		samsung,pin-function = <2>;
+	};
+};
+
+[...]
+
+	clocks: clock-controller at 56000084 {
+		compatible = "samsung,s3c2410-dclk";
+		reg = <0x56000084 0x4>;
+		#clock-cells = <1>;
+		samsung,misccr = <&misccr>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&clkout0>, <&clkout1>;
+	};
-- 
1.7.10.4
