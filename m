From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 29 Oct 2013 16:28:39 +0100
Subject: [PATCH] [RFC] ARM: debug: only wait for an idle uart after all chars
 are sent
Message-ID: <1383060519-14868-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of waiting after every single character that the fifo and
shifter become empty only wait after the whole string. Without this
optimization the fifo isn't used at all for more than a single
character. The added benefit is that debug output speed is improved.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

I didn't do any benchmarks with this patch but noticed this optimization
when I copied the printch/printascii code for the bootloader on efm32.

Obviously it depends on waituart to reliably signal if there is space
available in the fifo while without this patch debug output works fine
if only busyuart is functional. So this breaks at least
arch/arm/include/debug/imx.S and arch/arm/include/debug/8250.S .

Looking at the 8250 code I wonder if I got the semantics of waituart
right. I thought it's about waiting until there is space available in
the fifo but arch/arm/include/debug/8250.S suggests it's about hand
shaking? (In that case my patch would be wrong.)

Best regards
Uwe
---
 arch/arm/kernel/debug.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/debug.S b/arch/arm/kernel/debug.S
index e18cb30..17156ee 100644
--- a/arch/arm/kernel/debug.S
+++ b/arch/arm/kernel/debug.S
@@ -83,7 +83,6 @@ ENTRY(printascii)
 		b	2f
 1:		waituart r2, r3
 		senduart r1, r3
-		busyuart r2, r3
 		teq	r1, #'\n'
 		moveq	r1, #'\r'
 		beq	1b
@@ -91,6 +90,7 @@ ENTRY(printascii)
 		ldrneb	r1, [r0], #1
 		teqne	r1, #0
 		bne	1b
+		busyuart r2, r3
 		mov	pc, lr
 ENDPROC(printascii)
 
-- 
1.8.4.rc3
