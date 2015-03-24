From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 24 Mar 2015 17:10:29 +0100
Subject: [PATCH 2/3] ARM: exynos: move resume code to .text section
In-Reply-To: <1427213430-28463-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1427213430-28463-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1427213430-28463-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This code calls cpu_resume() using a straight branch (b), so
now that we have moved cpu_resume() back to .text, this should
be moved there as well. Note that all the .data references in
the code are already open coded PC relative references.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/mach-exynos/sleep.S | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/mach-exynos/sleep.S b/arch/arm/mach-exynos/sleep.S
index d3583773785e..98fba486fbe5 100644
--- a/arch/arm/mach-exynos/sleep.S
+++ b/arch/arm/mach-exynos/sleep.S
@@ -23,14 +23,7 @@
 #define CPU_MASK	0xff0ffff0
 #define CPU_CORTEX_A9	0x410fc090
 
-	/*
-	 * The following code is located into the .data section. This is to
-	 * allow l2x0_regs_phys to be accessed with a relative load while we
-	 * can't rely on any MMU translation. We could have put l2x0_regs_phys
-	 * in the .text section as well, but some setups might insist on it to
-	 * be truly read-only. (Reference from: arch/arm/kernel/sleep.S)
-	 */
-	.data
+	.text
 	.align
 
 	/*
-- 
1.8.3.2
