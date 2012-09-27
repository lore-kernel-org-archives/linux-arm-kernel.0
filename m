From: will.deacon@arm.com (Will Deacon)
Date: Thu, 27 Sep 2012 15:13:14 +0100
Subject: [PATCH 06/15] KVM: ARM: Initial skeleton to compile KVM support
In-Reply-To: <50625DB2.4000700@virtualopensystems.com>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153508.21241.47712.stgit@ubuntu>
 <20120925152055.GC28728@mudshark.cambridge.arm.com>
 <50625DB2.4000700@virtualopensystems.com>
Message-ID: <20120927141314.GK25916@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 26, 2012 at 02:43:14AM +0100, Christoffer Dall wrote:
> On 09/25/2012 11:20 AM, Will Deacon wrote:
> >> +/* Multiprocessor Affinity Register */
> >> +#define MPIDR_CPUID    (0x3 << 0)
> >
> > I'm fairly sure we already have code under arch/arm/ for dealing with the
> > mpidr. Let's re-use that rather than reinventing it here.
> >
>
> I see some defines in topology.c - do you want some of these factored
> out into a header file that we can then also use from kvm? If so, where?

I guess either in topology.h or a new header (topology-bits.h).

> >> +#define EXCEPTION_NONE      0
> >> +#define EXCEPTION_RESET     0x80
> >> +#define EXCEPTION_UNDEFINED 0x40
> >> +#define EXCEPTION_SOFTWARE  0x20
> >> +#define EXCEPTION_PREFETCH  0x10
> >> +#define EXCEPTION_DATA      0x08
> >> +#define EXCEPTION_IMPRECISE 0x04
> >> +#define EXCEPTION_IRQ       0x02
> >> +#define EXCEPTION_FIQ       0x01
> >
> > Why the noise?
> >
>
> these are simply cruft from a previous life of KVM/ARM.

Ok, then please get rid of them.

> >> +static inline enum vcpu_mode vcpu_mode(struct kvm_vcpu *vcpu)
> >> +{
> >> +       u8 mode = __vcpu_mode(vcpu->arch.regs.cpsr);
> >> +       BUG_ON(mode == 0xf);
> >> +       return mode;
> >> +}
> >
> > I noticed that you have a fair few BUG_ONs throughout the series. Fair
> > enough, but for hyp code is that really the right thing to do? Killing the
> > guest could make more sense, perhaps?
>
> the idea is to have BUG_ONs that are indeed BUG_ONs that we want to
> catch explicitly on the host. We have had a pass over the code to change
> all the BUG_ONs that can be provoked by the guest and inject the proper
> exceptions into the guest in this case. If you find places where this is
> not the case, it should be changed, and do let me know.

Ok, so are you saying that a BUG_ON due to some detected inconsistency with
one guest may not necessarily terminate the other guests? BUG_ONs in the
host seem like a bad idea if the host is able to continue with a subset of
guests.

> >
> >> +static inline u32 *vcpu_pc(struct kvm_vcpu *vcpu)
> >> +{
> >> +       return vcpu_reg(vcpu, 15);
> >> +}
> >
> > If you stick a struct pt_regs into struct kvm_regs, you could reuse ARM_pc
> > here etc.
> >
>
> I prefer not to, because we'd have those registers presumably for usr
> mode and then we only define the others explicit. I think it's much
> clearer to look at kvm_regs today.

I disagree and think that you should reuse as much of the arch/arm/ code as
possible. Not only does it make it easier to read by people who are familiar
with that code (and in turn get you more reviewers) but it also means that
we limit the amount of duplication that we have.

I think Marc (CC'd) had a go at this with some success.

> >> +#ifndef __ARM_KVM_HOST_H__
> >> +#define __ARM_KVM_HOST_H__
> >> +
> >> +#include <asm/kvm.h>
> >> +
> >> +#define KVM_MAX_VCPUS 4
> >
> > NR_CPUS?
> >
>
> well this is defined by KVM generic code, and is common for other
> architecture.

I mean #define KVM_MAX_CPUS NR_CPUS. The 4 seems arbitrary.

> >> +int __attribute_const__ kvm_target_cpu(void)
> >> +{
> >> +       unsigned int midr;
> >> +
> >> +       midr = read_cpuid_id();
> >> +       switch ((midr >> 4) & 0xfff) {
> >> +       case KVM_ARM_TARGET_CORTEX_A15:
> >> +               return KVM_ARM_TARGET_CORTEX_A15;
> >
> > I have this code already in perf_event.c. Can we move it somewhere common
> > and share it? You should also check that the implementor field is 0x41.
> >
>
> by all means, you can probably suggest a good place better than I can...

cputype.h?

> >> +#include <linux/module.h>
> >> +
> >> +EXPORT_SYMBOL_GPL(smp_send_reschedule);
> >
> > Erm...
> >
> > We already have arch/arm/kernel/armksyms.c for exports -- please use that.
> > However, exporting such low-level operations sounds like a bad idea. How
> > realistic is kvm-as-a-module on ARM anyway?
> >
>
> at this point it's broken, so I'll just remove this and leave this for a
> fun project for some poor soul at some point if anyone ever needs half
> the code outside the kernel as a module (the other half needs to be
> compiled in anyway)

Ok, that suits me. If it's broken, let's not include it in the initial
submission.

> >> +int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
> >> +{
> >> +       return -EINVAL;
> >> +}
> >> +
> >> +int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
> >> +{
> >> +       return -EINVAL;
> >> +}
> >
> > Again, all looks like this should be implemented using regsets from what I
> > can tell.
> >
>
> this API has been discussed to death on the KVM lists, and we can of
> course revive that if the regset makes it nicer - I'd prefer getting
> this upstream the way that it is now though, where GET_REG / SET_REG
> seems to be the way forward from a KVM perspective.

I'm sure the API has been discussed, but I've not seen that conversation and
I'm also not aware about whether or not regsets were considered as a
possibility for this stuff. The advantages of using them are:

	1. It's less code for the arch to implement (and most of what you
	need, you already have).

	2. You can move the actual copying code into core KVM, like we have
	for ptrace.

	3. New KVM ports (e.g. arm64) can reuse the core copying code
	easily.

Furthermore, some registers (typically) floating point and GPRs will already
have regsets for the ptrace code, so that can be reused if you share the
datatypes.

The big problem with getting things upstream and then changing it later is
that you will break the ABI. I highly doubt that's feasible, so can we not
just use regsets from the start for ARM?

> >> +int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
> >> +{
> >> +       struct kvm_regs *cpu_reset;
> >> +
> >> +       switch (vcpu->arch.target) {
> >> +       case KVM_ARM_TARGET_CORTEX_A15:
> >> +               if (vcpu->vcpu_id > a15_max_cpu_idx)
> >> +                       return -EINVAL;
> >> +               cpu_reset = &a15_regs_reset;
> >> +               vcpu->arch.midr = read_cpuid_id();
> >> +               break;
> >> +       default:
> >> +               return -ENODEV;
> >> +       }
> >> +
> >> +       /* Reset core registers */
> >> +       memcpy(&vcpu->arch.regs, cpu_reset, sizeof(vcpu->arch.regs));
> >> +
> >> +       /* Reset CP15 registers */
> >> +       kvm_reset_coprocs(vcpu);
> >> +
> >> +       return 0;
> >> +}
> >
> > This is a nice way to plug in new CPUs but the way the rest of the code is
> > currently written, all the ARMv7 and Cortex-A15 code is merged together. I
> > *strongly* suggest you isolate this from the start, as it will help you see
> > what is architected and what is implementation-specific.
> >
>
> not entirely sure what you mean. You want a separate coproc.c file for
> Cortex-A15 specific stuff like coproc_a15.c?

Indeed. I think it will make adding new CPUs a lot clearer and separate the
architecture from the implementation.

Cheers,

Will
