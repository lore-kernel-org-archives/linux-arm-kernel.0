From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 9 Oct 2017 13:39:34 +0100
Subject: [PATCH] ARM: compressed: discard ksym/kcrctab input section
In-Reply-To: <20171004124320.GP20805@n2100.armlinux.org.uk>
References: <20170908153143.27279-1-ard.biesheuvel@linaro.org>
 <87d163kt0m.fsf@free-electrons.com>
 <CAKv+Gu_pGeDxK_vD9iGUO486VgLsntMQwVs9wGKa79pkx7paMQ@mail.gmail.com>
 <20171004124320.GP20805@n2100.armlinux.org.uk>
Message-ID: <CAKv+Gu_t+oLJKGzy3LxgLZqqYsd9eQiwZRr6dgPbqpsHnQUUxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 October 2017 at 13:43, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Wed, Oct 04, 2017 at 01:20:26PM +0100, Ard Biesheuvel wrote:
>> On 4 October 2017 at 13:16, Gregory CLEMENT
>> <gregory.clement@free-electrons.com> wrote:
>> > Hi Ard,
>> >
>> >  On ven., sept. 08 2017, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> >
>> >> As it turns out, building the ARM kernel with EFI support pulls in
>> >> a couple of sections that we don't really need in the decompressor.
>> >> This is due to the fact the the UEFI stub uses sort() to sort the UEFI
>> >> memory map, which is an exported symbol pulled in from lib/sort.c.
>> >>
>> >> Before commit e4bae4d0b5f3 ("arm/efi: Split zImage code and data into
>> >> separate PE/COFF sections"), this resulted in the following layout
>> >> for the decompressor ELF binary.
>> >>
>> >>   [Nr] Name              Type     Addr     Off    Size   ES Flg Lk Inf Al
>> >>   [ 0]                   NULL     00000000 000000 000000 00      0   0  0
>> >>   [ 1] .text             PROGBITS 00000000 010000 009b3c 00  AX  0   0 512
>> >>   [ 2] .rodata           PROGBITS 00009b3c 019b3c 001684 00   A  0   0  4
>> >>   [ 3] __ksymtab_strings PROGBITS 0000b1c0 01b1c0 000005 00   A  0   0  1
>> >>   [ 4] .data             PROGBITS 0000b1c8 01b1c8 000020 00  WA  0   0  8
>> >>   [ 5] ___ksymtab+sort   PROGBITS 0000b1e8 01b1e8 000008 00  WA  0   0  4
>> >>   [ 6] .piggydata        PROGBITS 0000b1f0 01b1f0 77ac38 00   A  0   0  1
>> >>   [ 7] .got.plt          PROGBITS 00785e28 795e28 00000c 04  WA  0   0  4
>> >>   [ 8] .got              PROGBITS 00785e34 795e34 000028 00  WA  0   0  4
>> >>   [ 9] .pad              PROGBITS 00785e5c 795e5c 000004 00  WA  0   0  1
>> >>   [10] .bss              NOBITS   00785e60 795e60 00001c 00  WA  0   0  4
>> >>   [11] .stack            NOBITS   00785e80 795e60 001000 00  WA  0   0  1
>> >>
>> >> Commit e4bae4d0b5f3 made some changes to the linker script to allow the
>> >> UEFI firmware to map the decompressor with strict R-X/RW- permissions
>> >> before invoking it. Unfortunately, this turns out to break the boot on
>> >> some systems, because the linker now also moves the ksymtab/kcrctab
>> >> sections around, resulting in .piggydata to appear misaligned.
>> >>
>> >>   [Nr] Name              Type     Addr     Off    Size   ES Flg Lk Inf Al
>> >>   [ 0]                   NULL     00000000 000000 000000 00      0   0  0
>> >>   [ 1] .text             PROGBITS 00000000 010000 00a93c 00  AX  0   0 4096
>> >>   [ 2] .rodata           PROGBITS 0000a93c 01a93c 001684 00   A  0   0  4
>> >>   [ 3] __ksymtab_strings PROGBITS 0000bfc0 01bfc0 000005 00   A  0   0  1
>> >>   [ 4] .piggydata        PROGBITS 0000bfc5 01bfc5 77ac47 00   A  0   0  1
>> >>   [ 5] .got.plt          PROGBITS 00786c0c 796c0c 00000c 04  WA  0   0  4
>> >>   [ 6] .got              PROGBITS 00786c18 796c18 000028 00  WA  0   0  4
>> >>   [ 7] .pad              PROGBITS 00786c40 796c40 000008 00  WA  0   0  1
>> >>   [ 8] .data             PROGBITS 00787000 797000 000200 00  WA  0   0 4096
>> >>   [ 9] ___ksymtab+sort   PROGBITS 00787200 797200 000008 00  WA  0   0  4
>> >>   [10] .bss              NOBITS   00787208 797208 00001c 00  WA  0   0  4
>> >>   [11] .stack            NOBITS   00787228 797208 001000 00  WA  0   0  1
>> >>
>> >> So let's align piggydata explicitly, and discard these sections from the
>> >> binary.
>> >>
>> >> Cc: Russell King <linux@armlinux.org.uk>
>> >> Fixes: e4bae4d0b5f3 ("arm/efi: Split zImage code and data into separate ...")
>> >> Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> >
>> > Any new for this patch?
>> >
>> > It is not yet in v4.14-rc whereas "arm/efi: Split zImage code and data
>> > into separate ..." was already merged. So currently I have many boards
>> > which still does not boot in v4.14-rc3.
>> >
>>
>> Russell, any objections?
>
> It would be nice if there was something in the commit log that described
> why we need to align data that is basically a byte stream, and which
> decompressor methods it affects.  Maybe the decompressors should cope
> with a misaligned byte stream - what if (for example) someone supplies
> the kernel with a compressed initramfs image that is not word aligned?

The decompressor copes with a misaligned byte stream by using
get_unaligned et al. Only, on v7, these are simply converted to word
wide unaligned accesses, which the compiler may merge into ldm/stm if
they occur adjacently. In the kernel proper, this is caught and fixed
up by the alignment fixup code, but in the decompressor you hit the
fault.

> We already have people using non-page aligned compressed initramfs
> images.
>

Yes, but initramfs accesses are fixed up by the alignment fixup code as well.

So I suppose Arnd's patch to switch to the struct type unaligned
accessor would deal with this issue as well.
