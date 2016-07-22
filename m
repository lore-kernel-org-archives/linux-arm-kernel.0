From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 22 Jul 2016 18:28:21 +0100
Subject: [PATCH 04/55] arm/arm64: KVM: Map the HYP text as read-only
In-Reply-To: <1469208552-4155-1-git-send-email-marc.zyngier@arm.com>
References: <1469208552-4155-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1469208552-4155-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There should be no reason for mapping the HYP text read/write.

As such, let's have a new set of flags (PAGE_HYP_EXEC) that allows
execution, but makes the page as read-only, and update the two call
sites that deal with mapping code.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/include/asm/pgtable.h        | 1 +
 arch/arm/kvm/arm.c                    | 2 +-
 arch/arm/kvm/mmu.c                    | 6 +++---
 arch/arm64/include/asm/pgtable-prot.h | 1 +
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index f332087..7487bf9 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -98,6 +98,7 @@ extern pgprot_t		pgprot_s2_device;
 #define PAGE_KERNEL		_MOD_PROT(pgprot_kernel, L_PTE_XN)
 #define PAGE_KERNEL_EXEC	pgprot_kernel
 #define PAGE_HYP		_MOD_PROT(pgprot_kernel, L_PTE_HYP)
+#define PAGE_HYP_EXEC		_MOD_PROT(pgprot_kernel, L_PTE_HYP | L_PTE_RDONLY)
 #define PAGE_HYP_RO		_MOD_PROT(pgprot_kernel, L_PTE_HYP | L_PTE_RDONLY | L_PTE_XN)
 #define PAGE_HYP_DEVICE		_MOD_PROT(pgprot_hyp_device, L_PTE_HYP)
 #define PAGE_S2			_MOD_PROT(pgprot_s2, L_PTE_S2_RDONLY)
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index b308976..c74483f 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -1293,7 +1293,7 @@ static int init_hyp_mode(void)
 	 * Map the Hyp-code called directly from the host
 	 */
 	err = create_hyp_mappings(kvm_ksym_ref(__hyp_text_start),
-				  kvm_ksym_ref(__hyp_text_end), PAGE_HYP);
+				  kvm_ksym_ref(__hyp_text_end), PAGE_HYP_EXEC);
 	if (err) {
 		kvm_err("Cannot map world-switch code\n");
 		goto out_err;
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 49cb5cc..679608f 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -1733,7 +1733,7 @@ int kvm_mmu_init(void)
 	err = 	__create_hyp_mappings(boot_hyp_pgd,
 				      hyp_idmap_start, hyp_idmap_end,
 				      __phys_to_pfn(hyp_idmap_start),
-				      PAGE_HYP);
+				      PAGE_HYP_EXEC);
 
 	if (err) {
 		kvm_err("Failed to idmap %lx-%lx\n",
@@ -1756,7 +1756,7 @@ int kvm_mmu_init(void)
 	err = 	__create_hyp_mappings(boot_hyp_pgd,
 				      TRAMPOLINE_VA, TRAMPOLINE_VA + PAGE_SIZE,
 				      __phys_to_pfn(hyp_idmap_start),
-				      PAGE_HYP);
+				      PAGE_HYP_EXEC);
 	if (err) {
 		kvm_err("Failed to map trampoline @%lx into boot HYP pgd\n",
 			TRAMPOLINE_VA);
@@ -1767,7 +1767,7 @@ int kvm_mmu_init(void)
 	err = 	__create_hyp_mappings(hyp_pgd,
 				      TRAMPOLINE_VA, TRAMPOLINE_VA + PAGE_SIZE,
 				      __phys_to_pfn(hyp_idmap_start),
-				      PAGE_HYP);
+				      PAGE_HYP_EXEC);
 	if (err) {
 		kvm_err("Failed to map trampoline @%lx into runtime HYP pgd\n",
 			TRAMPOLINE_VA);
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 88db58c..3802048 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -56,6 +56,7 @@
 #define PAGE_KERNEL_EXEC_CONT	__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_CONT)
 
 #define PAGE_HYP		__pgprot(_PAGE_DEFAULT | PTE_HYP)
+#define PAGE_HYP_EXEC		__pgprot(_PAGE_DEFAULT | PTE_HYP | PTE_RDONLY)
 #define PAGE_HYP_RO		__pgprot(_PAGE_DEFAULT | PTE_HYP | PTE_RDONLY | PTE_HYP_XN)
 #define PAGE_HYP_DEVICE		__pgprot(PROT_DEVICE_nGnRE | PTE_HYP)
 
-- 
2.8.1
