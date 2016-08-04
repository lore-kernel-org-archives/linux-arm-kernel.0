From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu,  4 Aug 2016 13:40:30 +0200
Subject: [PULL 2/8] KVM: Add devid in kvm_kernel_irq_routing_entry
In-Reply-To: <1470310836-10371-1-git-send-email-christoffer.dall@linaro.org>
References: <1470310836-10371-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1470310836-10371-3-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Auger <eric.auger@redhat.com>

Enhance kvm_kernel_irq_routing_entry to transport the device id
field, devid. A new flags field makes possible to indicate the
devid is valid. Those additions are used for ARM GICv3 ITS MSI
injection. The original struct msi_msg msi field is replaced by
a new custom structure that embeds the new fields.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Radim Kr?m?? <rkrcmar@redhat.com>
Acked-by: Radim Kr?m?? <rkrcmar@redhat.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/kvm_host.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 614a981..a15828f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -317,7 +317,13 @@ struct kvm_kernel_irq_routing_entry {
 			unsigned irqchip;
 			unsigned pin;
 		} irqchip;
-		struct msi_msg msi;
+		struct {
+			u32 address_lo;
+			u32 address_hi;
+			u32 data;
+			u32 flags;
+			u32 devid;
+		} msi;
 		struct kvm_s390_adapter_int adapter;
 		struct kvm_hv_sint hv_sint;
 	};
-- 
1.9.1
