From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 16 Mar 2015 17:45:54 +0100
Subject: [RFC PATCH 0/3] arm64: relocatable kernel proof of concept
In-Reply-To: <20150316160948.GB18277@leverpostej>
References: <1426519423-28263-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150316160948.GB18277@leverpostej>
Message-ID: <CAKv+Gu_-1XMcpobRt7tXCZaqWoszWLfJxgHBLaKuWchz87UnSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 March 2015 at 17:09, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Ard,
>
> I agree that we want to be able to load the kernel anywhwere in memory
> (modulo alignment restrictions and the like). However, I'm not keen on
> the approach taken; I'd rather see the linear mapping split from the
> text mapping. More on that below.
>
> On Mon, Mar 16, 2015 at 03:23:40PM +0000, Ard Biesheuvel wrote:
>> These patches is a proof of concept of how we could potentially relocate
>> the kernel at runtime. This code is rough around the edges, and there are
>> a few unresolved issues, hence this RFC.
>>
>> With these patches, the kernel can essentially execute at any virtual offset.
>> There are a couple of reasons why we would want this:
>> - performance: we can align PHYS_OFFSET so that most of the linear mapping can
>>   be done using 512 MB or 1 GB blocks (depending on page size), instead of
>>   the more granular level that is currently unavoidable if Image cannot be
>>   loaded at base of RAM (since PHYS_OFFSET is tied to the start of the kernel
>>   Image).
>
> Isn't this gain somewhat offset by having to build the kernel as a PIE?

I don't think so. Note that this is not -fpic code, it's just the ld
option that dumps the reloc and dynsym tables into the output image.
The reloc penalty is boottime only.

> If we're doing this for performance it would be good to see numbers.
>

Ack

>> - security: with these changes, we can put the kernel Image anywhere in physical
>>   memory, and we can put the physical memory anywhere in the upper half of the
>>   virtual address range (modulo alignment). This gives us quite a number of
>>   bits of to play with if we were to randomize the kernel virtual address space.
>>   Also, this is entirely under the control of the boot loader, which is probably
>>   in better shape to get its hands on some entropy than the early kernel boot
>>   code.
>> - convenience: fewer constraints when loading the kernel into memory, as it
>>   can execute from anywhere.
>
> I agree that making things easier for loaders is for the best.
>
>> How it works:
>> - an additional boot argument 'image offset' is passed in x1 by the boot loader,
>>   which should contain a value that is at least the offset of Image into physical
>>   memory. Higher values are also possible, and may be used to randomize the
>>   kernel VA space.
>
> I have a very strong suspicion that bootloaders in the wild don't zero
> x1-x3, and that given that we might not have a reliable mechanism for
> acquiring the offset.
>

OK, sounds about time to start complaining about that then.

>> - the kernel binary is runtime relocated to PAGE_OFFSET + image offset
>>
>> Issues:
>> - Since AArch64 uses the ELF RELA format (where the addends are in the
>>   relocation table and not in the code), the relocations need to be applied even
>>   if the Image runs from the same offset it was linked at. It also means that
>>   some values that are produced by the linker (_kernel_size_le, etc) are missing
>>   from the binary. This will probably need a fixup step.
>> - The module area may be out of range, which needs to be worked around with
>>   module PLTs. This is straight forward but I haven't implemented it yet for
>>   arm64.
>> - The core extable is most likely broken, and would need to be changed to use
>>   relative offsets instead of absolute addresses.
>
> This sounds like it's going to be a big headache.
>

It's all manageable, really. The module PLT thing is something I
already implemented for 32-bit ARM here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/305539.html
(only Russell couldn't be bothered to merge it)

The extable is already relative on x86, and the fixup step is some
straight forward ELF mangling on vmlinux before performing the
objcopy.
But yes, it's rather ugly.

> I'd rather see that we decouple the kernel (text/data) mapping from the
> linear mapping, with the former given a fixed VA independent of the PA
> of the kernel Image (which would still need to be at a 2M-aligned
> address + text_offset, and not straddling a 512M boundary).
>

Hmm, that's quite nice, actually, It also fixes the module range
problem, and for VA randomization we could move both regions together.

> That would allow us to place the kernel anywhere in memory (modulo those
> constraints), enable us to address memory below the kernel when we do
> so, and would still allow the kernel to be built with absolute
> addressing, which keeps things simple and fast.
>
> That doesn't give us VA randomisation, but that could be built atop by
> reserving a larger VA range than necessary for the kernel, and have the
> kernel pick a window from within that (assuming we can find some entropy
> early on) to relocate itself to. That would also be independent of the
> physical layout, which is nice -- we could have randomised VAs even with
> a trivial loader that always placed the kernel at the same address
> (which is likely to be the common case).
>

vmlinux.ko ? That would be very cool :-)

> When I looked at this a while back it seemed like the majority of the
> changes were fairly mechanical (introducing and using
> text_to_phys/phys_to_text and leaving virt_to_x for the linear mapping),
> and the big pain points seemed to be the page table init (where we rely
> on memory at the end of the kernel mapping) and KVM.
