From: andre.przywara@linaro.org (Andre Przywara)
Date: Fri, 13 Dec 2013 15:16:25 +0100
Subject: [PATCH] ARM/KVM: inject data abort on unhandled memory access
In-Reply-To: <20131211005532.GF2871@cbox>
References: <1386256221-12294-1-git-send-email-andre.przywara@linaro.org>
 <CAFEAcA8tsdMjok8EQe-2ybuuCn_g7ZEYROwSPVcwr5A1VyrOVA@mail.gmail.com>
 <52A7434D.609@linaro.org> <20131211005532.GF2871@cbox>
Message-ID: <52AB16B9.8060607@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/2013 01:55 AM, Christoffer Dall wrote:
> On Tue, Dec 10, 2013 at 05:37:33PM +0100, Andre Przywara wrote:
>> On 12/05/2013 04:15 PM, Peter Maydell wrote:
>>> On 5 December 2013 15:10, Andre Przywara <andre.przywara@linaro.org> wrote:
>>>> If a KVM guest accesses memory that is outside its memory map (so no
>>>> MMIO and no RAM), KVM will return -ENOSYS to userland, causing QEMU
>>>> to do an abort() and kill the whole guest. This happens while
>>>> executing dmidecode on ARM, which mmaps /dev/mem and scans the first
>>>> Megabyte of memory for a DMI BIOS signature (sic!).
>>>> Of course this is silly, but in any case crashing the whole guest
>>>> does not seems appropriate.
>>>> So lets mimic native hardware's behavior in this case and inject a
>>>> Data Abort exception into the guest. In the previous case this will
>>>> crash dmidecode with SIGSEGV, but keeps the guest alive.
>>>
>>>> --- a/arch/arm/kvm/mmio.c
>>>> +++ b/arch/arm/kvm/mmio.c
>>>> @@ -183,7 +183,8 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
>>>>                          return ret;
>>>>          } else {
>>>>                  kvm_err("load/store instruction decoding not implemented\n");
>>>> -               return -ENOSYS;
>>>> +               kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
>>>> +               return 1;
>>>>          }
>>>
>>> This seems like it's mixing two different error cases:
>>>   (1) guest tries to access something with nothing backing it at all
>>>   -> should definitely cause a guest Data Abort
>>>   (2) guest tries to access something (whether at a valid device address
>>>   or not) with a "complex" instruction like LDM/STM which we can't deal
>>>   without emulating it
>>
>> I see. But looking at the ARM ARM there is no easy way of telling
>> the two apart, right? Or can we check the address for sanity easily?
>> Currently we cannot handle both cases anyway, so I'd like to refrain
>> from doing instruction decoding to see whether it was an instruction
>> involving a register writeback or the like.
>>
>
> Eh, in the kernel, all you can see there, is that the ISV bit in the HSR
> is not set, which means that the decode information in that register is
> not valid.
>
> This is completely orthorgonal to the question of what the VM model is
> and how KVM and user space defines the memory map for your system.  The
> way KVM works is that it knows about RAM, so it can tell if it's RAM or
> *something else* (MMIO, nothing at all, ...), and if it's RAM, KVM will
> handle the fault in the kernel, and otherwise will just exit to user
> space with the MMIO address.
>
> I'm currently not sure what QEMU does if that address is not backed by
> anything, or KVM tool for that matter, but it should inject a data abort
> I suppose...

Good point you mentioned. I checked again and we fail only because we do 
ldmia on the non-RAM area (because dmidecode uses memcpy).
By writing a small test case I get 0xffffffff back when reading normally 
(with ld) from 0xf0000, but crash when calling memcpy.
So I agree that ldm/stm emulation is the right fix, but I wonder if we 
could change QEMU to not too hastily call abort(), but check the memory 
address and inject an DAbort if it's not valid. -ENOSYS seems to be only 
returned by this particular case, if I looked correctly.
Not sure if that's feasible though, and also if ldm/stm emulation 
wouldn't reach the user faster than a QEMU patch.

Regards,
Andre.

>
>>> The error message you've removed relates to (2). I think there's a reasonable
>>> case to make for "log and reflect back into guest as a Data Abort"; silently
>>> Data Aborting seems a bit cryptic.
>>
>> Actually I didn't remove the message, I just removed the return.
>> But I can adjust the message, to something like:
>> vcpu_unimpl(vcpu, "guest data abort with invalid syndrome\n");
>>
>
> I don't think such a change is necessary.
>
>>>
>>> Of course if the guest tries to do a memcpy() on the device memory
>>> (which IIRC is what is happening with dmidecode in this case) then it's
>>> very likely to hit case (2).
>>
>> Good point. dmidecode does mmap, then memcpy, so it's likely to use
>> ldm (if glibc provides this, the dmidecode binary does not use ldm
>> directly).
>>
>> But in general this reminds me to push fixing dmidecode. Xen has a
>> similar fix now in queue ;-)
>>
>>> Or we could try to get the ldm/stm emulation code upstream :-)
>>
>> Sure, go ahead ;-)
>>
>
