From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 10 Mar 2016 15:36:24 +0700
Subject: [PATCH 6/8] efi/arm*: libstub: wire up GOP handling into the ARM
 UEFI stub
In-Reply-To: <20160310082522.GB8618@gmail.com>
References: <1457588408-19309-1-git-send-email-ard.biesheuvel@linaro.org>
 <1457588408-19309-7-git-send-email-ard.biesheuvel@linaro.org>
 <20160310082522.GB8618@gmail.com>
Message-ID: <CAKv+Gu8hTSbZVgGj6epquwf6kkSJV+imAFvNobowFVtB5AUe2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 March 2016 at 15:25, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
>> diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm32-stub.c
>> index 495ebd657e38..0fbe00f13186 100644
>> --- a/drivers/firmware/efi/libstub/arm32-stub.c
>> +++ b/drivers/firmware/efi/libstub/arm32-stub.c
>> @@ -9,6 +9,44 @@
>>  #include <linux/efi.h>
>>  #include <asm/efi.h>
>>
>> +static const efi_guid_t screen_info_guid = LINUX_ARM32_SCREEN_INFO_TABLE_GUID;
>> +
>> +struct screen_info *alloc_screen_info(efi_system_table_t *sys_table_arg)
>> +{
>> +     struct screen_info *si;
>> +     efi_status_t status;
>> +
>> +     /*
>> +      * Unlike on arm64, where we can directly fill out the screen_info
>> +      * structure from the stub, we need to allocate a buffer to hold
>> +      * its contents while we hand over to the kernel proper from the
>> +      * decompressor.
>> +      */
>> +     status = efi_call_early(allocate_pool, EFI_RUNTIME_SERVICES_DATA,
>> +                             sizeof(*si), (void **)&si);
>> +
>> +     if (status != EFI_SUCCESS)
>> +             return NULL;
>> +
>> +     status = efi_call_early(install_configuration_table,
>> +                             (efi_guid_t *)&screen_info_guid, si);
>> +     if (status == EFI_SUCCESS)
>> +             return si;
>> +
>> +     efi_call_early(free_pool, si);
>> +     return NULL;
>> +}
>> +
>> +void free_screen_info(efi_system_table_t *sys_table_arg, struct screen_info *si)
>> +{
>> +     if (!si)
>> +             return;
>> +
>> +     efi_call_early(install_configuration_table,
>> +                    (efi_guid_t *)&screen_info_guid, NULL);
>> +     efi_call_early(free_pool, si);
>> +}
>> +
>>  efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
>>                                unsigned long *image_addr,
>>                                unsigned long *image_size,
>
> So screen_info_guid should probably not be a 'const': you have to cast it away
> anyway, adding artificial linebreaks and uglifying the code. It's also a bad
> practice to cast away const-ness, it hinders move-consts-to-readonly-sections
> efforts.
>

The problem here is that the UEFI spec never uses const qualifiers in
its APIs for by-ref parameters that are obviously never modified by
the caller, such as these GUIDs. This is __init code regardless
(either due to the fact that it is linked into the stub rather than
the core kernel, or because we __init-ize it using objcopy) so I don't
care deeply, and I am happy to remove it.

> Otherwise the series looks mostly good to me. Time for new v4.6 merges is short,
> but if Matt acks it I can still take it into tip:efi/core.
>

Thank you. I am perfectly happy exercising some more caution here,
though, considering that our past experiences involving reshuffling
stub code for x86 were not a huge success (and broke Linus's laptop,
among others')

I was very careful not to introduce cross-object data symbol
references (which were the culprit before), and I tested both i386 and
x86_64 to the extent feasible to me, but we'd need to confirm that
those things are still fully correct before queuing this.

Thanks,
Ard.
