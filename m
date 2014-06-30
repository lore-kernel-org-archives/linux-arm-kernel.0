From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 30 Jun 2014 16:01:50 +0100
Subject: [PATCH v6 21/21] arm64: KVM: vgic: enable GICv2 emulation on top on
 GICv3 hardware
In-Reply-To: <1404140510-5382-1-git-send-email-marc.zyngier@arm.com>
References: <1404140510-5382-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1404140510-5382-22-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the last missing bits that enable GICv2 emulation on top of
GICv3 hardware.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_host.h | 7 +++++++
 arch/arm64/kvm/Makefile           | 2 ++
 virt/kvm/arm/vgic.c               | 1 +
 3 files changed, 10 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 4c182d0..4ae9213 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -216,6 +216,13 @@ static inline void vgic_arch_setup(const struct vgic_params *vgic)
 		__vgic_sr_vectors.restore_vgic	= __restore_vgic_v2_state;
 		break;
 
+#ifdef CONFIG_ARM_GIC_V3
+	case VGIC_V3:
+		__vgic_sr_vectors.save_vgic	= __save_vgic_v3_state;
+		__vgic_sr_vectors.restore_vgic	= __restore_vgic_v3_state;
+		break;
+#endif
+
 	default:
 		BUG();
 	}
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index daf24dc..32a0961 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -22,4 +22,6 @@ kvm-$(CONFIG_KVM_ARM_HOST) += guest.o reset.o sys_regs.o sys_regs_generic_v8.o
 kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic.o
 kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic-v2.o
 kvm-$(CONFIG_KVM_ARM_VGIC) += vgic-v2-switch.o
+kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic-v3.o
+kvm-$(CONFIG_KVM_ARM_VGIC) += vgic-v3-switch.o
 kvm-$(CONFIG_KVM_ARM_TIMER) += $(KVM)/arm/arch_timer.o
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 7867b9a..795ab48 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1530,6 +1530,7 @@ static struct notifier_block vgic_cpu_nb = {
 
 static const struct of_device_id vgic_ids[] = {
 	{ .compatible = "arm,cortex-a15-gic", .data = vgic_v2_probe, },
+	{ .compatible = "arm,gic-v3", .data = vgic_v3_probe, },
 	{},
 };
 
-- 
2.0.0
