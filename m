From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 25 Mar 2015 11:27:46 +0000
Subject: [PATCH RESEND 1/7] ARM: debug: fix big endian operation for 8250 word
 mode
In-Reply-To: <1427282872-10563-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1427282872-10563-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1427282872-10563-2-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the 8250 debug code is used in word mode on an big endian
host then the writes need to be change into little endian for
the bus.

Note, we have to re-convert the value back as the debug code
will inspect the value after writing it to see if a newline
has been written.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/include/debug/8250.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/include/debug/8250.S b/arch/arm/include/debug/8250.S
index 7a2baf9..7f7446f 100644
--- a/arch/arm/include/debug/8250.S
+++ b/arch/arm/include/debug/8250.S
@@ -16,11 +16,14 @@
 
 #ifdef CONFIG_DEBUG_UART_8250_WORD
 		.macro	store, rd, rx:vararg
+	 ARM_BE8(rev \rd, \rd)
 		str	\rd, \rx
+	 ARM_BE8(rev \rd, \rd)
 		.endm
 
 		.macro	load, rd, rx:vararg
 		ldr	\rd, \rx
+	ARM_BE8(rev \rd, \rd)
 		.endm
 #else
 		.macro	store, rd, rx:vararg
-- 
2.1.4
