From: jeffy.chen@rock-chips.com (jeffy)
Date: Mon, 23 Oct 2017 11:26:49 +0800
Subject: [PATCH] ARM: Fix zImage file size not aligned with CONFIG_EFI_STUB
 enabled
In-Reply-To: <CAKv+Gu9cgt0sjW_pnaXN6J8j8BXAb7z+gLhDY3oMaKwK5vcO-Q@mail.gmail.com>
References: <20171018050108.10352-1-jeffy.chen@rock-chips.com>
 <CAKv+Gu9ReBC+rLxaD-+Mp+aWRDfsYECAeOZo9CYU3big2nPw0w@mail.gmail.com>
 <20171022124757.GL20805@n2100.armlinux.org.uk>
 <CAKv+Gu9cgt0sjW_pnaXN6J8j8BXAb7z+gLhDY3oMaKwK5vcO-Q@mail.gmail.com>
Message-ID: <59ED6179.5020301@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On 10/22/2017 09:01 PM, Ard Biesheuvel wrote:
> On 22 October 2017 at 13:47, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
>> On Sun, Oct 22, 2017 at 12:01:13PM +0100, Ard Biesheuvel wrote:
>>> On 18 October 2017 at 06:01, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
>>>> The zImage file size should be aligned.
>>>>
>>>> Fixes: e4bae4d0b5f3 ("arm/efi: Split zImage code and data into separate PE/COFF sections")
>>>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>>>> ---
>>>>
>>>>   arch/arm/boot/compressed/vmlinux.lds.S | 8 ++++----
>>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
>>>> index b38dcef90756..1636fa259577 100644
>>>> --- a/arch/arm/boot/compressed/vmlinux.lds.S
>>>> +++ b/arch/arm/boot/compressed/vmlinux.lds.S
>>>> @@ -70,10 +70,6 @@ SECTIONS
>>>>     .got                 : { *(.got) }
>>>>     _got_end = .;
>>>>
>>>> -  /* ensure the zImage file size is always a multiple of 64 bits */
>>>> -  /* (without a dummy byte, ld just ignores the empty section) */
>>>> -  .pad                 : { BYTE(0); . = ALIGN(8); }
>>>> -
>>>>   #ifdef CONFIG_EFI_STUB
>>>>     .data : ALIGN(4096) {
>>>>       __pecoff_data_start = .;
>>>> @@ -93,6 +89,10 @@ SECTIONS
>>>>     __pecoff_data_rawsize = . - ADDR(.data);
>>>>   #endif
>>>>
>>>> +  /* ensure the zImage file size is always a multiple of 64 bits */
>>>> +  /* (without a dummy byte, ld just ignores the empty section) */
>>>> +  .pad                 : { BYTE(0); . = ALIGN(8); }
>>>> +
>>>>     _edata = .;
>>>>
>>>>     _magic_sig = ZIMAGE_MAGIC(0x016f2818);
>>>> --
>>>> 2.11.0
>>>>
>>>
>>> This is not the right fix. If CONFIG_EFI_STUB is enabled, the zImage
>>> filesize should be rounded up to 512 bytes not 8 bytes. The '. =
>>> ALIGN(512);' in the .data section appears to ensure that, but for some
>>> reason, that appears not to be working.
>>
>> Actually, the existing .pad section is totally and utterly bogus when
>> EFI is enabled:
>>
>>    . = ALIGN(4);
>>    _etext = .;
>>
>>    .got.plt              : { *(.got.plt) }
>>    _got_start = .;
>>    .got                  : { *(.got) }
>>    _got_end = .;
>>
>> The .got.plt and .got are always word-based.  This is then followed by
>> .pad, which does nothing but pad out to a multiple of 64 bit:
>>
>>    /* ensure the zImage file size is always a multiple of 64 bits */
>>    /* (without a dummy byte, ld just ignores the empty section) */
>>    .pad                  : { BYTE(0); . = ALIGN(8); }
>>
>> So this may add zero or 4 bytes of padding.
>>
>> This is then followed by the EFI data:
>>
>>    .data : ALIGN(4096) {
>>    ...
>>      . = ALIGN(512);
>>    }
>>
>> which is aligned to 4K but aligns the end of itself to 512.
>>
>> So, we have the end of .got aligned to 4, followed by .pad that tries to
>> align to 8, followed by an optional .data section.  This is pointless.
>>
>> A sane patch would be to choose between the EFI .data section and the
>> .pad section.  So, it should be:
>>
>> #ifdef CONFIG_EFI_STUB
>>     .data : ALIGN(4096) {
>>     ...
>>       . = ALIGN(512);
>>     }
>> #else
>>     .pad                 : { BYTE(0); . = ALIGN(8); }
>> #endif
>>
>
> Agreed, the .pad section has no point for EFI_STUB=y. However, it
> seems this symptom is caused by the same issues I am trying to address
> here
>
> https://marc.info/?l=linux-arm-kernel&m=150488477807353
>
> which is that we have __ksymtab_xxx sections that we should discard,
> because the linker will otherwise emit them /after/ .data or .pad.
> This is caused by the use of lib/sort.c in the EFI stub, which
> contains an EXPORT_SYMBOL().

hmm, right, didn't notice the data is already aligned...
so it's indeed caused by the ksym:

   [ 9] .data             PROGBITS        006ce000 6d6000 000200 00  WA 
  0   0 4096
   [10] ___ksymtab+sort   PROGBITS        006ce200 6d6200 000008 00  WA 
  0   0  4
   [11] .bss              NOBITS          006ce208 6d6208 00001c 00  WA 
  0   0  4


and both of your old([PATCH] ARM: compressed: discard ksym/kcrctab input 
section) and new([PATCH] efi/libstub: arm: omit sorting of the UEFI 
memory map) patches fix the issue i meet, thanks:)

>
> Would you perhaps prefer that I clone sort.c into its own .c file
> specifically for the EFI stub? (under drivers/firmware/efi/libstub)
> That should get rid of these spurious sections and thus the
> misalignments and/or movements that are causing all of these issues.
>
>
>
