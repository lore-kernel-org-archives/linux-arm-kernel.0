From: anup@brainfault.org (Anup Patel)
Date: Thu, 30 Jan 2014 09:39:40 +0530
Subject: [RFC PATCH 2/3] ARM/ARM64: KVM: Add support for PSCI v0.2
 emulation
In-Reply-To: <20140129155005.GC3570@cbox>
References: <1390309301-28424-1-git-send-email-anup.patel@linaro.org>
 <1390309301-28424-3-git-send-email-anup.patel@linaro.org>
 <20140128210410.GA26671@cbox>
 <CAAhSdy2ny3qhWGMFZcOE1vP1j-iqB9r1Q82fOhUo=NMP1h=JrA@mail.gmail.com>
 <20140129155005.GC3570@cbox>
Message-ID: <CAAhSdy08fEVGH08SPhE0pQ68ZyeFw+QDP85U+K6h8hH-PAmiGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 29, 2014 at 9:20 PM, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> On Wed, Jan 29, 2014 at 10:22:47AM +0530, Anup Patel wrote:
>> On Wed, Jan 29, 2014 at 2:34 AM, Christoffer Dall
>> <christoffer.dall@linaro.org> wrote:
>> > On Tue, Jan 21, 2014 at 06:31:40PM +0530, Anup Patel wrote:
>
> [...]
>
>> >
>> > Which tree does this patch apply to?  It looks like you'll get a
>> > conflict with:
>> > 478a823 arm: KVM: Don't return PSCI_INVAL if waitqueue is inactive
>>
>> This patchset applies on v3.13 tag of Torvalds tree.
>
> That would not contain anything in kvm/next or kvm-arm-next.
>
>>
>> I generally base my patches on latest stable/rc tag of Torvalds tree
>> so that I can provide KVM patches to folks interested in trying KVM
>> on X-Gene with latest Linux stable/rc.
>
> If you want to make it slightly easier for me or Marc to apply your
> patches in general I would recommend basing them off kvm/next or
> kvm-arm-next, but it's no big deal.
>
> In this case all you need to consider is already in linus/master.
>
>>
>> I will make sure that revised patchset applies on top of
>> 478a823 arm: KVM: Don't return PSCI_INVAL if waitqueue is inactive
>>
>> >
>> >>       }
>> >>
>> >> diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
>> >> index 0881bf1..ee044a3 100644
>> >> --- a/arch/arm/kvm/psci.c
>> >> +++ b/arch/arm/kvm/psci.c
>> >> @@ -55,13 +55,13 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
>> >>       }
>> >>
>> >>       if (!vcpu)
>> >> -             return KVM_PSCI_RET_INVAL;
>> >> +             return KVM_PSCI_RET_INVALID_PARAMS;
>> >>
>> >>       target_pc = *vcpu_reg(source_vcpu, 2);
>> >>
>> >>       wq = kvm_arch_vcpu_wq(vcpu);
>> >>       if (!waitqueue_active(wq))
>> >> -             return KVM_PSCI_RET_INVAL;
>> >> +             return KVM_PSCI_RET_INVALID_PARAMS;
>> >>
>> >>       kvm_reset_vcpu(vcpu);
>> >>
>> >> @@ -84,17 +84,49 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
>> >>       return KVM_PSCI_RET_SUCCESS;
>> >>  }
>> >>
>> >> -/**
>> >> - * kvm_psci_call - handle PSCI call if r0 value is in range
>> >> - * @vcpu: Pointer to the VCPU struct
>> >> - *
>> >> - * Handle PSCI calls from guests through traps from HVC instructions.
>> >> - * The calling convention is similar to SMC calls to the secure world where
>> >> - * the function number is placed in r0 and this function returns true if the
>> >> - * function number specified in r0 is withing the PSCI range, and false
>> >> - * otherwise.
>> >> - */
>> >> -bool kvm_psci_call(struct kvm_vcpu *vcpu)
>> >> +static bool kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
>> >> +{
>> >> +     unsigned long psci_fn = *vcpu_reg(vcpu, 0) & ~((u32) 0);
>> >> +     unsigned long val;
>> >> +
>> >> +     switch (psci_fn) {
>> >> +     case KVM_PSCI_0_2_FN_PSCI_VERSION:
>> >> +             /*
>> >> +              * Bits[31:16] = Major Version = 0
>> >> +              * Bits[15:0] = Minor Version = 2
>> >> +              */
>> >> +             val = 2;
>> >> +             break;
>> >> +     case KVM_PSCI_0_2_FN_CPU_OFF:
>> >> +             kvm_psci_vcpu_off(vcpu);
>> >> +             val = KVM_PSCI_RET_SUCCESS;
>> >> +             break;
>> >> +     case KVM_PSCI_0_2_FN_CPU_ON:
>> >> +     case KVM_PSCI_0_2_FN64_CPU_ON:
>> >> +             val = kvm_psci_vcpu_on(vcpu);
>> >> +             break;
>> >> +     case KVM_PSCI_0_2_FN_CPU_SUSPEND:
>> >> +     case KVM_PSCI_0_2_FN_AFFINITY_INFO:
>> >> +     case KVM_PSCI_0_2_FN_MIGRATE:
>> >> +     case KVM_PSCI_0_2_FN_MIGRATE_INFO_TYPE:
>> >> +     case KVM_PSCI_0_2_FN_MIGRATE_INFO_UP_CPU:
>> >> +     case KVM_PSCI_0_2_FN_SYSTEM_OFF:
>> >> +     case KVM_PSCI_0_2_FN_SYSTEM_RESET:
>> >> +     case KVM_PSCI_0_2_FN64_CPU_SUSPEND:
>> >> +     case KVM_PSCI_0_2_FN64_AFFINITY_INFO:
>> >> +     case KVM_PSCI_0_2_FN64_MIGRATE:
>> >> +     case KVM_PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU:
>> >> +             val = KVM_PSCI_RET_NOT_SUPPORTED;
>> >> +             break;
>> >> +     default:
>> >> +             return false;
>> >> +     }
>> >> +
>> >> +     *vcpu_reg(vcpu, 0) = val;
>> >> +     return true;
>> >> +}
>> >> +
>> >> +static bool kvm_psci_0_1_call(struct kvm_vcpu *vcpu)
>> >>  {
>> >>       unsigned long psci_fn = *vcpu_reg(vcpu, 0) & ~((u32) 0);
>> >>       unsigned long val;
>> >> @@ -109,9 +141,8 @@ bool kvm_psci_call(struct kvm_vcpu *vcpu)
>> >>               break;
>> >>       case KVM_PSCI_FN_CPU_SUSPEND:
>> >>       case KVM_PSCI_FN_MIGRATE:
>> >> -             val = KVM_PSCI_RET_NI;
>> >> +             val = KVM_PSCI_RET_NOT_SUPPORTED;
>> >>               break;
>> >> -
>> >>       default:
>> >>               return false;
>> >>       }
>> >> @@ -119,3 +150,21 @@ bool kvm_psci_call(struct kvm_vcpu *vcpu)
>> >>       *vcpu_reg(vcpu, 0) = val;
>> >>       return true;
>> >>  }
>> >> +
>> >> +/**
>> >> + * kvm_psci_call - handle PSCI call if r0 value is in range
>> >> + * @vcpu: Pointer to the VCPU struct
>> >> + *
>> >> + * Handle PSCI calls from guests through traps from HVC instructions.
>> >> + * The calling convention is similar to SMC calls to the secure world where
>> >> + * the function number is placed in r0 and this function returns true if the
>> >> + * function number specified in r0 is withing the PSCI range, and false
>> >> + * otherwise.
>> >> + */
>> >> +bool kvm_psci_call(struct kvm_vcpu *vcpu)
>> >> +{
>> >> +     if (test_bit(KVM_ARM_VCPU_PSCI_0_2, vcpu->arch.features))
>> >> +             return kvm_psci_0_2_call(vcpu);
>> >> +
>> >> +     return kvm_psci_0_1_call(vcpu);
>> >> +}
>> >
>> > Why don't we just try one after the other?  Do they conflict in some
>> > way?
>>
>> Atleast the functions IDs are totally different in v0.2 and v0.1
>>
>> Also, in v0.2 we have separate function IDs for 32bit and 64bit
>> VCPU calling same PSCI function.
>>
>
> So we could just do:
>
> {
>         ret = kvm_psci_0_2_call(vcpu);
>         if (ret)
>                 return ret;
>
>         ret = kvm_psci_0_1_call(vcpu);
>         if (ret)
>                 return ret;
>
>         return false;
> }
>
> and be rid of the vcpu feature, or?  I thought this was Marc's point in
> the last KVM/ARM call?

OK, I will update kvm_psci_call() as per this.

>
>> >
>> > I assume PSCI calls are never going to be in the critical path and calls
>> > into PSCI are pretty much expected to be slow as a dog anyhow, so if we
>> > could avoid the extra churn in user space code and potential user
>> > confusion (providing PSCI 0.2 kernel but too old user space tool for
>> > example), I think that would be preferred.
>>
>> Yes, PSCI calls will not be in critical path except few functions such as
>> PSCI CPU_SUSPEND and CPU_ON.
>>
>> For example,
>> On real HW, people are very much interested in time taken to resume a
>> HW CPU from suspended state because this affects responsiveness of
>> a system.
>>
>
> In which case time taken to wake up from suspended state in a VM will
> for sure not be dominated by an extra call to a psci function id
> checking function.
>
> Thanks,
> -Christoffer

--
Anup
