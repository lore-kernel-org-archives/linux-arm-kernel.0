From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 22 Nov 2013 15:57:17 -0800
Subject: [PATCH 1/3] arm/arm64: KVM: vgic: Bugfix in handle_mmio_cfg_reg
In-Reply-To: <1385164639-18710-1-git-send-email-christoffer.dall@linaro.org>
References: <1385164639-18710-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1385164639-18710-2-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We shift the offset right by 1 bit because we pretend the register
access is for a register packed with 1 bit per setting and not 2 bits
like the hardware.  However, after we expand the emulated register into
the layout of the real hardware register, we need to use the hardware
offset for accessing the register.  Adjust the code accordingly.

Cc: Haibin Wang <wanghaibin202@gmail.com>
Reported-by: Haibin Wang <wanghaibin202@gmail.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 685fc72..6699ed9 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -553,7 +553,7 @@ static bool handle_mmio_cfg_reg(struct kvm_vcpu *vcpu,
 		val = *reg & 0xffff;
 
 	val = vgic_cfg_expand(val);
-	vgic_reg_access(mmio, &val, offset,
+	vgic_reg_access(mmio, &val, offset << 1,
 			ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
 	if (mmio->is_write) {
 		if (offset < 4) {
-- 
1.8.4.3
