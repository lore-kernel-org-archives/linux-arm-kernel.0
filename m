From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue,  9 Dec 2014 12:26:00 +0100
Subject: [GIT PULL 1/9] KVM: ARM: VGIC: Optimize the vGIC
 vgic_update_irq_pending function.
In-Reply-To: <1418124368-28418-1-git-send-email-christoffer.dall@linaro.org>
References: <1418124368-28418-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1418124368-28418-2-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: wanghaibin <wanghaibin.wang@huawei.com>

When vgic_update_irq_pending with level-sensitive false, it is need to
deactivates an interrupt, and, it can go to out directly.
Here return a false value, because it will be not need to kick.

Signed-off-by: wanghaibin <wanghaibin.wang@huawei.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 3aaca49..5acf2c9 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1646,6 +1646,9 @@ static bool vgic_update_irq_pending(struct kvm *kvm, int cpuid,
 		} else {
 			vgic_dist_irq_clear_pending(vcpu, irq_num);
 		}
+
+		ret = false;
+		goto out;
 	}
 
 	enabled = vgic_irq_is_enabled(vcpu, irq_num);
-- 
2.1.2.330.g565301e.dirty
