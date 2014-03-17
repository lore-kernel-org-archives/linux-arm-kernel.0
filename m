From: anup@brainfault.org (Anup Patel)
Date: Mon, 17 Mar 2014 12:24:28 +0530
Subject: [PATCH v4 10/10] ARM/ARM64: KVM: Emulate PSCI v0.2 CPU_SUSPEND
In-Reply-To: <20140317034130.GK20648@cbox>
References: <1391686302-19451-1-git-send-email-anup.patel@linaro.org>
 <1391686302-19451-11-git-send-email-anup.patel@linaro.org>
 <20140317034130.GK20648@cbox>
Message-ID: <CAAhSdy3kbafDc=T0dYHpULKoGKxAner+zY1vdLDDyU1JrqD2tQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 17, 2014 at 9:11 AM, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> On Thu, Feb 06, 2014 at 05:01:42PM +0530, Anup Patel wrote:
>> This patch adds emulation of PSCI v0.2 CPU_SUSPEND function call for
>> KVM ARM/ARM64. This is a VCPU-level function call which can suspend
>> current VCPU or all VCPUs within current VCPU's affinity level.
>>
>> The CPU_SUSPEND emulation is not tested much because currently there
>> is no CPUIDLE driver in Linux kernel that uses PSCI CPU_SUSPEND. The
>> PSCI CPU_SUSPEND implementation in ARM64 kernel was tested using a
>> Simple CPUIDLE driver which is not published due to unstable DT-bindings
>> for PSCI.
>> (For more info, http://lwn.net/Articles/574950/)
>>
>> Even if we had stable DT-bindings for PSCI and CPUIDLE driver that
>> uses PSCI CPU_SUSPEND then still we need to define SUSPEND states
>> for KVM ARM/ARM64. Due to this, the CPU_SUSPEND emulation added
>> by this patch only pause a VCPU and to wakeup a VCPU we need to
>> explicity call PSCI CPU_ON from Guest.
>>
>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>> ---
>>  arch/arm/include/asm/kvm_host.h   |    5 +++
>>  arch/arm/include/asm/kvm_psci.h   |    1 +
>>  arch/arm/kvm/psci.c               |   88 +++++++++++++++++++++++++++++++++++--
>>  arch/arm/kvm/reset.c              |    4 ++
>>  arch/arm64/include/asm/kvm_host.h |    5 +++
>>  arch/arm64/include/asm/kvm_psci.h |    1 +
>>  arch/arm64/kvm/reset.c            |    4 ++
>>  7 files changed, 104 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
>> index 193ceaf..2cc36a6 100644
>> --- a/arch/arm/include/asm/kvm_host.h
>> +++ b/arch/arm/include/asm/kvm_host.h
>> @@ -131,6 +131,11 @@ struct kvm_vcpu_arch {
>>       /* Don't run the guest on this vcpu */
>>       bool pause;
>>
>> +     /* PSCI suspend state */
>> +     bool suspend;
>> +     u32 suspend_entry;
>> +     u32 suspend_context_id;
>> +
>>       /* IO related fields */
>>       struct kvm_decode mmio_decode;
>>
>> diff --git a/arch/arm/include/asm/kvm_psci.h b/arch/arm/include/asm/kvm_psci.h
>> index 6bda945..6a05ada 100644
>> --- a/arch/arm/include/asm/kvm_psci.h
>> +++ b/arch/arm/include/asm/kvm_psci.h
>> @@ -22,6 +22,7 @@
>>  #define KVM_ARM_PSCI_0_2     2
>>
>>  int kvm_psci_version(struct kvm_vcpu *vcpu);
>> +void kvm_psci_reset(struct kvm_vcpu *vcpu);
>>  int kvm_psci_call(struct kvm_vcpu *vcpu);
>>
>>  #endif /* __ARM_KVM_PSCI_H__ */
>> diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
>> index 675866e..482b0f6 100644
>> --- a/arch/arm/kvm/psci.c
>> +++ b/arch/arm/kvm/psci.c
>> @@ -15,6 +15,7 @@
>>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>>   */
>>
>> +#include <linux/smp.h>
>>  #include <linux/kvm_host.h>
>>  #include <linux/wait.h>
>>
>> @@ -27,9 +28,81 @@
>>   * as described in ARM document number ARM DEN 0022A.
>>   */
>>
>> +struct psci_suspend_info {
>> +     struct kvm_vcpu *vcpu;
>> +     unsigned long saved_entry;
>> +     unsigned long saved_context_id;
>> +};
>> +
>> +static void psci_do_suspend(void *context)
>> +{
>> +     struct psci_suspend_info *sinfo = context;
>> +
>> +     sinfo->vcpu->arch.pause = true;
>> +     sinfo->vcpu->arch.suspend = true;
>> +     sinfo->vcpu->arch.suspend_entry = sinfo->saved_entry;
>> +     sinfo->vcpu->arch.suspend_context_id = sinfo->saved_context_id;
>
> I don't really understand this, why are you not just setting pause =
> true and modifying the registers as per the reentry rules in the spec?
>
> Doesn't seem like this patch ever reads any of these values back?

Thats because we don't have any wake-up events defined for PSCI v0.2
emulated by KVM.

>
>> +}
>> +
>> +static unsigned long kvm_psci_vcpu_suspend(struct kvm_vcpu *vcpu)
>> +{
>> +     int i;
>> +     unsigned long mpidr;
>> +     unsigned long target_affinity;
>> +     unsigned long target_affinity_mask;
>> +     unsigned long lowest_affinity_level;
>> +     struct kvm *kvm = vcpu->kvm;
>> +     struct kvm_vcpu *tmp;
>> +     struct psci_suspend_info sinfo;
>> +
>> +     target_affinity = kvm_vcpu_get_mpidr(vcpu);
>> +     lowest_affinity_level = (*vcpu_reg(vcpu, 1) >> 24) & 0x3;
>> +
>> +     /* Determine target affinity mask */
>> +     target_affinity_mask = MPIDR_HWID_BITMASK;
>> +     switch (lowest_affinity_level) {
>> +     case 0: /* All affinity levels are valid */
>> +             target_affinity_mask &= ~0x0UL;
>> +             break;
>> +     case 1: /* Aff0 ignored */
>> +             target_affinity_mask &= ~0xFFUL;
>> +             break;
>> +     case 2: /* Aff0 and Aff1 ignored */
>> +             target_affinity_mask &= ~0xFFFFUL;
>> +             break;
>> +     case 3: /* Aff0, Aff1, and Aff2 ignored */
>> +             target_affinity_mask &= ~0xFFFFFFUL;
>> +             break;
>> +     default:
>> +             return KVM_PSCI_RET_INVAL;
>> +     };
>
> I feel like I've read this code before, can you factor it out?

OK, I will factor-out this portion since it can be shared
with AFFINTIY_INFO emulation.

>
>> +
>> +     /* Ignore other bits of target affinity */
>> +     target_affinity &= target_affinity_mask;
>> +
>> +     /* Prepare suspend info */
>> +     sinfo.vcpu = NULL;
>> +     sinfo.saved_entry = *vcpu_reg(vcpu, 2);
>> +     sinfo.saved_context_id = *vcpu_reg(vcpu, 3);
>> +
>> +     /* Suspend all VCPUs within target affinity */
>> +     kvm_for_each_vcpu(i, tmp, kvm) {
>> +             mpidr = kvm_vcpu_get_mpidr(tmp);
>> +             if (((mpidr & target_affinity_mask) == target_affinity) &&
>> +                 !tmp->arch.suspend) {
>> +                     sinfo.vcpu = tmp;
>> +                     smp_call_function_single(tmp->cpu,
>> +                                              psci_do_suspend, &sinfo, 1);
>
> Hmmm, are you sure this is correct?  How does that correspond to the
> PSCI docs saying
>
> "It is only possible to call CPU_SUSPEND from the current core. That is,
> it is not possible to request suspension of another core."
>
> I would think this means, if all other cores in the specified affinity
> level are already suspended, allow suspending the entire
> cluster/group/..., but I may be wrong.

Actually, CPU_SUSPEND is for all cores belonging to affinity
of current core.

>
> My comments above notwithstanding, this also feels racy.  What happens
> if two virtual cores within the same affinity level calls CPU_SUSPEND at
> the same time?

Yes, I know its racy. I was expecting this comment.

What would be appropriate lock to protect per-VCPU suspend context?

I think spinlock would be better because psci_do_suspend() is called
using SMP IPIs.

>
> Also, there doesn't seem to be any handling of the StateType requested
> by the caller, the reentry behavior is very different depending on the
> state you enter, unless you always treat the request as a suspend
> (clause 3 under Section 5.4.2 in the PSCI spec), in that case that
> deserves a comment.

The StateType is completely implementation dependent. Also, it is the
StateType that will help determine the wake-up event.

For KVM, we really don't have any StateType defined hence we don't
have any wake-up events defined for KVM PSCI.

Should we have KVM specific suspend states?
What would KVM suspend states look like because suspend states
are platform specific?

--
Anup

>
>> +             }
>> +     }
>> +
>> +     return KVM_PSCI_RET_SUCCESS;
>> +}
>> +
>>  static void kvm_psci_vcpu_off(struct kvm_vcpu *vcpu)
>>  {
>>       vcpu->arch.pause = true;
>> +     vcpu->arch.suspend = false;
>>  }
>>
>>  static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu,
>> @@ -179,6 +252,10 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
>>                */
>>               val = 2;
>>               break;
>> +     case KVM_PSCI_0_2_FN_CPU_SUSPEND:
>> +     case KVM_PSCI_0_2_FN64_CPU_SUSPEND:
>> +             val = kvm_psci_vcpu_suspend(vcpu);
>> +             break;
>>       case KVM_PSCI_0_2_FN_CPU_OFF:
>>               kvm_psci_vcpu_off(vcpu);
>>               val = KVM_PSCI_RET_SUCCESS;
>> @@ -216,10 +293,6 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
>>               val = KVM_PSCI_RET_SUCCESS;
>>               ret = 0;
>>               break;
>> -     case KVM_PSCI_0_2_FN_CPU_SUSPEND:
>> -     case KVM_PSCI_0_2_FN64_CPU_SUSPEND:
>> -             val = KVM_PSCI_RET_NI;
>> -             break;
>>       default:
>>               return -EINVAL;
>>       }
>> @@ -253,6 +326,13 @@ static int kvm_psci_0_1_call(struct kvm_vcpu *vcpu)
>>       return 1;
>>  }
>>
>> +void kvm_psci_reset(struct kvm_vcpu *vcpu)
>> +{
>> +     vcpu->arch.suspend = false;
>> +     vcpu->arch.suspend_entry = 0;
>> +     vcpu->arch.suspend_context_id = 0;
>> +}
>> +
>>  /**
>>   * kvm_psci_call - handle PSCI call if r0 value is in range
>>   * @vcpu: Pointer to the VCPU struct
>> diff --git a/arch/arm/kvm/reset.c b/arch/arm/kvm/reset.c
>> index f558c07..220c892 100644
>> --- a/arch/arm/kvm/reset.c
>> +++ b/arch/arm/kvm/reset.c
>> @@ -26,6 +26,7 @@
>>  #include <asm/cputype.h>
>>  #include <asm/kvm_arm.h>
>>  #include <asm/kvm_coproc.h>
>> +#include <asm/kvm_psci.h>
>>
>>  #include <kvm/arm_arch_timer.h>
>>
>> @@ -79,5 +80,8 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>>       /* Reset arch_timer context */
>>       kvm_timer_vcpu_reset(vcpu, cpu_vtimer_irq);
>>
>> +     /* Reset PSCI state */
>> +     kvm_psci_reset(vcpu);
>> +
>>       return 0;
>>  }
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index 92242ce..b2c97dc 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -119,6 +119,11 @@ struct kvm_vcpu_arch {
>>       /* Don't run the guest */
>>       bool pause;
>>
>> +     /* PSCI suspend state */
>> +     bool suspend;
>> +     u64 suspend_entry;
>> +     u64 suspend_context_id;
>> +
>>       /* IO related fields */
>>       struct kvm_decode mmio_decode;
>>
>> diff --git a/arch/arm64/include/asm/kvm_psci.h b/arch/arm64/include/asm/kvm_psci.h
>> index bc39e55..4da675d 100644
>> --- a/arch/arm64/include/asm/kvm_psci.h
>> +++ b/arch/arm64/include/asm/kvm_psci.h
>> @@ -22,6 +22,7 @@
>>  #define KVM_ARM_PSCI_0_2     2
>>
>>  int kvm_psci_version(struct kvm_vcpu *vcpu);
>> +void kvm_psci_reset(struct kvm_vcpu *vcpu);
>>  int kvm_psci_call(struct kvm_vcpu *vcpu);
>>
>>  #endif /* __ARM64_KVM_PSCI_H__ */
>> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
>> index 70a7816..aca9f65 100644
>> --- a/arch/arm64/kvm/reset.c
>> +++ b/arch/arm64/kvm/reset.c
>> @@ -29,6 +29,7 @@
>>  #include <asm/ptrace.h>
>>  #include <asm/kvm_arm.h>
>>  #include <asm/kvm_coproc.h>
>> +#include <asm/kvm_psci.h>
>>
>>  /*
>>   * ARMv8 Reset Values
>> @@ -108,5 +109,8 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>>       /* Reset timer */
>>       kvm_timer_vcpu_reset(vcpu, cpu_vtimer_irq);
>>
>> +     /* Reset PSCI state */
>> +     kvm_psci_reset(vcpu);
>> +
>>       return 0;
>>  }
>> --
>> 1.7.9.5
>>
>
> Thanks,
> --
> Christoffer
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
