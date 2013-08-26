From: b32955@freescale.com (Huang Shijie)
Date: Mon, 26 Aug 2013 12:41:37 +0800
Subject: [PATCH v2 3/8] mtd: m25p80: add the quad-read support
In-Reply-To: <1377492102-23543-1-git-send-email-b32955@freescale.com>
References: <1377492102-23543-1-git-send-email-b32955@freescale.com>
Message-ID: <1377492102-23543-4-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the quad read support:

(1) Add the relative commands:
      OPCODE_QIOR, OPCODE_4QIOR, OPCODE_RDCR,

    also add the relative macro for the Configuartion Register.

(2) add the "m25p,quad-read" property for the m25p80 driver
    If the dts has the "m25p,quad-read" property, the kernel will
    set the Quad bit of the configuration register, and when the
    setting suceedes, we will set the read opcode with the right
    spi nor command.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 Documentation/devicetree/bindings/mtd/m25p80.txt |    5 ++
 drivers/mtd/devices/m25p80.c                     |   62 ++++++++++++++++++++++
 include/linux/mtd/spi-nor.h                      |    6 ++
 3 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/m25p80.txt b/Documentation/devicetree/bindings/mtd/m25p80.txt
index 6d3d576..b33313f 100644
--- a/Documentation/devicetree/bindings/mtd/m25p80.txt
+++ b/Documentation/devicetree/bindings/mtd/m25p80.txt
@@ -17,6 +17,11 @@ Optional properties:
                    Refer to your chips' datasheet to check if this is supported
                    by your chip.
 
+- m25p,quad-read : Use the "quad read" opcode to read data from the chip instead
+                   of the usual "read" opcode. This opcode is not supported by
+                   all chips and support for it can not be detected at runtime.
+                   Refer to your chips' datasheet to check if this is supported
+                   by your chip.
 Example:
 
 	flash: m25p80 at 0 {
diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index cae419e..0645c9f 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -103,6 +103,40 @@ static int write_sr(struct m25p *flash, u8 val)
 }
 
 /*
+ * Read the configuration register, returning its value in the location
+ * Return the configuration register value.
+ * Returns negative if error occurred.
+ */
+static int read_cr(struct m25p *flash)
+{
+	u8 code = OPCODE_RDCR;
+	int ret;
+	u8 val;
+
+	ret = spi_write_then_read(flash->spi, &code, 1, &val, 1);
+	if (ret < 0) {
+		dev_err(&flash->spi->dev, "error %d reading CR\n", ret);
+		return ret;
+	}
+	return val;
+}
+
+/*
+ * Write status register and configuration register with 2 bytes
+ * The first byte will be written to the status register, while the second byte
+ * will be written to the configuration register.
+ * Returns negative if error occurred.
+ */
+static int write_sr_cr(struct m25p *flash, u16 val)
+{
+	flash->command[0] = OPCODE_WRSR;
+	flash->command[1] = val & 0xff;
+	flash->command[2] = (val >> 8);
+
+	return spi_write(flash->spi, flash->command, 3);
+}
+
+/*
  * Set write enable latch with Write Enable command.
  * Returns negative if error occurred.
  */
@@ -874,6 +908,31 @@ static const struct spi_device_id *jedec_probe(struct spi_device *spi)
 	return ERR_PTR(-ENODEV);
 }
 
+static void m25p80_check_quad_read(struct m25p *flash, struct device_node *np)
+{
+	int ret;
+	int sr_cr;
+
+	if (of_property_read_bool(np, "m25p,quad-read")) {
+		/* The configuration register is set by the second byte. */
+		sr_cr = CR_QUAD << 8;
+
+		/* Write the QUAD bit to the Configuration Register. */
+		write_enable(flash);
+		if (write_sr_cr(flash, sr_cr))
+			return;
+
+		/* read back and check it */
+		ret = read_cr(flash);
+		if (!(ret > 0 && (ret & CR_QUAD)))
+			return;
+
+		if (flash->mtd.size <= SZ_16M)
+			flash->read_opcode = OPCODE_QIOR;
+		else
+			flash->read_opcode = OPCODE_4QIOR;
+	}
+}
 
 /*
  * board specific setup should have ensured the SPI clock used here
@@ -1048,6 +1107,9 @@ static int m25p_probe(struct spi_device *spi)
 		flash->addr_width = 3;
 	}
 
+	/* Try to enable the Quad Read */
+	m25p80_check_quad_read(flash, np);
+
 	dev_info(&spi->dev, "%s (%lld Kbytes)\n", id->name,
 			(long long)flash->mtd.size >> 10);
 
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index f2637b9..e6c3309 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -40,6 +40,9 @@
 
 /* Used for Spansion flashes only. */
 #define	OPCODE_BRWR		0x17	/* Bank register write */
+#define	OPCODE_QIOR		0xeb	/* Quad read */
+#define	OPCODE_4QIOR		0xec	/* Quad read (4-byte)*/
+#define	OPCODE_RDCR		0x35	/* Read configuration register */
 
 /* Status Register bits. */
 #define	SR_WIP			1	/* Write in progress */
@@ -50,4 +53,7 @@
 #define	SR_BP2			0x10	/* Block protect 2 */
 #define	SR_SRWD			0x80	/* SR write protect */
 
+/* Configuration Register bits. */
+#define	CR_QUAD			0x2	/* Quad I/O */
+
 #endif /* __LINUX_MTD_SPI_NOR_H */
-- 
1.7.1
