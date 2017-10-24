From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 24 Oct 2017 10:13:09 +0100
Subject: [PATCH] ARM: Fix zImage file size not aligned with
 CONFIG_EFI_STUB enabled
In-Reply-To: <20171024090953.GZ20805@n2100.armlinux.org.uk>
References: <20171018050108.10352-1-jeffy.chen@rock-chips.com>
 <CAKv+Gu9ReBC+rLxaD-+Mp+aWRDfsYECAeOZo9CYU3big2nPw0w@mail.gmail.com>
 <20171022124757.GL20805@n2100.armlinux.org.uk>
 <CAKv+Gu9cgt0sjW_pnaXN6J8j8BXAb7z+gLhDY3oMaKwK5vcO-Q@mail.gmail.com>
 <59ED6179.5020301@rock-chips.com>
 <20171023085006.GM20805@n2100.armlinux.org.uk>
 <59EDC34C.40109@rock-chips.com> <20171023105046.GT20805@n2100.armlinux.org.uk>
 <20171023114549.GU20805@n2100.armlinux.org.uk>
 <CAKv+Gu_R+OfHMxcZEJML4Pm54DyOji6S42LihMgi6+vxi9LOAQ@mail.gmail.com>
 <20171024090953.GZ20805@n2100.armlinux.org.uk>
Message-ID: <CAKv+Gu_t=7uZ91MbVUqNfTcxX+3HKPF1+ZjS2-2Mn-Wq6D9H6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 October 2017 at 10:09, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Tue, Oct 24, 2017 at 09:09:52AM +0100, Ard Biesheuvel wrote:
>> The following patch appears to fix the issue as well:
>>
>> diff --git a/arch/arm/boot/compressed/vmlinux.lds.S
>> b/arch/arm/boot/compressed/vmlinux.lds.S
>> index 7a4c59154361..0e0f504e256e 100644
>> --- a/arch/arm/boot/compressed/vmlinux.lds.S
>> +++ b/arch/arm/boot/compressed/vmlinux.lds.S
>> @@ -83,7 +83,9 @@ SECTIONS
>>    __pecoff_data_rawsize = . - ADDR(.data);
>>  #endif
>>
>> -  _edata = .;
>> +  .edata (NOLOAD) : {
>> +    _edata = .;
>> +  }
>>
>>    _magic_sig = ZIMAGE_MAGIC(0x016f2818);
>>    _magic_start = ZIMAGE_MAGIC(_start);
>>
>> because the NOLOAD triggers the linker to emit all PROGBITS sections
>> before _edata, including unknown ones.
>>
>> E.g., in my binary, it gives me
>>
>> 00798020 D __pecoff_data_end
>> 00798200 d __ksymtab_sort
>> 00798208 B __bss_start
>> 00798208 D _edata
>
> The question is: do we want to know when additional sections get
> emitted into the binary?
>

Well, we need to know whether the size of zImage is a multiple of 512
bytes. We could check that separately by adding the following as well

#ifdef CONFIG_EFI_STUB
ASSERT((_edata % 512 == 0), "zImage file size is not a multiple of 512 bytes")
#endif

> You've already said that for EFI, you need the size of the binary
> to be a multiple of 512, so I guess the answer to that is "yes".
>

Indeed.
