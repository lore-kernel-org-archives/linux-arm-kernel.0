From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 11 Nov 2013 09:53:40 +0100
Subject: [RFC v1 PATCH] ARM64: KGDB: Add FP/SIMD debug support
In-Reply-To: <CALicx6s_F=s7XmoU=f1kdyq0c12VcJZC5KJtH-5=0OGv1Sn9vA@mail.gmail.com>
References: <1383827921-18526-1-git-send-email-vijay.kilari@gmail.com>
 <1383827921-18526-2-git-send-email-vijay.kilari@gmail.com>
 <20131108150602.GN17461@mudshark.cambridge.arm.com>
 <CALicx6s_F=s7XmoU=f1kdyq0c12VcJZC5KJtH-5=0OGv1Sn9vA@mail.gmail.com>
Message-ID: <CAKv+Gu85arutxu_M9Y37cnYWtCcEju-Rj11U8dwepU344ayZyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 November 2013 09:47, Vijay Kilari <vijay.kilari@gmail.com> wrote:
> On Fri, Nov 8, 2013 at 8:36 PM, Will Deacon <will.deacon@arm.com> wrote:
>> On Thu, Nov 07, 2013 at 12:38:41PM +0000, vijay.kilari at gmail.com wrote:
>>> From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
>>>
>>> Add KGDB debug support for FP/SIMD processor.This support
>>> only debugging of FP/SIMD in kernel mode.
>>> With this patch one can view or set FP/SIMD registers in
>>> kernel context
>>>
>>> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
>>> ---
>>>  arch/arm64/kernel/kgdb.c |   98 ++++++++++++++++++++++++++++------------------
>>>  1 file changed, 60 insertions(+), 38 deletions(-)
>>
>> [...]
>>
>>> @@ -100,11 +108,18 @@ char *dbg_get_reg(int regno, void *mem, struct pt_regs *regs)
>>>       if (regno >= DBG_MAX_REG_NUM || regno < 0)
>>>               return NULL;
>>>
>>> -     if (dbg_reg_def[regno].offset != -1)
>>> +     if (dbg_reg_def[regno].offset != -1 && regno < _GP_REGS)
>>>               memcpy(mem, (void *)regs + dbg_reg_def[regno].offset,
>>>                      dbg_reg_def[regno].size);
>>> -     else
>>> +     else {
>>> +#ifdef CONFIG_KERNEL_MODE_NEON
>>> +             fpsimd_save_state(&kgdb_fpsimd_regs);
>>> +             memcpy(mem, (void *)&kgdb_fpsimd_regs +
>>> +                     dbg_reg_def[regno].offset, dbg_reg_def[regno].size);
>>
>> Don't you only want to do this if you're inside a kernel_neon_{begin,end}
>> section? Otherwise, you'll be copying out user registers. It really depends
>> on what semantics you want.
>>
> Yes, we can do that. I couldn't find any api to know the state of the neon.
> I think of using a status variable and update in kernel_neon_begin/end?
>

I have posted a patch here

http://marc.info/?l=linux-arm-kernel&m=138324498203157&w=2

that already keeps track of whether the current NEON register contents
belong to the current userland or not.
This is for a different purpose (lazy restore) but could potentially
be reused here I suppose.

-- 
Ard.
