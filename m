From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 03 Nov 2015 14:51:44 +0000
Subject: [PATCH 10/11] tty: amba-pl011: add support for 32-bit register access
In-Reply-To: <20151103134349.GV8644@n2100.arm.linux.org.uk>
References: <20151103134349.GV8644@n2100.arm.linux.org.uk>
Message-ID: <E1Ztcw4-0007Ct-PP@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for 32-bit register accesses to the AMBA PL011 UART.  This
is needed for ZTE UARTs, which require 32-bit accesses as opposed to
the more normal 16-bit accesses.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/amba-pl011.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 4cb282a377c0..8f5f82039346 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -93,6 +93,7 @@ static u16 pl011_std_offsets[REG_ARRAY_SIZE] = {
 struct vendor_data {
 	const u16		*reg_offset;
 	unsigned int		ifls;
+	bool			access_32b;
 	bool			oversampling;
 	bool			dma_threshold;
 	bool			cts_event_workaround;
@@ -214,6 +215,7 @@ struct uart_amba_port {
 	unsigned int		fifosize;	/* vendor-specific */
 	unsigned int		old_cr;		/* state during shutdown */
 	bool			autorts;
+	bool			access_32b;
 	unsigned int		fixed_baud;	/* vendor-set fixed baud rate */
 	char			type[12];
 #ifdef CONFIG_DMA_ENGINE
@@ -235,13 +237,20 @@ static unsigned int pl011_reg_to_offset(const struct uart_amba_port *uap,
 static unsigned int pl011_read(const struct uart_amba_port *uap,
 	unsigned int reg)
 {
-	return readw(uap->port.membase + pl011_reg_to_offset(uap, reg));
+	void __iomem *addr = uap->port.membase + pl011_reg_to_offset(uap, reg);
+
+	return uap->access_32b ? readl(addr) : readw(addr);
 }
 
 static void pl011_write(unsigned int val, const struct uart_amba_port *uap,
 	unsigned int reg)
 {
-	writew(val, uap->port.membase + pl011_reg_to_offset(uap, reg));
+	void __iomem *addr = uap->port.membase + pl011_reg_to_offset(uap, reg);
+
+	if (uap->access_32b)
+		writel(val, addr);
+	else
+		writew(val, addr);
 }
 
 /*
@@ -2438,6 +2447,7 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 		return PTR_ERR(uap->clk);
 
 	uap->reg_offset = vendor->reg_offset;
+	uap->access_32b = vendor->access_32b;
 	uap->vendor = vendor;
 	uap->fifosize = vendor->get_fifosize(dev);
 	uap->port.irq = dev->irq[0];
@@ -2518,6 +2528,7 @@ static int sbsa_uart_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	uap->reg_offset	= vendor_sbsa.reg_offset;
+	uap->access_32b = vendor_sbsa.access_32b;
 	uap->vendor	= &vendor_sbsa;
 	uap->fifosize	= 32;
 	uap->port.irq	= platform_get_irq(pdev, 0);
-- 
2.1.0
