From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 13:06:12 +0100
Subject: [PATCH 5/6] ARM: sa1100/hackkit: remove empty serial mctrl functions
In-Reply-To: <20160829120531.GG1041@n2100.armlinux.org.uk>
References: <20160829120531.GG1041@n2100.armlinux.org.uk>
Message-ID: <E1beLKO-0001Tv-Dh@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the empty serial modem control signal functions from hackkit
as these are unnecessary - the core code can copes fine without
these.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/hackkit.c | 48 ------------------------------------------
 1 file changed, 48 deletions(-)

diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
index 643d5f2d9af9..9faf602666cf 100644
--- a/arch/arm/mach-sa1100/hackkit.c
+++ b/arch/arm/mach-sa1100/hackkit.c
@@ -49,8 +49,6 @@
 /* init funcs */
 static void __init hackkit_map_io(void);
 
-static u_int hackkit_get_mctrl(struct uart_port *port);
-static void hackkit_set_mctrl(struct uart_port *port, u_int mctrl);
 static void hackkit_uart_pm(struct uart_port *port, u_int state, u_int oldstate);
 
 /**********************************************************************
@@ -71,8 +69,6 @@ static struct map_desc hackkit_io_desc[] __initdata = {
 };
 
 static struct sa1100_port_fns hackkit_port_fns __initdata = {
-	.set_mctrl	= hackkit_set_mctrl,
-	.get_mctrl	= hackkit_get_mctrl,
 	.pm		= hackkit_uart_pm,
 };
 
@@ -105,50 +101,6 @@ static void hackkit_uart_pm(struct uart_port *port, u_int state, u_int oldstate)
 	/* TODO: switch on/off uart in powersave mode */
 }
 
-/*
- * Note! this can be called from IRQ context.
- * FIXME: No modem ctrl lines yet.
- */
-static void hackkit_set_mctrl(struct uart_port *port, u_int mctrl)
-{
-#if 0
-	if (port->mapbase == _Ser1UTCR0) {
-		u_int set = 0, clear = 0;
-
-		if (mctrl & TIOCM_RTS)
-			set |= PT_CTRL2_RS1_RTS;
-		else
-			clear |= PT_CTRL2_RS1_RTS;
-
-		if (mctrl & TIOCM_DTR)
-			set |= PT_CTRL2_RS1_DTR;
-		else
-			clear |= PT_CTRL2_RS1_DTR;
-
-		PTCTRL2_clear(clear);
-		PTCTRL2_set(set);
-	}
-#endif
-}
-
-static u_int hackkit_get_mctrl(struct uart_port *port)
-{
-	u_int ret = 0;
-#if 0
-	u_int irqsr = PT_IRQSR;
-
-	/* need 2 reads to read current value */
-	irqsr = PT_IRQSR;
-
-	/* TODO: check IRQ source register for modem/com
-	 status lines and set them correctly. */
-#endif
-
-	ret = TIOCM_CD | TIOCM_CTS | TIOCM_DSR;
-
-	return ret;
-}
-
 static struct mtd_partition hackkit_partitions[] = {
 	{
 		.name		= "BLOB",
-- 
2.1.0
