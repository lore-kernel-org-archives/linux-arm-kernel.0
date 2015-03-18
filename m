From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 18 Mar 2015 08:49:53 +0100
Subject: [PATCH 3/3] arm64: enforce x1|x2|x3 == 0 upon kernel entry as per
 boot protocol
In-Reply-To: <550868AB.7080303@codeaurora.org>
References: <1426587074-22390-1-git-send-email-ard.biesheuvel@linaro.org>
 <1426587074-22390-4-git-send-email-ard.biesheuvel@linaro.org>
 <550868AB.7080303@codeaurora.org>
Message-ID: <CAKv+Gu-sUaftz4g7N7mHCcPrBbxk44-+2Hrh57ZyHioitVeXoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 March 2015 at 18:47, Christopher Covington <cov@codeaurora.org> wrote:
> On 03/17/2015 06:11 AM, Ard Biesheuvel wrote:
>> According to the arm64 boot protocol, registers x1 to x3 should be
>> zero upon kernel entry, and non-zero values are reserved for future
>> use. This future use is going to be problematic if we never enforce
>> the current rules, so start enforcing them now, by emitting a warning
>> if non-zero values are detected.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm64/kernel/head.S  |  8 ++++++++
>>  arch/arm64/kernel/setup.c | 13 +++++++++++++
>>  2 files changed, 21 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
>> index 1651c0fd50e6..fe5354eae069 100644
>> --- a/arch/arm64/kernel/head.S
>> +++ b/arch/arm64/kernel/head.S
>> @@ -231,6 +231,10 @@ section_table:
>>  #endif
>>
>>  ENTRY(stext)
>> +     adr     x8, boot_regs                   // record the contents of
>> +     stp     x0, x1, [x8]                    // x0 .. x3 at kernel entry
>> +     stp     x2, x3, [x8, #16]
>> +
>>       mov     x21, x0                         // x21=FDT
>>       bl      el2_setup                       // Drop to EL1, w20=cpu_boot_mode
>>       adrp    x24, KERNEL_START - TEXT_OFFSET // x24=PHYS_OFFSET
>> @@ -251,6 +255,10 @@ ENTRY(stext)
>>       b       __cpu_setup                     // initialise processor
>>  ENDPROC(stext)
>>
>> +     .align  3
>> +ENTRY(boot_regs)
>> +     .skip   4 * 8                           // x0 .. x3
>> +
>>  /*
>>   * Determine validity of the x21 FDT pointer.
>>   * The dtb must be 8-byte aligned and live in the first 512M of memory.
>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>> index 6c5fb5aff325..2b81d0a907ce 100644
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -532,3 +532,16 @@ const struct seq_operations cpuinfo_op = {
>>       .stop   = c_stop,
>>       .show   = c_show
>>  };
>> +
>> +static int verify_boot_protocol(void)
>> +{
>> +     extern u64 boot_regs[];
>> +
>> +     if (boot_regs[1] || boot_regs[2] || boot_regs[3]) {
>> +             pr_err("WARNING: boot protocol violation detected (x1 == %llx, x2 == %llx, x3 == %llx)\n",
>> +                     boot_regs[1], boot_regs[2], boot_regs[3]);
>> +             pr_err("WARNING: your bootloader may fail to load newer kernels\n");
>
> pr_warn?
>

Semantically more correct, perhaps, but pr_err() should be slightly
noisier, which is preferred here imo

>> +     }
>> +     return 0;
>> +}
>> +late_initcall(verify_boot_protocol);
>>
>
> Chris
>
> --
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
