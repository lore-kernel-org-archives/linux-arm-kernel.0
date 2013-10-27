From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 27 Oct 2013 17:18:27 +0000
Subject: [PATCH RESEND v2 2/8] KVM: arm-vgic: Support  KVM_CREATE_DEVICE
 for VGIC
In-Reply-To: <2b4aea6fef36b2155dfdb39622760798@www.loen.fr>
References: <1382432923-61267-1-git-send-email-christoffer.dall@linaro.org>
 <1382432923-61267-3-git-send-email-christoffer.dall@linaro.org>
 <2b4aea6fef36b2155dfdb39622760798@www.loen.fr>
Message-ID: <20131027171827.GA21180@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 03:55:16PM +0100, Marc Zyngier wrote:
> Hi Christoffer,
> 
> On 2013-10-22 10:08, Christoffer Dall wrote:
> >Support creating the ARM VGIC device through the KVM_CREATE_DEVICE
> >ioctl, which can then later be leveraged to use the
> >KVM_{GET/SET}_DEVICE_ATTR, which is useful both for setting
> >addresses in
> >a more generic API than the ARM-specific one and is useful for
> >save/restore of VGIC state.
> >
> >Adds KVM_CAP_DEVICE_CTRL to ARM capabilities.
> >
> >Note that we change the check for creating a VGIC from bailing out if
> >any VCPUs were created to bailing if any VCPUs were ever run.
> >This is
> >an important distinction that doesn't break anything, but allows
> >creating the VGIC after the VCPUs have been created.
> >
> >Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> >Reviewed-by: Alexander Graf <agraf@suse.de>
> >---
> > Documentation/virtual/kvm/devices/arm-vgic.txt |   10 ++++++
> > arch/arm/include/uapi/asm/kvm.h                |    1 -
> > arch/arm/kvm/arm.c                             |    1 +
> > include/linux/kvm_host.h                       |    1 +
> > include/uapi/linux/kvm.h                       |    1 +
> > virt/kvm/arm/vgic.c                            |   46
> >++++++++++++++++++++++--
> > virt/kvm/kvm_main.c                            |    5 +++
> > 7 files changed, 62 insertions(+), 3 deletions(-)
> > create mode 100644 Documentation/virtual/kvm/devices/arm-vgic.txt
> >
> >diff --git a/Documentation/virtual/kvm/devices/arm-vgic.txt
> >b/Documentation/virtual/kvm/devices/arm-vgic.txt
> >new file mode 100644
> >index 0000000..38f27f7
> >--- /dev/null
> >+++ b/Documentation/virtual/kvm/devices/arm-vgic.txt
> >@@ -0,0 +1,10 @@
> >+ARM Virtual Generic Interrupt Controller (VGIC)
> >+===============================================
> >+
> >+Device types supported:
> >+  KVM_DEV_TYPE_ARM_VGIC_V2     ARM Generic Interrupt Controller v2.0
> >+
> >+Only one VGIC instance may be instantiated through either this
> >API or the
> >+legacy KVM_CREATE_IRQCHIP api.  The created VGIC will act as the VM
> >interrupt
> >+controller, requiring emulated user-space devices to inject
> >interrupts to the
> >+VGIC instead of directly to CPUs.
> >diff --git a/arch/arm/include/uapi/asm/kvm.h
> >b/arch/arm/include/uapi/asm/kvm.h
> >index c1ee007..1c85102 100644
> >--- a/arch/arm/include/uapi/asm/kvm.h
> >+++ b/arch/arm/include/uapi/asm/kvm.h
> >@@ -142,7 +142,6 @@ struct kvm_arch_memory_slot {
> > #define KVM_REG_ARM_VFP_FPINST		0x1009
> > #define KVM_REG_ARM_VFP_FPINST2		0x100A
> >
> >-
> 
> Nit: pointless change?
> 
> > /* KVM_IRQ_LINE irq field index values */
> > #define KVM_ARM_IRQ_TYPE_SHIFT		24
> > #define KVM_ARM_IRQ_TYPE_MASK		0xff
> >diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> >index 2b1091a..ab96af2 100644
> >--- a/arch/arm/kvm/arm.c
> >+++ b/arch/arm/kvm/arm.c
> >@@ -187,6 +187,7 @@ int kvm_dev_ioctl_check_extension(long ext)
> > 	case KVM_CAP_IRQCHIP:
> > 		r = vgic_present;
> > 		break;
> >+	case KVM_CAP_DEVICE_CTRL:
> > 	case KVM_CAP_USER_MEMORY:
> > 	case KVM_CAP_SYNC_MMU:
> > 	case KVM_CAP_DESTROY_MEMORY_REGION_WORKS:
> >diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> >index ca645a0..2906b79 100644
> >--- a/include/linux/kvm_host.h
> >+++ b/include/linux/kvm_host.h
> >@@ -1065,6 +1065,7 @@ struct kvm_device *kvm_device_from_filp(struct
> >file *filp);
> >
> > extern struct kvm_device_ops kvm_mpic_ops;
> > extern struct kvm_device_ops kvm_xics_ops;
> >+extern struct kvm_device_ops kvm_arm_vgic_ops;
> >
> > #ifdef CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT
> >
> >diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> >index 99c2533..2d50233 100644
> >--- a/include/uapi/linux/kvm.h
> >+++ b/include/uapi/linux/kvm.h
> >@@ -843,6 +843,7 @@ struct kvm_device_attr {
> > #define KVM_DEV_TYPE_FSL_MPIC_20	1
> > #define KVM_DEV_TYPE_FSL_MPIC_42	2
> > #define KVM_DEV_TYPE_XICS		3
> >+#define KVM_DEV_TYPE_ARM_VGIC_V2	4
> 
> How about calling it GIC_V2 instead of VGIC_V2? As far as the guest
> is concerned, this is a "true" GIC, and the other names don't imply
> any distinction either...
> 

I thought about this, but we already have exported defines named
VGIC_something and we make all references in the kernel to VGIC in
documentaiton and so on, so I decided against that.  If you insist, do
you also want me to rename/create new defines for all other fields (like
KVM_VGIC_V2_ADDR_TYPE_DIST)?

> > /*
> >  * ioctls for VM fds
> >diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> >index 5ce100f..79a8bae 100644
> >--- a/virt/kvm/arm/vgic.c
> >+++ b/virt/kvm/arm/vgic.c
> >@@ -1434,15 +1434,23 @@ out:
> >
> > int kvm_vgic_create(struct kvm *kvm)
> > {
> >-	int ret = 0;
> >+	int i, ret = 0;
> >+	struct kvm_vcpu *vcpu;
> >
> > 	mutex_lock(&kvm->lock);
> >
> >-	if (atomic_read(&kvm->online_vcpus) || kvm->arch.vgic.vctrl_base) {
> >+	if (kvm->arch.vgic.vctrl_base) {
> > 		ret = -EEXIST;
> > 		goto out;
> > 	}
> >
> >+	kvm_for_each_vcpu(i, vcpu, kvm) {
> >+		if (vcpu->arch.has_run_once) {
> >+			ret = -EBUSY;
> >+			goto out;
> >+		}
> >+	}
> 
> Isn't this racy? What prevents anyone from starting a CPU while
> you're in this loop?
> 

It is indeed racy, nicely spotted!

Will fix in v3.

Thanks,
-Christoffer
