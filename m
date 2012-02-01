From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed,  1 Feb 2012 09:54:56 +0100
Subject: [PATCH] ARM: head-nommu.S: use long distance encoding for branch
 instruction
Message-ID: <1328086496-31184-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a linker error when the kernel image gets bigger than approx.
1 MiB.

This is done analogous to the change to head.S in commit

	a75e524 (ARM: 6504/1: Thumb-2: Fix long-distance conditional branches in head.S for Thumb-2.)

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

compared to a75e524 I didn't put the it instruction into THUMB(). I
think this is OK? If so I can follow up with a patch that removes these
THUMB()s from head.S, too.

And I wonder if it's correct that head-nommu.S doesn't check the machine
type.

I don't see a need to get this in before the next merge window.

Best regards
Uwe


 arch/arm/kernel/head-nommu.S |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index d46f259..1aca35d 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -51,6 +51,7 @@ ENTRY(stext)
 #endif
 	bl	__lookup_processor_type		@ r5=procinfo r9=cpuid
 	movs	r10, r5				@ invalid processor (r5=0)?
+	it	eq
 	beq	__error_p				@ yes, error 'p'
 
 	adr	lr, BSYM(__after_proc_init)	@ return (PIC) address
-- 
1.7.8.3
