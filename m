From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 14 May 2013 15:13:58 +0100
Subject: [PATCH v4 30/32] arm64: KVM: userspace API documentation
In-Reply-To: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1368540840-26750-31-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unsurprisingly, the arm64 userspace API is extremely similar to
the 32bit one, the only significant difference being the ONE_REG
register mapping.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/virtual/kvm/api.txt | 58 ++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 5f91eda..9bfadeb 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -280,7 +280,7 @@ kvm_run' (see below).
 4.11 KVM_GET_REGS
 
 Capability: basic
-Architectures: all except ARM
+Architectures: all except ARM, arm64
 Type: vcpu ioctl
 Parameters: struct kvm_regs (out)
 Returns: 0 on success, -1 on error
@@ -301,7 +301,7 @@ struct kvm_regs {
 4.12 KVM_SET_REGS
 
 Capability: basic
-Architectures: all except ARM
+Architectures: all except ARM, arm64
 Type: vcpu ioctl
 Parameters: struct kvm_regs (in)
 Returns: 0 on success, -1 on error
@@ -587,7 +587,7 @@ struct kvm_fpu {
 4.24 KVM_CREATE_IRQCHIP
 
 Capability: KVM_CAP_IRQCHIP
-Architectures: x86, ia64, ARM
+Architectures: x86, ia64, ARM, arm64
 Type: vm ioctl
 Parameters: none
 Returns: 0 on success, -1 on error
@@ -595,14 +595,14 @@ Returns: 0 on success, -1 on error
 Creates an interrupt controller model in the kernel.  On x86, creates a virtual
 ioapic, a virtual PIC (two PICs, nested), and sets up future vcpus to have a
 local APIC.  IRQ routing for GSIs 0-15 is set to both PIC and IOAPIC; GSI 16-23
-only go to the IOAPIC.  On ia64, a IOSAPIC is created. On ARM, a GIC is
+only go to the IOAPIC.  On ia64, a IOSAPIC is created. On ARM/arm64, a GIC is
 created.
 
 
 4.25 KVM_IRQ_LINE
 
 Capability: KVM_CAP_IRQCHIP
-Architectures: x86, ia64, arm
+Architectures: x86, ia64, arm, arm64
 Type: vm ioctl
 Parameters: struct kvm_irq_level
 Returns: 0 on success, -1 on error
@@ -612,9 +612,10 @@ On some architectures it is required that an interrupt controller model has
 been previously created with KVM_CREATE_IRQCHIP.  Note that edge-triggered
 interrupts require the level to be set to 1 and then back to 0.
 
-ARM can signal an interrupt either at the CPU level, or at the in-kernel irqchip
-(GIC), and for in-kernel irqchip can tell the GIC to use PPIs designated for
-specific cpus.  The irq field is interpreted like this:
+ARM/arm64 can signal an interrupt either at the CPU level, or at the
+in-kernel irqchip (GIC), and for in-kernel irqchip can tell the GIC to
+use PPIs designated for specific cpus.  The irq field is interpreted
+like this:
 
  ?bits:  | 31 ... 24 | 23  ... 16 | 15    ...    0 |
   field: | irq_type  | vcpu_index |     irq_id     |
@@ -1831,6 +1832,22 @@ ARM 32-bit VFP control registers have the following id bit patterns:
 ARM 64-bit FP registers have the following id bit patterns:
   0x4030 0000 0012 0 <regno:12>
 
+
+arm64 registers are mapped using the lower 32 bits. The upper 16 of
+that is the register group type, or coprocessor number:
+
+arm64 core/FP-SIMD registers have the following id bit patterns. Note
+that the size of the access is variable, as the kvm_regs structure
+contains elements ranging from 32 to 128 bits. The index is a 32bit
+value in the kvm_regs structure seen as a 32bit array.
+  0x60x0 0000 0010 <index into the kvm_regs struct:16>
+
+arm64 CCSIDR registers are demultiplexed by CSSELR value:
+  0x6020 0000 0011 00 <csselr:8>
+
+arm64 system registers have the following id bit patterns:
+  0x6030 0000 0013 <op0:2> <op1:3> <crn:4> <crm:4> <op2:3>
+
 4.69 KVM_GET_ONE_REG
 
 Capability: KVM_CAP_ONE_REG
@@ -2264,7 +2281,7 @@ current state.  "addr" is ignored.
 4.77 KVM_ARM_VCPU_INIT
 
 Capability: basic
-Architectures: arm
+Architectures: arm, arm64
 Type: vcpu ioctl
 Parameters: struct struct kvm_vcpu_init (in)
 Returns: 0 on success; -1 on error
@@ -2283,12 +2300,14 @@ should be created before this ioctl is invoked.
 Possible features:
 	- KVM_ARM_VCPU_POWER_OFF: Starts the CPU in a power-off state.
 	  Depends on KVM_CAP_ARM_PSCI.
+	- KVM_ARM_VCPU_EL1_32BIT: Starts the CPU in a 32bit mode.
+	  Depends on KVM_CAP_ARM_EL1_32BIT (arm64 only).
 
 
 4.78 KVM_GET_REG_LIST
 
 Capability: basic
-Architectures: arm
+Architectures: arm, arm64
 Type: vcpu ioctl
 Parameters: struct kvm_reg_list (in/out)
 Returns: 0 on success; -1 on error
@@ -2308,7 +2327,7 @@ KVM_GET_ONE_REG/KVM_SET_ONE_REG calls.
 4.80 KVM_ARM_SET_DEVICE_ADDR
 
 Capability: KVM_CAP_ARM_SET_DEVICE_ADDR
-Architectures: arm
+Architectures: arm, arm64
 Type: vm ioctl
 Parameters: struct kvm_arm_device_address (in)
 Returns: 0 on success, -1 on error
@@ -2329,18 +2348,19 @@ can access emulated or directly exposed devices, which the host kernel needs
 to know about. The id field is an architecture specific identifier for a
 specific device.
 
-ARM divides the id field into two parts, a device id and an address type id
-specific to the individual device.
+ARM/arm64 divides the id field into two parts, a device id and an
+address type id specific to the individual device.
 
  ?bits:  | 63        ...       32 | 31    ...    16 | 15    ...    0 |
   field: |        0x00000000      |     device id   |  addr type id  |
 
-ARM currently only require this when using the in-kernel GIC support for the
-hardware VGIC features, using KVM_ARM_DEVICE_VGIC_V2 as the device id.  When
-setting the base address for the guest's mapping of the VGIC virtual CPU
-and distributor interface, the ioctl must be called after calling
-KVM_CREATE_IRQCHIP, but before calling KVM_RUN on any of the VCPUs.  Calling
-this ioctl twice for any of the base addresses will return -EEXIST.
+ARM/arm64 currently only require this when using the in-kernel GIC
+support for the hardware VGIC features, using KVM_ARM_DEVICE_VGIC_V2
+as the device id.  When setting the base address for the guest's
+mapping of the VGIC virtual CPU and distributor interface, the ioctl
+must be called after calling KVM_CREATE_IRQCHIP, but before calling
+KVM_RUN on any of the VCPUs.  Calling this ioctl twice for any of the
+base addresses will return -EEXIST.
 
 4.82 KVM_PPC_RTAS_DEFINE_TOKEN
 
-- 
1.8.2.3
