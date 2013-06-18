From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 18 Jun 2013 11:09:28 +0100
Subject: [PATCH] ARM: KVM: vgic: fix GICD_ICFGRn access
Message-ID: <1371550168-8036-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the code in handle_mmio_cfg_reg() assumes the offset has
been shifted right to accomodate for the 2:1 bit compression,
but this is only done when getting the register addess.

Shift the offset early so the code works mostly unchanged.

Reported-by: Zhaobo (Bob, ERC) <zhaobo@huawei.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/vgic.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
index a2d478a..902789f 100644
--- a/arch/arm/kvm/vgic.c
+++ b/arch/arm/kvm/vgic.c
@@ -541,8 +541,12 @@ static bool handle_mmio_cfg_reg(struct kvm_vcpu *vcpu,
 				struct kvm_exit_mmio *mmio, phys_addr_t offset)
 {
 	u32 val;
-	u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_cfg,
-				       vcpu->vcpu_id, offset >> 1);
+	u32 *reg;
+
+	offset >>= 1;
+	reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_cfg,
+				  vcpu->vcpu_id, offset);
+
 	if (offset & 2)
 		val = *reg >> 16;
 	else
-- 
1.8.2.3
