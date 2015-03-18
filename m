From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 18 Mar 2015 15:53:04 +0000
Subject: [PATCH 05/13] ARM: at91: debug: fix debug in big endian mode
In-Reply-To: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1426693992-31163-6-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add appropriate endian swaps for when the CPU is in big endian

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: Andrew Victor <linux@maxim.org.za>
CC: Nicolas Ferre <nicolas.ferre@atmel.com>
CC: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
CC: Russell King <linux@arm.linux.org.uk>
CC: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
---
 arch/arm/include/debug/at91.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/debug/at91.S b/arch/arm/include/debug/at91.S
index c3c45e6..0217f8d 100644
--- a/arch/arm/include/debug/at91.S
+++ b/arch/arm/include/debug/at91.S
@@ -40,12 +40,14 @@
 
 	.macro	waituart,rd,rx
 1001:	ldr	\rd, [\rx, #(AT91_DBGU_SR)]		@ Read Status Register
+ARM_BE8(rev	\rd, \rd)
 	tst	\rd, #AT91_DBGU_TXRDY			@ DBGU_TXRDY = 1 when ready to transmit
 	beq	1001b
 	.endm
 
 	.macro	busyuart,rd,rx
 1001:	ldr	\rd, [\rx, #(AT91_DBGU_SR)]		@ Read Status Register
+ARM_BE8(rev	\rd, \rd)
 	tst	\rd, #AT91_DBGU_TXEMPTY			@ DBGU_TXEMPTY = 1 when transmission complete
 	beq	1001b
 	.endm
-- 
2.1.4
