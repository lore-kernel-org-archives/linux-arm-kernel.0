From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 11 Mar 2015 15:42:06 +0100
Subject: [PATCH 5/5] arm64/efi: adapt to relaxed FDT placement requirements
In-Reply-To: <20150311120950.GF4114@leverpostej>
References: <1425380630-3684-1-git-send-email-ard.biesheuvel@linaro.org>
 <1425380630-3684-6-git-send-email-ard.biesheuvel@linaro.org>
 <20150311120950.GF4114@leverpostej>
Message-ID: <CAKv+Gu-CuHuQALfrtKxXDYHrYHR963+SdhKC6xPYace95yGg2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 March 2015 at 13:09, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Mar 03, 2015 at 11:03:50AM +0000, Ard Biesheuvel wrote:
>> With the relaxed FDT placement requirements in place, we can change
>> the allocation strategy used by the stub to put the FDT image higher
>> up in memory. At the same time, reduce the minimal alignment to a
>> power of 2 upper bound of the size: this way, we are still guaranteed
>> not to cross a 2 MB boundary, but will potentially waste less memory
>> doing so.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm64/include/asm/efi.h            | 9 ++++-----
>>  drivers/firmware/efi/libstub/arm-stub.c | 2 +-
>>  drivers/firmware/efi/libstub/fdt.c      | 7 ++-----
>>  3 files changed, 7 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
>> index ef572206f1c3..68f7bb2ddad7 100644
>> --- a/arch/arm64/include/asm/efi.h
>> +++ b/arch/arm64/include/asm/efi.h
>> @@ -39,12 +39,11 @@ extern void efi_init(void);
>>  /* arch specific definitions used by the stub code */
>>
>>  /*
>> - * AArch64 requires the DTB to be 8-byte aligned in the first 512MiB from
>> - * start of kernel and may not cross a 2MiB boundary. We set alignment to
>> - * 2MiB so we know it won't cross a 2MiB boundary.
>> + * AArch64 requires the DTB to be 8-byte aligned and not cross a 2MiB boundary.
>> + * So align to a power of 2 upper bound of the FDT size.
>>   */
>> -#define EFI_FDT_ALIGN        SZ_2M   /* used by allocate_new_fdt_and_exit_boot() */
>> -#define MAX_FDT_OFFSET       SZ_512M
>> +#define EFI_FDT_ALIGN(x)     roundup_pow_of_two(x)
>> +#define MAX_FDT_OFFSET               ULONG_MAX
>>
>>  #define efi_call_early(f, ...) sys_table_arg->boottime->f(__VA_ARGS__)
>>
>> diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
>> index dcae482a9a17..c58c21c22dbe 100644
>> --- a/drivers/firmware/efi/libstub/arm-stub.c
>> +++ b/drivers/firmware/efi/libstub/arm-stub.c
>> @@ -269,7 +269,7 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table,
>>
>>       new_fdt_addr = fdt_addr;
>>       status = allocate_new_fdt_and_exit_boot(sys_table, handle,
>> -                             &new_fdt_addr, dram_base + MAX_FDT_OFFSET,
>> +                             &new_fdt_addr, MAX_FDT_OFFSET,
>
> Do we still need the max_addr parameter and MAX_FDT_OFFSET, or can we
> just have allocate_new_fdt_and_exit_boot assume it can allocate anywhere
> in the physical address space (or ULONG_MAX if we want to allocate below
> 4GB whenever we get 32-bit EFI stub support).
>

Yes, I could probably drop the parameter and hardcode ULONG_MAX in there.
(32-bit EFI stub support is still on our todo list, but nobody is
actually working on it atm)

-- 
Ard.
