From: eric.auger@linaro.org (Eric Auger)
Date: Mon,  3 Aug 2015 17:31:24 +0200
Subject: [PATCH v3 2/7] KVM: kvm_host: add devid in
 kvm_kernel_irq_routing_entry
In-Reply-To: <1438615889-10892-1-git-send-email-eric.auger@linaro.org>
References: <1438615889-10892-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1438615889-10892-3-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend kvm_kernel_irq_routing_entry to transport the device id
field, devid. A new flags field makes possible to indicate the
devid is valid. Those additions are used for ARM GICv3 ITS MSI
injection.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---
v2 -> v3:
- add flags

v1 -> v2:
- replace msi_msg field by a struct composed of msi_msg and devid

RFC -> PATCH:
- reword the commit message after change in first patch (uapi)
---
 include/linux/kvm_host.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 05e99b8..b784465 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -321,7 +321,11 @@ struct kvm_kernel_irq_routing_entry {
 			unsigned irqchip;
 			unsigned pin;
 		} irqchip;
-		struct msi_msg msi;
+		struct {
+			struct msi_msg msi;
+			u32 flags;
+			u32 devid;
+		};
 		struct kvm_s390_adapter_int adapter;
 	};
 	struct hlist_node link;
-- 
1.9.1
