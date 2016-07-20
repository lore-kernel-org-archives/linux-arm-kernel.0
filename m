From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 20 Jul 2016 18:04:28 +0100
Subject: [PATCH v7 08/15] arm: allow creation of an MSI register frame region
In-Reply-To: <20160720170435.28090-1-andre.przywara@arm.com>
References: <20160720170435.28090-1-andre.przywara@arm.com>
Message-ID: <20160720170435.28090-9-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GICv3 ITS expects a separate 64K page to hold ITS registers.
Add a function to reserve such a page in the guest's I/O memory and
use that for the ITS vGIC type.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arm/gic.c                    | 63 ++++++++++++++++++++++++++++++++++++++++++++
 arm/include/arm-common/gic.h |  1 +
 2 files changed, 64 insertions(+)

diff --git a/arm/gic.c b/arm/gic.c
index 2c1a547..3544211 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -8,6 +8,7 @@
 #include <linux/byteorder.h>
 #include <linux/kernel.h>
 #include <linux/kvm.h>
+#include <linux/sizes.h>
 
 /* Those names are not defined for ARM (yet) */
 #ifndef KVM_VGIC_V3_ADDR_TYPE_DIST
@@ -21,6 +22,8 @@
 static int gic_fd = -1;
 static u64 gic_redists_base;
 static u64 gic_redists_size;
+static u64 gic_msi_base;
+static u64 gic_msi_size = 0;
 
 int irqchip_parser(const struct option *opt, const char *arg, int unset)
 {
@@ -38,6 +41,56 @@ int irqchip_parser(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int gic__create_its_frame(struct kvm *kvm, u64 its_frame_addr)
+{
+	struct kvm_create_device its_device = {
+		.type = KVM_DEV_TYPE_ARM_VGIC_ITS,
+		.flags	= 0,
+	};
+	struct kvm_device_attr its_attr = {
+		.group	= KVM_DEV_ARM_VGIC_GRP_ADDR,
+		.attr	= KVM_VGIC_ITS_ADDR_TYPE,
+		.addr	= (u64)(unsigned long)&its_frame_addr,
+	};
+	struct kvm_device_attr its_init_attr = {
+		.group	= KVM_DEV_ARM_VGIC_GRP_CTRL,
+		.attr	= KVM_DEV_ARM_VGIC_CTRL_INIT,
+	};
+	int err;
+
+	err = ioctl(kvm->vm_fd, KVM_CREATE_DEVICE, &its_device);
+	if (err) {
+		fprintf(stderr,
+			"GICv3 ITS requested, but kernel does not support it.\n");
+		fprintf(stderr, "Try --irqchip=gicv3 instead\n");
+		return err;
+	}
+
+	err = ioctl(its_device.fd, KVM_HAS_DEVICE_ATTR, &its_attr);
+	if (err) {
+		close(its_device.fd);
+		its_device.fd = -1;
+		return err;
+	}
+
+	err = ioctl(its_device.fd, KVM_SET_DEVICE_ATTR, &its_attr);
+	if (err)
+		return err;
+
+	return ioctl(its_device.fd, KVM_SET_DEVICE_ATTR, &its_init_attr);
+}
+
+static int gic__create_msi_frame(struct kvm *kvm, enum irqchip_type type,
+				 u64 msi_frame_addr)
+{
+	switch (type) {
+	case IRQCHIP_GICV3_ITS:
+		return gic__create_its_frame(kvm, msi_frame_addr);
+	default:	/* No MSI frame needed */
+		return 0;
+	}
+}
+
 static int gic__create_device(struct kvm *kvm, enum irqchip_type type)
 {
 	int err;
@@ -67,6 +120,7 @@ static int gic__create_device(struct kvm *kvm, enum irqchip_type type)
 		dist_attr.attr  = KVM_VGIC_V2_ADDR_TYPE_DIST;
 		break;
 	case IRQCHIP_GICV3:
+	case IRQCHIP_GICV3_ITS:
 		gic_device.type = KVM_DEV_TYPE_ARM_VGIC_V3;
 		dist_attr.attr  = KVM_VGIC_V3_ADDR_TYPE_DIST;
 		break;
@@ -82,6 +136,7 @@ static int gic__create_device(struct kvm *kvm, enum irqchip_type type)
 	case IRQCHIP_GICV2:
 		err = ioctl(gic_fd, KVM_SET_DEVICE_ATTR, &cpu_if_attr);
 		break;
+	case IRQCHIP_GICV3_ITS:
 	case IRQCHIP_GICV3:
 		err = ioctl(gic_fd, KVM_SET_DEVICE_ATTR, &redist_attr);
 		break;
@@ -93,6 +148,10 @@ static int gic__create_device(struct kvm *kvm, enum irqchip_type type)
 	if (err)
 		goto out_err;
 
+	err = gic__create_msi_frame(kvm, type, gic_msi_base);
+	if (err)
+		goto out_err;
+
 	return 0;
 
 out_err:
@@ -136,9 +195,13 @@ int gic__create(struct kvm *kvm, enum irqchip_type type)
 	switch (type) {
 	case IRQCHIP_GICV2:
 		break;
+	case IRQCHIP_GICV3_ITS:
+		gic_msi_size = KVM_VGIC_V3_ITS_SIZE;
+		/* fall through */
 	case IRQCHIP_GICV3:
 		gic_redists_size = kvm->cfg.nrcpus * ARM_GIC_REDIST_SIZE;
 		gic_redists_base = ARM_GIC_DIST_BASE - gic_redists_size;
+		gic_msi_base = gic_redists_base - gic_msi_size;
 		break;
 	default:
 		return -ENODEV;
diff --git a/arm/include/arm-common/gic.h b/arm/include/arm-common/gic.h
index b43a180..433dd23 100644
--- a/arm/include/arm-common/gic.h
+++ b/arm/include/arm-common/gic.h
@@ -24,6 +24,7 @@
 enum irqchip_type {
 	IRQCHIP_GICV2,
 	IRQCHIP_GICV3,
+	IRQCHIP_GICV3_ITS,
 };
 
 struct kvm;
-- 
2.9.0
