From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 22 Jul 2016 18:29:00 +0100
Subject: [PATCH 43/55] KVM: arm/arm64: Fix vGICv2
 KVM_DEV_ARM_VGIC_GRP_CPU/DIST_REGS
In-Reply-To: <1469208552-4155-1-git-send-email-marc.zyngier@arm.com>
References: <1469208552-4155-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1469208552-4155-44-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Auger <eric.auger@redhat.com>

For VGICv2 save and restore the CPU interface registers
are accessed. Restore the modality which has been altered.
Also explicitly set the iodev_type for both the DIST and CPU
interface.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-mmio-v2.c | 2 ++
 virt/kvm/arm/vgic/vgic-mmio.c    | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/vgic-mmio-v2.c b/virt/kvm/arm/vgic/vgic-mmio-v2.c
index 4152348..b44b359 100644
--- a/virt/kvm/arm/vgic/vgic-mmio-v2.c
+++ b/virt/kvm/arm/vgic/vgic-mmio-v2.c
@@ -437,6 +437,7 @@ int vgic_v2_cpuif_uaccess(struct kvm_vcpu *vcpu, bool is_write,
 	struct vgic_io_device dev = {
 		.regions = vgic_v2_cpu_registers,
 		.nr_regions = ARRAY_SIZE(vgic_v2_cpu_registers),
+		.iodev_type = IODEV_CPUIF,
 	};
 
 	return vgic_uaccess(vcpu, &dev, is_write, offset, val);
@@ -448,6 +449,7 @@ int vgic_v2_dist_uaccess(struct kvm_vcpu *vcpu, bool is_write,
 	struct vgic_io_device dev = {
 		.regions = vgic_v2_dist_registers,
 		.nr_regions = ARRAY_SIZE(vgic_v2_dist_registers),
+		.iodev_type = IODEV_DIST,
 	};
 
 	return vgic_uaccess(vcpu, &dev, is_write, offset, val);
diff --git a/virt/kvm/arm/vgic/vgic-mmio.c b/virt/kvm/arm/vgic/vgic-mmio.c
index 26be827..3bad3c5 100644
--- a/virt/kvm/arm/vgic/vgic-mmio.c
+++ b/virt/kvm/arm/vgic/vgic-mmio.c
@@ -484,7 +484,8 @@ static int dispatch_mmio_read(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
 
 	switch (iodev->iodev_type) {
 	case IODEV_CPUIF:
-		return 1;
+		data = region->read(vcpu, addr, len);
+		break;
 	case IODEV_DIST:
 		data = region->read(vcpu, addr, len);
 		break;
@@ -517,6 +518,7 @@ static int dispatch_mmio_write(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
 
 	switch (iodev->iodev_type) {
 	case IODEV_CPUIF:
+		region->write(vcpu, addr, len, data);
 		break;
 	case IODEV_DIST:
 		region->write(vcpu, addr, len, data);
-- 
2.8.1
