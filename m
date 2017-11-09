From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 9 Nov 2017 21:23:14 +0900
Subject: [PATCH 2/2] kbuild: handle dtb-y and CONFIG_OF_ALL_DTBS natively
 in Makefile.lib
In-Reply-To: <CAAG0J99envT6gtM6tHdTvetrHr0itX1dexkuWSU=u1c5UTLE1A@mail.gmail.com>
References: <1509859853-27473-1-git-send-email-yamada.masahiro@socionext.com>
 <1509859853-27473-3-git-send-email-yamada.masahiro@socionext.com>
 <CAAG0J98rRS+Sw8k_87gmTqYdNWByk=9zWVbWnC348vd63H4N9w@mail.gmail.com>
 <CAAG0J99envT6gtM6tHdTvetrHr0itX1dexkuWSU=u1c5UTLE1A@mail.gmail.com>
Message-ID: <CAK7LNAT-3yBTFqnFECbGzSHRUiaG38b0BG3_3ouRAZRTF+iiDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,


2017-11-09 21:19 GMT+09:00 James Hogan <james@albanarts.com>:
> (resend using a working From address)
>
> <yamada.masahiro@socionext.com> wrote:
>> If CONFIG_OF_ALL_DTBS is enabled, "make ARCH=arm64 dtbs" compiles each
>> DTB twice; one from arch/arm64/boot/dts/*/Makefile and the other from
>> the dtb-$(CONFIG_OF_ALL_DTBS) line in arch/arm64/boot/dts/Makefile.
>> It could be a race problem when building DTBS in parallel.
>>
>> Another minor issue is CONFIG_OF_ALL_DTBS covers only *.dts in vendor
>> sub-directories, so this broke when Broadcom added one more hierarchy
>> in arch/arm64/boot/dts/broadcom/<soc>/.
>>
>> One idea to fix the issues in a clean way is to move DTB handling
>> to Kbuild core scripts.  Makefile.dtbinst already recognizes dtb-y
>> natively, so it should not hurt to do so.
>>
>> Add $(dtb-y) to extra-y, and $(dtb-) as well if CONFIG_OF_ALL_DTBS is
>> enabled.  All clutter things in Makefiles go away.
>>
>> As a bonus clean-up, I also removed dts-dirs.  Just use subdir-y
>> directly to traverse sub-directories.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
>  ...
>
>> diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
>> index 7891ffa..b2b0d88 100644
>> --- a/arch/mips/boot/dts/Makefile
>> +++ b/arch/mips/boot/dts/Makefile
>> @@ -1,20 +1,14 @@
>> -dts-dirs       += brcm
>> -dts-dirs       += cavium-octeon
>> -dts-dirs       += img
>> -dts-dirs       += ingenic
>> -dts-dirs       += lantiq
>> -dts-dirs       += mti
>> -dts-dirs       += netlogic
>> -dts-dirs       += ni
>> -dts-dirs       += pic32
>> -dts-dirs       += qca
>> -dts-dirs       += ralink
>> -dts-dirs       += xilfpga
>> +subdir-y       += brcm
>> +subdir-y       += cavium-octeon
>> +subdir-y       += img
>> +subdir-y       += ingenic
>> +subdir-y       += lantiq
>> +subdir-y       += mti
>> +subdir-y       += netlogic
>> +subdir-y       += ni
>> +subdir-y       += pic32
>> +subdir-y       += qca
>> +subdir-y       += ralink
>> +subdir-y       += xilfpga
>>
>> -obj-y          := $(addsuffix /, $(dts-dirs))
>> -
>> -dtstree                := $(srctree)/$(src)
>> -dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(foreach d,$(dts-dirs), $(wildcard $(dtstree)/$(d)/*.dts)))
>> -
>> -always         := $(dtb-y)
>> -subdir-y       := $(dts-dirs)
>> +obj-$(BUILTIN_DTB)     := $(addsuffix /, $(subdir-y))
>
> I wonder if that should be CONFIG_BUILTIN_DTB?
>
> This is causing failures in linux-next with MIPS
> cavium_octeon_defconfig like below, and changing this line to
> CONFIG_BUILTIN_DTB seems to fix it.

Good catch!


Rob,
Can you fix it to CONFIG_BUILTIN_DTB?

Thanks!



> arch/mips/cavium-octeon/setup.o: In function `__octeon_is_model_runtime__':
> /work/mips/linux/main/./arch/mips/include/asm/octeon/octeon-model.h:368:
> undefined reference to `__dtb_octeon_3xxx_begin'
> arch/mips/cavium-octeon/setup.o: In function `device_tree_init':
> /work/mips/linux/main/arch/mips/cavium-octeon/setup.c:1188: undefined
> reference to `__dtb_octeon_3xxx_begin'
> /work/mips/linux/main/arch/mips/cavium-octeon/setup.c:1184: undefined
> reference to `__dtb_octeon_68xx_begin'
> /work/mips/linux/main/arch/mips/cavium-octeon/setup.c:1184: undefined
> reference to `__dtb_octeon_68xx_begin'
>
> Thanks
> James
>
>


-- 
Best Regards
Masahiro Yamada
