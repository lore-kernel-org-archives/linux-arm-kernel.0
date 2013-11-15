From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 15 Nov 2013 08:10:04 -0800
Subject: [PATCH] arm/arm64: KVM: introduce new mapping API for percpu
 mappings
In-Reply-To: <1384530008-18181-1-git-send-email-marc.zyngier@arm.com>
References: <1384530008-18181-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20131115161004.GA25051@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 03:40:08PM +0000, Marc Zyngier wrote:
> Using virt_to_phys on percpu mappings is horribly wrong (my own bad).
> Thankfully, the kernel offers a way to obtain the physical address
> of such a mapping.
> 
> Add a new create_hyp_percpu_mappings function to deal with those.
> 
> Reported-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---


So, I find this nicer, somehow, what do you think:


diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 3719583..dd531ba 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -334,6 +334,15 @@ out:
 	return err;
 }
 
+static phys_addr_t kvm_kaddr_to_phys(void *kaddr)
+{
+	if (!is_vmalloc_addr(kaddr))
+		return __pa(kaddr);
+	else
+		return page_to_phys(vmalloc_to_page(kaddr)) +
+		       offset_in_page(kaddr);
+}
+
 /**
  * create_hyp_mappings - duplicate a kernel virtual address range in Hyp mode
  * @from:	The virtual kernel start address of the range
@@ -345,16 +354,24 @@ out:
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
+	for (virt_addr = start; virt_addr < end; virt_addr += PAGE_SIZE) {
+		int err;
 
-	return __create_hyp_mappings(hyp_pgd, start, end,
-				     __phys_to_pfn(phys_addr), PAGE_HYP);
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
