From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 19 May 2016 19:08:21 +0100
Subject: [PATCH v5 42/57] KVM: arm/arm64: vgic-new: vgic_kvm_device:
 KVM_DEV_ARM_VGIC_GRP_CTRL
In-Reply-To: <1463681316-23039-1-git-send-email-andre.przywara@arm.com>
References: <1463681316-23039-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1463681316-23039-43-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Auger <eric.auger@linaro.org>

This patch implements the KVM_DEV_ARM_VGIC_GRP_CTRL group API
featuring KVM_DEV_ARM_VGIC_CTRL_INIT attribute. The vgic_init
function is not yet implemented though.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic/vgic-kvm-device.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-kvm-device.c b/virt/kvm/arm/vgic/vgic-kvm-device.c
index 05ff925..e153f12 100644
--- a/virt/kvm/arm/vgic/vgic-kvm-device.c
+++ b/virt/kvm/arm/vgic/vgic-kvm-device.c
@@ -23,6 +23,8 @@
 static int vgic_set_common_attr(struct kvm_device *dev,
 				struct kvm_device_attr *attr)
 {
+	int r;
+
 	switch (attr->group) {
 	case KVM_DEV_ARM_VGIC_GRP_NR_IRQS: {
 		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
@@ -55,6 +57,16 @@ static int vgic_set_common_attr(struct kvm_device *dev,
 
 		return ret;
 	}
+	case KVM_DEV_ARM_VGIC_GRP_CTRL: {
+		switch (attr->attr) {
+		case KVM_DEV_ARM_VGIC_CTRL_INIT:
+			mutex_lock(&dev->kvm->lock);
+			r = vgic_init(dev->kvm);
+			mutex_unlock(&dev->kvm->lock);
+			return r;
+		}
+		break;
+	}
 	}
 
 	return -ENXIO;
@@ -131,6 +143,11 @@ static int vgic_v2_has_attr(struct kvm_device *dev,
 	switch (attr->group) {
 	case KVM_DEV_ARM_VGIC_GRP_NR_IRQS:
 		return 0;
+	case KVM_DEV_ARM_VGIC_GRP_CTRL:
+		switch (attr->attr) {
+		case KVM_DEV_ARM_VGIC_CTRL_INIT:
+			return 0;
+		}
 	}
 	return -ENXIO;
 }
@@ -166,6 +183,11 @@ static int vgic_v3_has_attr(struct kvm_device *dev,
 	switch (attr->group) {
 	case KVM_DEV_ARM_VGIC_GRP_NR_IRQS:
 		return 0;
+	case KVM_DEV_ARM_VGIC_GRP_CTRL:
+		switch (attr->attr) {
+		case KVM_DEV_ARM_VGIC_CTRL_INIT:
+			return 0;
+		}
 	}
 	return -ENXIO;
 }
-- 
2.8.2
