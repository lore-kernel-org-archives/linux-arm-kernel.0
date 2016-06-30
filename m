From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 30 Jun 2016 18:40:37 +0100
Subject: [PATCH v2 04/18] arm64: KVM: Kill HYP_PAGE_OFFSET
In-Reply-To: <1467308451-13365-1-git-send-email-marc.zyngier@arm.com>
References: <1467308451-13365-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1467308451-13365-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HYP_PAGE_OFFSET is not massively useful. And the way we use it
in KERN_HYP_VA is inconsistent with the equivalent operation in
EL2, where we use a mask instead.

Let's replace the uses of HYP_PAGE_OFFSET with HYP_PAGE_OFFSET_MASK,
and get rid of the pointless macro.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 6149dfc..2f1e1ae 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -70,7 +70,6 @@
  */
 #define HYP_PAGE_OFFSET_SHIFT	VA_BITS
 #define HYP_PAGE_OFFSET_MASK	((UL(1) << HYP_PAGE_OFFSET_SHIFT) - 1)
-#define HYP_PAGE_OFFSET		(PAGE_OFFSET & HYP_PAGE_OFFSET_MASK)
 
 /*
  * Our virtual mapping for the idmap-ed MMU-enable code. Must be
@@ -104,7 +103,7 @@ alternative_endif
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
 
-#define KERN_TO_HYP(kva)	((unsigned long)kva - PAGE_OFFSET + HYP_PAGE_OFFSET)
+#define KERN_TO_HYP(kva)	((unsigned long)kva & HYP_PAGE_OFFSET_MASK)
 
 /*
  * We currently only support a 40bit IPA.
-- 
2.1.4
