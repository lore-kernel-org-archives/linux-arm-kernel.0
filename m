From: cov@codeaurora.org (Christopher Covington)
Date: Tue, 17 May 2016 16:36:06 -0400
Subject: [PATCH v2 2/2] arm64/efi: esrt: add missing call to
 efi_esrt_init()
In-Reply-To: <56C385D3.3090308@codeaurora.org>
References: <1455535953-5056-1-git-send-email-ard.biesheuvel@linaro.org>
 <1455535953-5056-3-git-send-email-ard.biesheuvel@linaro.org>
 <56C385D3.3090308@codeaurora.org>
Message-ID: <573B80B6.2010108@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On 02/16/2016 03:25 PM, Baicar, Tyler wrote:
> On 2/15/2016 4:32 AM, Ard Biesheuvel wrote:
>> ESRT support is built by default for all architectures that define
>> CONFIG_EFI. However, this support was not wired up yet for ARM/arm64,
>> since efi_esrt_init() was never called. So add the missing call.
>>
>> Since efi_esrt_init() uses efi_mem_desc_lookup(), which in turn relies
>> on efi.memmap having been assigned and populated completetely, add the
>> missing assignments of efi.memmap and efi.memmap->nr_map.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>   drivers/firmware/efi/arm-init.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/firmware/efi/arm-init.c
>> b/drivers/firmware/efi/arm-init.c
>> index 9e15d571b53c..5c5e799bdb50 100644
>> --- a/drivers/firmware/efi/arm-init.c
>> +++ b/drivers/firmware/efi/arm-init.c
>> @@ -197,10 +197,13 @@ void __init efi_init(void)
>>       memmap.map_end = memmap.map + params.mmap_size;
>>       memmap.desc_size = params.desc_size;
>>       memmap.desc_version = params.desc_ver;
>> +    memmap.nr_map = params.mmap_size / params.desc_size;
>> +    efi.memmap = &memmap;
>>         if (uefi_init() < 0)
>>           return;
>>   +    efi_esrt_init();
> This call to efi_esrt_init() is failing because efi.flags does not have
> EFI_MEMMAP set. This flag gets set at the end of reserve_regions(). I
> tested moving the set_bit() call from reserve_regions() to just before
> efi_esrt_init() and also tested moving efi_esrt_init() to just after
> reserve_regions(). Both of these options worked.
>>       reserve_regions();
>>       early_memunmap(memmap.map, params.mmap_size);
>>       memblock_mark_nomap(params.mmap & PAGE_MASK,

Do you expect to respin this patch in the near future?

Thanks,
Cov

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
