From: b32955@freescale.com (Huang Shijie)
Date: Mon, 26 Aug 2013 12:41:35 +0800
Subject: [PATCH v2 1/8] mtd: m25p80: move the spi-nor commands to a header
In-Reply-To: <1377492102-23543-1-git-send-email-b32955@freescale.com>
References: <1377492102-23543-1-git-send-email-b32955@freescale.com>
Message-ID: <1377492102-23543-2-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Why should move the spi-nor commands to a header?

The reason is caused by the Freescale's Quadspi controller.

(0) What is the Quadspi controller?

    The Quadspi(Quad Serial Peripheral Interface) acts as an interface to
    one single or two external serial flash devices, each with up to 4
    bidirectional data lines.

(1) The Quadspi controller is driven by the LUT(Look-up Table) registers.
    The LUT registers are a look-up-table for sequences of instructions.
    A valid sequence consists of four LUT registers.

(2) The definition of the LUT register shows below:

    ---------------------------------------------------
    | INSTR1 | PAD1 | OPRND1 | INSTR0 | PAD0 | OPRND0 |
    ---------------------------------------------------

    There are several types of INSTRx, such as:
    	CMD	: the SPI NOR command.
	ADDR	: the address for the SPI NOR command.
	DUMMY	: the dummy cycles needed by the SPI NOR command.
	....

(3) We should pre-populate the LUT table before the Quadspi controller
    starts to work. Take the SPI Write Enable command for example, we
    should set the LUT table like this:

         INSTR0 = CMD; PAD0 = 0; OPRND0 = 0x06 (SPI Write Enable command)

(4) Conclusion:
    We need to move the SPI NOR commands to a separate header which can be
    used the m25p80.c and the drivers, such Quadspi controller.
    (It seems the spear-smi.c driver also needs this header.)

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/devices/m25p80.c |   42 +--------------------------------
 include/linux/mtd/spi-nor.h  |   53 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 41 deletions(-)
 create mode 100644 include/linux/mtd/spi-nor.h

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 26b14f9..299cc69 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -30,52 +30,12 @@
 #include <linux/mtd/cfi.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/mtd/spi-nor.h>
 #include <linux/of_platform.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
 
-/* Flash opcodes. */
-#define	OPCODE_WREN		0x06	/* Write enable */
-#define	OPCODE_RDSR		0x05	/* Read status register */
-#define	OPCODE_WRSR		0x01	/* Write status register 1 byte */
-#define	OPCODE_NORM_READ	0x03	/* Read data bytes (low frequency) */
-#define	OPCODE_FAST_READ	0x0b	/* Read data bytes (high frequency) */
-#define	OPCODE_PP		0x02	/* Page program (up to 256 bytes) */
-#define	OPCODE_BE_4K		0x20	/* Erase 4KiB block */
-#define	OPCODE_BE_4K_PMC	0xd7	/* Erase 4KiB block on PMC chips */
-#define	OPCODE_BE_32K		0x52	/* Erase 32KiB block */
-#define	OPCODE_CHIP_ERASE	0xc7	/* Erase whole flash chip */
-#define	OPCODE_SE		0xd8	/* Sector erase (usually 64KiB) */
-#define	OPCODE_RDID		0x9f	/* Read JEDEC ID */
-
-/* 4-byte address opcodes - used on Spansion and some Macronix flashes. */
-#define	OPCODE_NORM_READ_4B	0x13	/* Read data bytes (low frequency) */
-#define	OPCODE_FAST_READ_4B	0x0c	/* Read data bytes (high frequency) */
-#define	OPCODE_PP_4B		0x12	/* Page program (up to 256 bytes) */
-#define	OPCODE_SE_4B		0xdc	/* Sector erase (usually 64KiB) */
-
-/* Used for SST flashes only. */
-#define	OPCODE_BP		0x02	/* Byte program */
-#define	OPCODE_WRDI		0x04	/* Write disable */
-#define	OPCODE_AAI_WP		0xad	/* Auto address increment word program */
-
-/* Used for Macronix and Winbond flashes. */
-#define	OPCODE_EN4B		0xb7	/* Enter 4-byte mode */
-#define	OPCODE_EX4B		0xe9	/* Exit 4-byte mode */
-
-/* Used for Spansion flashes only. */
-#define	OPCODE_BRWR		0x17	/* Bank register write */
-
-/* Status Register bits. */
-#define	SR_WIP			1	/* Write in progress */
-#define	SR_WEL			2	/* Write enable latch */
-/* meaning of other SR_* bits may differ between vendors */
-#define	SR_BP0			4	/* Block protect 0 */
-#define	SR_BP1			8	/* Block protect 1 */
-#define	SR_BP2			0x10	/* Block protect 2 */
-#define	SR_SRWD			0x80	/* SR write protect */
-
 /* Define max times to check status register before we give up. */
 #define	MAX_READY_WAIT_JIFFIES	(40 * HZ)	/* M25P16 specs 40s max chip erase */
 #define	MAX_CMD_SIZE		5
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
new file mode 100644
index 0000000..f2637b9
--- /dev/null
+++ b/include/linux/mtd/spi-nor.h
@@ -0,0 +1,53 @@
+/*
+ * This header contains the SPI-NOR commands and the relative macros
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#ifndef __LINUX_MTD_SPI_NOR_H
+#define __LINUX_MTD_SPI_NOR_H
+
+/* Flash opcodes. */
+#define	OPCODE_WREN		0x06	/* Write enable */
+#define	OPCODE_RDSR		0x05	/* Read status register */
+#define	OPCODE_WRSR		0x01	/* Write status register 1 byte */
+#define	OPCODE_NORM_READ	0x03	/* Read data bytes (low frequency) */
+#define	OPCODE_FAST_READ	0x0b	/* Read data bytes (high frequency) */
+#define	OPCODE_PP		0x02	/* Page program (up to 256 bytes) */
+#define	OPCODE_BE_4K		0x20	/* Erase 4KiB block */
+#define	OPCODE_BE_4K_PMC	0xd7	/* Erase 4KiB block on PMC chips */
+#define	OPCODE_BE_32K		0x52	/* Erase 32KiB block */
+#define	OPCODE_CHIP_ERASE	0xc7	/* Erase whole flash chip */
+#define	OPCODE_SE		0xd8	/* Sector erase (usually 64KiB) */
+#define	OPCODE_RDID		0x9f	/* Read JEDEC ID */
+
+/* 4-byte address opcodes - used on Spansion and some Macronix flashes. */
+#define	OPCODE_NORM_READ_4B	0x13	/* Read data bytes (low frequency) */
+#define	OPCODE_FAST_READ_4B	0x0c	/* Read data bytes (high frequency) */
+#define	OPCODE_PP_4B		0x12	/* Page program (up to 256 bytes) */
+#define	OPCODE_SE_4B		0xdc	/* Sector erase (usually 64KiB) */
+
+/* Used for SST flashes only. */
+#define	OPCODE_BP		0x02	/* Byte program */
+#define	OPCODE_WRDI		0x04	/* Write disable */
+#define	OPCODE_AAI_WP		0xad	/* Auto address increment word program */
+
+/* Used for Macronix and Winbond flashes. */
+#define	OPCODE_EN4B		0xb7	/* Enter 4-byte mode */
+#define	OPCODE_EX4B		0xe9	/* Exit 4-byte mode */
+
+/* Used for Spansion flashes only. */
+#define	OPCODE_BRWR		0x17	/* Bank register write */
+
+/* Status Register bits. */
+#define	SR_WIP			1	/* Write in progress */
+#define	SR_WEL			2	/* Write enable latch */
+/* meaning of other SR_* bits may differ between vendors */
+#define	SR_BP0			4	/* Block protect 0 */
+#define	SR_BP1			8	/* Block protect 1 */
+#define	SR_BP2			0x10	/* Block protect 2 */
+#define	SR_SRWD			0x80	/* SR write protect */
+
+#endif /* __LINUX_MTD_SPI_NOR_H */
-- 
1.7.1
