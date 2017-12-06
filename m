From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  6 Dec 2017 14:38:39 +0000
Subject: [PATCH 18/18] KVM: arm/arm64: Move HYP IO VAs to the "idmap" range
In-Reply-To: <20171206143839.29223-1-marc.zyngier@arm.com>
References: <20171206143839.29223-1-marc.zyngier@arm.com>
Message-ID: <20171206143839.29223-19-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We so far mapped our HYP IO (which is essencially the GICv2 control
registers) using the same method as for memory. It recently appeared
that is a bit unsafe:

we compute the HYP VA using the kern_hyp_va helper, but that helper
is only designed to deal with kernel VAs coming from the linear map,
and not from the vmalloc region... This could in turn cause some bad
aliasing between the two, amplified by the new VA randomisation.

A solution is to come up with our very own basic VA allocator for
MMIO. Since half of the HYP address space only contains a single
page (the idmap), we have plenty to borrow from. Let's use the idmap
as a base, and allocate downwards from it. GICv2 now lives on the
other side of the great VA barrier.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/mmu.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 9f73a8a17147..d843548abd3d 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -43,6 +43,9 @@ static unsigned long hyp_idmap_start;
 static unsigned long hyp_idmap_end;
 static phys_addr_t hyp_idmap_vector;
 
+static DEFINE_MUTEX(io_map_lock);
+static unsigned long io_map_base;
+
 #define S2_PGD_SIZE	(PTRS_PER_S2_PGD * sizeof(pgd_t))
 #define hyp_pgd_order get_order(PTRS_PER_PGD * sizeof(pgd_t))
 
@@ -723,7 +726,8 @@ int create_hyp_io_mappings(phys_addr_t phys_addr, size_t size,
 			   void __iomem **kaddr,
 			   void __iomem **haddr)
 {
-	unsigned long start, end;
+	pgd_t *pgd = hyp_pgd;
+	unsigned long base;
 	int ret;
 
 	*kaddr = ioremap(phys_addr, size);
@@ -735,19 +739,26 @@ int create_hyp_io_mappings(phys_addr_t phys_addr, size_t size,
 		return 0;
 	}
 
+	mutex_lock(&io_map_lock);
+
+	base = io_map_base - size;
+	base &= ~(size - 1);
+
+	if (__kvm_cpu_uses_extended_idmap())
+		pgd = boot_hyp_pgd;
 
-	start = kern_hyp_va((unsigned long)*kaddr);
-	end = kern_hyp_va((unsigned long)*kaddr + size);
-	ret = __create_hyp_mappings(hyp_pgd, start, end,
+	ret = __create_hyp_mappings(pgd, base, base + size,
 				     __phys_to_pfn(phys_addr), PAGE_HYP_DEVICE);
 
 	if (ret) {
 		iounmap(*kaddr);
 		*kaddr = NULL;
 	} else {
-		*haddr = (void __iomem *)start;
+		*haddr = (void __iomem *)base;
+		io_map_base = base;
 	}
 
+	mutex_unlock(&io_map_lock);
 	return ret;
 }
 
@@ -1828,6 +1839,7 @@ int kvm_mmu_init(void)
 			goto out;
 	}
 
+	io_map_base = hyp_idmap_start;
 	return 0;
 out:
 	free_hyp_pgds();
-- 
2.14.2
