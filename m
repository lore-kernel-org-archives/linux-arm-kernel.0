From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 25 Jun 2010 22:55:19 +0900
Subject: [PATCH] serial: samsung.c: Add FRACVAL support for newer UART
Message-ID: <1277474119-6897-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Changhwan Youn <chaos.youn@samsung.com>

FRACVAL register provides the same function as UDIVSLOT register which is
the 1/16ths adjustment to the baud rate but the implementaiton is easier.
To support UDIVSLOT register, UDIVSLOT table search is necessary though
supporting FRACVAL only needs the index value of UDIVSLOT table.

This patch implements the FRACVAL supports for the newer Samsung SoC UARTs.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/serial/samsung.c |    7 +++++--
 drivers/serial/samsung.h |    1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/samsung.c b/drivers/serial/samsung.c
index a9d6c56..09805c7 100644
--- a/drivers/serial/samsung.c
+++ b/drivers/serial/samsung.c
@@ -530,7 +530,7 @@ static int s3c24xx_serial_calcbaud(struct baud_calc *calc,
 
 	calc->clksrc = clksrc;
 
-	if (ourport->info->has_divslot) {
+	if ((ourport->info->has_divslot) || (ourport->info->has_fracval)) {
 		unsigned long div = rate / baud;
 
 		/* The UDIVSLOT register on the newer UARTs allows us to
@@ -707,6 +707,9 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 
 		udivslot = udivslot_table[div & 15];
 		dbg("udivslot = %04x (div %d)\n", udivslot, div & 15);
+	} else if (ourport->info->has_fracval) {
+		udivslot = (ourport->baudclk_rate / baud) & 15;
+		dbg("fracval = %04x\n", udivslot);
 	}
 
 	switch (termios->c_cflag & CSIZE) {
@@ -755,7 +758,7 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 	wr_regl(port, S3C2410_UBRDIV, quot);
 	wr_regl(port, S3C2410_UMCON, umcon);
 
-	if (ourport->info->has_divslot)
+	if ((ourport->info->has_divslot) || (ourport->info->has_fracval))
 		wr_regl(port, S3C2443_DIVSLOT, udivslot);
 
 	dbg("uart: ulcon = 0x%08x, ucon = 0x%08x, ufcon = 0x%08x\n",
diff --git a/drivers/serial/samsung.h b/drivers/serial/samsung.h
index 0ac06a0..124f476 100644
--- a/drivers/serial/samsung.h
+++ b/drivers/serial/samsung.h
@@ -24,6 +24,7 @@ struct s3c24xx_uart_info {
 	/* uart port features */
 
 	unsigned int		has_divslot:1;
+	unsigned int		has_fracval:1;
 
 	/* clock source control */
 
-- 
1.6.2.5
