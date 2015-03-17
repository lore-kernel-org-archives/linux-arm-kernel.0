From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 17 Mar 2015 08:38:23 +0100
Subject: [RFC PATCH 0/3] arm64: relocatable kernel proof of concept
In-Reply-To: <CAGXu5jJB8jQm+FOqwWLaA1zYsVYs4gMrgmdUH1LUxnoOcZdDrw@mail.gmail.com>
References: <1426519423-28263-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAGXu5jJB8jQm+FOqwWLaA1zYsVYs4gMrgmdUH1LUxnoOcZdDrw@mail.gmail.com>
Message-ID: <CAKv+Gu_A=_d+2=25WCOhAZnxTHQAWY4QZ2eVgyu03aweJvKjPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 March 2015 at 00:19, Kees Cook <keescook@chromium.org> wrote:
> On Mon, Mar 16, 2015 at 8:23 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
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
>> - security: with these changes, we can put the kernel Image anywhere in physical
>>   memory, and we can put the physical memory anywhere in the upper half of the
>>   virtual address range (modulo alignment). This gives us quite a number of
>>   bits of to play with if we were to randomize the kernel virtual address space.
>>   Also, this is entirely under the control of the boot loader, which is probably
>>   in better shape to get its hands on some entropy than the early kernel boot
>>   code.
>
> This is great! Thank you for working on this. ARM kernel text ASLR has
> been on my TODO list for a while now, but I kept looking at the
> missing relocation support and then would start crying. :) (Do you
> have any plans for 32-bit ARM relocation support?)
>

Well, to be honest, I have no real plans at all to devote substantial
time on this, this is really just a rainy Sunday afternoon hack.
But I will check internally (Joakim?) if this is on anyone's radar at Linaro

> Some random brain-dump from my experiences with kASLR on x86:
>
> I don't want to exclusively depend on the bootloader for kASLR. There
> is, I think, already a way to pass entropy into the kernel from the
> bootloader, so perhaps that could be used on top of chipset-specific
> entropy sources? I would like to try to keep the way kASLR gets
> enabled/used/whatever at least compatible with x86 (which probably
> means adding some additional knobs to x86 to gain what ARM will have).
>

Yes, that makes sense.

> Possibly related to running with/detecting an offset, we need a way to
> communicate that kASLR is active through the compressed kernel to
> uncompressed kernel. x86 is going to be using x86's setup_data, but we
> may need to generalize this. (The reasoning here is that when kaslr is
> disabled at runtime, we should turn off other kernel ASLR, like module
> offset ASLR, without duplicating kernel command line parameter parsing
> -- which is what x86 is currently doing now.) Just examining the
> offset isn't sufficient because perhaps we got randomized to offset 0.
> :)
>

There is no decompressor on arm64, just the core kernel Image. So if
an offset needs to be chosen before branching into the kernel proper,
it needs to be the bootloader that chooses it.

> For note, here's kernel module offset ASLR for ARM:
> https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git/commit/?h=kaslr/arm&id=773234f719a5cccb662840b90f41fad2930b2460
>

Interesting. I have a patch for module PLTs (which Russel hasn't
merged yet) which allows modules to reside anywhere in the vmalloc
space. It was mainly for large kernels/modules to work around the
limited range of the branch instructions, but it makes sense for ASLR
as well.
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/305539.html

> You mention the linear mappings in "performance", which I worry may be
> at odds with kASLR? Can large mappings still be used even when we've
> got smaller alignment goals? Since you mention the "upper half of the
> virtual address range", I assume ARM is built using the -2GB
> addressing as used by x86, is that right? So it sounds like it would
> be similar entropy to x86.
>

I haven't quantified the performance gain, but it is arguably more
efficient to map RAM using 1 GB blocks than using 2 MB sections.
On the other part of the question, I really need to do more research
on what x86 implements in the first place before even trying to answer
it.

> We should keep in mind the idea of splitting physical ASLR from
> virtual ASLR. The virtual addresses remain bound to the -2GB
> addressing, but the kernel could be anywhere in physical RAM when
> there is >4GB available. This is currently being worked on for x86.
>

On arm64, the only issue here (again) is that there is no decompressor
so it is up to the bootloader or the very early boot code to move the
image around, and getting any randomness in that case is problematic

>> - convenience: fewer constraints when loading the kernel into memory, as it
>>   can execute from anywhere.
>>
>> How it works:
>> - an additional boot argument 'image offset' is passed in x1 by the boot loader,
>>   which should contain a value that is at least the offset of Image into physical
>>   memory. Higher values are also possible, and may be used to randomize the
>>   kernel VA space.
>> - the kernel binary is runtime relocated to PAGE_OFFSET + image offset
>>
>> Issues:
>> - Since AArch64 uses the ELF RELA format (where the addends are in the
>>   relocation table and not in the code), the relocations need to be applied even
>>   if the Image runs from the same offset it was linked at. It also means that
>>   some values that are produced by the linker (_kernel_size_le, etc) are missing
>>   from the binary. This will probably need a fixup step.
>
> I had no end of troubles with linkers changing their behavior. :) Have
> you looked at arch/x86/tools/relocs* tool, or the reloc mechanisms in
> arch/x86/boot/compressed/misc.c handle_relocations()? It looks like
> you're using real ELF relocations in patch 2, which seems more
> sensible that what x86 is doing (reinventing relocation tables). I'm
> not sure why it's done that way, though.
>

As I said, I need to educate myself a bit before attempting to rework
this into a proper kaslr implementation.

>> - The module area may be out of range, which needs to be worked around with
>>   module PLTs. This is straight forward but I haven't implemented it yet for
>>   arm64.
>> - The core extable is most likely broken, and would need to be changed to use
>>   relative offsets instead of absolute addresses.
>> - Probably lots and lots of other roadblocks, hence this RFC
>>
>> Output from QEMU/efi with 2 GB of memory:
>>
>> Base of RAM:
>>   0x000040000000-0x00004000ffff [Loader Data        |   |  |  |  |   |WB|WT|WC|UC]
>>
>> Physical location of Image:
>>   0x00007f400000-0x00007fe6ffff [Loader Data        |   |  |  |  |   |WB|WT|WC|UC]
>>
>> Virtual kernel memory layout:
>>     vmalloc : 0xffffff8000000000 - 0xffffffbdbfff0000   (   246 GB)
>>     vmemmap : 0xffffffbdc0000000 - 0xffffffbfc0000000   (     8 GB maximum)
>>               0xffffffbdc1000000 - 0xffffffbdc3000000   (    32 MB actual)
>>     fixed   : 0xffffffbffa9fe000 - 0xffffffbffac00000   (  2056 KB)
>>     PCI I/O : 0xffffffbffae00000 - 0xffffffbffbe00000   (    16 MB)
>>     modules : 0xffffffbffc000000 - 0xffffffc000000000   (    64 MB)
>>     memory  : 0xffffffc000000000 - 0xffffffc080000000   (  2048 MB)
>>       .init : 0xffffffc03fb82000 - 0xffffffc03fdbe000   (  2288 KB)
>>       .text : 0xffffffc03f480000 - 0xffffffc03fb81344   (  7173 KB)
>>       .data : 0xffffffc03fdc2000 - 0xffffffc03fe28c00   (   411 KB)
>>
>>
>> Ard Biesheuvel (3):
>>   arm64: head.S: replace early literals with constant immediates
>>   arm64: add support for relocatable kernel
>>   arm64/efi: use relocated kernel
>>
>>  arch/arm64/Kconfig              |  3 ++
>>  arch/arm64/Makefile             |  4 ++
>>  arch/arm64/kernel/efi-entry.S   |  6 ++-
>>  arch/arm64/kernel/efi-stub.c    |  5 ++-
>>  arch/arm64/kernel/head.S        | 94 +++++++++++++++++++++++++++++++----------
>>  arch/arm64/kernel/image.h       |  8 +++-
>>  arch/arm64/kernel/vmlinux.lds.S | 12 ++++++
>>  scripts/sortextable.c           |  4 +-
>>  8 files changed, 107 insertions(+), 29 deletions(-)
>>
>> --
>> 1.8.3.2
>>
>
> I'll try to get this series into a state I can test on my hardware.
> Thanks again!
>

Thanks Kees.
