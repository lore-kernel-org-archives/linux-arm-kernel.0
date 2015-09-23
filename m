From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 23 Sep 2015 15:24:08 +0100
Subject: [PATCH 2/4] arm: Move asm statements accessing TTBCR into dedicated
 functions
In-Reply-To: <1443018250-22893-1-git-send-email-catalin.marinas@arm.com>
References: <1443018250-22893-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1443018250-22893-3-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements cpu_get_ttbcr() and cpu_set_ttbcr() and replaces
the corresponding asm statements. These functions will be reused in
subsequent patches.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/proc-fns.h | 12 ++++++++++++
 arch/arm/mm/mmu.c               |  7 +++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/proc-fns.h
index 8877ad5ffe10..db695e612ab4 100644
--- a/arch/arm/include/asm/proc-fns.h
+++ b/arch/arm/include/asm/proc-fns.h
@@ -142,6 +142,18 @@ extern void cpu_resume(void);
 	})
 #endif
 
+static inline unsigned int cpu_get_ttbcr(void)
+{
+	unsigned int ttbcr;
+	asm("mrc p15, 0, %0, c2, c0, 2" : "=r" (ttbcr));
+	return ttbcr;
+}
+
+static inline void cpu_set_ttbcr(unsigned int ttbcr)
+{
+	asm volatile("mcr p15, 0, %0, c2, c0, 2" : : "r" (ttbcr));
+}
+
 #else	/*!CONFIG_MMU */
 
 #define cpu_switch_mm(pgd,mm)	{ }
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 7cd15143a507..f6c5744bb5ef 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1494,9 +1494,8 @@ void __init early_paging_init(const struct machine_desc *mdesc)
 	 */
 	cr = get_cr();
 	set_cr(cr & ~(CR_I | CR_C));
-	asm("mrc p15, 0, %0, c2, c0, 2" : "=r" (ttbcr));
-	asm volatile("mcr p15, 0, %0, c2, c0, 2"
-		: : "r" (ttbcr & ~(3 << 8 | 3 << 10)));
+	ttbcr = cpu_get_ttbcr();
+	cpu_set_ttbcr(ttbcr & ~(3 << 8 | 3 << 10));
 	flush_cache_all();
 
 	/*
@@ -1508,7 +1507,7 @@ void __init early_paging_init(const struct machine_desc *mdesc)
 	lpae_pgtables_remap(offset, pa_pgd, boot_data);
 
 	/* Re-enable the caches and cacheable TLB walks */
-	asm volatile("mcr p15, 0, %0, c2, c0, 2" : : "r" (ttbcr));
+	cpu_set_ttbcr(ttbcr);
 	set_cr(cr);
 }
 
