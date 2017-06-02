From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Fri,  2 Jun 2017 18:52:38 -0500
Subject: [PATCHv3 3/4] dt-bindings: i2c: Add Altera I2C Controller
In-Reply-To: <1496447559-19782-1-git-send-email-thor.thayer@linux.intel.com>
References: <1496447559-19782-1-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <1496447559-19782-4-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add the documentation to support the Altera synthesizable
logic I2C Controller in FPGA.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
v2  Change the subject to identify dt-bindings
    Add synthesizable logic to description.
    Change compatible string to "altr,softip-i2c"
    Make description of clock phandle singular since 1 clock.
    Remove altr, from fifo-size
    Specify fifo-size is in bytes.
v3  Add version to compatible string "altr,softip-i2c-v1.0"
    Add for use in FPGA in description.
---
 .../devicetree/bindings/i2c/i2c-altera.txt         | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-altera.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-altera.txt b/Documentation/devicetree/bindings/i2c/i2c-altera.txt
new file mode 100644
index 0000000..767664f
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-altera.txt
@@ -0,0 +1,39 @@
+* Altera I2C Controller
+* This is Altera's synthesizable logic block I2C Controller for use
+* in Altera's FPGAs.
+
+Required properties :
+ - compatible : should be "altr,softip-i2c-v1.0"
+ - reg        : Offset and length of the register set for the device
+ - interrupts : <IRQ> where IRQ is the interrupt number.
+ - clocks     : phandle to input clock.
+ - #address-cells = <1>;
+ - #size-cells = <0>;
+
+Recommended properties :
+ - clock-frequency : desired I2C bus clock frequency in Hz.
+
+Optional properties :
+ - fifo-size : Size of the RX and TX FIFOs in bytes.
+ - Child nodes conforming to i2c bus binding
+
+Example :
+
+	i2c at 100080000 {
+		compatible = "altr,softip-i2c-v1.0";
+		reg = <0x00000001 0x00080000 0x00000040>;
+		interrupt-parent = <&intc>;
+		interrupts = <0 43 4>;
+		clocks = <&clk_0>;
+		clock-frequency = <100000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		fifo-size = <4>;
+
+		eeprom at 51 {
+			compatible = "atmel,24c32";
+			reg = <0x51>;
+			pagesize = <32>;
+		};
+	};
+
-- 
2.7.4
