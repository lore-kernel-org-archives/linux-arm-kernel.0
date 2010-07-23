From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 23 Jul 2010 08:52:02 +0200
Subject: [PATCH] ARM: ns9xxx: fix FTBFS for zImage
In-Reply-To: <20100722111412.GB10399@kyllikki.org>
References: <20100722111412.GB10399@kyllikki.org>
Message-ID: <1279867922-10626-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the different putc variants used an initialized local static variable
which is broken since

	5de813b (ARM: Eliminate decompressor -Dstatic= PIC hack)

This needs to be initialized at runtime and so needs to be global.
While at it give it a better name.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
KernelVersion: v2.6.35-rc6

 arch/arm/mach-ns9xxx/include/mach/uncompress.h |   30 ++++++++++++------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-ns9xxx/include/mach/uncompress.h b/arch/arm/mach-ns9xxx/include/mach/uncompress.h
index 1b12d32..770a68c 100644
--- a/arch/arm/mach-ns9xxx/include/mach/uncompress.h
+++ b/arch/arm/mach-ns9xxx/include/mach/uncompress.h
@@ -20,50 +20,49 @@ static void putc_dummy(char c, void __iomem *base)
 	/* nothing */
 }
 
+static int timeout;
+
 static void putc_ns9360(char c, void __iomem *base)
 {
-	static int t = 0x10000;
 	do {
-		if (t)
-			--t;
+		if (timeout)
+			--timeout;
 
 		if (__raw_readl(base + 8) & (1 << 3)) {
 			__raw_writeb(c, base + 16);
-			t = 0x10000;
+			timeout = 0x10000;
 			break;
 		}
-	} while (t);
+	} while (timeout);
 }
 
 static void putc_a9m9750dev(char c, void __iomem *base)
 {
-	static int t = 0x10000;
 	do {
-		if (t)
-			--t;
+		if (timeout)
+			--timeout;
 
 		if (__raw_readb(base + 5) & (1 << 5)) {
 			__raw_writeb(c, base);
-			t = 0x10000;
+			timeout = 0x10000;
 			break;
 		}
-	} while (t);
+	} while (timeout);
 
 }
 
 static void putc_ns921x(char c, void __iomem *base)
 {
-	static int t = 0x10000;
 	do {
-		if (t)
-			--t;
+		if (timeout)
+			--timeout;
 
 		if (!(__raw_readl(base) & (1 << 11))) {
 			__raw_writeb(c, base + 0x0028);
-			t = 0x10000;
+			timeout = 0x10000;
 			break;
 		}
-	} while (t);
+	} while (timeout);
 }
 
 #define MSCS __REG(0xA0900184)
@@ -89,6 +88,7 @@ static void putc_ns921x(char c, void __iomem *base)
 
 static void autodetect(void (**putc)(char, void __iomem *), void __iomem **base)
 {
+	timeout = 0x10000;
 	if (((__raw_readl(MSCS) >> 16) & 0xfe) == 0x00) {
 		/* ns9360 or ns9750 */
 		if (NS9360_UART_ENABLED(NS9360_UARTA)) {
-- 
1.7.1
