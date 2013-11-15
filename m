From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 15 Nov 2013 15:40:08 +0000
Subject: [PATCH] arm/arm64: KVM: introduce new mapping API for percpu mappings
Message-ID: <1384530008-18181-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using virt_to_phys on percpu mappings is horribly wrong (my own bad).
Thankfully, the kernel offers a way to obtain the physical address
of such a mapping.

Add a new create_hyp_percpu_mappings function to deal with those.

Reported-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
Santosh, can you please give this new patch a spin on your HW?

Thanks,

	M.

 arch/arm/include/asm/kvm_mmu.h   |  1 +
 arch/arm/kvm/arm.c               |  2 +-
 arch/arm/kvm/mmu.c               | 32 ++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/kvm_mmu.h |  1 +
 4 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 9b28c41..6dcb9ff 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -43,6 +43,7 @@
 #include <asm/pgalloc.h>
 
 int create_hyp_mappings(void *from, void *to);
+int create_hyp_percpu_mappings(void *from, void *to);
 int create_hyp_io_mappings(void *from, void *to, phys_addr_t);
 void free_boot_hyp_pgd(void);
 void free_hyp_pgds(void);
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 9c697db..6191960 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -911,7 +911,7 @@ static int init_hyp_mode(void)
 		kvm_cpu_context_t *cpu_ctxt;
 
 		cpu_ctxt = per_cpu_ptr(kvm_host_cpu_state, cpu);
-		err = create_hyp_mappings(cpu_ctxt, cpu_ctxt + 1);
+		err = create_hyp_percpu_mappings(cpu_ctxt, cpu_ctxt + 1);
 
 		if (err) {
 			kvm_err("Cannot map host CPU state: %d\n", err);
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index b0de86b..f2a552b 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -331,6 +331,38 @@ int create_hyp_mappings(void *from, void *to)
 }
 
 /**
+ * create_hyp_percpu_mappings - duplicate a percpu kernel virtual address
+ *				range in Hyp mode
+ * @from:	The virtual kernel start address of the range
+ * @to:		The virtual kernel end address of the range (exclusive)
+ *
+ * The same virtual address as the kernel virtual address is also used
+ * in Hyp-mode mapping (modulo HYP_PAGE_OFFSET) to the same underlying
+ * physical pages. It *has* to be a percpu region.
+ */
+int create_hyp_percpu_mappings(void *from, void *to)
+{
+	unsigned long phys_addr;
+	unsigned long virt_addr;
+	unsigned long start = KERN_TO_HYP((unsigned long)from);
+	unsigned long end = KERN_TO_HYP((unsigned long)to);
+
+	for (virt_addr = start; virt_addr < end; virt_addr += PAGE_SIZE) {
+		int err;
+
+		phys_addr = per_cpu_ptr_to_phys(from + virt_addr - start);
+		err = __create_hyp_mappings(hyp_pgd, virt_addr,
+					    virt_addr + PAGE_SIZE,
+					    __phys_to_pfn(phys_addr),
+					    PAGE_HYP);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+/**
  * create_hyp_io_mappings - duplicate a kernel IO mapping into Hyp mode
  * @from:	The kernel start VA of the range
  * @to:		The kernel end VA of the range (exclusive)
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index efe609c..a97a92d 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -71,6 +71,7 @@
 #define S2_PGD_ORDER	get_order(PTRS_PER_S2_PGD * sizeof(pgd_t))
 
 int create_hyp_mappings(void *from, void *to);
+int create_hyp_percpu_mappings(void *from, void *to);
 int create_hyp_io_mappings(void *from, void *to, phys_addr_t);
 void free_boot_hyp_pgd(void);
 void free_hyp_pgds(void);
-- 
1.8.2.3
