From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 16 Nov 2017 17:58:20 +0000
Subject: [PATCH 6/7] arm64: KVM: fix VTTBR_BADDR_MASK BUG_ON off-by-one
In-Reply-To: <20171116175821.26544-1-marc.zyngier@arm.com>
References: <20171116175821.26544-1-marc.zyngier@arm.com>
Message-ID: <20171116175821.26544-7-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kristina Martsenko <kristina.martsenko@arm.com>

VTTBR_BADDR_MASK is used to sanity check the size and alignment of the
VTTBR address. It seems to currently be off by one, thereby only
allowing up to 47-bit addresses (instead of 48-bit) and also
insufficiently checking the alignment. This patch fixes it.

As an example, with 4k pages, before this patch we have:

  PHYS_MASK_SHIFT = 48
  VTTBR_X = 37 - 24 = 13
  VTTBR_BADDR_SHIFT = 13 - 1 = 12
  VTTBR_BADDR_MASK = ((1 << 35) - 1) << 12 = 0x00007ffffffff000

Which is wrong, because the mask doesn't allow bit 47 of the VTTBR
address to be set, and only requires the address to be 12-bit (4k)
aligned, while it actually needs to be 13-bit (8k) aligned because we
concatenate two 4k tables.

With this patch, the mask becomes 0x0000ffffffffe000, which is what we
want.

Fixes: 0369f6a34b9f ("arm64: KVM: EL2 register definitions")
Cc: <stable@vger.kernel.org> # 3.11.x
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_arm.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 61d694c2eae5..555d463c0eaa 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -170,8 +170,7 @@
 #define VTCR_EL2_FLAGS			(VTCR_EL2_COMMON_BITS | VTCR_EL2_TGRAN_FLAGS)
 #define VTTBR_X				(VTTBR_X_TGRAN_MAGIC - VTCR_EL2_T0SZ_IPA)
 
-#define VTTBR_BADDR_SHIFT (VTTBR_X - 1)
-#define VTTBR_BADDR_MASK  (((UL(1) << (PHYS_MASK_SHIFT - VTTBR_X)) - 1) << VTTBR_BADDR_SHIFT)
+#define VTTBR_BADDR_MASK  (((UL(1) << (PHYS_MASK_SHIFT - VTTBR_X)) - 1) << VTTBR_X)
 #define VTTBR_VMID_SHIFT  (UL(48))
 #define VTTBR_VMID_MASK(size) (_AT(u64, (1 << size) - 1) << VTTBR_VMID_SHIFT)
 
-- 
2.14.2
