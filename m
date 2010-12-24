From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Dec 2010 10:24:30 +0000
Subject: [PATCH 1/6] ARM: PL011: Ensure error flags are clear at startup
In-Reply-To: <20101224102359.GC20587@n2100.arm.linux.org.uk>
References: <20101224102359.GC20587@n2100.arm.linux.org.uk>
Message-ID: <E1PW4p4-0006GA-2e@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The error flags weren't being cleared upon UART startup, which
can cause problems when we add DMA support.  It's good practice
to ensure that these flags are cleared anyway, so let's do so.

This was part of a larger patch from Linus Walleij.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/serial/amba-pl011.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/amba-pl011.c b/drivers/serial/amba-pl011.c
index 6ca7a44..6066b18 100644
--- a/drivers/serial/amba-pl011.c
+++ b/drivers/serial/amba-pl011.c
@@ -423,6 +423,10 @@ static int pl011_startup(struct uart_port *port)
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
