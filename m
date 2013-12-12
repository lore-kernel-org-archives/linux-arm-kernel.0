From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 11 Dec 2013 21:29:13 -0800
Subject: [PATCH v3 3/9] KVM: arm-vgic: Set base addr through device API
In-Reply-To: <55bea7ea9586bcd44de3831205e5e925@www.loen.fr>
References: <1384662620-13795-1-git-send-email-christoffer.dall@linaro.org>
 <1384662620-13795-4-git-send-email-christoffer.dall@linaro.org>
 <55bea7ea9586bcd44de3831205e5e925@www.loen.fr>
Message-ID: <20131212052913.GL2871@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 09, 2013 at 03:38:19PM +0000, Marc Zyngier wrote:
> On 2013-11-17 04:30, Christoffer Dall wrote:
> >Support setting the distributor and cpu interface base addresses
> >in the
> >VM physical address space through the KVM_{SET,GET}_DEVICE_ATTR API
> >in addition to the ARM specific API.
> >
> >This has the added benefit of being able to share more code in user
> >space and do things in a uniform manner.
> >
> >Also deprecate the older API at the same time, but backwards
> >compatibility will be maintained.
> >
> >Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> >
> >Changelog[v3]:
> > - Spelling nits
> > - Fix error codes from vgic_get_attr
> >
> >Changelog[v2]:
> > - None
> >---
> > Documentation/virtual/kvm/api.txt              |    7 +-
> > Documentation/virtual/kvm/devices/arm-vgic.txt |   11 +++
> > arch/arm/include/uapi/asm/kvm.h                |    8 +++
> > arch/arm/kvm/arm.c                             |    2 +-
> > include/kvm/arm_vgic.h                         |    2 +-
> > virt/kvm/arm/vgic.c                            |   89
> >++++++++++++++++++++----
> > 6 files changed, 104 insertions(+), 15 deletions(-)
> >
> >diff --git a/Documentation/virtual/kvm/api.txt
> >b/Documentation/virtual/kvm/api.txt
> >index a30035d..867112f 100644
> >--- a/Documentation/virtual/kvm/api.txt
> >+++ b/Documentation/virtual/kvm/api.txt
> >@@ -2391,7 +2391,8 @@ struct kvm_reg_list {
> > This ioctl returns the guest registers that are supported for the
> > KVM_GET_ONE_REG/KVM_SET_ONE_REG calls.
> >
> >-4.85 KVM_ARM_SET_DEVICE_ADDR
> >+
> >+4.85 KVM_ARM_SET_DEVICE_ADDR (deprecated)
> >
> > Capability: KVM_CAP_ARM_SET_DEVICE_ADDR
> > Architectures: arm, arm64
> >@@ -2429,6 +2430,10 @@ must be called after calling
> >KVM_CREATE_IRQCHIP, but before calling
> > KVM_RUN on any of the VCPUs.  Calling this ioctl twice for any of
> >the
> > base addresses will return -EEXIST.
> >
> >+Note, this IOCTL is deprecated and the more flexible
> >SET/GET_DEVICE_ATTR API
> >+should be used instead.
> >+
> >+
> > 4.86 KVM_PPC_RTAS_DEFINE_TOKEN
> >
> > Capability: KVM_CAP_PPC_RTAS
> >diff --git a/Documentation/virtual/kvm/devices/arm-vgic.txt
> >b/Documentation/virtual/kvm/devices/arm-vgic.txt
> >index 38f27f7..c9febb2 100644
> >--- a/Documentation/virtual/kvm/devices/arm-vgic.txt
> >+++ b/Documentation/virtual/kvm/devices/arm-vgic.txt
> >@@ -8,3 +8,14 @@ Only one VGIC instance may be instantiated through
> >either this API or the
> > legacy KVM_CREATE_IRQCHIP api.  The created VGIC will act as the VM
> >interrupt
> > controller, requiring emulated user-space devices to inject
> >interrupts to the
> > VGIC instead of directly to CPUs.
> >+
> >+Groups:
> >+  KVM_DEV_ARM_VGIC_GRP_ADDR
> >+  Attributes:
> >+    KVM_VGIC_V2_ADDR_TYPE_DIST (rw, 64-bit)
> >+      Base address in the guest physical address space of the GIC
> >distributor
> >+      register mappings.
> >+
> >+    KVM_VGIC_V2_ADDR_TYPE_CPU (rw, 64-bit)
> >+      Base address in the guest physical address space of the GIC
> >virtual cpu
> >+      interface register mappings.
> >diff --git a/arch/arm/include/uapi/asm/kvm.h
> >b/arch/arm/include/uapi/asm/kvm.h
> >index bd3b2f7..26a375c 100644
> >--- a/arch/arm/include/uapi/asm/kvm.h
> >+++ b/arch/arm/include/uapi/asm/kvm.h
> >@@ -159,6 +159,14 @@ struct kvm_arch_memory_slot {
> > #define KVM_REG_ARM_VFP_FPINST		0x1009
> > #define KVM_REG_ARM_VFP_FPINST2		0x100A
> >
> >+/* Device Control API: ARM VGIC */
> >+#define KVM_DEV_ARM_VGIC_GRP_ADDR	0
> >+#define KVM_DEV_ARM_VGIC_GRP_DIST_REGS	1
> >+#define KVM_DEV_ARM_VGIC_GRP_CPU_REGS	2
> >+#define   KVM_DEV_ARM_VGIC_CPUID_SHIFT	32
> >+#define   KVM_DEV_ARM_VGIC_CPUID_MASK	(0xffULL <<
> >KVM_DEV_ARM_VGIC_CPUID_SHIFT)
> >+#define   KVM_DEV_ARM_VGIC_OFFSET_SHIFT	0
> >+#define   KVM_DEV_ARM_VGIC_OFFSET_MASK	(0xffffffffULL <<
> >KVM_DEV_ARM_VGIC_OFFSET_SHIFT)
> 
> What are these #defines for? I suppose they are used in a subsequent
> patch? If so, can we please move them?
> 

Yeah, they're used in the patch:

"KVM: arm-vgic: Add vgic reg access from dev attr"

There was also an unused variable warning on compiling this patch that I
fixed.  I must have screwed something up in the rebasing.


Thanks!
