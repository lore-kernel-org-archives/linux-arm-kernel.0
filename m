From: aneesh.kumar@linux.vnet.ibm.com (Aneesh Kumar K.V)
Date: Sat, 14 Jun 2014 14:23:59 +0530
Subject: [PATCH v2 07/10] PPC, KVM,
 CMA: use general CMA reserved area management framework
In-Reply-To: <1402543307-29800-8-git-send-email-iamjoonsoo.kim@lge.com>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-8-git-send-email-iamjoonsoo.kim@lge.com>
Message-ID: <87mwdfg9co.fsf@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joonsoo Kim <iamjoonsoo.kim@lge.com> writes:

> Now, we have general CMA reserved area management framework,
> so use it for future maintainabilty. There is no functional change.
>
> Acked-by: Michal Nazarewicz <mina86@mina86.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Need this. We may want to keep the VM_BUG_ON by moving
KVM_CMA_CHUNK_ORDER around.

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 8056107..1932e0e 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -37,8 +37,6 @@
 #include <asm/ppc-opcode.h>
 #include <asm/cputable.h>
 
-#include "book3s_hv_cma.h"
-
 /* POWER7 has 10-bit LPIDs, PPC970 has 6-bit LPIDs */
 #define MAX_LPID_970   63
 
@@ -64,7 +62,6 @@ long kvmppc_alloc_hpt(struct kvm *kvm, u32 *htab_orderp)
        }
 
        kvm->arch.hpt_cma_alloc = 0;
-       VM_BUG_ON(order < KVM_CMA_CHUNK_ORDER);
        page = kvm_alloc_hpt(1 << (order - PAGE_SHIFT));
        if (page) {
                hpt = (unsigned long)pfn_to_kaddr(page_to_pfn(page));



-aneesh
