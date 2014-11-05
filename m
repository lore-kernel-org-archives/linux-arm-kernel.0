From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  5 Nov 2014 16:59:49 +0000
Subject: [PATCH v4 07/11] mtd: nand: stm_nand_bch: provide Device Tree
 documentation
In-Reply-To: <1415206793-25670-1-git-send-email-lee.jones@linaro.org>
References: <1415206793-25670-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1415206793-25670-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is where we describe the different new and generic options used by
the ST BCH driver.

Cc: devicetree at vger.kernel.org
Reviewed-by: Pekon Gupta <pekon@pek-sem.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/mtd/stm-nand.txt | 74 ++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/stm-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/stm-nand.txt b/Documentation/devicetree/bindings/mtd/stm-nand.txt
new file mode 100644
index 0000000..9b87cde
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/stm-nand.txt
@@ -0,0 +1,74 @@
+STM BCH NAND Support
+--------------------
+
+Required properties:
+
+- compatible		: Should be "st,nand-bch"
+- reg			: Should contain register's location and length
+- reg-names		: "emi_nand" - NAND Controller register map
+			  "emiss" - External Memory Interface Subsystem base
+- interrupts		: Interrupt number
+- interrupt-names	: "nand_irq" - NAND Controller IRQ
+
+Optional properties:
+
+- nand-ecc-strength	: Generic NAND property (See mtd/nand.txt)
+			  Options are; 0, 18 or 30. If not present, the driver
+			  will choose the strongest scheme compatible if the
+			  OOB size.
+
+Required sub-node:
+
+- bank			: Subnode representing one of NAND Flash, connected
+			  to an STM NAND Controller (see description below).
+			  There should be one of these per connect bank.
+
+Optional sub-node properies:
+
+- nand-chip-select	: Generic NAND property (See mtd/nand.txt)
+- st,nand-timing-relax	: Number of IP clock cycles by which to "relax" timing
+			  configuration.  Required on some boards to accommodate
+			  board-level limitations. Applies to ONFI timing mode
+			  configuration.
+- nand-on-flash-bbt	: Generic NAND property (See mtd/nand.txt)
+
+Note, during initialisation, the NAND Controller timing registers are configured
+according to one of the following methods, in order of precedence:
+
+	   1. Configuration based on ONFI timing mode, as advertised by the
+	      device during ONFI-probing (ONFI-compliant NAND only).
+
+	   2. Use reset/safe timing values
+
+Example:
+
+	nand at fe901000 {
+		compatible = "st,nand-bch";
+		reg = <0xfe901000 0x1000>, <0xfef00800 0x0800>;
+		reg-names = "emi_nand", "emiss";
+		interrupts = <0 139 0x0>;
+		interrupt-names = "nand_irq";
+		nand-ecc-strength = <30>;
+
+		status = "okay";
+
+		bank {
+			nand-on-flash-bbt;
+			st,nand-csn		= <0>;
+
+			partitions {
+				#address-cells	= <1>;
+				#size-cells	= <1>;
+
+				partition at 0{
+					label = "NANDFlash1";
+					reg = <0x00000000 0x00800000>;
+				};
+
+				partition at 800000{
+					label = "NANDFlash2";
+					reg = <0x00800000 0x0f800000>;
+				};
+			};
+		};
+	};
-- 
1.9.1
