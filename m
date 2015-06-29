From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 29 Jun 2015 17:37:11 +0200
Subject: [PATCH 1/7] KVM: api: add kvm_irq_routing_extended_msi
In-Reply-To: <1435592237-17924-1-git-send-email-eric.auger@linaro.org>
References: <1435592237-17924-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1435592237-17924-2-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM, the MSI msg (address and data) comes along with
out-of-band device ID information. The device ID encodes the device
that composes the MSI msg. Let's create a new routing entry type,
dubbed KVM_IRQ_ROUTING_EXTENDED_MSI and use the __u32 pad space
to convey the device ID.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

RFC -> PATCH
- remove kvm_irq_routing_extended_msi and use union instead
---
 Documentation/virtual/kvm/api.txt | 9 ++++++++-
 include/uapi/linux/kvm.h          | 6 +++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index d20fd94..6426ae9 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -1414,7 +1414,10 @@ struct kvm_irq_routing_entry {
 	__u32 gsi;
 	__u32 type;
 	__u32 flags;
-	__u32 pad;
+	union {
+		__u32 pad;
+		__u32 devid;
+	};
 	union {
 		struct kvm_irq_routing_irqchip irqchip;
 		struct kvm_irq_routing_msi msi;
@@ -1427,6 +1430,10 @@ struct kvm_irq_routing_entry {
 #define KVM_IRQ_ROUTING_IRQCHIP 1
 #define KVM_IRQ_ROUTING_MSI 2
 #define KVM_IRQ_ROUTING_S390_ADAPTER 3
+#define KVM_IRQ_ROUTING_EXTENDED_MSI 4
+
+In case of KVM_IRQ_ROUTING_EXTENDED_MSI routing type, devid is used to convey
+the device ID.
 
 No flags are specified so far, the corresponding field must be set to zero.
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 2a23705..8484681 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -841,12 +841,16 @@ struct kvm_irq_routing_s390_adapter {
 #define KVM_IRQ_ROUTING_IRQCHIP 1
 #define KVM_IRQ_ROUTING_MSI 2
 #define KVM_IRQ_ROUTING_S390_ADAPTER 3
+#define KVM_IRQ_ROUTING_EXTENDED_MSI 4
 
 struct kvm_irq_routing_entry {
 	__u32 gsi;
 	__u32 type;
 	__u32 flags;
-	__u32 pad;
+	union {
+		__u32 pad;
+		__u32 devid;
+	};
 	union {
 		struct kvm_irq_routing_irqchip irqchip;
 		struct kvm_irq_routing_msi msi;
-- 
1.9.1
