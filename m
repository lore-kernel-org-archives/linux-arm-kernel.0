From: gleb@redhat.com (Gleb Natapov)
Date: Tue, 15 Jan 2013 15:32:07 +0200
Subject: [PATCH v5 03/14] KVM: ARM: Initial skeleton to compile KVM support
In-Reply-To: <CANM98qJoOxG_g7Dz+65vfGmzi3MOXqE=AjbVBtimeqLL9TgV8w@mail.gmail.com>
References: <20130108183811.46302.58543.stgit@ubuntu>
 <20130108183855.46302.40539.stgit@ubuntu>
 <20130114184908.GB12489@redhat.com>
 <CANM98qJoOxG_g7Dz+65vfGmzi3MOXqE=AjbVBtimeqLL9TgV8w@mail.gmail.com>
Message-ID: <20130115133207.GM11529@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 05:17:31PM -0500, Christoffer Dall wrote:
> On Mon, Jan 14, 2013 at 1:49 PM, Gleb Natapov <gleb@redhat.com> wrote:
> > A couple of general question about ABI. If they were already answered
> > just refer me to the previous discussion.
> >
> > On Tue, Jan 08, 2013 at 01:38:55PM -0500, Christoffer Dall wrote:
> >> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> >> index a4df553..4237c27 100644
> >> --- a/Documentation/virtual/kvm/api.txt
> >> +++ b/Documentation/virtual/kvm/api.txt
> >> @@ -293,7 +293,7 @@ kvm_run' (see below).
> >>  4.11 KVM_GET_REGS
> >>
> >>  Capability: basic
> >> -Architectures: all
> >> +Architectures: all except ARM
> >>  Type: vcpu ioctl
> >>  Parameters: struct kvm_regs (out)
> >>  Returns: 0 on success, -1 on error
> >> @@ -314,7 +314,7 @@ struct kvm_regs {
> >>  4.12 KVM_SET_REGS
> >>
> >>  Capability: basic
> >> -Architectures: all
> >> +Architectures: all except ARM
> >>  Type: vcpu ioctl
> >>  Parameters: struct kvm_regs (in)
> >>  Returns: 0 on success, -1 on error
> >> @@ -600,7 +600,7 @@ struct kvm_fpu {
> >>  4.24 KVM_CREATE_IRQCHIP
> > Why KVM_GET_REGS/KVM_SET_REGS are not usable for arm?
> >
> 
> We use the ONE_REG API instead and we don't want to support two
> separate APIs to user space.
> 
I suppose fetching all registers is not anywhere on a fast path in
userspace :)

> >>
> >>  Capability: KVM_CAP_IRQCHIP
> >> -Architectures: x86, ia64
> >> +Architectures: x86, ia64, ARM
> >>  Type: vm ioctl
> >>  Parameters: none
> >>  Returns: 0 on success, -1 on error
> >> @@ -608,7 +608,8 @@ Returns: 0 on success, -1 on error
> >>  Creates an interrupt controller model in the kernel.  On x86, creates a virtual
> >>  ioapic, a virtual PIC (two PICs, nested), and sets up future vcpus to have a
> >>  local APIC.  IRQ routing for GSIs 0-15 is set to both PIC and IOAPIC; GSI 16-23
> >> -only go to the IOAPIC.  On ia64, a IOSAPIC is created.
> >> +only go to the IOAPIC.  On ia64, a IOSAPIC is created. On ARM, a GIC is
> >> +created.
> >>
> >>
> >>  4.25 KVM_IRQ_LINE
> >> @@ -1775,6 +1776,14 @@ registers, find a list below:
> >>    PPC   | KVM_REG_PPC_VPA_DTL   | 128
> >>    PPC   | KVM_REG_PPC_EPCR   | 32
> >>
> >> +ARM registers are mapped using the lower 32 bits.  The upper 16 of that
> >> +is the register group type, or coprocessor number:
> >> +
> >> +ARM core registers have the following id bit patterns:
> >> +  0x4002 0000 0010 <index into the kvm_regs struct:16>
> >> +
> >> +
> >> +
> >>  4.69 KVM_GET_ONE_REG
> >>
> >>  Capability: KVM_CAP_ONE_REG
> >> @@ -2127,6 +2136,46 @@ written, then `n_invalid' invalid entries, invalidating any previously
> >>  valid entries found.
> >>
> >>
> >> +4.77 KVM_ARM_VCPU_INIT
> >> +
> >> +Capability: basic
> >> +Architectures: arm
> >> +Type: vcpu ioctl
> >> +Parameters: struct struct kvm_vcpu_init (in)
> >> +Returns: 0 on success; -1 on error
> >> +Errors:
> >> +  EINVAL:    the target is unknown, or the combination of features is invalid.
> >> +  ENOENT:    a features bit specified is unknown.
> >> +
> >> +This tells KVM what type of CPU to present to the guest, and what
> >> +optional features it should have.  This will cause a reset of the cpu
> >> +registers to their initial values.  If this is not called, KVM_RUN will
> >> +return ENOEXEC for that vcpu.
> >> +
> > Can different vcpus of the same VM be of different type?
> >
> 
> In the future yes. For example, if we ever want to virtualize a
> Big.Little system.
> 
> >> +Note that because some registers reflect machine topology, all vcpus
> >> +should be created before this ioctl is invoked.
> > How cpu hot plug suppose to work?
> >
> 
> Those CPUs would be added from the beginning, but not powered on, and
> would be powered on later on, I suppose.  See
> https://lists.cs.columbia.edu/pipermail/kvmarm/2013-January/004617.html.
> 
When we suggested similar "hot plug" for x86, people started screaming
how they suppose to know when they create a VM how much vcpus they will
need in the future. In short people who are asking for hot plug (on x86
at least) do not like such solution.

> 
> >> +
> >> +
> >> +4.78 KVM_GET_REG_LIST
> >> +
> >> +Capability: basic
> >> +Architectures: arm
> >> +Type: vcpu ioctl
> >> +Parameters: struct kvm_reg_list (in/out)
> >> +Returns: 0 on success; -1 on error
> >> +Errors:
> >> +  E2BIG:     the reg index list is too big to fit in the array specified by
> >> +             the user (the number required will be written into n).
> >> +
> >> +struct kvm_reg_list {
> >> +     __u64 n; /* number of registers in reg[] */
> >> +     __u64 reg[0];
> >> +};
> >> +
> >> +This ioctl returns the guest registers that are supported for the
> >> +KVM_GET_ONE_REG/KVM_SET_ONE_REG calls.
> >> +
> >> +
> > Doesn't userspace know what registers are supported by each CPU type?
> >
> It would know about core registers, but there is a huge space of
> co-processors, and we don't emulate all of them or support
> getting/setting all of them yet. Surely this is something that will
> change over time and we want user space to be able to discover the
> available registers for backwards compatibility, migration, etc.
> 
> -Christoffer

--
			Gleb.
