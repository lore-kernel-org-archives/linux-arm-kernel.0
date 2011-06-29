From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jun 2011 10:19:33 +0100
Subject: [PATCH 02/23] ARM: entry: shark: don't directly reference registers
	in macros
In-Reply-To: <20110629091853.GK21898@n2100.arm.linux.org.uk>
References: <20110629091853.GK21898@n2100.arm.linux.org.uk>
Message-ID: <E1Qbqvl-0002Eo-WC@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Directly referencing registers in macros makes assembly code harder
to change, because the macros have side effects which are non-obvious.
Use the provided 'base' register rather than directly referencing r4.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-shark/include/mach/entry-macro.S |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shark/include/mach/entry-macro.S b/arch/arm/mach-shark/include/mach/entry-macro.S
index e2853c0..0bb6cc6 100644
--- a/arch/arm/mach-shark/include/mach/entry-macro.S
+++ b/arch/arm/mach-shark/include/mach/entry-macro.S
@@ -11,17 +11,17 @@
 		.endm
 
 		.macro  get_irqnr_preamble, base, tmp
+		mov	\base, #0xe0000000
 		.endm
 
 		.macro  arch_ret_to_user, tmp1, tmp2
 		.endm
 
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-		mov	r4, #0xe0000000
 
 		mov	\irqstat, #0x0C
-		strb	\irqstat, [r4, #0x20]		@outb(0x0C, 0x20) /* Poll command */
-		ldrb	\irqnr, [r4, #0x20]		@irq = inb(0x20) & 7
+		strb	\irqstat, [\base, #0x20]	@outb(0x0C, 0x20) /* Poll command */
+		ldrb	\irqnr, [\base, #0x20]		@irq = inb(0x20) & 7
 		and	\irqstat, \irqnr, #0x80
 		teq	\irqstat, #0
 		beq	43f
@@ -29,8 +29,8 @@
 		teq	\irqnr, #2
 		bne	44f
 43:		mov	\irqstat, #0x0C
-		strb	\irqstat, [r4, #0xa0]		@outb(0x0C, 0xA0) /* Poll command */
-		ldrb	\irqnr, [r4, #0xa0]		@irq = (inb(0xA0) & 7) + 8
+		strb	\irqstat, [\base, #0xa0]	@outb(0x0C, 0xA0) /* Poll command */
+		ldrb	\irqnr, [\base, #0xa0]		@irq = (inb(0xA0) & 7) + 8
 		and	\irqstat, \irqnr, #0x80
 		teq	\irqstat, #0
 		beq	44f
-- 
1.7.4.4
