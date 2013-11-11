From: vijay.kilari@gmail.com (Vijay Kilari)
Date: Mon, 11 Nov 2013 14:17:52 +0530
Subject: [RFC v1 PATCH] ARM64: KGDB: Add FP/SIMD debug support
In-Reply-To: <20131108150602.GN17461@mudshark.cambridge.arm.com>
References: <1383827921-18526-1-git-send-email-vijay.kilari@gmail.com>
 <1383827921-18526-2-git-send-email-vijay.kilari@gmail.com>
 <20131108150602.GN17461@mudshark.cambridge.arm.com>
Message-ID: <CALicx6s_F=s7XmoU=f1kdyq0c12VcJZC5KJtH-5=0OGv1Sn9vA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 8, 2013 at 8:36 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, Nov 07, 2013 at 12:38:41PM +0000, vijay.kilari at gmail.com wrote:
>> From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
>>
>> Add KGDB debug support for FP/SIMD processor.This support
>> only debugging of FP/SIMD in kernel mode.
>> With this patch one can view or set FP/SIMD registers in
>> kernel context
>>
>> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
>> ---
>>  arch/arm64/kernel/kgdb.c |   98 ++++++++++++++++++++++++++++------------------
>>  1 file changed, 60 insertions(+), 38 deletions(-)
>
> [...]
>
>> @@ -100,11 +108,18 @@ char *dbg_get_reg(int regno, void *mem, struct pt_regs *regs)
>>       if (regno >= DBG_MAX_REG_NUM || regno < 0)
>>               return NULL;
>>
>> -     if (dbg_reg_def[regno].offset != -1)
>> +     if (dbg_reg_def[regno].offset != -1 && regno < _GP_REGS)
>>               memcpy(mem, (void *)regs + dbg_reg_def[regno].offset,
>>                      dbg_reg_def[regno].size);
>> -     else
>> +     else {
>> +#ifdef CONFIG_KERNEL_MODE_NEON
>> +             fpsimd_save_state(&kgdb_fpsimd_regs);
>> +             memcpy(mem, (void *)&kgdb_fpsimd_regs +
>> +                     dbg_reg_def[regno].offset, dbg_reg_def[regno].size);
>
> Don't you only want to do this if you're inside a kernel_neon_{begin,end}
> section? Otherwise, you'll be copying out user registers. It really depends
> on what semantics you want.
>
Yes, we can do that. I couldn't find any api to know the state of the neon.
I think of using a status variable and update in kernel_neon_begin/end?

> Will
