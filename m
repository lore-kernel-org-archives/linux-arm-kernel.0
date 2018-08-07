From: tali.perry1@gmail.com (Tali Perry)
Date: Tue,  7 Aug 2018 13:38:13 +0300
Subject: [PATCH v2 1/2] dt-binding: i2c: npcm7xx: add binding for i2c
 controller
In-Reply-To: <20180807103814.29586-1-tali.perry1@gmail.com>
References: <20180807103814.29586-1-tali.perry1@gmail.com>
Message-ID: <20180807103814.29586-2-tali.perry1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nuvoton NPCM7XX I2C Controller
NPCM7xx includes 16 I2C contollers. THis driver operates the controller.
This module also includes a slave mode, which will be submitted later on.

Any feedback would be appreciated.  

v2 -> v1:
	- run check patch in strict mode.
	- use linux crc.
	- define regs in constant offset without base.
	- remove debug prints.
	- no declerations for local functions.
	
v1: initial version

Signed-off-by: Tali Perry <tali.perry1@gmail.com>

---
 .../devicetree/bindings/i2c/i2c-npcm7xx.txt        | 27 ++++++++++++++++++++++
 MAINTAINERS                                        |  8 +++++++
 2 files changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt b/Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt
new file mode 100644
index 000000000000..e2ee45d7a41e
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt
@@ -0,0 +1,27 @@
+Nuvoton NPCM7XX I2C bus
+
+The NPCM750x includes sixteen I2C busses
+
+Required properties:
+- compatible      : must be "nuvoton,npcm750-i2c-bus"
+- reg             : Offset and length of the register set for the device.
+- interrupts      : Contain the I2C interrupt with flags for falling edge.
+- clocks          : phandle of I2C reference clock.
+
+Optional:
+- bus-frequency   : Contain the I2C bus frequency,
+			the default I2C bus frequency is 100000.
+- pinctrl-0       : must be <&smbX_pins>, X is module number
+			(on NPCM7XX it's 0 to 15)
+- pinctrl-names   : should be set to "default"
+Example:
+
+	i2c0: i2c-bus at 80000 {
+		compatible = "nuvoton,npcm750-i2c-bus";
+		reg = <0x80000 0x1000>;
+		clocks = <&clk NPCM7XX_CLK_APB2>;
+		bus-frequency = <100000>;
+		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&smb0_pins>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 192d7f73fd01..13bac916d21d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1244,6 +1244,14 @@ F:	drivers/i2c/busses/i2c-aspeed.c
 F:	Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-i2c-ic.txt
 F:	Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
 
+ARM/NUVOTON I2C DRIVER
+M:	Tali Perry <tali.perry1@gmail.com>
+L:	linux-i2c at vger.kernel.org
+L:	openbmc at lists.ozlabs.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/i2c/busses/i2c-npcm7xx.c
+F:	Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt
+
 ARM/ASPEED MACHINE SUPPORT
 M:	Joel Stanley <joel@jms.id.au>
 R:	Andrew Jeffery <andrew@aj.id.au>
-- 
2.14.1
