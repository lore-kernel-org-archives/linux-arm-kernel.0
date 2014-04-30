From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 30 Apr 2014 04:15:56 -0700
Subject: [PATCH 5/5] KVM: ARM: vgic: Fix the overlap check action about
 setting the GICD & GICC base address.
In-Reply-To: <1398856556-13199-1-git-send-email-christoffer.dall@linaro.org>
References: <1398856556-13199-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1398856556-13199-6-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Haibin Wang <wanghaibin.wang@huawei.com>

Currently below check in vgic_ioaddr_overlap will always succeed,
because the vgic dist base and vgic cpu base are still kept UNDEF
after initialization. The code as follows will be return forever.

	if (IS_VGIC_ADDR_UNDEF(dist) || IS_VGIC_ADDR_UNDEF(cpu))
                return 0;

So, before invoking the vgic_ioaddr_overlap, it needs to set the
corresponding base address firstly.

Signed-off-by: Haibin Wang <wanghaibin.wang@huawei.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index f9af48c..56ff9be 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1667,10 +1667,11 @@ static int vgic_ioaddr_assign(struct kvm *kvm, phys_addr_t *ioaddr,
 	if (addr + size < addr)
 		return -EINVAL;
 
+	*ioaddr = addr;
 	ret = vgic_ioaddr_overlap(kvm);
 	if (ret)
-		return ret;
-	*ioaddr = addr;
+		*ioaddr = VGIC_ADDR_UNDEF;
+
 	return ret;
 }
 
-- 
1.8.5.2
