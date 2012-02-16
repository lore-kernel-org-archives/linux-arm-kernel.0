From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 16 Feb 2012 21:18:08 +0100
Subject: [PATCH 3/5] ARM: force branch instructions to use long distance
 encoding
In-Reply-To: <1329423490-15580-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20120216200143.GS14173@pengutronix.de>
 <1329423490-15580-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1329423490-15580-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a linker error when the kernel image gets bigger than approx.
1 MiB.

This is done analogous to the change to head.S in commit

	a75e524 (ARM: 6504/1: Thumb-2: Fix long-distance conditional branches in head.S for Thumb-2.)

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
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
1.7.9
