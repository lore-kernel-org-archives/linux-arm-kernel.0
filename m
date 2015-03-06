From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 6 Mar 2015 13:11:44 +0100
Subject: Intermittent efi libstub build errors on arm64
In-Reply-To: <20150306110941.GA8770@linaro.org>
References: <20150306103428.GA8045@linaro.org>
 <20150306110941.GA8770@linaro.org>
Message-ID: <CAKv+Gu8TWRRgqqCKuyXmTcEQvzJtNVw9ZYVfm327NvEDs0fFJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 March 2015 at 12:09, Steve Capper <steve.capper@linaro.org> wrote:
> On Fri, Mar 06, 2015 at 10:34:29AM +0000, Steve Capper wrote:
>> Hi,
>> I've run into some strange build errors with 3.19.
>>
>> If I set a high number of parallel jobs, I sometimes get build errors
>> such as:
>>
>> mv: cannot stat ?drivers/firmware/efi/libstub/.fdt.o.tmp?: No such file or directory
>>   AR      drivers/firmware/efi/libstub/lib.a
>> scripts/Makefile.build:257: recipe for target 'drivers/firmware/efi/libstub/fdt.o' failed
>> make[1]: *** [drivers/firmware/efi/libstub/fdt.o] Error 1
>> Makefile:939: recipe for target 'drivers/firmware/efi/libstub' failed
>> make: *** [drivers/firmware/efi/libstub] Error 2
>>
>> and,
>>
>> fixdep: error opening depfile: drivers/firmware/efi/libstub/.efi-stub-helper.o.d: No such file or directory
>> scripts/Makefile.build:257: recipe for target 'drivers/firmware/efi/libstub/efi-stub-helper.o' failed
>> make[1]: *** [drivers/firmware/efi/libstub/efi-stub-helper.o] Error 2
>> Makefile:939: recipe for target 'drivers/firmware/efi/libstub' failed
>> make: *** [drivers/firmware/efi/libstub] Error 2
>> make: *** Waiting for unfinished jobs....
>>
>>
>> I think some dependency information/header includes may need tweaking
>> somewhere. Has anyone else come across this, or know more?
>>
>
> Having done some more digging, I believe it may be the libstub
> directory being entered twice by the build system.
>
> I am testing the following patch out:
> --- a/drivers/firmware/efi/Makefile
> +++ b/drivers/firmware/efi/Makefile
> @@ -7,4 +7,3 @@ obj-$(CONFIG_EFI_VARS_PSTORE)           += efi-pstore.o
>  obj-$(CONFIG_UEFI_CPER)                        += cper.o
>  obj-$(CONFIG_EFI_RUNTIME_MAP)          += runtime-map.o
>  obj-$(CONFIG_EFI_RUNTIME_WRAPPERS)     += runtime-wrappers.o
> -obj-$(CONFIG_EFI_STUB)                 += libstub/
>
> To see if the problem persists.
>

I have noticed something odd once or twice, but I thought it was just
my stale build tree.

In any case, removing this line will break x86, as it includes
libstub/lib.a explicitly into its decompressor, so it needs the build
system to traverse libstub/
So we could either drop this and link arm64's vmlinux to libstub/lib.a
explicitly as well, or conditionalize it on CONFIG_ARM64

(This all assuming this is the culprit)

Thanks,
Ard.
