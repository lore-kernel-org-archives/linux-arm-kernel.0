From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 03 Nov 2015 14:51:24 +0000
Subject: [PATCH 06/11] tty: amba-pl011: add register offset table to vendor
 data
In-Reply-To: <20151103134349.GV8644@n2100.arm.linux.org.uk>
References: <20151103134349.GV8644@n2100.arm.linux.org.uk>
Message-ID: <E1Ztcvk-0007CV-8Z@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the register offset table to the vendor data, allowing vendor
differences to be described in this table.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/amba-pl011.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 6269eb9907bd..b912220bf13e 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -103,6 +103,7 @@ static u16 pl011_std_offsets[REG_ARRAY_SIZE] = {
 
 /* There is by now at least one vendor with differing details, so handle it */
 struct vendor_data {
+	const u16		*reg_offset;
 	unsigned int		ifls;
 	unsigned int		lcrh_tx;
 	unsigned int		lcrh_rx;
@@ -121,6 +122,7 @@ static unsigned int get_fifosize_arm(struct amba_device *dev)
 }
 
 static struct vendor_data vendor_arm = {
+	.reg_offset		= pl011_std_offsets,
 	.ifls			= UART011_IFLS_RX4_8|UART011_IFLS_TX4_8,
 	.lcrh_tx		= REG_LCRH,
 	.lcrh_rx		= REG_LCRH,
@@ -133,6 +135,7 @@ static struct vendor_data vendor_arm = {
 };
 
 static struct vendor_data vendor_sbsa = {
+	.reg_offset		= pl011_std_offsets,
 	.oversampling		= false,
 	.dma_threshold		= false,
 	.cts_event_workaround	= false,
@@ -146,6 +149,7 @@ static unsigned int get_fifosize_st(struct amba_device *dev)
 }
 
 static struct vendor_data vendor_st = {
+	.reg_offset		= pl011_std_offsets,
 	.ifls			= UART011_IFLS_RX_HALF|UART011_IFLS_TX_HALF,
 	.lcrh_tx		= REG_ST_LCRH_TX,
 	.lcrh_rx		= REG_ST_LCRH_RX,
@@ -2426,7 +2430,7 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 	if (IS_ERR(uap->clk))
 		return PTR_ERR(uap->clk);
 
-	uap->reg_offset = pl011_std_offsets;
+	uap->reg_offset = vendor->reg_offset;
 	uap->vendor = vendor;
 	uap->lcrh_rx = vendor->lcrh_rx;
 	uap->lcrh_tx = vendor->lcrh_tx;
@@ -2508,7 +2512,7 @@ static int sbsa_uart_probe(struct platform_device *pdev)
 	if (!uap)
 		return -ENOMEM;
 
-	uap->reg_offset	= pl011_std_offsets;
+	uap->reg_offset	= vendor_sbsa.reg_offset;
 	uap->vendor	= &vendor_sbsa;
 	uap->fifosize	= 32;
 	uap->port.irq	= platform_get_irq(pdev, 0);
-- 
2.1.0
