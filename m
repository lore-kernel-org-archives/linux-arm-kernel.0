From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:58:57 +0000
Subject: [PATCH 13/20] ARM: sa1111: move PS/2 interface register definitions
 to sa1111p2.c
In-Reply-To: <20120203195419.GH14129@n2100.arm.linux.org.uk>
References: <20120203195419.GH14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtPHd-00044V-6t@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the PS/2 interface register definitions into the driver, rather
than keeping them in a common location.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/hardware/sa1111.h |   39 +-----------------------
 drivers/input/serio/sa1111ps2.c        |   52 ++++++++++++++++++++++----------
 2 files changed, 37 insertions(+), 54 deletions(-)

diff --git a/arch/arm/include/asm/hardware/sa1111.h b/arch/arm/include/asm/hardware/sa1111.h
index 5ba2e13..dc15bf8 100644
--- a/arch/arm/include/asm/hardware/sa1111.h
+++ b/arch/arm/include/asm/hardware/sa1111.h
@@ -409,48 +409,11 @@
 #define SA1111_WAKEPOL0		0x0034
 #define SA1111_WAKEPOL1		0x0038
 
-/*
- * PS/2 Trackpad and Mouse Interfaces
- *
- * Registers
- *    PS2CR		Control Register
- *    PS2STAT		Status Register
- *    PS2DATA		Transmit/Receive Data register
- *    PS2CLKDIV		Clock Division Register
- *    PS2PRECNT		Clock Precount Register
- *    PS2TEST1		Test register 1
- *    PS2TEST2		Test register 2
- *    PS2TEST3		Test register 3
- *    PS2TEST4		Test register 4
- */
-
+/* PS/2 Trackpad and Mouse Interfaces */
 #define SA1111_KBD		0x0a00
 #define SA1111_MSE		0x0c00
 
 /*
- * These are offsets from the above bases.
- */
-#define SA1111_PS2CR		0x0000
-#define SA1111_PS2STAT		0x0004
-#define SA1111_PS2DATA		0x0008
-#define SA1111_PS2CLKDIV	0x000c
-#define SA1111_PS2PRECNT	0x0010
-
-#define PS2CR_ENA		0x08
-#define PS2CR_FKD		0x02
-#define PS2CR_FKC		0x01
-
-#define PS2STAT_STP		0x0100
-#define PS2STAT_TXE		0x0080
-#define PS2STAT_TXB		0x0040
-#define PS2STAT_RXF		0x0020
-#define PS2STAT_RXB		0x0010
-#define PS2STAT_ENA		0x0008
-#define PS2STAT_RXP		0x0004
-#define PS2STAT_KBD		0x0002
-#define PS2STAT_KBC		0x0001
-
-/*
  * PCMCIA Interface
  *
  * Registers
diff --git a/drivers/input/serio/sa1111ps2.c b/drivers/input/serio/sa1111ps2.c
index ad7d23b..5ebabe3 100644
--- a/drivers/input/serio/sa1111ps2.c
+++ b/drivers/input/serio/sa1111ps2.c
@@ -24,6 +24,26 @@
 
 #include <asm/hardware/sa1111.h>
 
+#define PS2CR		0x0000
+#define PS2STAT		0x0004
+#define PS2DATA		0x0008
+#define PS2CLKDIV	0x000c
+#define PS2PRECNT	0x0010
+
+#define PS2CR_ENA	0x08
+#define PS2CR_FKD	0x02
+#define PS2CR_FKC	0x01
+
+#define PS2STAT_STP	0x0100
+#define PS2STAT_TXE	0x0080
+#define PS2STAT_TXB	0x0040
+#define PS2STAT_RXF	0x0020
+#define PS2STAT_RXB	0x0010
+#define PS2STAT_ENA	0x0008
+#define PS2STAT_RXP	0x0004
+#define PS2STAT_KBD	0x0002
+#define PS2STAT_KBC	0x0001
+
 struct ps2if {
 	struct serio		*io;
 	struct sa1111_dev	*dev;
@@ -45,22 +65,22 @@ static irqreturn_t ps2_rxint(int irq, void *dev_id)
 	struct ps2if *ps2if = dev_id;
 	unsigned int scancode, flag, status;
 
-	status = sa1111_readl(ps2if->base + SA1111_PS2STAT);
+	status = sa1111_readl(ps2if->base + PS2STAT);
 	while (status & PS2STAT_RXF) {
 		if (status & PS2STAT_STP)
-			sa1111_writel(PS2STAT_STP, ps2if->base + SA1111_PS2STAT);
+			sa1111_writel(PS2STAT_STP, ps2if->base + PS2STAT);
 
 		flag = (status & PS2STAT_STP ? SERIO_FRAME : 0) |
 		       (status & PS2STAT_RXP ? 0 : SERIO_PARITY);
 
-		scancode = sa1111_readl(ps2if->base + SA1111_PS2DATA) & 0xff;
+		scancode = sa1111_readl(ps2if->base + PS2DATA) & 0xff;
 
 		if (hweight8(scancode) & 1)
 			flag ^= SERIO_PARITY;
 
 		serio_interrupt(ps2if->io, scancode, flag);
 
-		status = sa1111_readl(ps2if->base + SA1111_PS2STAT);
+		status = sa1111_readl(ps2if->base + PS2STAT);
         }
 
         return IRQ_HANDLED;
@@ -75,12 +95,12 @@ static irqreturn_t ps2_txint(int irq, void *dev_id)
 	unsigned int status;
 
 	spin_lock(&ps2if->lock);
-	status = sa1111_readl(ps2if->base + SA1111_PS2STAT);
+	status = sa1111_readl(ps2if->base + PS2STAT);
 	if (ps2if->head == ps2if->tail) {
 		disable_irq_nosync(irq);
 		/* done */
 	} else if (status & PS2STAT_TXE) {
-		sa1111_writel(ps2if->buf[ps2if->tail], ps2if->base + SA1111_PS2DATA);
+		sa1111_writel(ps2if->buf[ps2if->tail], ps2if->base + PS2DATA);
 		ps2if->tail = (ps2if->tail + 1) & (sizeof(ps2if->buf) - 1);
 	}
 	spin_unlock(&ps2if->lock);
@@ -103,8 +123,8 @@ static int ps2_write(struct serio *io, unsigned char val)
 	/*
 	 * If the TX register is empty, we can go straight out.
 	 */
-	if (sa1111_readl(ps2if->base + SA1111_PS2STAT) & PS2STAT_TXE) {
-		sa1111_writel(val, ps2if->base + SA1111_PS2DATA);
+	if (sa1111_readl(ps2if->base + PS2STAT) & PS2STAT_TXE) {
+		sa1111_writel(val, ps2if->base + PS2DATA);
 	} else {
 		if (ps2if->head == ps2if->tail)
 			enable_irq(ps2if->dev->irq[1]);
@@ -151,7 +171,7 @@ static int ps2_open(struct serio *io)
 
 	enable_irq_wake(ps2if->dev->irq[0]);
 
-	sa1111_writel(PS2CR_ENA, ps2if->base + SA1111_PS2CR);
+	sa1111_writel(PS2CR_ENA, ps2if->base + PS2CR);
 	return 0;
 }
 
@@ -159,7 +179,7 @@ static void ps2_close(struct serio *io)
 {
 	struct ps2if *ps2if = io->port_data;
 
-	sa1111_writel(0, ps2if->base + SA1111_PS2CR);
+	sa1111_writel(0, ps2if->base + PS2CR);
 
 	disable_irq_wake(ps2if->dev->irq[0]);
 
@@ -179,7 +199,7 @@ static void __devinit ps2_clear_input(struct ps2if *ps2if)
 	int maxread = 100;
 
 	while (maxread--) {
-		if ((sa1111_readl(ps2if->base + SA1111_PS2DATA) & 0xff) == 0xff)
+		if ((sa1111_readl(ps2if->base + PS2DATA) & 0xff) == 0xff)
 			break;
 	}
 }
@@ -189,11 +209,11 @@ static unsigned int __devinit ps2_test_one(struct ps2if *ps2if,
 {
 	unsigned int val;
 
-	sa1111_writel(PS2CR_ENA | mask, ps2if->base + SA1111_PS2CR);
+	sa1111_writel(PS2CR_ENA | mask, ps2if->base + PS2CR);
 
 	udelay(2);
 
-	val = sa1111_readl(ps2if->base + SA1111_PS2STAT);
+	val = sa1111_readl(ps2if->base + PS2STAT);
 	return val & (PS2STAT_KBC | PS2STAT_KBD);
 }
 
@@ -224,7 +244,7 @@ static int __devinit ps2_test(struct ps2if *ps2if)
 		ret = -ENODEV;
 	}
 
-	sa1111_writel(0, ps2if->base + SA1111_PS2CR);
+	sa1111_writel(0, ps2if->base + PS2CR);
 
 	return ret;
 }
@@ -278,8 +298,8 @@ static int __devinit ps2_probe(struct sa1111_dev *dev)
 	sa1111_enable_device(ps2if->dev);
 
 	/* Incoming clock is 8MHz */
-	sa1111_writel(0, ps2if->base + SA1111_PS2CLKDIV);
-	sa1111_writel(127, ps2if->base + SA1111_PS2PRECNT);
+	sa1111_writel(0, ps2if->base + PS2CLKDIV);
+	sa1111_writel(127, ps2if->base + PS2PRECNT);
 
 	/*
 	 * Flush any pending input.
-- 
1.7.4.4
