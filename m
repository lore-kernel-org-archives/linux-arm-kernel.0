From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 29 Jun 2015 17:37:12 +0200
Subject: [PATCH 2/7] KVM: kvm_host: add kvm_extended_msi
In-Reply-To: <1435592237-17924-1-git-send-email-eric.auger@linaro.org>
References: <1435592237-17924-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1435592237-17924-3-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new kvm_extended_msi struct to store the additional device ID
specific to ARM. kvm_kernel_irq_routing_entry union now encompasses
this new struct.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

RFC -> PATCH:
- reword the commit message after change in first patch (uapi)
---
 include/linux/kvm_host.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ad45054..e1c1c0d 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -304,6 +304,13 @@ struct kvm_s390_adapter_int {
 	u32 adapter_id;
 };
 
+struct kvm_extended_msi {
+	u32     address_lo;     /* low 32 bits of msi message address */
+	u32     address_hi;     /* high 32 bits of msi message address */
+	u32     data;           /* 16 bits of msi message data */
+	u32	devid;		/* out-of-band device ID */
+};
+
 struct kvm_kernel_irq_routing_entry {
 	u32 gsi;
 	u32 type;
@@ -317,6 +324,7 @@ struct kvm_kernel_irq_routing_entry {
 		} irqchip;
 		struct msi_msg msi;
 		struct kvm_s390_adapter_int adapter;
+		struct kvm_extended_msi ext_msi;
 	};
 	struct hlist_node link;
 };
-- 
1.9.1
