From: james.morse@arm.com (James Morse)
Date: Thu, 08 Jun 2017 11:23:55 +0100
Subject: [PATCH 03/11] KVM: arm64: Change hyp_panic()s dependency on
 tpidr_el2
In-Reply-To: <20170606194525.GK9464@cbox>
References: <20170515174400.29735-1-james.morse@arm.com>
 <20170515174400.29735-4-james.morse@arm.com> <20170606194525.GK9464@cbox>
Message-ID: <593925BB.30503@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 06/06/17 20:45, Christoffer Dall wrote:
> On Mon, May 15, 2017 at 06:43:51PM +0100, James Morse wrote:
>> KVM calls hyp_panic() when anything unexpected happens. This may occur
>> while a guest owns the EL1 registers. KVM stashes the vcpu pointer in
>> tpidr_el2, which it uses to find the host context in order to restore
>> the host EL1 registers before parachuting into the host's panic().
>>
>> The host context is a struct kvm_cpu_context allocated in the per-cpu
>> area, and mapped to hyp. Given the per-cpu offset for this CPU, this is
>> easy to find. Change hyp_panic() to take a pointer to the
>> struct kvm_cpu_context. Wrap these calls with an asm function that
>> retrieves the struct kvm_cpu_context from the host's per-cpu area.
>>
>> Copy the per-cpu offset from the hosts tpidr_el1 into tpidr_el2 during
>> kvm init. (Later patches will make this unnecessary for VHE hosts)
>>
>> We print out the vcpu pointer as part of the panic message. Add a back
>> reference to the 'running vcpu' in the host cpu context to preserve this.

>> diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
>> index fce7cc507e0a..0f83e7e402ad 100644
>> --- a/arch/arm64/kvm/hyp/hyp-entry.S
>> +++ b/arch/arm64/kvm/hyp/hyp-entry.S
>> @@ -163,6 +163,13 @@ ENTRY(__hyp_do_panic)
>>  	eret
>>  ENDPROC(__hyp_do_panic)
>>  
>> +ENTRY(__hyp_panic)
>> +	ldr	x0, =kvm_host_cpu_state
> 
> Why is this guaranteed to give us a valid EL2 address?

... it doesn't. Its a host address from the constant pool which is used by
hyp-panic as __host_ctxt:
> void __hyp_text __noreturn hyp_panic(struct kvm_cpu_context *__host_ctxt);

and fixed up with:
> host_ctxt = kern_hyp_va(__host_ctxt);

to give us the EL2 address before we access it.
For VHE the last step is a nop as the host address can be accessed directly.

I will add a comment here explaining this.


Thanks!

James
