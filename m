From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 13 May 2014 09:13:57 -0700
Subject: [PATCH v3 05/14] ARM: KVM: vgic mmio should hold data as LE bytes
 array in BE case
In-Reply-To: <1399997646-4716-1-git-send-email-victor.kamensky@linaro.org>
References: <1399997646-4716-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <1399997646-4716-6-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to recent clarifications of mmio.data array meaning -
the mmio.data array should hold bytes as they would appear in
memory. Vgic is little endian device. And in case of BE image
kernel side that emulates vgic, holds data in BE form. So we
need to byteswap cpu<->le32 vgic registers when we read/write them
from mmio.data[].

Change has no effect in LE case because cpu already runs in le32.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 56ff9be..529c336 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -241,12 +241,12 @@ static void vgic_cpu_irq_clear(struct kvm_vcpu *vcpu, int irq)
 
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
1.8.1.4
