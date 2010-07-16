From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 16 Jul 2010 17:46:02 +0900
Subject: [PATCH v2] ARM: SAMSUNG: serial: Add FRACVAL support for newer UART
Message-ID: <1279269962-15109-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jongpill Lee <boyko.lee@samsung.com>

Add support for the FRACVAL register on the newer UART blocks which provides
the same function as UDIVSLOT register but the FRACVAL is easier to implement.
To support UDIVSLOT register, UDIVSLOT table search is necessary though
supporting FRACVAL only needs the index value of UDIVSLOT table.

Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
Acked-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
Changes since v1:
- Movded 'has_fracval' from s3c24xx_uart_info to s3c2410_uartcfg to support
  FRACVAL through platform_data. This can help to reduce register duplicated
  similar serial driver.

 arch/arm/plat-samsung/include/plat/regs-serial.h |    2 ++
 drivers/serial/samsung.c                         |    9 +++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/regs-serial.h b/arch/arm/plat-samsung/include/plat/regs-serial.h
index a6eba84..788837e 100644
--- a/arch/arm/plat-samsung/include/plat/regs-serial.h
+++ b/arch/arm/plat-samsung/include/plat/regs-serial.h
@@ -259,6 +259,8 @@ struct s3c2410_uartcfg {
 	unsigned short	   flags;
 	upf_t		   uart_flags;	 /* default uart flags */
 
+	unsigned int	   has_fracval;
+
 	unsigned long	   ucon;	 /* value of ucon for port */
 	unsigned long	   ulcon;	 /* value of ulcon for port */
 	unsigned long	   ufcon;	 /* value of ufcon for port */
diff --git a/drivers/serial/samsung.c b/drivers/serial/samsung.c
index a9d6c56..b1156ba 100644
--- a/drivers/serial/samsung.c
+++ b/drivers/serial/samsung.c
@@ -705,8 +705,13 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 	if (ourport->info->has_divslot) {
 		unsigned int div = ourport->baudclk_rate / baud;
 
-		udivslot = udivslot_table[div & 15];
-		dbg("udivslot = %04x (div %d)\n", udivslot, div & 15);
+		if (cfg->has_fracval) {
+			udivslot = (div & 15);
+			dbg("fracval = %04x\n", udivslot);
+		} else {
+			udivslot = udivslot_table[div & 15];
+			dbg("udivslot = %04x (div %d)\n", udivslot, div & 15);
+		}
 	}
 
 	switch (termios->c_cflag & CSIZE) {
-- 
1.6.2.5
