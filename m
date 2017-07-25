From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 25 Jul 2017 14:53:05 +0100
Subject: [PATCH 3/6] kvm: arm64: Convert kvm_set_s2pte_readonly() from inline
 asm to cmpxchg()
In-Reply-To: <20170725135308.18173-1-catalin.marinas@arm.com>
References: <20170725135308.18173-1-catalin.marinas@arm.com>
Message-ID: <20170725135308.18173-4-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To take advantage of the LSE atomic instructions and also make the code
cleaner, convert the kvm_set_s2pte_readonly() function to use the more
generic cmpxchg().

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index a89cc22abadc..40b3ea690826 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -175,18 +175,14 @@ static inline pmd_t kvm_s2pmd_mkwrite(pmd_t pmd)
 
 static inline void kvm_set_s2pte_readonly(pte_t *pte)
 {
-	pteval_t pteval;
-	unsigned long tmp;
-
-	asm volatile("//	kvm_set_s2pte_readonly\n"
-	"	prfm	pstl1strm, %2\n"
-	"1:	ldxr	%0, %2\n"
-	"	and	%0, %0, %3		// clear PTE_S2_RDWR\n"
-	"	orr	%0, %0, %4		// set PTE_S2_RDONLY\n"
-	"	stxr	%w1, %0, %2\n"
-	"	cbnz	%w1, 1b\n"
-	: "=&r" (pteval), "=&r" (tmp), "+Q" (pte_val(*pte))
-	: "L" (~PTE_S2_RDWR), "L" (PTE_S2_RDONLY));
+	pteval_t old_pteval, pteval;
+
+	do {
+		pteval = old_pteval = READ_ONCE(pte_val(*pte));
+		pteval &= ~PTE_S2_RDWR;
+		pteval |= PTE_S2_RDONLY;
+	} while (cmpxchg_relaxed(&pte_val(*pte), old_pteval, pteval) !=
+		 old_pteval);
 }
 
 static inline bool kvm_s2pte_readonly(pte_t *pte)
