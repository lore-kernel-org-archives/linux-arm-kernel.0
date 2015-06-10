From: achandran@mvista.com (Arun Chandran)
Date: Wed, 10 Jun 2015 19:43:04 +0530
Subject: [PATCH v1] ARM: zynq: Fix earlyprintk in big endian mode
Message-ID: <1433945584-16379-1-git-send-email-achandran@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

earlyprintk messages are not appearing on the terminal
emulator during a big endian kernel boot. If we
byte swap the sending data it comes properly.

Signed-off-by: Arun Chandran <achandran@mvista.com>
---
---
This can be tested by adding 'early_print("early print test\n");'
to setup_arch() in arch/arm/kernel/setup.c
---
 arch/arm/include/debug/zynq.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/debug/zynq.S b/arch/arm/include/debug/zynq.S
index bd13ded..0d274fe 100644
--- a/arch/arm/include/debug/zynq.S
+++ b/arch/arm/include/debug/zynq.S
@@ -38,6 +38,7 @@
 		.endm
 
 		.macro	senduart,rd,rx
+ARM_BE8(	rev	\rd, \rd )
 		str	\rd, [\rx, #UART_FIFO_OFFSET]	@ TXDATA
 		.endm
 
-- 
1.9.1
