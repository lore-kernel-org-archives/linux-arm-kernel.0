From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 18 Oct 2014 12:56:53 +0100
Subject: [PATCH 03/12] arm/arm64: KVM: use __GFP_ZERO not memset() to get
 zeroed pages
In-Reply-To: <1413633422-14907-1-git-send-email-marc.zyngier@arm.com>
References: <1413633422-14907-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1413633422-14907-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Pass __GFP_ZERO to __get_free_pages() instead of calling memset()
explicitly.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/mmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index eea0306..8f0c7a4 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -528,11 +528,10 @@ int kvm_alloc_stage2_pgd(struct kvm *kvm)
 		return -EINVAL;
 	}
 
-	pgd = (pgd_t *)__get_free_pages(GFP_KERNEL, S2_PGD_ORDER);
+	pgd = (pgd_t *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, S2_PGD_ORDER);
 	if (!pgd)
 		return -ENOMEM;
 
-	memset(pgd, 0, PTRS_PER_S2_PGD * sizeof(pgd_t));
 	kvm_clean_pgd(pgd);
 	kvm->arch.pgd = pgd;
 
-- 
2.1.1
