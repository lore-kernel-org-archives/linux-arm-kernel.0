From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 10:08:38 +0000
Subject: [PATCH 2/7] ARM: PL011: Ensure error flags are clear at startup
In-Reply-To: <20110103100753.GB26785@n2100.arm.linux.org.uk>
References: <20110103100753.GB26785@n2100.arm.linux.org.uk>
Message-ID: <E1PZhLC-0007pV-Fu@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The error flags weren't being cleared upon UART startup, which
can cause problems when we add DMA support.  It's good practice
to ensure that these flags are cleared anyway, so let's do so.

This was part of a larger patch from Linus Walleij.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/serial/amba-pl011.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/amba-pl011.c b/drivers/serial/amba-pl011.c
index 2c07939..c77b3eb 100644
--- a/drivers/serial/amba-pl011.c
+++ b/drivers/serial/amba-pl011.c
@@ -424,6 +424,10 @@ static int pl011_startup(struct uart_port *port)
 	cr = UART01x_CR_UARTEN | UART011_CR_RXE | UART011_CR_TXE;
 	writew(cr, uap->port.membase + UART011_CR);
 
+	/* Clear pending error interrupts */
+	writew(UART011_OEIS | UART011_BEIS | UART011_PEIS | UART011_FEIS,
+	       uap->port.membase + UART011_ICR);
+
 	/*
 	 * initialise the old status of the modem signals
 	 */
-- 
1.6.2.5
