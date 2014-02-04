From: anup.patel@linaro.org (Anup Patel)
Date: Tue,  4 Feb 2014 15:07:20 +0530
Subject: [PATCH] ARM64: KVM: Fix VGIC compile error for Linux-3.14-rc1
Message-ID: <1391506640-1901-1-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes VGIC compilation for Linux-3.14-rc1 ARM64 kernel.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
---
 arch/arm64/include/uapi/asm/kvm.h |    9 +++++++++
 virt/kvm/arm/vgic.c               |    1 +
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 31c2f54..cadc318 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -149,6 +149,15 @@ struct kvm_arch_memory_slot {
 #define KVM_REG_ARM_TIMER_CNT		ARM64_SYS_REG(3, 3, 14, 3, 2)
 #define KVM_REG_ARM_TIMER_CVAL		ARM64_SYS_REG(3, 3, 14, 0, 2)
 
+/* Device Control API: ARM VGIC */
+#define KVM_DEV_ARM_VGIC_GRP_ADDR	0
+#define KVM_DEV_ARM_VGIC_GRP_DIST_REGS	1
+#define KVM_DEV_ARM_VGIC_GRP_CPU_REGS	2
+#define   KVM_DEV_ARM_VGIC_CPUID_SHIFT	32
+#define   KVM_DEV_ARM_VGIC_CPUID_MASK	(0xffULL << KVM_DEV_ARM_VGIC_CPUID_SHIFT)
+#define   KVM_DEV_ARM_VGIC_OFFSET_SHIFT	0
+#define   KVM_DEV_ARM_VGIC_OFFSET_MASK	(0xffffffffULL << KVM_DEV_ARM_VGIC_OFFSET_SHIFT)
+
 /* KVM_IRQ_LINE irq field index values */
 #define KVM_ARM_IRQ_TYPE_SHIFT		24
 #define KVM_ARM_IRQ_TYPE_MASK		0xff
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index be456ce..55b0609 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -21,6 +21,7 @@
 #include <linux/kvm_host.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/uaccess.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-- 
1.7.9.5
