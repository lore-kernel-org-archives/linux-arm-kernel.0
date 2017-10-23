From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 23 Oct 2017 23:15:18 +0200
Subject: [PATCH] ARM: compressed: discard ksym/kcrctab input section
In-Reply-To: <20171023092956.GN20805@n2100.armlinux.org.uk>
References: <20170908153143.27279-1-ard.biesheuvel@linaro.org>
 <33486b3e-8221-92b0-7e18-859be7d0a74b@suse.com>
 <CAKv+Gu-8PEPuWH=bT_wD0MYDw67RY3gQudW2mLO-QeBYqQesyw@mail.gmail.com>
 <2b3af288-51b1-561a-a1a9-f5f42f7ca1c4@gmail.com>
 <20171023092956.GN20805@n2100.armlinux.org.uk>
Message-ID: <973a510c-559f-152b-44af-f4ae022f1d60@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/23/2017 11:29 AM, Russell King - ARM Linux wrote:
> On Mon, Oct 23, 2017 at 12:00:46AM +0200, Matthias Brugger wrote:
>> Hi Ard,
>>
>> On 10/21/2017 10:14 AM, Ard Biesheuvel wrote:
>>> On 21 October 2017 at 08:56, Matthias Brugger <mbrugger@suse.com> wrote:
>>>> On 09/08/2017 05:31 PM, Ard Biesheuvel wrote:
>>>>> As it turns out, building the ARM kernel with EFI support pulls in
>>>>> a couple of sections that we don't really need in the decompressor.
>>>>> This is due to the fact the the UEFI stub uses sort() to sort the UEFI
>>>>> memory map, which is an exported symbol pulled in from lib/sort.c.
>>>>>
>>>>> Before commit e4bae4d0b5f3 ("arm/efi: Split zImage code and data into
>>>>> separate PE/COFF sections"), this resulted in the following layout
>>>>> for the decompressor ELF binary.
>>>>>
>>>>>   [Nr] Name              Type     Addr     Off    Size   ES Flg Lk Inf Al
>>>>>   [ 0]                   NULL     00000000 000000 000000 00      0   0  0
>>>>>   [ 1] .text             PROGBITS 00000000 010000 009b3c 00  AX  0   0 512
>>>>>   [ 2] .rodata           PROGBITS 00009b3c 019b3c 001684 00   A  0   0  4
>>>>>   [ 3] __ksymtab_strings PROGBITS 0000b1c0 01b1c0 000005 00   A  0   0  1
>>>>>   [ 4] .data             PROGBITS 0000b1c8 01b1c8 000020 00  WA  0   0  8
>>>>>   [ 5] ___ksymtab+sort   PROGBITS 0000b1e8 01b1e8 000008 00  WA  0   0  4
>>>>>   [ 6] .piggydata        PROGBITS 0000b1f0 01b1f0 77ac38 00   A  0   0  1
>>>>>   [ 7] .got.plt          PROGBITS 00785e28 795e28 00000c 04  WA  0   0  4
>>>>>   [ 8] .got              PROGBITS 00785e34 795e34 000028 00  WA  0   0  4
>>>>>   [ 9] .pad              PROGBITS 00785e5c 795e5c 000004 00  WA  0   0  1
>>>>>   [10] .bss              NOBITS   00785e60 795e60 00001c 00  WA  0   0  4
>>>>>   [11] .stack            NOBITS   00785e80 795e60 001000 00  WA  0   0  1
>>>>>
>>>>> Commit e4bae4d0b5f3 made some changes to the linker script to allow the
>>>>> UEFI firmware to map the decompressor with strict R-X/RW- permissions
>>>>> before invoking it. Unfortunately, this turns out to break the boot on
>>>>> some systems, because the linker now also moves the ksymtab/kcrctab
>>>>> sections around, resulting in .piggydata to appear misaligned.
>>>>>
>>>>>   [Nr] Name              Type     Addr     Off    Size   ES Flg Lk Inf Al
>>>>>   [ 0]                   NULL     00000000 000000 000000 00      0   0  0
>>>>>   [ 1] .text             PROGBITS 00000000 010000 00a93c 00  AX  0   0 4096
>>>>>   [ 2] .rodata           PROGBITS 0000a93c 01a93c 001684 00   A  0   0  4
>>>>>   [ 3] __ksymtab_strings PROGBITS 0000bfc0 01bfc0 000005 00   A  0   0  1
>>>>>   [ 4] .piggydata        PROGBITS 0000bfc5 01bfc5 77ac47 00   A  0   0  1
>>>>>   [ 5] .got.plt          PROGBITS 00786c0c 796c0c 00000c 04  WA  0   0  4
>>>>>   [ 6] .got              PROGBITS 00786c18 796c18 000028 00  WA  0   0  4
>>>>>   [ 7] .pad              PROGBITS 00786c40 796c40 000008 00  WA  0   0  1
>>>>>   [ 8] .data             PROGBITS 00787000 797000 000200 00  WA  0   0 4096
>>>>>   [ 9] ___ksymtab+sort   PROGBITS 00787200 797200 000008 00  WA  0   0  4
>>>>>   [10] .bss              NOBITS   00787208 797208 00001c 00  WA  0   0  4
>>>>>   [11] .stack            NOBITS   00787228 797208 001000 00  WA  0   0  1
>>>>>
>>>>> So let's align piggydata explicitly, and discard these sections from the
>>>>> binary.
>>>>>
>>>>> Cc: Russell King <linux@armlinux.org.uk>
>>>>> Fixes: e4bae4d0b5f3 ("arm/efi: Split zImage code and data into separate ...")
>>>>> Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>>> ---
>>>>>  arch/arm/boot/compressed/piggy.S       | 1 +
>>>>>  arch/arm/boot/compressed/vmlinux.lds.S | 1 +
>>>>>  2 files changed, 2 insertions(+)
>>>>>
>>>>
>>>> This fixes the boot regression on bananapi-r2.
>>>> Thanks! Feel free to add:
>>>>
>>>> Tested-by: Matthias Brugger <mbrugger@suse.com>
>>>>
>>>
>>> Thanks for confirming Matthias. Could you please check whether this
>>> patch from Arnd
>>>
>>> https://marc.info/?l=linux-kernel&m=150852980119217&w=2
>>>
>>> fixes the issue as well? (after reverting this one)
>>>
>>
>> After only applying this patch on top of v4.14-rc5 I was not able to boot.
> 
> Which decompression method are you using?

uImage/zImage

> 
> What does objdump -h arch/arm/boot/vmlinux say?
> 

arch/arm/boot/compressed/vmlinux:     file format elf32-littlearm

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         0000b06c  00000000  00000000  00010000  2**12
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .rodata       000016cc  0000b06c  0000b06c  0001b06c  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  2 __ksymtab_strings 00000005  0000c738  0000c738  0001c738  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  3 .piggydata    007ce9c5  0000c73d  0000c73d  0001c73d  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  4 .got.plt      0000000c  007db104  007db104  007eb104  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  5 .got          00000028  007db110  007db110  007eb110  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  6 .pad          00000008  007db138  007db138  007eb138  2**0
                  CONTENTS, ALLOC, LOAD, DATA
  7 .data         00000200  007dc000  007dc000  007ec000  2**12
                  CONTENTS, ALLOC, LOAD, DATA
  8 ___ksymtab+sort 00000008  007dc200  007dc200  007ec200  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  9 .bss          0000001c  007dc208  007dc208  007ec208  2**2
                  ALLOC
 10 .stack        00001000  007dc228  007dc228  007ec208  2**0
                  ALLOC
 11 .comment      0000002d  00000000  00000000  007ec208  2**0
                  CONTENTS, READONLY
 12 .ARM.attributes 0000002d  00000000  00000000  007ec235  2**0
                  CONTENTS, READONLY
 13 .debug_line   00007088  00000000  00000000  007ec262  2**0
                  CONTENTS, READONLY, DEBUGGING
 14 .debug_info   00057677  00000000  00000000  007f32ea  2**0
                  CONTENTS, READONLY, DEBUGGING
 15 .debug_abbrev 00003bc2  00000000  00000000  0084a961  2**0
                  CONTENTS, READONLY, DEBUGGING
 16 .debug_aranges 00000308  00000000  00000000  0084e528  2**3
                  CONTENTS, READONLY, DEBUGGING
 17 .debug_ranges 00000e78  00000000  00000000  0084e830  2**3
                  CONTENTS, READONLY, DEBUGGING
 18 .debug_frame  00002228  00000000  00000000  0084f6a8  2**2
                  CONTENTS, READONLY, DEBUGGING
 19 .debug_loc    00005bff  00000000  00000000  008518d0  2**0
                  CONTENTS, READONLY, DEBUGGING
 20 .debug_str    00008c41  00000000  00000000  008574cf  2**0
                  CONTENTS, READONLY, DEBUGGING

This objdump is with Arnd Bergmans patch applied on top of v4.14-rc5.

Beware that Ard provided a patch against efi/libstub which independently fixes
the boot regression:
"efi/libstub: arm: omit sorting of the UEFI memory map"

Regards,
Matthias
