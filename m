From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 12 Sep 2014 14:42:39 +0200
Subject: qemu
In-Reply-To: <20140911220711.GK5535@lvm>
References: <CAKv+Gu9MDEZUW3mkcy3hRj3waAnPwHps9TNici+Fb4HKOMna-A@mail.gmail.com>
 <5411B725.8090009@arm.com>
 <CAKv+Gu9qha4LVwsUfxu=_zdDMbLR_m0Ws+AvFQAbb0v9G30mCg@mail.gmail.com>
 <5411D262.2030800@arm.com>
 <CAKv+Gu_j5SMeqkgP+CAjOu0quzMBFMMgjBcfx_-Q5ch9SOxpvw@mail.gmail.com>
 <20140911180904.GI5535@lvm>
 <CAKv+Gu9bzLmPQ=3kU6giSkv7xZCzuD7Yy0m2pPRS0oCk7LwjTA@mail.gmail.com>
 <20140911220711.GK5535@lvm>
Message-ID: <CAKv+Gu-XrYNtSJpefpYKkyuLHLT67pt8mPOw9QLJ74Y_V+s0hA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 September 2014 00:07, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> On Thu, Sep 11, 2014 at 08:35:07PM +0200, Ard Biesheuvel wrote:
>> On 11 September 2014 20:09, Christoffer Dall
>> <christoffer.dall@linaro.org> wrote:
>> > On Thu, Sep 11, 2014 at 07:06:17PM +0200, Ard Biesheuvel wrote:
>> >> On 11 September 2014 18:48, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> >> > On 11/09/14 16:26, Ard Biesheuvel wrote:
>> >> >> On 11 September 2014 16:52, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> >> >>> On 11/09/14 15:41, Ard Biesheuvel wrote:
>> >> >>>> Hello all,
>> >> >>>>
>> >> >>>> I spent most of the day chasing a particularly weird heisenbug in the
>> >> >>>> QEMU+KVM+UEFI combo.
>> >> >>>> The symptom was that UEFI init would hang on the first write to the
>> >> >>>> second NOR flash (to initialize the variable store) but *only* when
>> >> >>>> using the -bios option (instead of -pflash) and a boot image of
>> >> >>>> exactly 64 MB in size. Note that this implies that the second NOR
>> >> >>>> flash was not file backed.
>> >> >>>>
>> >> >>>> As it turns out, the choice of the -bios option and the size of the
>> >> >>>> file affect whether KVM ends up using sections or pages to back the
>> >> >>>> NOR flash, and in my failure case, it was using the latter. That
>> >> >>>> resulted in KVM going down a code path where the memory backing the
>> >> >>>> NOR was writable, which breaks the MMIO emulation, and resulted in the
>> >> >>>> hang on init of the variable store.
>> >> >>>>
>> >> >>>> The patch below fixes it for me.
>> >> >>>>
>> >> >>>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>> >> >>>> index c68ec28f17c3..121abc6fef97 100644
>> >> >>>> --- a/arch/arm/kvm/mmu.c
>> >> >>>> +++ b/arch/arm/kvm/mmu.c
>> >> >>>> @@ -817,7 +817,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu,
>> >> >>>> phys_addr_t fault_ipa,
>> >> >>>>  pfn = gfn_to_pfn_prot(kvm, gfn, write_fault, &writable);
>> >> >>>>  if (is_error_pfn(pfn))
>> >> >>>>   return -EFAULT;
>> >> >>>>
>> >> >>>> - if (kvm_is_mmio_pfn(pfn))
>> >> >>>> + if (writable && kvm_is_mmio_pfn(pfn))
>> >> >>>>   mem_type = PAGE_S2_DEVICE;
>> >> >>>>
>> >> >>>>   spin_lock(&kvm->mmu_lock);
>> >> >>>>
>> >> >>>> Here is the definition of kvm_is_mmio() for completeness. I am a bit
>> >> >>>> out of my depth here, so perhaps someone else can shed some light on
>> >> >>>> this?
>> >> >>>>
>> >> >>>> bool kvm_is_mmio_pfn(pfn_t pfn)
>> >> >>>> {
>> >> >>>>         if (pfn_valid(pfn))
>> >> >>>>                 return PageReserved(pfn_to_page(pfn));
>> >> >>>>
>> >> >>>>         return true;
>> >> >>>> }
>> >> >>>>
>> >> >>>> To me, it is particularly puzzling what PageReserved() has to do with
>> >> >>>> anything, as I couldn't find any other uses of it under kvm/
>> >> >>>>
>> >> >>>
>> >> >>> My understanding is that kvm_is_mmio_pfn() is used for *devices* that
>> >> >>> are mapped directly mapped (think device assignment). PageReserved()
>> >> >>> would make sense there.
>> >> >>>
>> >> >>> Now, I'm not familiar with the whole QEMU setup, so maybe you could
>> >> >>> describe how things are mapped, and what is supposed to happen?
>> >> >>>
>> >> >>
>> >> >> When running QEMU using the -bios <file> option, the file is exposed
>> >> >> to the guest as an emulated NOR flash at 0x0, so that you can boot
>> >> >> from it directly.
>> >> >> In my case, the NOR is used for the boot image itself, and for a
>> >> >> non-volatile variable store at 0x400_0000, which is initialized by
>> >> >> UEFI when it boots.
>> >> >>
>> >> >> In order for the NOR emulation to work, writes to the NOR need to
>> >> >> trap, so that QEMU can take down the whole memory region, trapping all
>> >> >> reads and writes, until a command is issued that puts it back into
>> >> >> array mode, and the memory region is created again. In this mode, the
>> >> >> guest reads to the NOR go straight to host RAM. (Or they should: the
>> >> >> patch you merged today fixed and issue where reads were mistaken for
>> >> >> writes and sent to QEMU instead)
>> >> >>
>> >> >> So when UEFI enters it non-volatile variable store driver, it first
>> >> >> issues a read to the base of the second half of the NOR (0x400_0000),
>> >> >> resulting in some host RAM to be pinned to back it up. However, for
>> >> >> some reason, it is mapped as PAGE_S2_DEVICE, which is read-write, so
>> >> >> when subsequently a write is issued to kick the NOR into command mode,
>> >> >> it just gets sent to host RAM as well.
>> >> >>
>> >> >> Indeed, by the looks of it, kvm_is_mmio_pfn() is intended to map host
>> >> >> device memory straight into the guest physical address space, but this
>> >> >> is not what I am doing, so why is it returning 'true' here?
>> >> >
>> >> > That's the bit I do not understand. Any chance you can find out who sets
>> >> > this bit in the page tables?
>> >> >
>> >>
>> >> That is also the bit *I* don't understand, and that is why I am asking
>> >> you guys :-)
>> >>
>> >> Let me first double check that PageReserved is actually the culprit here ...
>> >
>> > Yeah, so assuming that Linux is not broken, we either have a bug in how
>> > we resolve the pfn or QEMU puts an incorrect address for the backing of
>> > the flash into the memory region.
>> >
>> > Another question here is whether we should be always setting the RDWR
>> > bits for PAGE_S2_DEVICE?  Is it conceivable that we would want to expose
>> > some device MMIO region as a read-only region and still fault on writes?
>> >
>>
>> Let's see if the holes in our knowledge line up :-)
>>
>> I noticed that the call to kvm_is_mmio_pfn() was only recently added
>> by Kim Phillips (b88657674d39 ARM: KVM: user_mem_abort: support stage
>> 2 MMIO page mapping), and there are no other references to it in
>> KVM/ARM
>
> right, but KVM/x86 calls this as well...
>
>>
>> I am willing to accept that checking for PG_reserved makes sense in
>> the context of deciding whether some pfn is backed by normal RAM
>> (aiui, there may be a hole there), but returning writable RAM when
>> writable = false is arguably a bug.
>
> Agreed, I think the PAGE_S2_DEVICE should not be touching the read/write
> bits, but I still want to figure out why your specific PFN is resolved
> as an MMIO PFN.
>
>> Due to the fact that we are only
>> introducing KVM_CAP_READONLY_MEM now, and due to the
>> read-as-ROM/write-as-control-reg nature of NOR, it is no surprise that
>> this is where the issues present themselves.
>>
>> So could anyone shed some light on the nature of the memory returned
>> by hva_to_pfn() and why it would have the PG_reserved flag set?
>>
> So did you verify that it indeed does have the PG_reserved flag set?
>
> Can you dump the values for the memory slot that QEMU sets up for your
> region and the PFN that the lookup here resolves to on your particular
> setup so that we can try to see what is happening here?
>

OK, it looks like I am getting the zero page, which makes perfect
sense for a read-only anonymous mapping. It also explains perfectly
why my kernel was unstable after running the test, as I was mapping
the zero page PAGE_S2_DEVICE and clobbering it with bogus NOR flash
writes.

So the question is whether pfn_valid() and PageReserved() both return
true for the zero page on all archs, or just on arm[64].
In any case, kvm_is_mmio_pfn() should obviously return false for the
zero page, question is to change it in generic or in arch specific
code

-- 
Ard.
