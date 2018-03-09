From: alex.shi@linaro.org (Alex Shi)
Date: Fri,  9 Mar 2018 17:06:55 +0800
Subject: [PATCH 12/39] arm64: Move post_ttbr_update_workaround to C code
In-Reply-To: <20180309090722.26279-1-alex.shi@linaro.org>
References: <20180309090722.26279-1-alex.shi@linaro.org>
Message-ID: <20180309090722.26279-13-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

commit 95e3de3590e3 upstream.

We will soon need to invoke a CPU-specific function pointer after changing
page tables, so move post_ttbr_update_workaround out into C code to make
this possible.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/mm/context.c | 10 ++++++++++
 arch/arm64/mm/proc.S    | 14 +++-----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index e87f53ff5f58..b901cb964a08 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -25,6 +25,7 @@
 #include <asm/cpufeature.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
+#include <asm/alternative.h>
 
 static u32 asid_bits;
 static DEFINE_RAW_SPINLOCK(cpu_asid_lock);
@@ -185,6 +186,15 @@ switch_mm_fastpath:
 	cpu_switch_mm(mm->pgd, mm);
 }
 
+/* Errata workaround post TTBRx_EL1 update. */
+asmlinkage void post_ttbr_update_workaround(void)
+{
+	asm(ALTERNATIVE("nop; nop; nop",
+			"ic iallu; dsb nsh; isb",
+			ARM64_WORKAROUND_CAVIUM_27456,
+			CONFIG_CAVIUM_ERRATUM_27456));
+}
+
 static int asids_init(void)
 {
 	int fld = cpuid_feature_extract_field(read_cpuid(ID_AA64MMFR0_EL1), 4);
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 18201e9e8cc7..dc678aed63ec 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -139,19 +139,11 @@ ENTRY(cpu_do_switch_mm)
 	bfi	x0, x1, #48, #16		// set the ASID
 	msr	ttbr0_el1, x0			// set TTBR0
 	isb
-alternative_if_not ARM64_WORKAROUND_CAVIUM_27456
-	ret
-	nop
-	nop
-	nop
-alternative_else
-	ic	iallu
-	dsb	nsh
-	isb
-	ret
-alternative_endif
+	b	post_ttbr_update_workaround	// Back to C code...
 ENDPROC(cpu_do_switch_mm)
 
+	.pushsection ".idmap.text", "ax"
+
 	.section ".text.init", #alloc, #execinstr
 
 /*
-- 
2.16.2.440.gc6284da
