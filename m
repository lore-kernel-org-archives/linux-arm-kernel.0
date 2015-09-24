From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 24 Sep 2015 16:23:30 -0700
Subject: [RFC PATCH] arm64/efi: remove /chosen/linux,
 uefi-stub-kern-ver DT property
In-Reply-To: <20150924231309.GA1650@svinekod>
References: <1443131190-17790-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150924231309.GA1650@svinekod>
Message-ID: <CAKv+Gu9kR+xph2PFN0XFVAx0XjHNLZ5U=wKWN8SLk6bc3=PmFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 September 2015 at 16:13, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Ard,
>
> On Thu, Sep 24, 2015 at 10:46:30PM +0100, Ard Biesheuvel wrote:
>> With the stub to kernel interface being promoted to a proper interface
>> so that other agents than the stub can boot the kernel proper in EFI
>> mode, we can remove the linux,uefi-stub-kern-ver field, considering
>> that its original purpose was to prevent this from happening in the
>> first place.
>
> I'm not oppposed to this, but this change needs to be folded together with the
> other documentation updates necessary for this to become a stable ABI, as
> discussed in the other thread [1].
>

Yes, you are quite right (and apologies to Stefano and Shannon for not
cc'ing them on this patch)

It would be good to remove this /before/ promoting any of this to stable ABI.

-- 
Ard.



> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-September/369001.html
>
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  Documentation/arm/uefi.txt         | 2 --
>>  drivers/firmware/efi/libstub/fdt.c | 9 ---------
>>  2 files changed, 11 deletions(-)
>>
>> diff --git a/Documentation/arm/uefi.txt b/Documentation/arm/uefi.txt
>> index 7b3fdfe0f7ba..6543a0adea8a 100644
>> --- a/Documentation/arm/uefi.txt
>> +++ b/Documentation/arm/uefi.txt
>> @@ -58,5 +58,3 @@ linux,uefi-mmap-desc-size | 32-bit | Size in bytes of each entry in the UEFI
>>  --------------------------------------------------------------------------------
>>  linux,uefi-mmap-desc-ver  | 32-bit | Version of the mmap descriptor format.
>>  --------------------------------------------------------------------------------
>> -linux,uefi-stub-kern-ver  | string | Copy of linux_banner from build.
>> ---------------------------------------------------------------------------------
>> diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
>> index a7e87cd582f2..60a11551fc15 100644
>> --- a/drivers/firmware/efi/libstub/fdt.c
>> +++ b/drivers/firmware/efi/libstub/fdt.c
>> @@ -116,15 +116,6 @@ efi_status_t update_fdt(efi_system_table_t *sys_table, void *orig_fdt,
>>       if (status)
>>               goto fdt_set_fail;
>>
>> -     /*
>> -      * Add kernel version banner so stub/kernel match can be
>> -      * verified.
>> -      */
>> -     status = fdt_setprop_string(fdt, node, "linux,uefi-stub-kern-ver",
>> -                          linux_banner);
>> -     if (status)
>> -             goto fdt_set_fail;
>> -
>>       return EFI_SUCCESS;
>>
>>  fdt_set_fail:
>> --
>> 1.9.1
>>
