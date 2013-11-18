From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 18 Nov 2013 13:13:14 -0800
Subject: [PATCH] arm/arm64: KVM: Fix hyp mappings of vmalloc regions
In-Reply-To: <1384809194-9301-1-git-send-email-christoffer.dall@linaro.org>
References: <1384809194-9301-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1384809194-9301-2-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using virt_to_phys on percpu mappings is horribly wrong as it may be
backed by vmalloc.  Introduce kvm_kaddr_to_phys which translates both
types of valid kernel addresses to the corresponding physical address.

At the same time resolves a typing issue where we were storing the
physical address as a 32 bit unsigned long (on arm), truncating the
physical address for addresses above the 4GB limit.  This caused
breakage on Keystone.

Cc: Stable <stable@vger.kernel.org>        [3.10+]
Reported-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/mmu.c |   34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index b0de86b..cb79a5d 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -307,6 +307,17 @@ out:
 	return err;
 }
 
+static phys_addr_t kvm_kaddr_to_phys(void *kaddr)
+{
+	if (!is_vmalloc_addr(kaddr)) {
+		BUG_ON(!virt_addr_valid(kaddr));
+		return __pa(kaddr);
+	} else {
+		return page_to_phys(vmalloc_to_page(kaddr)) +
+		       offset_in_page(kaddr);
+	}
+}
+
 /**
  * create_hyp_mappings - duplicate a kernel virtual address range in Hyp mode
  * @from:	The virtual kernel start address of the range
@@ -318,16 +329,27 @@ out:
  */
 int create_hyp_mappings(void *from, void *to)
 {
-	unsigned long phys_addr = virt_to_phys(from);
+	phys_addr_t phys_addr;
+	unsigned long virt_addr;
 	unsigned long start = KERN_TO_HYP((unsigned long)from);
 	unsigned long end = KERN_TO_HYP((unsigned long)to);
 
-	/* Check for a valid kernel memory mapping */
-	if (!virt_addr_valid(from) || !virt_addr_valid(to - 1))
-		return -EINVAL;
+	start = start & PAGE_MASK;
+	end = PAGE_ALIGN(end);
 
-	return __create_hyp_mappings(hyp_pgd, start, end,
-				     __phys_to_pfn(phys_addr), PAGE_HYP);
+	for (virt_addr = start; virt_addr < end; virt_addr += PAGE_SIZE) {
+		int err;
+
+		phys_addr = kvm_kaddr_to_phys(from + virt_addr - start);
+		err = __create_hyp_mappings(hyp_pgd, virt_addr,
+					    virt_addr + PAGE_SIZE,
+					    __phys_to_pfn(phys_addr),
+					    PAGE_HYP);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
 
 /**
-- 
1.7.10.4
