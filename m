From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 30 Apr 2014 04:15:54 -0700
Subject: [PATCH 3/5] KVM: ARM: vgic: Fix sgi dispatch problem
In-Reply-To: <1398856556-13199-1-git-send-email-christoffer.dall@linaro.org>
References: <1398856556-13199-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1398856556-13199-4-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Haibin Wang <wanghaibin.wang@huawei.com>

When dispatch SGI(mode == 0), that is the vcpu of VM should send
sgi to the cpu which the target_cpus list.
So, there must add the "break" to branch of case 0.

Cc: <stable@vger.kernel.org> # 3.10+
Signed-off-by: Haibin Wang <wanghaibin.wang@huawei.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 47b2983..7e8b44e 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -916,6 +916,7 @@ static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg)
 	case 0:
 		if (!target_cpus)
 			return;
+		break;
 
 	case 1:
 		target_cpus = ((1 << nrcpus) - 1) & ~(1 << vcpu_id) & 0xff;
-- 
1.8.5.2
