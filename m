From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 02:43:20 +0000
Subject: [PATCH 26/29] ARM: KVM: vgic: decouple alignment restriction from
 page size
In-Reply-To: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
References: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362451403-23460-27-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The virtual GIC is supposed to be 4kB aligned. On a 64kB page
system, comparing the alignment to PAGE_SIZE is wrong.

Use SZ_4K instead.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/vgic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
index c9a1731..161d5c1 100644
--- a/arch/arm/kvm/vgic.c
+++ b/arch/arm/kvm/vgic.c
@@ -1484,7 +1484,7 @@ int kvm_vgic_set_addr(struct kvm *kvm, unsigned long type, u64 addr)
 	if (addr & ~KVM_PHYS_MASK)
 		return -E2BIG;
 
-	if (addr & ~PAGE_MASK)
+	if (addr & (SZ_4K - 1))
 		return -EINVAL;
 
 	mutex_lock(&kvm->lock);
-- 
1.7.12.4
