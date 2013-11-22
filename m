From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 22 Nov 2013 15:57:18 -0800
Subject: [PATCH 2/3] arm/arm64: KVM: vgic: Bugfix in vgic_dispatch_sgi
In-Reply-To: <1385164639-18710-1-git-send-email-christoffer.dall@linaro.org>
References: <1385164639-18710-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1385164639-18710-3-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When software writes to the GICD_SGIR with the TargetListFilter field
set to 0, we should use the target_cpus mask as the VCPU destination
mask for the SGI.  However, because we were falling through to the next
case due to a missing break, we would always send the SGI to all other
cores than ourselves.  This does not change anything on dual-core system
(unless a core is IPI'ing itself), but would look quite bad on systems
with more cores.

Cc: Haibin Wang <wanghaibin202@gmail.com>
Reported-by: Haibin Wang <wanghaibin202@gmail.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 6699ed9..ecee766 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -751,7 +751,7 @@ static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg)
 	case 0:
 		if (!target_cpus)
 			return;
-
+		break;
 	case 1:
 		target_cpus = ((1 << nrcpus) - 1) & ~(1 << vcpu_id) & 0xff;
 		break;
-- 
1.8.4.3
