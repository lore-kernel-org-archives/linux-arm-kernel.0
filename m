From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  9 Dec 2015 12:44:44 +0000
Subject: [RFC PATCH 09/20] arm64: add function to install the idmap
In-Reply-To: <1449665095-20774-1-git-send-email-mark.rutland@arm.com>
References: <1449665095-20774-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1449665095-20774-10-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some cases (e.g. when making invasive changes to the kernel page
tables) we will need to execute code from the idmap.

Add a new helper which may be used to install the idmap, complementing
the existing cpu_uninstall_idmap.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Laura Abbott <labbott@fedoraproject.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/mmu_context.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index b1b2514..944f273 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -74,7 +74,7 @@ static inline bool __cpu_uses_extended_idmap(void)
 /*
  * Set TCR.T0SZ to its default value (based on VA_BITS)
  */
-static inline void cpu_set_default_tcr_t0sz(void)
+static inline void __cpu_set_tcr_t0sz(unsigned long t0sz)
 {
 	unsigned long tcr;
 
@@ -87,9 +87,12 @@ static inline void cpu_set_default_tcr_t0sz(void)
 	"	msr	tcr_el1, %0	;"
 	"	isb"
 	: "=&r" (tcr)
-	: "r"(TCR_T0SZ(VA_BITS)), "I"(TCR_T0SZ_OFFSET), "I"(TCR_TxSZ_WIDTH));
+	: "r"(t0sz), "I"(TCR_T0SZ_OFFSET), "I"(TCR_TxSZ_WIDTH));
 }
 
+#define cpu_set_default_tcr_t0sz()	__cpu_set_tcr_t0sz(TCR_T0SZ(VA_BITS))
+#define cpu_set_idmap_tcr_t0sz()	__cpu_set_tcr_t0sz(idmap_t0sz)
+
 /*
  * Remove the idmap from TTBR0_EL1 and install the pgd of the active mm.
  *
@@ -114,6 +117,15 @@ static inline void cpu_uninstall_idmap(void)
 		cpu_switch_mm(mm->pgd, mm);
 }
 
+static inline void cpu_install_idmap(void)
+{
+	cpu_set_reserved_ttbr0();
+	local_flush_tlb_all();
+	cpu_set_idmap_tcr_t0sz();
+
+	cpu_switch_mm(idmap_pg_dir, &init_mm);
+}
+
 /*
  * It would be nice to return ASIDs back to the allocator, but unfortunately
  * that introduces a race with a generation rollover where we could erroneously
-- 
1.9.1
