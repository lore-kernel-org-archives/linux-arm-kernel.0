From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 23 Oct 2017 00:00:46 +0200
Subject: [PATCH] ARM: compressed: discard ksym/kcrctab input section
In-Reply-To: <CAKv+Gu-8PEPuWH=bT_wD0MYDw67RY3gQudW2mLO-QeBYqQesyw@mail.gmail.com>
References: <20170908153143.27279-1-ard.biesheuvel@linaro.org>
 <33486b3e-8221-92b0-7e18-859be7d0a74b@suse.com>
 <CAKv+Gu-8PEPuWH=bT_wD0MYDw67RY3gQudW2mLO-QeBYqQesyw@mail.gmail.com>
Message-ID: <2b3af288-51b1-561a-a1a9-f5f42f7ca1c4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On 10/21/2017 10:14 AM, Ard Biesheuvel wrote:
> On 21 October 2017 at 08:56, Matthias Brugger <mbrugger@suse.com> wrote:
>> On 09/08/2017 05:31 PM, Ard Biesheuvel wrote:
>>> As it turns out, building the ARM kernel with EFI support pulls in
>>> a couple of sections that we don't really need in the decompressor.
>>> This is due to the fact the the UEFI stub uses sort() to sort the UEFI
>>> memory map, which is an exported symbol pulled in from lib/sort.c.
>>>
>>> Before commit e4bae4d0b5f3 ("arm/efi: Split zImage code and data into
>>> separate PE/COFF sections"), this resulted in the following layout
>>> for the decompressor ELF binary.
>>>
>>>   [Nr] Name              Type     Addr     Off    Size   ES Flg Lk Inf Al
>>>   [ 0]                   NULL     00000000 000000 000000 00      0   0  0
>>>   [ 1] .text             PROGBITS 00000000 010000 009b3c 00  AX  0   0 512
>>>   [ 2] .rodata           PROGBITS 00009b3c 019b3c 001684 00   A  0   0  4
>>>   [ 3] __ksymtab_strings PROGBITS 0000b1c0 01b1c0 000005 00   A  0   0  1
>>>   [ 4] .data             PROGBITS 0000b1c8 01b1c8 000020 00  WA  0   0  8
>>>   [ 5] ___ksymtab+sort   PROGBITS 0000b1e8 01b1e8 000008 00  WA  0   0  4
>>>   [ 6] .piggydata        PROGBITS 0000b1f0 01b1f0 77ac38 00   A  0   0  1
>>>   [ 7] .got.plt          PROGBITS 00785e28 795e28 00000c 04  WA  0   0  4
>>>   [ 8] .got              PROGBITS 00785e34 795e34 000028 00  WA  0   0  4
>>>   [ 9] .pad              PROGBITS 00785e5c 795e5c 000004 00  WA  0   0  1
>>>   [10] .bss              NOBITS   00785e60 795e60 00001c 00  WA  0   0  4
>>>   [11] .stack            NOBITS   00785e80 795e60 001000 00  WA  0   0  1
>>>
>>> Commit e4bae4d0b5f3 made some changes to the linker script to allow the
>>> UEFI firmware to map the decompressor with strict R-X/RW- permissions
>>> before invoking it. Unfortunately, this turns out to break the boot on
>>> some systems, because the linker now also moves the ksymtab/kcrctab
>>> sections around, resulting in .piggydata to appear misaligned.
>>>
>>>   [Nr] Name              Type     Addr     Off    Size   ES Flg Lk Inf Al
>>>   [ 0]                   NULL     00000000 000000 000000 00      0   0  0
>>>   [ 1] .text             PROGBITS 00000000 010000 00a93c 00  AX  0   0 4096
>>>   [ 2] .rodata           PROGBITS 0000a93c 01a93c 001684 00   A  0   0  4
>>>   [ 3] __ksymtab_strings PROGBITS 0000bfc0 01bfc0 000005 00   A  0   0  1
>>>   [ 4] .piggydata        PROGBITS 0000bfc5 01bfc5 77ac47 00   A  0   0  1
>>>   [ 5] .got.plt          PROGBITS 00786c0c 796c0c 00000c 04  WA  0   0  4
>>>   [ 6] .got              PROGBITS 00786c18 796c18 000028 00  WA  0   0  4
>>>   [ 7] .pad              PROGBITS 00786c40 796c40 000008 00  WA  0   0  1
>>>   [ 8] .data             PROGBITS 00787000 797000 000200 00  WA  0   0 4096
>>>   [ 9] ___ksymtab+sort   PROGBITS 00787200 797200 000008 00  WA  0   0  4
>>>   [10] .bss              NOBITS   00787208 797208 00001c 00  WA  0   0  4
>>>   [11] .stack            NOBITS   00787228 797208 001000 00  WA  0   0  1
>>>
>>> So let's align piggydata explicitly, and discard these sections from the
>>> binary.
>>>
>>> Cc: Russell King <linux@armlinux.org.uk>
>>> Fixes: e4bae4d0b5f3 ("arm/efi: Split zImage code and data into separate ...")
>>> Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> ---
>>>  arch/arm/boot/compressed/piggy.S       | 1 +
>>>  arch/arm/boot/compressed/vmlinux.lds.S | 1 +
>>>  2 files changed, 2 insertions(+)
>>>
>>
>> This fixes the boot regression on bananapi-r2.
>> Thanks! Feel free to add:
>>
>> Tested-by: Matthias Brugger <mbrugger@suse.com>
>>
> 
> Thanks for confirming Matthias. Could you please check whether this
> patch from Arnd
> 
> https://marc.info/?l=linux-kernel&m=150852980119217&w=2
> 
> fixes the issue as well? (after reverting this one)
> 

After only applying this patch on top of v4.14-rc5 I was not able to boot.

Regards,
Matthias
