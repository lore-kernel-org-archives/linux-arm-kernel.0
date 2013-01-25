From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jan 2013 15:28:30 +0000
Subject: [PATCH 4/5] ARM: w90x900: fix legacy assembly syntax
In-Reply-To: <1359127711-19070-1-git-send-email-arnd@arndb.de>
References: <1359127711-19070-1-git-send-email-arnd@arndb.de>
Message-ID: <1359127711-19070-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

New ARM binutils don't allow extraneous whitespace inside
of brackets, which causes this error on all mach-w90x900
defconfigs:

arch/arm/kernel/entry-armv.S: Assembler messages:
arch/arm/kernel/entry-armv.S:214: Error: ARM register expected -- `ldr r0,[ r6,#(0x10C)]'
arch/arm/kernel/entry-armv.S:214: Error: ARM register expected -- `ldr r0,[ r6,#(0x110)]'
arch/arm/kernel/entry-armv.S:430: Error: ARM register expected -- `ldr r0,[ r6,#(0x10C)]'
arch/arm/kernel/entry-armv.S:430: Error: ARM register expected -- `ldr r0,[ r6,#(0x110)]'

This removes the whitespace in order to build the kernel
again.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Wan ZongShun <mcuos.com@gmail.com>
---
 arch/arm/mach-w90x900/include/mach/entry-macro.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-w90x900/include/mach/entry-macro.S b/arch/arm/mach-w90x900/include/mach/entry-macro.S
index e286dac..0ff612a 100644
--- a/arch/arm/mach-w90x900/include/mach/entry-macro.S
+++ b/arch/arm/mach-w90x900/include/mach/entry-macro.S
@@ -19,8 +19,8 @@
 
 		mov	\base, #AIC_BA
 
-		ldr	\irqnr, [ \base, #AIC_IPER]
-		ldr	\irqnr, [ \base, #AIC_ISNR]
+		ldr	\irqnr, [\base, #AIC_IPER]
+		ldr	\irqnr, [\base, #AIC_ISNR]
 		cmp	\irqnr, #0
 
 	.endm
-- 
1.8.0
