From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed,  4 Nov 2015 15:49:43 +0100
Subject: [PULL 04/21] arm/arm64: KVM: Implement GICD_ICFGR as RO for PPIs
In-Reply-To: <1446648600-27297-1-git-send-email-christoffer.dall@linaro.org>
References: <1446648600-27297-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1446648600-27297-5-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GICD_ICFGR allows the bits for the SGIs and PPIs to be read only.
We currently simulate this behavior by writing a hardcoded value to the
register for the SGIs and PPIs on every write of these bits to the
register (ignoring what the guest actually wrote), and by writing the
same value as the reset value to the register.

This is a bit counter-intuitive, as the register is RO for these bits,
and we can just implement it that way, allowing us to control the value
of the bits purely in the reset code.

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 367a180..f8ca2e9 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -690,10 +690,9 @@ bool vgic_handle_cfg_reg(u32 *reg, struct kvm_exit_mmio *mmio,
 	vgic_reg_access(mmio, &val, offset,
 			ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
 	if (mmio->is_write) {
-		if (offset < 8) {
-			*reg = ~0U; /* Force PPIs/SGIs to 1 */
+		/* Ignore writes to read-only SGI and PPI bits */
+		if (offset < 8)
 			return false;
-		}
 
 		val = vgic_cfg_compress(val);
 		if (offset & 4) {
-- 
2.1.2.330.g565301e.dirty
