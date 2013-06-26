From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 26 Jun 2013 17:53:07 +0900
Subject: [PATCH 4/4] serial: sh-sci: Initialise variables before access in
 sci_set_termios()
In-Reply-To: <1372236787-23342-1-git-send-email-horms+renesas@verge.net.au>
References: <1372236787-23342-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1372236787-23342-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change addresses two warnings that are flagged by gcc relating to
potential access to the ssr and cks variables while they are uninitialised.

I have addressed this by initialising the values to
the defaults present in sci_baud_calc_hscif().

It is my analysis that cks is always initialised if used
but that without this change ssr may be accessed while uninitialised.

The code altered by this patch was introduced by commit
f303b364b41d3fc5bf879799128958400b7859aa ("serial: sh-sci: HSCIF support").

Reported-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/tty/serial/sh-sci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 931d6c3..7477e0e 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1887,9 +1887,9 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 {
 	struct sci_port *s = to_sci_port(port);
 	struct plat_sci_reg *reg;
-	unsigned int baud, smr_val, max_baud, cks;
+	unsigned int baud, smr_val, max_baud, cks = 0;
 	int t = -1;
-	unsigned int srr;
+	unsigned int srr = 15;
 
 	/*
 	 * earlyprintk comes here early on with port->uartclk set to zero.
-- 
1.8.2.1
