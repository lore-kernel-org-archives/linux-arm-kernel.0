From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 12 Dec 2017 17:08:40 +0100
Subject: [PATCH] ARM: verify size of zImage
In-Reply-To: <CAKv+Gu-oXSpUcJ6acBKyohQ3WxSDp3sK7A4No2y4CHCFw1kSaQ@mail.gmail.com>
 (Ard Biesheuvel's message of "Tue, 28 Nov 2017 16:32:42 +0000")
References: <E1eJiiq-0006k9-FE@rmk-PC.armlinux.org.uk>
 <CAKv+Gu-oXSpUcJ6acBKyohQ3WxSDp3sK7A4No2y4CHCFw1kSaQ@mail.gmail.com>
Message-ID: <87mv2oq67r.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,
 
 On mar., nov. 28 2017, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> (+ Gregory)
>
> On 28 November 2017 at 16:27, Russell King <rmk+kernel@armlinux.org.uk> wrote:
>> The linker can sometimes add additional sections to the zImage ELF file
>> which results in the zImage binary being larger than expected.  This
>> causes appended DT blobs to fail.
>>
>> Verify that the zImage binary is the expected size, and fail the build
>> if this is not the case.
>>
>> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>> ---
>> As this patch is different, I've dropped Matthias' tested-by.  I'd
>> appreciate a replacement, thanks.  Also, I seem to remember that
>> Ard's toolchain was giving issues - maybe this alternative will
>> finally resolve them.
>>
>
> $ nm arch/arm/boot/compressed/vmlinux |grep _edata
> 007b8200 D _edata
> 007b8200 D _edata_real
>
> Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> although I don't remember seeing this fail. It think it may have been
> Gregory who was having these issues?

Thanks to remember me, I finally find time to test it, and with my setup
I didn't have anymore issue while building it for a dtb append zImage
for Armada XP:

Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Gregory


>
>
>
>>  arch/arm/boot/compressed/vmlinux.lds.S | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
>> index e6bf6774c4bb..ed53ca9f482e 100644
>> --- a/arch/arm/boot/compressed/vmlinux.lds.S
>> +++ b/arch/arm/boot/compressed/vmlinux.lds.S
>> @@ -101,6 +101,12 @@ SECTIONS
>>     * this symbol allows further debug in the near future.
>>     */
>>    .image_end (NOLOAD) : {
>> +    /*
>> +     * EFI requires that the image is aligned to 512 bytes, and appended
>> +     * DTB requires that we know where the end of the image is.  Ensure
>> +     * that both are satisfied by ensuring that there are no additional
>> +     * sections emitted into the decompressor image.
>> +     */
>>      _edata_real = .;
>>    }
>>
>> @@ -128,3 +134,4 @@ SECTIONS
>>    .stab.indexstr 0     : { *(.stab.indexstr) }
>>    .comment 0           : { *(.comment) }
>>  }
>> +ASSERT(_edata_real == _edata, "error: zImage file size is incorrect");
>> --
>> 2.7.4
>>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
