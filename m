From: florian@openwrt.org (Florian Fainelli)
Date: Mon, 10 Dec 2012 22:21:19 +0100
Subject: [PATCH] ARM: ep93xx: properly wait for UART FIFO to be empty
Message-ID: <1836468.ZU3cPkV103@bender>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the busy-waiting loop around in the decompressor
putc() function on the UART FIFO register. Without a proper wait, the
output of the decompressor was corrupted like this:

Uncompressing Linx. done, booting th enl

To highlight the issue more evidently, looping 100 times instead of 1000
makes the issue appear much faster. This patch takes the approach of
using an active while loop until the FIFO is empty (not FULL).
This issue happened to me on Sim.One running at 200Mhz.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Ryan, this is based on your ep93xx-fixes branch, thanks!

 arch/arm/mach-ep93xx/include/mach/uncompress.h |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-ep93xx/include/mach/uncompress.h b/arch/arm/mach-ep93xx/include/mach/uncompress.h
index 16026c2..d64274f 100644
--- a/arch/arm/mach-ep93xx/include/mach/uncompress.h
+++ b/arch/arm/mach-ep93xx/include/mach/uncompress.h
@@ -47,13 +47,9 @@ static void __raw_writel(unsigned int value, unsigned int ptr)
 
 static inline void putc(int c)
 {
-	int i;
-
-	for (i = 0; i < 1000; i++) {
-		/* Transmit fifo not full?  */
-		if (!(__raw_readb(PHYS_UART_FLAG) & UART_FLAG_TXFF))
-			break;
-	}
+	/* Transmit fifo not full?  */
+	while (__raw_readb(PHYS_UART_FLAG) & UART_FLAG_TXFF)
+		;
 
 	__raw_writeb(c, PHYS_UART_DATA);
 }
-- 
1.7.10.4
