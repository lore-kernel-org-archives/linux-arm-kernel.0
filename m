From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Thu, 4 Oct 2012 09:35:03 -0400
Subject: [PATCH 06/15] KVM: ARM: Initial skeleton to compile KVM support
In-Reply-To: <000301cda230$91eb4fa0$b5c1eee0$@samsung.com>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153508.21241.47712.stgit@ubuntu>
 <20120925152055.GC28728@mudshark.cambridge.arm.com>
 <50625DB2.4000700@virtualopensystems.com>
 <20120927141314.GK25916@mudshark.cambridge.arm.com>
 <CANM98qKidvG_sOHM197F+1EDtEFTGnLksCJo=12T36JE3u6R4w@mail.gmail.com>
 <000301cda230$91eb4fa0$b5c1eee0$@samsung.com>
Message-ID: <CANM98q+16g6-aQh6geuK+erB6aGCbzVXqax_MNJ9u+cbjX+RGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 4, 2012 at 9:02 AM, Min-gyu Kim <mingyu84.kim@samsung.com> wrote:
>
>
>> -----Original Message-----
>> From: kvm-owner at vger.kernel.org [mailto:kvm-owner at vger.kernel.org] On
>> Behalf Of Christoffer Dall
>> Sent: Monday, October 01, 2012 4:22 AM
>> To: Will Deacon
>> Cc: kvm at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>> kvmarm at lists.cs.columbia.edu; rusty.russell at linaro.org; avi at redhat.com;
>> marc.zyngier at arm.com
>> Subject: Re: [PATCH 06/15] KVM: ARM: Initial skeleton to compile KVM
>> support
>>
>> On Thu, Sep 27, 2012 at 10:13 AM, Will Deacon <will.deacon@arm.com> wrote:
>> > On Wed, Sep 26, 2012 at 02:43:14AM +0100, Christoffer Dall wrote:
>> >> On 09/25/2012 11:20 AM, Will Deacon wrote:
>> >> >> +/* Multiprocessor Affinity Register */
>> >> >> +#define MPIDR_CPUID    (0x3 << 0)
>> >> >
>> >> > I'm fairly sure we already have code under arch/arm/ for dealing
>> >> > with the mpidr. Let's re-use that rather than reinventing it here.
>> >> >
>> >>
>> >> I see some defines in topology.c - do you want some of these factored
>> >> out into a header file that we can then also use from kvm? If so,
> where?
>> >
>> > I guess either in topology.h or a new header (topology-bits.h).
>> >
>> >> >> +#define EXCEPTION_NONE      0
>> >> >> +#define EXCEPTION_RESET     0x80
>> >> >> +#define EXCEPTION_UNDEFINED 0x40
>> >> >> +#define EXCEPTION_SOFTWARE  0x20
>> >> >> +#define EXCEPTION_PREFETCH  0x10
>> >> >> +#define EXCEPTION_DATA      0x08
>> >> >> +#define EXCEPTION_IMPRECISE 0x04
>> >> >> +#define EXCEPTION_IRQ       0x02
>> >> >> +#define EXCEPTION_FIQ       0x01
>> >> >
>> >> > Why the noise?
>> >> >
>> >>
>> >> these are simply cruft from a previous life of KVM/ARM.
>> >
>> > Ok, then please get rid of them.
>> >
>> >> >> +static inline enum vcpu_mode vcpu_mode(struct kvm_vcpu *vcpu) {
>> >> >> +       u8 mode = __vcpu_mode(vcpu->arch.regs.cpsr);
>> >> >> +       BUG_ON(mode == 0xf);
>> >> >> +       return mode;
>> >> >> +}
>> >> >
>> >> > I noticed that you have a fair few BUG_ONs throughout the series.
>> >> > Fair enough, but for hyp code is that really the right thing to do?
>> >> > Killing the guest could make more sense, perhaps?
>> >>
>> >> the idea is to have BUG_ONs that are indeed BUG_ONs that we want to
>> >> catch explicitly on the host. We have had a pass over the code to
>> >> change all the BUG_ONs that can be provoked by the guest and inject
>> >> the proper exceptions into the guest in this case. If you find places
>> >> where this is not the case, it should be changed, and do let me know.
>> >
>> > Ok, so are you saying that a BUG_ON due to some detected inconsistency
>> > with one guest may not necessarily terminate the other guests? BUG_ONs
>> > in the host seem like a bad idea if the host is able to continue with
>> > a subset of guests.
>> >
>>
>> No, I'm saying a BUG_ON is an actual BUG, it should not happen and there
>> should be nowhere where a guest can cause a BUG_ON to occur in the host,
>> because that would be a bug.
>>
>> We basically never kill a guest unless really extreme things happen (like
>> we cannot allocate a pte, in which case we return -ENOMEM). If a guest
>> does something really weird, that guest will receive the appropriate
>> exception (undefined, prefetch abort, ...)
>>
>
> I agree with Will. It seems to be overreacting to kill the entire system.
>
> From the code above, BUG_ON case clearly points out that there happened a
> serious bug case. However, killing the corresponding VM may not cause any
> further problem.
> Then leave some logs for debugging and killing the VM seems to be enough.
>
> Let's assume KVM for ARM is distributed with a critical bug.
> If the case is defended by BUG_ON, it will cause host to shutdown.
> If the case is defended by killing VM, it will cause VM to shutdown.
> In my opinion, latter case seems to be better.
>
> I looked for a guide on BUG_ON and found this:
>      http://yarchive.net/comp/linux/BUG.html
>
>

I completely agree with all this, no further argument is needed. The
point of a BUG_ON is to explicitly state the reason for a bug that
will anyhow cause the host kernel to overall malfunction. The above
bug_on statement is long gone (see new patches), and if you see other
cases like this, the code should have been tested and we can remove
the BUG_ON.

>> >> >
>> >> >> +static inline u32 *vcpu_pc(struct kvm_vcpu *vcpu) {
>> >> >> +       return vcpu_reg(vcpu, 15); }
>> >> >
>> >> > If you stick a struct pt_regs into struct kvm_regs, you could reuse
>> >> > ARM_pc here etc.
>> >> >
>> >>
>> >> I prefer not to, because we'd have those registers presumably for usr
>> >> mode and then we only define the others explicit. I think it's much
>> >> clearer to look at kvm_regs today.
>> >
>> > I disagree and think that you should reuse as much of the arch/arm/
>> > code as possible. Not only does it make it easier to read by people
>> > who are familiar with that code (and in turn get you more reviewers)
>> > but it also means that we limit the amount of duplication that we have.
>>
>> Reusing a struct just for the sake of reusing is not necessarily an
>> improvement. Some times it complicates things, and some times it's
>> misleading. To me, pt_regs carry the meaning that these are the registers
>> for a user space process that traps into the kernel - in KVM we emulate a
>> virtual CPU and that current definition is quite clear.
>>
>> The argument that more people will review the code if the struct contains
>> a pt_regs field rather than a usr_regs field is completely invalid,
>> because I'm sure everyone that reviews virtualization code will know that
>> user mode is a mode on the cpu and it has some registers and this is the
>> state we store when we context switch a VM - pt_regs could be read as the
>> regs that we stored in the mode that the VM happened to be in when we took
>> an exception, which I would think is crazy, and probably not what you
>> suggest.
>>
>> Writing the literal 15 for the PC register is not really a problem in
>> terms of duplication - it's nothing that requires separate maintenance.
>>
>> At this point the priority should really be correctness, readability, and
>> performance, imho.
>>
>> >
>> > I think Marc (CC'd) had a go at this with some success.
>> >
>>
>> great, if this improves the code, then I suggest someone rebases an
>> appropriate patch and sends it to the kvmarm mailing list so we can have a
>> look at it, but there are users out there looking to try kvm/arm and we
>> should try to give it to them.
>>
>> >> >> +#ifndef __ARM_KVM_HOST_H__
>> >> >> +#define __ARM_KVM_HOST_H__
>> >> >> +
>> >> >> +#include <asm/kvm.h>
>> >> >> +
>> >> >> +#define KVM_MAX_VCPUS 4
>> >> >
>> >> > NR_CPUS?
>> >> >
>> >>
>> >> well this is defined by KVM generic code, and is common for other
>> >> architecture.
>> >
>> > I mean #define KVM_MAX_CPUS NR_CPUS. The 4 seems arbitrary.
>> >
>> >> >> +int __attribute_const__ kvm_target_cpu(void) {
>> >> >> +       unsigned int midr;
>> >> >> +
>> >> >> +       midr = read_cpuid_id();
>> >> >> +       switch ((midr >> 4) & 0xfff) {
>> >> >> +       case KVM_ARM_TARGET_CORTEX_A15:
>> >> >> +               return KVM_ARM_TARGET_CORTEX_A15;
>> >> >
>> >> > I have this code already in perf_event.c. Can we move it somewhere
>> >> > common and share it? You should also check that the implementor field
>> is 0x41.
>> >> >
>> >>
>> >> by all means, you can probably suggest a good place better than I
> can...
>> >
>> > cputype.h?
>> >
>> >> >> +#include <linux/module.h>
>> >> >> +
>> >> >> +EXPORT_SYMBOL_GPL(smp_send_reschedule);
>> >> >
>> >> > Erm...
>> >> >
>> >> > We already have arch/arm/kernel/armksyms.c for exports -- please use
>> that.
>> >> > However, exporting such low-level operations sounds like a bad
>> >> > idea. How realistic is kvm-as-a-module on ARM anyway?
>> >> >
>> >>
>> >> at this point it's broken, so I'll just remove this and leave this
>> >> for a fun project for some poor soul at some point if anyone ever
>> >> needs half the code outside the kernel as a module (the other half
>> >> needs to be compiled in anyway)
>> >
>> > Ok, that suits me. If it's broken, let's not include it in the initial
>> > submission.
>> >
>> >> >> +int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct
>> >> >> +kvm_regs *regs) {
>> >> >> +       return -EINVAL;
>> >> >> +}
>> >> >> +
>> >> >> +int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct
>> >> >> +kvm_regs *regs) {
>> >> >> +       return -EINVAL;
>> >> >> +}
>> >> >
>> >> > Again, all looks like this should be implemented using regsets from
>> >> > what I can tell.
>> >> >
>> >>
>> >> this API has been discussed to death on the KVM lists, and we can of
>> >> course revive that if the regset makes it nicer - I'd prefer getting
>> >> this upstream the way that it is now though, where GET_REG / SET_REG
>> >> seems to be the way forward from a KVM perspective.
>> >
>> > I'm sure the API has been discussed, but I've not seen that
>> > conversation and I'm also not aware about whether or not regsets were
>> > considered as a possibility for this stuff. The advantages of using them
>> are:
>> >
>> >         1. It's less code for the arch to implement (and most of what
> you
>> >         need, you already have).
>> >
>> >         2. You can move the actual copying code into core KVM, like we
>> have
>> >         for ptrace.
>> >
>> >         3. New KVM ports (e.g. arm64) can reuse the core copying code
>> >         easily.
>> >
>> > Furthermore, some registers (typically) floating point and GPRs will
>> > already have regsets for the ptrace code, so that can be reused if you
>> > share the datatypes.
>> >
>> > The big problem with getting things upstream and then changing it
>> > later is that you will break the ABI. I highly doubt that's feasible,
>> > so can we not just use regsets from the start for ARM?
>> >
>> >> >> +int kvm_reset_vcpu(struct kvm_vcpu *vcpu) {
>> >> >> +       struct kvm_regs *cpu_reset;
>> >> >> +
>> >> >> +       switch (vcpu->arch.target) {
>> >> >> +       case KVM_ARM_TARGET_CORTEX_A15:
>> >> >> +               if (vcpu->vcpu_id > a15_max_cpu_idx)
>> >> >> +                       return -EINVAL;
>> >> >> +               cpu_reset = &a15_regs_reset;
>> >> >> +               vcpu->arch.midr = read_cpuid_id();
>> >> >> +               break;
>> >> >> +       default:
>> >> >> +               return -ENODEV;
>> >> >> +       }
>> >> >> +
>> >> >> +       /* Reset core registers */
>> >> >> +       memcpy(&vcpu->arch.regs, cpu_reset,
>> >> >> + sizeof(vcpu->arch.regs));
>> >> >> +
>> >> >> +       /* Reset CP15 registers */
>> >> >> +       kvm_reset_coprocs(vcpu);
>> >> >> +
>> >> >> +       return 0;
>> >> >> +}
>> >> >
>> >> > This is a nice way to plug in new CPUs but the way the rest of the
>> >> > code is currently written, all the ARMv7 and Cortex-A15 code is
>> >> > merged together. I
>> >> > *strongly* suggest you isolate this from the start, as it will help
>> >> > you see what is architected and what is implementation-specific.
>> >> >
>> >>
>> >> not entirely sure what you mean. You want a separate coproc.c file
>> >> for
>> >> Cortex-A15 specific stuff like coproc_a15.c?
>> >
>> > Indeed. I think it will make adding new CPUs a lot clearer and
>> > separate the architecture from the implementation.
>> >
>> > Cheers,
>> >
>> > Will
>> --
>> To unsubscribe from this list: send the line "unsubscribe kvm" in the body
>> of a message to majordomo at vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
>
