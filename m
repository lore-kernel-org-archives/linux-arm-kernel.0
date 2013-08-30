From: b32955@freescale.com (Huang Shijie)
Date: Fri, 30 Aug 2013 10:07:25 +0800
Subject: [PATCH v3 4/8] mtd: m25p80: add the DDR quad-read support
In-Reply-To: <1377828449-18912-1-git-send-email-b32955@freescale.com>
References: <1377828449-18912-1-git-send-email-b32955@freescale.com>
Message-ID: <1377828449-18912-5-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the DDR quad read support by:

(1) Add the relative commands:
      OPCODE_DDRQIOR, OPCODE_4DDRQIOR

(2) add the "m25p,ddr-quad-read" property for the m25p80 driver
    If the dts has the "m25p,ddr-quad-read" property, the kernel will
    set the Quad bit of the configuration register, and when the
    setting suceedes, we will set the read opcode with the right
    spi nor command.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 Documentation/devicetree/bindings/mtd/m25p80.txt |    5 +++++
 drivers/mtd/devices/m25p80.c                     |   21 ++++++++++++++++-----
 include/linux/mtd/spi-nor.h                      |    2 ++
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/m25p80.txt b/Documentation/devicetree/bindings/mtd/m25p80.txt
index b33313f..a01c6b7 100644
--- a/Documentation/devicetree/bindings/mtd/m25p80.txt
+++ b/Documentation/devicetree/bindings/mtd/m25p80.txt
@@ -22,6 +22,11 @@ Optional properties:
                    all chips and support for it can not be detected at runtime.
                    Refer to your chips' datasheet to check if this is supported
                    by your chip.
+- m25p,ddr-quad-read : Use the "ddr quad read" opcode to read data from the chip
+                   instead of the usual "read" opcode. This opcode is not
+                   supported by all chips and support for it can not be detected
+                   at runtime. Refer to your chips' datasheet to check if this
+                   is supported by your chip.
 Example:
 
 	flash: m25p80 at 0 {
diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 0645c9f..32ccdc7 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -913,7 +913,8 @@ static void m25p80_check_quad_read(struct m25p *flash, struct device_node *np)
 	int ret;
 	int sr_cr;
 
-	if (of_property_read_bool(np, "m25p,quad-read")) {
+	if (of_property_read_bool(np, "m25p,quad-read")
+		|| of_property_read_bool(np, "m25p,ddr-quad-read")) {
 		/* The configuration register is set by the second byte. */
 		sr_cr = CR_QUAD << 8;
 
@@ -927,10 +928,20 @@ static void m25p80_check_quad_read(struct m25p *flash, struct device_node *np)
 		if (!(ret > 0 && (ret & CR_QUAD)))
 			return;
 
-		if (flash->mtd.size <= SZ_16M)
-			flash->read_opcode = OPCODE_QIOR;
-		else
-			flash->read_opcode = OPCODE_4QIOR;
+		if (of_property_read_bool(np, "m25p,quad-read")) {
+			if (flash->mtd.size <= SZ_16M)
+				flash->read_opcode = OPCODE_QIOR;
+			else
+				flash->read_opcode = OPCODE_4QIOR;
+			return;
+		}
+
+		if (of_property_read_bool(np, "m25p,ddr-quad-read")) {
+			if (flash->mtd.size <= SZ_16M)
+				flash->read_opcode = OPCODE_DDRQIOR;
+			else
+				flash->read_opcode = OPCODE_4DDRQIOR;
+		}
 	}
 }
 
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index e6c3309..a985336 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -42,6 +42,8 @@
 #define	OPCODE_BRWR		0x17	/* Bank register write */
 #define	OPCODE_QIOR		0xeb	/* Quad read */
 #define	OPCODE_4QIOR		0xec	/* Quad read (4-byte)*/
+#define	OPCODE_DDRQIOR		0xed	/* DDR Quad read */
+#define	OPCODE_4DDRQIOR		0xee	/* DDR Quad read (4-byte)*/
 #define	OPCODE_RDCR		0x35	/* Read configuration register */
 
 /* Status Register bits. */
-- 
1.7.1
