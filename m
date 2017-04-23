From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:09:21 +0200
Subject: [PULL 71/79] KVM: arm/arm64: Add ARM user space interrupt signaling
 ABI
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-72-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexander Graf <agraf@suse.de>

We have 2 modes for dealing with interrupts in the ARM world. We can
either handle them all using hardware acceleration through the vgic or
we can emulate a gic in user space and only drive CPU IRQ pins from
there.

Unfortunately, when driving IRQs from user space, we never tell user
space about events from devices emulated inside the kernel, which may
result in interrupt line state changes, so we lose out on for example
timer and PMU events if we run with user space gic emulation.

Define an ABI to publish such device output levels to userspace.

Reviewed-by: Alexander Graf <agraf@suse.de>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Alexander Graf <agraf@suse.de>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/virtual/kvm/api.txt | 42 +++++++++++++++++++++++++++++++++++++++
 arch/arm/include/uapi/asm/kvm.h   |  2 ++
 arch/arm64/include/uapi/asm/kvm.h |  2 ++
 include/uapi/linux/kvm.h          |  8 ++++++++
 4 files changed, 54 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 3c248f7..3b4e76e 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -4147,3 +4147,45 @@ This capability, if KVM_CHECK_EXTENSION indicates that it is
 available, means that that the kernel can support guests using the
 hashed page table MMU defined in Power ISA V3.00 (as implemented in
 the POWER9 processor), including in-memory segment tables.
+
+
+8.5 KVM_CAP_ARM_USER_IRQ
+
+Architectures: arm, arm64
+This capability, if KVM_CHECK_EXTENSION indicates that it is available, means
+that if userspace creates a VM without an in-kernel interrupt controller, it
+will be notified of changes to the output level of in-kernel emulated devices,
+which can generate virtual interrupts, presented to the VM.
+For such VMs, on every return to userspace, the kernel
+updates the vcpu's run->s.regs.device_irq_level field to represent the actual
+output level of the device.
+
+Whenever kvm detects a change in the device output level, kvm guarantees at
+least one return to userspace before running the VM.  This exit could either
+be a KVM_EXIT_INTR or any other exit event, like KVM_EXIT_MMIO. This way,
+userspace can always sample the device output level and re-compute the state of
+the userspace interrupt controller.  Userspace should always check the state
+of run->s.regs.device_irq_level on every kvm exit.
+The value in run->s.regs.device_irq_level can represent both level and edge
+triggered interrupt signals, depending on the device.  Edge triggered interrupt
+signals will exit to userspace with the bit in run->s.regs.device_irq_level
+set exactly once per edge signal.
+
+The field run->s.regs.device_irq_level is available independent of
+run->kvm_valid_regs or run->kvm_dirty_regs bits.
+
+If KVM_CAP_ARM_USER_IRQ is supported, the KVM_CHECK_EXTENSION ioctl returns a
+number larger than 0 indicating the version of this capability is implemented
+and thereby which bits in in run->s.regs.device_irq_level can signal values.
+
+Currently the following bits are defined for the device_irq_level bitmap:
+
+  KVM_CAP_ARM_USER_IRQ >= 1:
+
+    KVM_ARM_DEV_EL1_VTIMER -  EL1 virtual timer
+    KVM_ARM_DEV_EL1_PTIMER -  EL1 physical timer
+    KVM_ARM_DEV_PMU        -  ARM PMU overflow interrupt signal
+
+Future versions of kvm may implement additional events. These will get
+indicated by returning a higher number from KVM_CHECK_EXTENSION and will be
+listed above.
diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
index 6ebd3e6..a5838d6 100644
--- a/arch/arm/include/uapi/asm/kvm.h
+++ b/arch/arm/include/uapi/asm/kvm.h
@@ -114,6 +114,8 @@ struct kvm_debug_exit_arch {
 };
 
 struct kvm_sync_regs {
+	/* Used with KVM_CAP_ARM_USER_IRQ */
+	__u64 device_irq_level;
 };
 
 struct kvm_arch_memory_slot {
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index c286035..cd6bea4 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -143,6 +143,8 @@ struct kvm_debug_exit_arch {
 #define KVM_GUESTDBG_USE_HW		(1 << 17)
 
 struct kvm_sync_regs {
+	/* Used with KVM_CAP_ARM_USER_IRQ */
+	__u64 device_irq_level;
 };
 
 struct kvm_arch_memory_slot {
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index f51d508..6d6b9b2 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -883,6 +883,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PPC_MMU_RADIX 134
 #define KVM_CAP_PPC_MMU_HASH_V3 135
 #define KVM_CAP_IMMEDIATE_EXIT 136
+#define KVM_CAP_ARM_USER_IRQ 137
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1354,4 +1355,11 @@ struct kvm_assigned_msix_entry {
 #define KVM_X2APIC_API_USE_32BIT_IDS            (1ULL << 0)
 #define KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK  (1ULL << 1)
 
+/* Available with KVM_CAP_ARM_USER_IRQ */
+
+/* Bits for run->s.regs.device_irq_level */
+#define KVM_ARM_DEV_EL1_VTIMER		(1 << 0)
+#define KVM_ARM_DEV_EL1_PTIMER		(1 << 1)
+#define KVM_ARM_DEV_PMU			(1 << 2)
+
 #endif /* __LINUX_KVM_H */
-- 
2.9.0
