From: andre.przywara@linaro.org (Andre Przywara)
Date: Tue, 10 Dec 2013 17:37:33 +0100
Subject: [PATCH] ARM/KVM: inject data abort on unhandled memory access
In-Reply-To: <CAFEAcA8tsdMjok8EQe-2ybuuCn_g7ZEYROwSPVcwr5A1VyrOVA@mail.gmail.com>
References: <1386256221-12294-1-git-send-email-andre.przywara@linaro.org>
 <CAFEAcA8tsdMjok8EQe-2ybuuCn_g7ZEYROwSPVcwr5A1VyrOVA@mail.gmail.com>
Message-ID: <52A7434D.609@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/2013 04:15 PM, Peter Maydell wrote:
> On 5 December 2013 15:10, Andre Przywara <andre.przywara@linaro.org> wrote:
>> If a KVM guest accesses memory that is outside its memory map (so no
>> MMIO and no RAM), KVM will return -ENOSYS to userland, causing QEMU
>> to do an abort() and kill the whole guest. This happens while
>> executing dmidecode on ARM, which mmaps /dev/mem and scans the first
>> Megabyte of memory for a DMI BIOS signature (sic!).
>> Of course this is silly, but in any case crashing the whole guest
>> does not seems appropriate.
>> So lets mimic native hardware's behavior in this case and inject a
>> Data Abort exception into the guest. In the previous case this will
>> crash dmidecode with SIGSEGV, but keeps the guest alive.
>
>> --- a/arch/arm/kvm/mmio.c
>> +++ b/arch/arm/kvm/mmio.c
>> @@ -183,7 +183,8 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
>>                          return ret;
>>          } else {
>>                  kvm_err("load/store instruction decoding not implemented\n");
>> -               return -ENOSYS;
>> +               kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
>> +               return 1;
>>          }
>
> This seems like it's mixing two different error cases:
>   (1) guest tries to access something with nothing backing it at all
>   -> should definitely cause a guest Data Abort
>   (2) guest tries to access something (whether at a valid device address
>   or not) with a "complex" instruction like LDM/STM which we can't deal
>   without emulating it

I see. But looking at the ARM ARM there is no easy way of telling the 
two apart, right? Or can we check the address for sanity easily?
Currently we cannot handle both cases anyway, so I'd like to refrain 
from doing instruction decoding to see whether it was an instruction 
involving a register writeback or the like.

> The error message you've removed relates to (2). I think there's a reasonable
> case to make for "log and reflect back into guest as a Data Abort"; silently
> Data Aborting seems a bit cryptic.

Actually I didn't remove the message, I just removed the return.
But I can adjust the message, to something like:
vcpu_unimpl(vcpu, "guest data abort with invalid syndrome\n");

>
> Of course if the guest tries to do a memcpy() on the device memory
> (which IIRC is what is happening with dmidecode in this case) then it's
> very likely to hit case (2).

Good point. dmidecode does mmap, then memcpy, so it's likely to use ldm 
(if glibc provides this, the dmidecode binary does not use ldm directly).

But in general this reminds me to push fixing dmidecode. Xen has a 
similar fix now in queue ;-)

> Or we could try to get the ldm/stm emulation code upstream :-)

Sure, go ahead ;-)

Regards,
Andre.
