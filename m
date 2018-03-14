From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 14 Mar 2018 16:50:33 +0000
Subject: [PATCH v6 10/26] KVM: arm/arm64: Fix idmap size and alignment
In-Reply-To: <20180314165049.30105-1-marc.zyngier@arm.com>
References: <20180314165049.30105-1-marc.zyngier@arm.com>
Message-ID: <20180314165049.30105-11-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Although the idmap section of KVM can only be at most 4kB and
must be aligned on a 4kB boundary, the rest of the code expects
it to be page aligned. Things get messy when tearing down the
HYP page tables when PAGE_SIZE is 64K, and the idmap section isn't
64K aligned.

Let's fix this by computing aligned boundaries that the HYP code
will use.

Reported-by: James Morse <james.morse@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/mmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 0e5cfffb4c21..a9e0513868e9 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1815,7 +1815,9 @@ int kvm_mmu_init(void)
 	int err;
 
 	hyp_idmap_start = kvm_virt_to_phys(__hyp_idmap_text_start);
+	hyp_idmap_start = ALIGN_DOWN(hyp_idmap_start, PAGE_SIZE);
 	hyp_idmap_end = kvm_virt_to_phys(__hyp_idmap_text_end);
+	hyp_idmap_end = ALIGN(hyp_idmap_end, PAGE_SIZE);
 	hyp_idmap_vector = kvm_virt_to_phys(__kvm_hyp_init);
 
 	/*
-- 
2.14.2
