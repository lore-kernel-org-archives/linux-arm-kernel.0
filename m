From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 10 Mar 2015 16:39:42 +0100
Subject: [PATCH v4 5/5] arm64: use PC-relative reference for
 secondary_holding_pen_release
In-Reply-To: <1426001982-20047-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1426001982-20047-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1426001982-20047-6-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the confusing virtual/physical address arithmetic with a simple
PC-relative reference.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index cd3b94cb597f..69f2029a883c 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -576,10 +576,6 @@ ENTRY(__boot_cpu_mode)
 	.popsection
 
 #ifdef CONFIG_SMP
-	.align	3
-1:	.quad	.
-	.quad	secondary_holding_pen_release
-
 	/*
 	 * This provides a "holding pen" for platforms to hold all secondary
 	 * cores are held until we're ready for them to initialise.
@@ -591,10 +587,7 @@ ENTRY(secondary_holding_pen)
 	mrs	x0, mpidr_el1
 	ldr     x1, =MPIDR_HWID_BITMASK
 	and	x0, x0, x1
-	adr	x1, 1b
-	ldp	x2, x3, [x1]
-	sub	x1, x1, x2
-	add	x3, x3, x1
+	adr_l	x3, secondary_holding_pen_release
 pen:	ldr	x4, [x3]
 	cmp	x4, x0
 	b.eq	secondary_startup
-- 
1.8.3.2
