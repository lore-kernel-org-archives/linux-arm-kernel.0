From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 16 Mar 2015 18:43:14 +0100
Subject: [RFC PATCH 0/3] arm64: relocatable kernel proof of concept
In-Reply-To: <20150316173324.GA21040@leverpostej>
References: <1426519423-28263-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150316160948.GB18277@leverpostej>
 <CAKv+Gu_-1XMcpobRt7tXCZaqWoszWLfJxgHBLaKuWchz87UnSA@mail.gmail.com>
 <20150316173324.GA21040@leverpostej>
Message-ID: <AEDF43E0-1C4F-43DF-B8A2-BFF7836091E8@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 16 mrt. 2015, at 18:33, Mark Rutland <mark.rutland@arm.com> wrote:

>>>> - performance: we can align PHYS_OFFSET so that most of the linear mapping can
>>>>  be done using 512 MB or 1 GB blocks (depending on page size), instead of
>>>>  the more granular level that is currently unavoidable if Image cannot be
>>>>  loaded at base of RAM (since PHYS_OFFSET is tied to the start of the kernel
>>>>  Image).
>>> 
>>> Isn't this gain somewhat offset by having to build the kernel as a PIE?
>> 
>> I don't think so. Note that this is not -fpic code, it's just the ld
>> option that dumps the reloc and dynsym tables into the output image.
>> The reloc penalty is boottime only.
> 
> Ah, ok.
> 
>>> I have a very strong suspicion that bootloaders in the wild don't zero
>>> x1-x3, and that given that we might not have a reliable mechanism for
>>> acquiring the offset.
>> 
>> OK, sounds about time to start complaining about that then.
> 
> I guess so.
> 
>>>> Issues:
>>>> - Since AArch64 uses the ELF RELA format (where the addends are in the
>>>>  relocation table and not in the code), the relocations need to be applied even
>>>>  if the Image runs from the same offset it was linked at. It also means that
>>>>  some values that are produced by the linker (_kernel_size_le, etc) are missing
>>>>  from the binary. This will probably need a fixup step.
>>>> - The module area may be out of range, which needs to be worked around with
>>>>  module PLTs. This is straight forward but I haven't implemented it yet for
>>>>  arm64.
>>>> - The core extable is most likely broken, and would need to be changed to use
>>>>  relative offsets instead of absolute addresses.
>>> 
>>> This sounds like it's going to be a big headache.
>> 
>> It's all manageable, really. The module PLT thing is something I
>> already implemented for 32-bit ARM here:
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/305539.html
>> (only Russell couldn't be bothered to merge it)
>> 
>> The extable is already relative on x86, and the fixup step is some
>> straight forward ELF mangling on vmlinux before performing the
>> objcopy.
>> But yes, it's rather ugly.
> 
> Hmm. I'd be rather worried about the fixup step; I suspect that'll be
> fragile and rarely tested. Perhaps we could verify them at boot time?

It would essentially be __relocate_kernel() but executed at build time against vmlinux with a reloc offset of #0

> 
>>> I'd rather see that we decouple the kernel (text/data) mapping from the
>>> linear mapping, with the former given a fixed VA independent of the PA
>>> of the kernel Image (which would still need to be at a 2M-aligned
>>> address + text_offset, and not straddling a 512M boundary).
>> 
>> Hmm, that's quite nice, actually, It also fixes the module range
>> problem, and for VA randomization we could move both regions together.
> 
> Ah, good point. I hadn't consdiered modules all that much, but it sounds
> like it could work.
> 
