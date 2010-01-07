From: tony@atomide.com (Tony Lindgren)
Date: Wed, 06 Jan 2010 16:19:57 -0800
Subject: [PATCH 07/12] omap2/3: make serial_in_override() address the right
	uart port
In-Reply-To: <20100107001728.21352.38471.stgit@baageli.muru.com>
References: <20100107001728.21352.38471.stgit@baageli.muru.com>
Message-ID: <20100107001957.21352.16506.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexander Shishkin <virtuoso@slind.org>

Commit f62349ee9788b1d94c55eb6c291d74a1f69bdd9e makes it possible to
have some other than first uart port as ttyS0, which breaks the workaround
serial_in_override() function which will try to address the first uart
port (for ttyS0) and not the one that was initialized.

Signed-off-by: Alexander Shishkin <virtuoso@slind.org>
CC: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/serial.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 19805a7..8c964be 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -125,6 +125,13 @@ static struct plat_serial8250_port serial_platform_data3[] = {
 	}
 };
 #endif
+static inline unsigned int __serial_read_reg(struct uart_port *up,
+					   int offset)
+{
+	offset <<= up->regshift;
+	return (unsigned int)__raw_readb(up->membase + offset);
+}
+
 static inline unsigned int serial_read_reg(struct plat_serial8250_port *up,
 					   int offset)
 {
@@ -583,11 +590,12 @@ static unsigned int serial_in_override(struct uart_port *up, int offset)
 {
 	if (UART_RX == offset) {
 		unsigned int lsr;
-		lsr = serial_read_reg(omap_uart[up->line].p, UART_LSR);
+		lsr = __serial_read_reg(up, UART_LSR);
 		if (!(lsr & UART_LSR_DR))
 			return -EPERM;
 	}
-	return serial_read_reg(omap_uart[up->line].p, offset);
+
+	return __serial_read_reg(up, offset);
 }
 
 void __init omap_serial_early_init(void)
