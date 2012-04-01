From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 01 Apr 2012 11:39:27 -0400 (EDT)
Subject: [PATCH] serial: fix pl011 probe
Message-ID: <alpine.LFD.2.02.1204011120000.24151@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 9b96fbacda "serial: PL011: clear pending interrupts" (which is 
also marked with Cc: stable <stable@vger.kernel.org>) oopses the kernel
as it uses an unitialized uap->port.membase.

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 0c65c9e669..7ed11ceb4b 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1947,8 +1947,8 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 	}
 
 	/* Ensure interrupts from this UART are masked and cleared */
-	writew(0, uap->port.membase + UART011_IMSC);
-	writew(0xffff, uap->port.membase + UART011_ICR);
+	writew(0, base + UART011_IMSC);
+	writew(0xffff, base + UART011_ICR);
 
 	uap->vendor = vendor;
 	uap->lcrh_rx = vendor->lcrh_rx;
