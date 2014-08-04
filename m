From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon,  4 Aug 2014 10:46:48 +0200
Subject: [GIT PULL 31/51] ARM: KVM: vgic mmio should hold data as LE bytes
 array in BE case
In-Reply-To: <1407142028-31105-1-git-send-email-christoffer.dall@linaro.org>
References: <1407142028-31105-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1407142028-31105-32-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Kamensky <victor.kamensky@linaro.org>

According to recent clarifications of mmio.data array meaning -
the mmio.data array should hold bytes as they would appear in
memory. Vgic is little endian device. And in case of BE image
kernel side that emulates vgic, holds data in BE form. So we
need to byteswap cpu<->le32 vgic registers when we read/write them
from mmio.data[].

Change has no effect in LE case because cpu already runs in le32.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 795ab48..b0edc8c 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -238,12 +238,12 @@ static void vgic_cpu_irq_clear(struct kvm_vcpu *vcpu, int irq)
 
 static u32 mmio_data_read(struct kvm_exit_mmio *mmio, u32 mask)
 {
-	return *((u32 *)mmio->data) & mask;
+	return le32_to_cpu(*((u32 *)mmio->data)) & mask;
 }
 
 static void mmio_data_write(struct kvm_exit_mmio *mmio, u32 mask, u32 value)
 {
-	*((u32 *)mmio->data) = value & mask;
+	*((u32 *)mmio->data) = cpu_to_le32(value) & mask;
 }
 
 /**
-- 
2.0.0
