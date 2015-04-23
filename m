From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Thu, 23 Apr 2015 15:26:53 +0100
Subject: [PATCH v2 06/10] KVM: arm64: guest debug,
 add SW break point support
In-Reply-To: <20150414082558.GS6186@cbox>
References: <1427814488-28467-1-git-send-email-alex.bennee@linaro.org>
 <1427814488-28467-7-git-send-email-alex.bennee@linaro.org>
 <20150414082558.GS6186@cbox>
Message-ID: <87y4li6hua.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Christoffer Dall <christoffer.dall@linaro.org> writes:

> On Tue, Mar 31, 2015 at 04:08:04PM +0100, Alex Benn?e wrote:
>> This adds support for SW breakpoints inserted by userspace.
>> 
>> We do this by trapping all BKPT exceptions in the
>> hypervisor (MDCR_EL2_TDE).
>
> you mean trapping all exceptions in the guest to the hypervisor?
>
>> The kvm_debug_exit_arch carries the address
>> of the exception.
>
> why?  can userspace not simply read out the PC using GET_ONE_REG?

Yes, I have re-worded and removed PC from the debug information.

<snip>
>>  
>> +	/* Trap breakpoints? */
>> +	if (vcpu->guest_debug & KVM_GUESTDBG_USE_SW_BP)
>> +		vcpu->arch.mdcr_el2 |= MDCR_EL2_TDE;
>> +	else
>> +		vcpu->arch.mdcr_el2 &= ~MDCR_EL2_TDE;
>
> so now you're trapping all debug exceptions, right?
>
> what happens if the guest is using the hardware to debug debug stuff and
> generates other kinds of debug exceptions, like a hardware breakpoint,
> will we not see an unhandled exception and the guest being forcefully
> killed?

Yes until the later patches which stop the guest using HW debug
registers while we are using them.

>
>> +
>>  }
>>  
>>  void kvm_arch_clear_debug(struct kvm_vcpu *vcpu)
>> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
>> index 524fa25..ed1bbb4 100644
>> --- a/arch/arm64/kvm/handle_exit.c
>> +++ b/arch/arm64/kvm/handle_exit.c
>> @@ -82,6 +82,37 @@ static int kvm_handle_wfx(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>  	return 1;
>>  }
>>  
>> +/**
>> + * kvm_handle_debug_exception - handle a debug exception instruction
>
> handle a software breadkpoint exception
>
>> + *
>> + * @vcpu:	the vcpu pointer
>> + * @run:	access to the kvm_run structure for results
>> + *
>> + * We route all debug exceptions through the same handler as we
>
> all debug exceptions?  software breakpoints and all?  then why the above
> shot text?
>
>> + * just need to report the PC and the HSR values to userspace.
>> + * Userspace may decide to re-inject the exception and deliver it to
>> + * the guest if it wasn't for the host to deal with.
>
> now I'm confused - does userspace setup the guest to receive an
> exception or does it tell KVM to emulate an exception for the guest or
> do we execute the breakpoint without trapping the debug exception?

I've made it all go through userspace as we may have to translate the
hypervisor visible exception code to what the guest was expecting to see.

>
>> + */
>> +static int kvm_handle_guest_debug(struct kvm_vcpu *vcpu, struct kvm_run *run)
>> +{
>> +	u32 hsr = kvm_vcpu_get_hsr(vcpu);
>> +
>> +	run->exit_reason = KVM_EXIT_DEBUG;
>> +	run->debug.arch.hsr = hsr;
>> +
>> +	switch (hsr >> ESR_ELx_EC_SHIFT) {
>> +	case ESR_ELx_EC_BKPT32:
>> +	case ESR_ELx_EC_BRK64:
>> +		run->debug.arch.pc = *vcpu_pc(vcpu);
>> +		break;
>> +	default:
>> +		kvm_err("%s: un-handled case hsr: %#08x\n",
>> +			__func__, (unsigned int) hsr);
>
> this should never happen right?

At the moment it could, at the end of the patch series we should cover
all the cases so it would indicate a bug. I've made it return an error
code so it fails hard as suggested by David.

-- 
Alex Benn?e
