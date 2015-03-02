From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  2 Mar 2015 16:24:44 +0800
Subject: [PATCH v2 2/4] i2c: sunxi: Add Reduced Serial Bus (RSB) DT bindings
 documentation
In-Reply-To: <1425284686-5116-1-git-send-email-wens@csie.org>
References: <1425284686-5116-1-git-send-email-wens@csie.org>
Message-ID: <1425284686-5116-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reduced Serial Bus (RSB) is an SMBus like bus used to communicate
with some PMICs (like the AXP223) or other peripherals.

The RSB DT bindings are pretty much the same as the one defined for
the marvell's mv64xxx controller, with the additional RSB specific
"allwinner,rsb-hw-addr" property for slave device nodes.

There are 2 types of addresses for RSB devices, a hardware address
and a runtime (software) configurable address. The former is only
used when configuring the latter. All read/write accesses use the
runtime address.

It would seem straightforward to use the hardware address in the
DT bindings as the slave's address. However this will not work as
the hardware address is 12 bits wide, and at least 1 device, the
AC100 audio codec, has the highest bit set. This address would be
incompatible with I2C (7 or 10 bit addresses) and likely rejected.

Hence this binding uses statically allocated (by the author of the
DT) runtime addresses for the slave's "reg" property. The hardware
address is put in a separete named property. When writing a new DT,
the author must take care to not have multiple slave devices use
the same address. It is recommended to follow whatever conventions
the hardware vendor uses.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../devicetree/bindings/i2c/i2c-sunxi-rsb.txt      | 54 ++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-sunxi-rsb.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-sunxi-rsb.txt b/Documentation/devicetree/bindings/i2c/i2c-sunxi-rsb.txt
new file mode 100644
index 000000000000..9b1f2dd2e17a
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-sunxi-rsb.txt
@@ -0,0 +1,54 @@
+
+* Allwinner RSB (Reduced Serial Bus) controller
+
+Required properties :
+
+ - reg             : Offset and length of the register set for the device.
+ - compatible      : Should be "allwinner,sun8i-a23-rsb".
+ - interrupts      : The interrupt line connected to the RSB peripheral.
+ - clocks          : The gate clk connected to the RSB peripheral.
+ - resets          : The reset line connected to the RSB peripheral.
+ - #address-cells  : always 1 (for RSB runtime addresses)
+ - #size-cells     : always 0
+
+Optional properties :
+
+ - clock-frequency : Desired RSB bus clock frequency in Hz. If not set
+		     the default frequency is 100kHz. Maximum is 20MHz.
+
+An RSB device node may contain up to 15 child nodes each encoding an RSB
+slave device.
+
+Slave device properties:
+  Required properties:
+   - reg           : The runtime address used to access the device.
+   - allwinner,rsb-hw-addr : The RSB hardware address for the device. This
+			     is only used when configuring the runtime
+			     address of the device.
+
+  Valid runtime addresses - There are only 15 valid runtime addresses:
+
+      0x17, 0x2d, 0x3a, 0x4e, 0x59, 0x63, 0x74, 0x8b,
+      0x9c, 0xa6, 0xb1, 0xc5, 0xd2, 0xe8, 0xff
+
+
+Example:
+
+	rsb at 01f03400 {
+		compatible = "allwinner,sun8i-a23-rsb";
+		reg = <0x01f03400 0x400>;
+		interrupts = <0 39 4>;
+		clocks = <&apb0_gates 3>;
+		clock-frequency = <3000000>;
+		resets = <&apb0_rst 3>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		axp223: pmic at 2d {
+			compatible = "x-powers,axp223", "x-powers,axp221";
+			reg = <0x2d>;
+			allwinner,rsb-hw-addr = <0x3e3>;
+
+			/* ... */
+		};
+	};
-- 
2.1.4
