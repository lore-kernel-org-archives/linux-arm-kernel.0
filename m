From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 25 Sep 2014 19:49:07 +0200
Subject: [PATCH] arm/arm64: KVM: Fix set_clear_sgi_pend_reg offset
Message-ID: <1411667347-2989-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sgi values calculated in read_set_clear_sgi_pend_reg() and
write_set_clear_sgi_pend_reg() were horribly incorrectly multiplied by 4
with catastrophic results in that subfunctions ended up overwriting
memory not allocated for the expected purpose.

This showed up as bugs in kfree() and the kernel complaining a lot of
you turn on memory debugging.

This addresses: http://marc.info/?l=kvm&m=141164910007868&w=2

Reported-by: Shannon Zhao <zhaoshenglong@huawei.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index b6fab0f..8629678 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -816,7 +816,7 @@ static bool read_set_clear_sgi_pend_reg(struct kvm_vcpu *vcpu,
 {
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
 	int sgi;
-	int min_sgi = (offset & ~0x3) * 4;
+	int min_sgi = (offset & ~0x3);
 	int max_sgi = min_sgi + 3;
 	int vcpu_id = vcpu->vcpu_id;
 	u32 reg = 0;
@@ -837,7 +837,7 @@ static bool write_set_clear_sgi_pend_reg(struct kvm_vcpu *vcpu,
 {
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
 	int sgi;
-	int min_sgi = (offset & ~0x3) * 4;
+	int min_sgi = (offset & ~0x3);
 	int max_sgi = min_sgi + 3;
 	int vcpu_id = vcpu->vcpu_id;
 	u32 reg;
-- 
2.0.0
