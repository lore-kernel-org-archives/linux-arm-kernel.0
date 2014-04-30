From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 30 Apr 2014 04:15:55 -0700
Subject: [PATCH 4/5] KVM: arm/arm64: vgic: fix GICD_ICFGR register accesses
In-Reply-To: <1398856556-13199-1-git-send-email-christoffer.dall@linaro.org>
References: <1398856556-13199-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1398856556-13199-5-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>

Since KVM internally represents the ICFGR registers by stuffing two
of them into one word, the offset for accessing the internal
representation and the one for the MMIO based access are different.
So keep the original offset around, but adjust the internal array
offset by one bit.

Reported-by: Haibin Wang <wanghaibin.wang@huawei.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 7e8b44e..f9af48c 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -548,11 +548,10 @@ static bool handle_mmio_cfg_reg(struct kvm_vcpu *vcpu,
 	u32 val;
 	u32 *reg;
 
-	offset >>= 1;
 	reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_cfg,
-				  vcpu->vcpu_id, offset);
+				  vcpu->vcpu_id, offset >> 1);
 
-	if (offset & 2)
+	if (offset & 4)
 		val = *reg >> 16;
 	else
 		val = *reg & 0xffff;
@@ -561,13 +560,13 @@ static bool handle_mmio_cfg_reg(struct kvm_vcpu *vcpu,
 	vgic_reg_access(mmio, &val, offset,
 			ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
 	if (mmio->is_write) {
-		if (offset < 4) {
+		if (offset < 8) {
 			*reg = ~0U; /* Force PPIs/SGIs to 1 */
 			return false;
 		}
 
 		val = vgic_cfg_compress(val);
-		if (offset & 2) {
+		if (offset & 4) {
 			*reg &= 0xffff;
 			*reg |= val << 16;
 		} else {
-- 
1.8.5.2
