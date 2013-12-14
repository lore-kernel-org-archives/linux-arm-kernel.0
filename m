From: anup@brainfault.org (Anup Patel)
Date: Sat, 14 Dec 2013 18:54:58 +0530
Subject: [PATCH v2 2/2] ARM/ARM64: KVM: Forward PSCI SYSTEM_OFF and
 SYSTEM_RESET to user space
In-Reply-To: <20131213200834.GB2871@cbox>
References: <1386864747-29006-1-git-send-email-anup.patel@linaro.org>
 <1386864747-29006-6-git-send-email-anup.patel@linaro.org>
 <20131213200834.GB2871@cbox>
Message-ID: <CAAhSdy1KbPZ+6Kyfq4E+cZ=Lu=JVFadVh2ysWU1kZ4B4urkWPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 14, 2013 at 1:38 AM, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> On Thu, Dec 12, 2013 at 09:42:27PM +0530, Anup Patel wrote:
>> The PSCI SYSTEM_OFF and SYSTEM_RESET functions are system-level
>> functions hence cannot be fully emulated by the in-kernel PSCI
>> emulation code.
>>
>> To tackle this, we forward PSCI SYSTEM_OFF and SYSTEM_RESET function
>> calls from vcpu to user space (i.e. QEMU or KVMTOOL) via kvm_run
>> structure using KVM_EXIT_SYSTEM_EVENT exit reasons.
>>
>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>> ---
>>  arch/arm/include/asm/kvm_psci.h   |    2 +-
>>  arch/arm/include/uapi/asm/kvm.h   |    2 ++
>>  arch/arm/kvm/handle_exit.c        |   13 +++++++---
>>  arch/arm/kvm/psci.c               |   48 ++++++++++++++++++++++++++++++-------
>>  arch/arm64/include/asm/kvm_psci.h |    2 +-
>>  arch/arm64/include/uapi/asm/kvm.h |    2 ++
>>  arch/arm64/kvm/handle_exit.c      |   12 +++++++---
>>  7 files changed, 65 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/kvm_psci.h b/arch/arm/include/asm/kvm_psci.h
>> index 9a83d98..992d7f1 100644
>> --- a/arch/arm/include/asm/kvm_psci.h
>> +++ b/arch/arm/include/asm/kvm_psci.h
>> @@ -18,6 +18,6 @@
>>  #ifndef __ARM_KVM_PSCI_H__
>>  #define __ARM_KVM_PSCI_H__
>>
>> -bool kvm_psci_call(struct kvm_vcpu *vcpu);
>> +int kvm_psci_call(struct kvm_vcpu *vcpu);
>>
>>  #endif /* __ARM_KVM_PSCI_H__ */
>> diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
>> index c498b60..f4de20c 100644
>> --- a/arch/arm/include/uapi/asm/kvm.h
>> +++ b/arch/arm/include/uapi/asm/kvm.h
>> @@ -172,6 +172,8 @@ struct kvm_arch_memory_slot {
>>  #define KVM_PSCI_FN_CPU_OFF          KVM_PSCI_FN(1)
>>  #define KVM_PSCI_FN_CPU_ON           KVM_PSCI_FN(2)
>>  #define KVM_PSCI_FN_MIGRATE          KVM_PSCI_FN(3)
>> +#define KVM_PSCI_FN_SYSTEM_OFF               KVM_PSCI_FN(4)
>> +#define KVM_PSCI_FN_SYSTEM_RESET     KVM_PSCI_FN(5)
>>
>>  #define KVM_PSCI_RET_SUCCESS         0
>>  #define KVM_PSCI_RET_NI                      ((unsigned long)-1)
>> diff --git a/arch/arm/kvm/handle_exit.c b/arch/arm/kvm/handle_exit.c
>> index a920790..c3f0e72 100644
>> --- a/arch/arm/kvm/handle_exit.c
>> +++ b/arch/arm/kvm/handle_exit.c
>> @@ -40,14 +40,21 @@ static int handle_svc_hyp(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>
>>  static int handle_hvc(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>  {
>> +     int ret;
>> +
>>       trace_kvm_hvc(*vcpu_pc(vcpu), *vcpu_reg(vcpu, 0),
>>                     kvm_vcpu_hvc_get_imm(vcpu));
>>
>> -     if (kvm_psci_call(vcpu))
>> +     ret = kvm_psci_call(vcpu);
>> +     if (ret >= 0)
>> +             return ret;
>> +     else if (ret == -EINVAL) {
>> +             kvm_inject_undefined(vcpu);
>>               return 1;
>> +     }
>> +
>> +     return ret;
>
> Wouldn't
>
> ret = kvm_psci_call(vcpu);
> if (ret == -EINVAL) {
>         kvm_inject_undefined(vcpu);
>         return 1;
> }
>
> return ret;
>
> be simpler?

Yes, I will make this simpler.

>
> also, minor nit, but I think according to the CodingStyle if you have
> single statements in if cases, but they are part of a larger if
> statement with alternative clauses that use curly-brackets to
> encapsulate multiple statements, then you should use curly braces around
> the single-line statement as well...
>
>>
>> -     kvm_inject_undefined(vcpu);
>> -     return 1;
>>  }
>>
>>  static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
>> diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
>> index 0881bf1..8e246d6 100644
>> --- a/arch/arm/kvm/psci.c
>> +++ b/arch/arm/kvm/psci.c
>> @@ -84,18 +84,41 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
>>       return KVM_PSCI_RET_SUCCESS;
>>  }
>>
>> +static inline void kvm_prepare_system_event(struct kvm_vcpu *vcpu, u32 type)
>> +{
>> +     memset(&vcpu->run->system_event, 0, sizeof(vcpu->run->system_event));
>> +     vcpu->run->system_event.type = type;
>> +     vcpu->run->exit_reason = KVM_EXIT_SYSTEM_EVENT;
>> +}
>> +
>> +static void kvm_psci_system_off(struct kvm_vcpu *vcpu)
>> +{
>> +     kvm_prepare_system_event(vcpu, KVM_SYSTEM_EVENT_SHUTDOWN);
>> +}
>> +
>> +static void kvm_psci_system_reset(struct kvm_vcpu *vcpu)
>> +{
>> +     kvm_prepare_system_event(vcpu, KVM_SYSTEM_EVENT_RESET);
>> +}
>> +
>>  /**
>>   * kvm_psci_call - handle PSCI call if r0 value is in range
>>   * @vcpu: Pointer to the VCPU struct
>>   *
>>   * Handle PSCI calls from guests through traps from HVC instructions.
>> - * The calling convention is similar to SMC calls to the secure world where
>> - * the function number is placed in r0 and this function returns true if the
>> - * function number specified in r0 is withing the PSCI range, and false
>> - * otherwise.
>> + * The calling convention is similar to SMC calls to the secure world
>> + * where the function number is placed in r0 and function number
>
> the function number
>
>> + * specified in r0 is withing the PSCI range.
>
> this reads a little funny now.  I think you can get rid of everything
> after the first mention of r0 (cut from "and function number...") since
> you explain that in the error codes below.

Sure, I will update this comment.

>
>> + *
>> + * This function returns: > 0 (success), 0 (success but exit to user
>> + * space), and < 0 (errors)
>
> you could use @return: instead of "This function returns", but I'm not
> sure if anyone actually cares.

Actually, "@returns" is correct way to specify as-per doxygen
comment style for C but I have seen "Returns:" or "Returns" being
used commonly in other parts of kernel. I will replace "The function
returns:" with "Returns:".

>
>> + *
>> + * Errors:
>> + * -EINVAL: Unrecognized PSCI function
>>   */
>> -bool kvm_psci_call(struct kvm_vcpu *vcpu)
>> +int kvm_psci_call(struct kvm_vcpu *vcpu)
>>  {
>> +     int ret = 1;
>>       unsigned long psci_fn = *vcpu_reg(vcpu, 0) & ~((u32) 0);
>>       unsigned long val;
>>
>> @@ -111,11 +134,20 @@ bool kvm_psci_call(struct kvm_vcpu *vcpu)
>>       case KVM_PSCI_FN_MIGRATE:
>>               val = KVM_PSCI_RET_NI;
>>               break;
>> -
>> +     case KVM_PSCI_FN_SYSTEM_OFF:
>> +             kvm_psci_system_off(vcpu);
>> +             val = KVM_PSCI_RET_SUCCESS;
>> +             ret = 0;
>> +             break;
>> +     case KVM_PSCI_FN_SYSTEM_RESET:
>> +             kvm_psci_system_reset(vcpu);
>> +             val = KVM_PSCI_RET_SUCCESS;
>> +             ret = 0;
>> +             break;
>>       default:
>> -             return false;
>> +             return -EINVAL;
>>       }
>>
>>       *vcpu_reg(vcpu, 0) = val;
>> -     return true;
>> +     return ret;
>>  }
>> diff --git a/arch/arm64/include/asm/kvm_psci.h b/arch/arm64/include/asm/kvm_psci.h
>> index e301a48..9bd0ee8 100644
>> --- a/arch/arm64/include/asm/kvm_psci.h
>> +++ b/arch/arm64/include/asm/kvm_psci.h
>> @@ -18,6 +18,6 @@
>>  #ifndef __ARM64_KVM_PSCI_H__
>>  #define __ARM64_KVM_PSCI_H__
>>
>> -bool kvm_psci_call(struct kvm_vcpu *vcpu);
>> +int kvm_psci_call(struct kvm_vcpu *vcpu);
>>
>>  #endif /* __ARM64_KVM_PSCI_H__ */
>> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
>> index d9f026b..f678902 100644
>> --- a/arch/arm64/include/uapi/asm/kvm.h
>> +++ b/arch/arm64/include/uapi/asm/kvm.h
>> @@ -158,6 +158,8 @@ struct kvm_arch_memory_slot {
>>  #define KVM_PSCI_FN_CPU_OFF          KVM_PSCI_FN(1)
>>  #define KVM_PSCI_FN_CPU_ON           KVM_PSCI_FN(2)
>>  #define KVM_PSCI_FN_MIGRATE          KVM_PSCI_FN(3)
>> +#define KVM_PSCI_FN_SYSTEM_OFF               KVM_PSCI_FN(4)
>> +#define KVM_PSCI_FN_SYSTEM_RESET     KVM_PSCI_FN(5)
>>
>>  #define KVM_PSCI_RET_SUCCESS         0
>>  #define KVM_PSCI_RET_NI                      ((unsigned long)-1)
>> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
>> index df84d7b..e382eb8 100644
>> --- a/arch/arm64/kvm/handle_exit.c
>> +++ b/arch/arm64/kvm/handle_exit.c
>> @@ -30,11 +30,17 @@ typedef int (*exit_handle_fn)(struct kvm_vcpu *, struct kvm_run *);
>>
>>  static int handle_hvc(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>  {
>> -     if (kvm_psci_call(vcpu))
>> +     int ret;
>> +
>> +     ret = kvm_psci_call(vcpu);
>> +     if (ret >= 0)
>> +             return ret;
>> +     else if (ret == -EINVAL) {
>> +             kvm_inject_undefined(vcpu);
>>               return 1;
>> +     }
>>
>> -     kvm_inject_undefined(vcpu);
>> -     return 1;
>> +     return ret;
>
> same as above.

OK.

>
>>  }
>>
>>  static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
>> --
>> 1.7.9.5
>>
>
> Aside from the code formatting and commenting above, it looks pretty
> good to me.
>
> -Christoffer
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm
