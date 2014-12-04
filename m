From: eric.auger@linaro.org (Eric Auger)
Date: Thu,  4 Dec 2014 10:48:04 +0100
Subject: [PATCH v2 4/4] KVM: arm/arm64: vgic: check vgic_initialized in
 KVM_DEV_ARM_VGIC_GRP_ADDR
In-Reply-To: <1417686484-20828-1-git-send-email-eric.auger@linaro.org>
References: <1417686484-20828-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1417686484-20828-5-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch prevents user-space from changing VGIC base addresses
if the vgic already is initialized.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 Documentation/virtual/kvm/devices/arm-vgic.txt | 2 ++
 virt/kvm/arm/vgic.c                            | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/virtual/kvm/devices/arm-vgic.txt b/Documentation/virtual/kvm/devices/arm-vgic.txt
index 30f5427..8492715 100644
--- a/Documentation/virtual/kvm/devices/arm-vgic.txt
+++ b/Documentation/virtual/kvm/devices/arm-vgic.txt
@@ -19,6 +19,8 @@ Groups:
     KVM_VGIC_V2_ADDR_TYPE_CPU (rw, 64-bit)
       Base address in the guest physical address space of the GIC virtual cpu
       interface register mappings.
+  Errors:
+    -EBUSY: VGIC already is initialized
 
   KVM_DEV_ARM_VGIC_GRP_DIST_REGS
   Attributes:
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 89dca86..652e0bb 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -2427,6 +2427,9 @@ static int vgic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 		u64 addr;
 		unsigned long type = (unsigned long)attr->attr;
 
+		if (vgic_initialized(dev->kvm))
+			return -EBUSY;
+
 		if (copy_from_user(&addr, uaddr, sizeof(addr)))
 			return -EFAULT;
 
-- 
1.9.1
