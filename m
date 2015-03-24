From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 24 Mar 2015 16:03:16 +0000
Subject: [PATCH] KVM: arm/arm64: fix MMIO handling on userland induced accesses
In-Reply-To: <1427126309-11223-12-git-send-email-andre.przywara@arm.com>
References: <1427126309-11223-12-git-send-email-andre.przywara@arm.com>
Message-ID: <1427212996-16844-1-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The guest is not the only user of the MMIO handling routines, userland
can also read and write to those handlers. Since we don't use the
KVM iobus framework in this case, we have to set the data pointer to
some actual memory before executing the handler routines.
This allows to use QEMU as the userland control tool.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
Hi,

just embarrassingly realised that I haven't tested the latest version of this
series with QEMU, so this bug slipped me. Sorry for that! I will merge this
patch in the next revision of this series (or just send a new version of
11/12).

Cheers,
Andre.

 virt/kvm/arm/vgic-v2-emul.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/virt/kvm/arm/vgic-v2-emul.c b/virt/kvm/arm/vgic-v2-emul.c
index 12cb1361..a715054 100644
--- a/virt/kvm/arm/vgic-v2-emul.c
+++ b/virt/kvm/arm/vgic-v2-emul.c
@@ -666,6 +666,7 @@ static int vgic_attr_regs_access(struct kvm_device *dev,
 	struct kvm_vcpu *vcpu, *tmp_vcpu;
 	struct vgic_dist *vgic;
 	struct kvm_exit_mmio mmio;
+	u32 data;
 
 	offset = attr->attr & KVM_DEV_ARM_VGIC_OFFSET_MASK;
 	cpuid = (attr->attr & KVM_DEV_ARM_VGIC_CPUID_MASK) >>
@@ -687,6 +688,7 @@ static int vgic_attr_regs_access(struct kvm_device *dev,
 
 	mmio.len = 4;
 	mmio.is_write = is_write;
+	mmio.data = &data;
 	if (is_write)
 		mmio_data_write(&mmio, ~0, *reg);
 	switch (attr->group) {
-- 
1.7.9.5
