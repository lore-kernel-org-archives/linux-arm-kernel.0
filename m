From: james.morse@arm.com (James Morse)
Date: Tue, 29 Aug 2017 18:10:57 +0100
Subject: [PATCH] KVM: arm64: stop propagating DAIF flags between kernel
 and VHE's world switch
In-Reply-To: <20170824152304.GB2150@lvm>
References: <20170810113021.1110-1-james.morse@arm.com>
 <20170824152304.GB2150@lvm>
Message-ID: <59A5A021.1090102@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,


(I suspect I'm using some term differently here ...)

On 24/08/17 16:23, Christoffer Dall wrote:
> On Thu, Aug 10, 2017 at 12:30:21PM +0100, James Morse wrote:
>> KVM calls __kvm_vcpu_run() in a loop with interrupts masked for the
>> duration of the call. On a non-vhe system we HVC to EL2 and the
>> host DAIF flags are save/restored via the SPSR.
>>
>> On a system with vhe, we branch to the EL2 code because the kernel
>> also runs at EL2. This means the other kernel DAIF flags propagate into
>> KVMs EL2 code.
>>
>> The same happens in reverse, we take an exception to exit the guest
>> and all the flags are masked. __guest_exit() unmasks SError, and we
>> return with these flags through world switch and back into the host
>> kernel. KVM unmasks interrupts as part of its __kvm_vcpu_run(), but
> 
> when does KVM unmask interrupts as part of the __kvm_vcpu_run()?  Do you
> mean kvm_arch_vcpu_ioctl_run() ?

Oops, yes, I meant kvm_arch_vcpu_ioctl_run().


>> debug exceptions remain disabled due to the guest exit exception,
>> (as does SError: today this is the only time SError is unmasked in the
>> kernel). The flags stay in this state until we return to userspace.
>>
>> We have a __vhe_hyp_call() function that does the isb that we implicitly
>> have on non-vhe systems, add the DAIF save/restore here, instead of in
>> __sysreg_{save,restore}_host_state() which would require an extra isb()
>> between the hosts VBAR_EL1 being restored and DAIF being restored.

> This also means that anyone else calling kvm_call_hyp(), which we are
> beginning to do more often, would also do this save/restore which
> shouldn't really be necessary, doesn't it?

I think it is, its done implicitly via SPSR_EL2 by the HVC/ERET on non-VHE.
Does the HYP code on the other end of kvm_call_hyp() expect to be called with
DAIF masked? What about the other way, if the HYP code modifies the DAIF flags
should that spread back into the kernel?

Today this behaviour differs depending on whether we have VHE.

I think KVM expects its HYP code to be called with DAIF masked, (e.g. there is
no explicit mask of debug before save/restoring MDSCR_EL1).

I'll argue all kvm_call_hyp() users expect the code be called at HYP with DAIF
masked, as if we just took an HVC. On return the flags should be restored as
they would with an ERET.

On VHE we are already at EL2 so we don't have HVC's DAIF-masking behaviour.


> Also, I can't really see why we need to save/restore this.  We are
> 'entering the kernel' similarly to entering the kernel from user space.

(I'm lost here, entering KVM's HYP code from a guest, or returning to the kernel
from KVM?)


> Does the kernel/userspace boundry preserve kernel state or can we simply
> set what the wanted state of the flags should be upon having entered the
> kernel from EL2?

Entering KVM's HYP code from a guest is an exception so the CPU masks DAIF, KVM
unmasks SError, world-switches back to the host and on VHE: 'ret's to the kernel.

On VHE before kvm_call_hyp() SError was masked and Debug was enabled, on return
SError is unmasked and Debug disabled. We can then re-schedule to some other
task with Debug disabled.

(I'll have another go at the commit message)


Thanks,

James
