From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 22 Feb 2016 12:51:09 +0100
Subject: [PATCH 3/3] arm64: ptdump: include UEFI runtime service mappings
In-Reply-To: <20160222112901.GA3435@leverpostej>
References: <1456135239-3607-1-git-send-email-ard.biesheuvel@linaro.org>
 <1456135239-3607-4-git-send-email-ard.biesheuvel@linaro.org>
 <20160222112901.GA3435@leverpostej>
Message-ID: <CAKv+Gu8RCrZJ4F8CA+FWTBe+WaF11BTJiM0cRiHJH_b0snk-yA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 February 2016 at 12:29, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> On Mon, Feb 22, 2016 at 11:00:39AM +0100, Ard Biesheuvel wrote:
>> This adds the UEFI runtime services page table mappings to the output
>> of the kernel page table dumper. These tables are only live during the
>> time UEFI runtime services are being invoked, but we can include them
>> for informational purposes nonetheless.
>
> I would prefer that we had a separate file for the EFI runtime services
> page tables. As you mention, they are distinct from the kernel and not
> always live (which is also the case for the idmap, for example).
>
> I have some local patches atop of v4.3 that librify the dumping code and
> add a separate file for EFI [1]. I spotted a couple other things in
> doing that (e.g. that we need to pad addresses more).
>
> Is it worth cleaning that up?
>

I think so. It would be especially nice if we could share the
registration API between ARM and arm64, since the ptdump code is very
similar, and the UEFI range is identical between them


>>
>> Cc: Matt Fleming <matt@codeblueprint.co.uk>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm64/mm/dump.c               | 8 ++++++++
>>  drivers/firmware/efi/arm-runtime.c | 2 +-
>>  2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
>> index 12e4b1732303..e7b937c9ad52 100644
>> --- a/arch/arm64/mm/dump.c
>> +++ b/arch/arm64/mm/dump.c
>> @@ -36,6 +36,10 @@ struct addr_marker {
>>  };
>>
>>  static struct addr_marker address_markers[] = {
>> +#ifdef CONFIG_EFI
>> +     { 0,                            "UEFI runtime start" },
>> +     { TASK_SIZE_64,                 "UEFI runtime end" },
>> +#endif
>>  #ifdef CONFIG_KASAN
>>       { KASAN_SHADOW_START,           "Kasan shadow start" },
>>       { KASAN_SHADOW_END,             "Kasan shadow end" },
>> @@ -310,6 +314,10 @@ static int ptdump_show(struct seq_file *m, void *v)
>>               .marker = address_markers,
>>       };
>>
>> +     if (IS_ENABLED(CONFIG_EFI)) {
>> +             extern struct mm_struct efi_mm;
>> +             walk_pgd(&st, &efi_mm, 0);
>> +     }
>>       walk_pgd(&st, &init_mm, LOWEST_ADDR);
>>
>>       note_page(&st, 0, 0, 0);
>> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
>> index 6ae21e41a429..3a3911641049 100644
>> --- a/drivers/firmware/efi/arm-runtime.c
>> +++ b/drivers/firmware/efi/arm-runtime.c
>> @@ -30,7 +30,7 @@
>>
>>  extern u64 efi_system_table;
>>
>> -static struct mm_struct efi_mm = {
>> +struct mm_struct efi_mm = {
>>       .mm_rb                  = RB_ROOT,
>>       .mm_users               = ATOMIC_INIT(2),
>>       .mm_count               = ATOMIC_INIT(1),
>> --
>> 2.5.0
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
