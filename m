From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 13 Dec 2013 09:28:35 -0800
Subject: [PATCH] ARM/KVM: inject data abort on unhandled memory access
In-Reply-To: <52AB16B9.8060607@linaro.org>
References: <1386256221-12294-1-git-send-email-andre.przywara@linaro.org>
 <CAFEAcA8tsdMjok8EQe-2ybuuCn_g7ZEYROwSPVcwr5A1VyrOVA@mail.gmail.com>
 <52A7434D.609@linaro.org> <20131211005532.GF2871@cbox>
 <52AB16B9.8060607@linaro.org>
Message-ID: <20131213172835.GV2871@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 03:16:25PM +0100, Andre Przywara wrote:
> On 12/11/2013 01:55 AM, Christoffer Dall wrote:
> >On Tue, Dec 10, 2013 at 05:37:33PM +0100, Andre Przywara wrote:
> >>On 12/05/2013 04:15 PM, Peter Maydell wrote:
> >>>On 5 December 2013 15:10, Andre Przywara <andre.przywara@linaro.org> wrote:
> >>>>If a KVM guest accesses memory that is outside its memory map (so no
> >>>>MMIO and no RAM), KVM will return -ENOSYS to userland, causing QEMU
> >>>>to do an abort() and kill the whole guest. This happens while
> >>>>executing dmidecode on ARM, which mmaps /dev/mem and scans the first
> >>>>Megabyte of memory for a DMI BIOS signature (sic!).
> >>>>Of course this is silly, but in any case crashing the whole guest
> >>>>does not seems appropriate.
> >>>>So lets mimic native hardware's behavior in this case and inject a
> >>>>Data Abort exception into the guest. In the previous case this will
> >>>>crash dmidecode with SIGSEGV, but keeps the guest alive.
> >>>
> >>>>--- a/arch/arm/kvm/mmio.c
> >>>>+++ b/arch/arm/kvm/mmio.c
> >>>>@@ -183,7 +183,8 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
> >>>>                         return ret;
> >>>>         } else {
> >>>>                 kvm_err("load/store instruction decoding not implemented\n");
> >>>>-               return -ENOSYS;
> >>>>+               kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
> >>>>+               return 1;
> >>>>         }
> >>>
> >>>This seems like it's mixing two different error cases:
> >>>  (1) guest tries to access something with nothing backing it at all
> >>>  -> should definitely cause a guest Data Abort
> >>>  (2) guest tries to access something (whether at a valid device address
> >>>  or not) with a "complex" instruction like LDM/STM which we can't deal
> >>>  without emulating it
> >>
> >>I see. But looking at the ARM ARM there is no easy way of telling
> >>the two apart, right? Or can we check the address for sanity easily?
> >>Currently we cannot handle both cases anyway, so I'd like to refrain
> >>from doing instruction decoding to see whether it was an instruction
> >>involving a register writeback or the like.
> >>
> >
> >Eh, in the kernel, all you can see there, is that the ISV bit in the HSR
> >is not set, which means that the decode information in that register is
> >not valid.
> >
> >This is completely orthorgonal to the question of what the VM model is
> >and how KVM and user space defines the memory map for your system.  The
> >way KVM works is that it knows about RAM, so it can tell if it's RAM or
> >*something else* (MMIO, nothing at all, ...), and if it's RAM, KVM will
> >handle the fault in the kernel, and otherwise will just exit to user
> >space with the MMIO address.
> >
> >I'm currently not sure what QEMU does if that address is not backed by
> >anything, or KVM tool for that matter, but it should inject a data abort
> >I suppose...
> 
> Good point you mentioned. I checked again and we fail only because
> we do ldmia on the non-RAM area (because dmidecode uses memcpy).
> By writing a small test case I get 0xffffffff back when reading
> normally (with ld) from 0xf0000, but crash when calling memcpy.
> So I agree that ldm/stm emulation is the right fix, but I wonder if
> we could change QEMU to not too hastily call abort(), but check the
> memory address and inject an DAbort if it's not valid. -ENOSYS seems
> to be only returned by this particular case, if I looked correctly.
> Not sure if that's feasible though, and also if ldm/stm emulation
> wouldn't reach the user faster than a QEMU patch.
> 

It is the responsibility of KVM to report back to user space which
address the MMIO load/store was attempted at, if it was a load or a
store, which register is the source/destination, and how many bytes are
attempted to be read/written.  KVM fails to do so for a number of
instructions, and this is a basic feature, which is simply not
implemented in the kernel yet - just like if you happened to be missing
a syscall on a new architecture, hence the choice of the error message.
User space can try to jump through hoops to work around this, but it is
simply a glaring limitation of KVM/ARM, unfortunately.

There's an extra little complication here, which is that for an LDM/STM
there are multiple source/destination registers and the current code
wouldn't handle that very nicely, so we'd have to fix that...

I'd be happy to revive the instruction decoding patch and add support
for ldm/stm, and run the unit tests I wrote for this on tht coe, but I'm
afraid I don't have cycles at this point to pursue a rewrite of all
arch/arm instruction decoding, plus from the attempts we made at doing
so, it wasn't clear that it would even be a win at all...

-Christoffer


> 
> >
> >>>The error message you've removed relates to (2). I think there's a reasonable
> >>>case to make for "log and reflect back into guest as a Data Abort"; silently
> >>>Data Aborting seems a bit cryptic.
> >>
> >>Actually I didn't remove the message, I just removed the return.
> >>But I can adjust the message, to something like:
> >>vcpu_unimpl(vcpu, "guest data abort with invalid syndrome\n");
> >>
> >
> >I don't think such a change is necessary.
> >
> >>>
> >>>Of course if the guest tries to do a memcpy() on the device memory
> >>>(which IIRC is what is happening with dmidecode in this case) then it's
> >>>very likely to hit case (2).
> >>
> >>Good point. dmidecode does mmap, then memcpy, so it's likely to use
> >>ldm (if glibc provides this, the dmidecode binary does not use ldm
> >>directly).
> >>
> >>But in general this reminds me to push fixing dmidecode. Xen has a
> >>similar fix now in queue ;-)
> >>
> >>>Or we could try to get the ldm/stm emulation code upstream :-)
> >>
> >>Sure, go ahead ;-)
> >>
> >
> 

-- 
Christoffer
