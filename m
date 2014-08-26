From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 26 Aug 2014 16:21:09 +0200
Subject: [PATCH 3/6] arm64: Add support for hooks to handle undefined
 instructions
In-Reply-To: <20140826131339.GO23445@arm.com>
References: <1409048930-21598-1-git-send-email-punit.agrawal@arm.com>
 <1409048930-21598-4-git-send-email-punit.agrawal@arm.com>
 <20140826131339.GO23445@arm.com>
Message-ID: <CAKv+Gu8Nji0Jspk2cMCwVGKeODsiOb0NFUFWucm3rAbNdb_bTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 August 2014 15:13, Will Deacon <will.deacon@arm.com> wrote:
> Hi Punit,
>
> On Tue, Aug 26, 2014 at 11:28:47AM +0100, Punit Agrawal wrote:
>> Add support to register hooks for undefined instructions. The handlers
>> will be called when the undefined instruction and the processor state
>> (as contained in pstate) match criteria used at registration.
>>
>> Note: The patch only deals with ARM instruction encodings and needs
>> fixing to handle thumb instructions as well.
>
> [...]
>
>> +static int call_undef_hook(struct pt_regs *regs)
>> +{
>> +     struct undef_hook *hook;
>> +     unsigned long flags;
>> +     u32 instr;
>> +     int (*fn)(struct pt_regs *regs, u32 instr) = NULL;
>> +     void __user *pc = (void __user *)instruction_pointer(regs);
>> +
>> +     /*
>> +      * Currently, undefined instruction patching is only supported
>> +      * for user mode. Also, as we're not emulating any thumb
>> +      * instructions lets not add thumb instruction decoding until
>> +      * it is needed.
>> +      */
>> +     if (!compat_user_mode(regs) || compat_thumb_mode(regs))
>> +             return 1;
>
> What do you mean by `undefined instruction patching'? I don't see anything
> in the mechanism that means this can't be reused for kernel code, then we
> just register the SWP emulation hook for userspace only using the mode (like
> we do for kgdb).
>

You need this patch in order to be able to return from an undef
exception taken in EL1:

--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -287,7 +287,9 @@ el1_undef:
         */
        enable_dbg
        mov     x0, sp
-       b       do_undefinstr
+       bl      do_undefinstr
+
+       kernel_exit 1
 el1_dbg:
        /*
         * Debug exception handling

-- 
Ard.


>> +     get_user(instr, (u32 __user *)pc);
>> +     instr = le32_to_cpu(instr);
>> +
>> +     raw_spin_lock_irqsave(&undef_lock, flags);
>> +     list_for_each_entry(hook, &undef_hook, node)
>> +             if ((instr & hook->instr_mask) == hook->instr_val &&
>> +                     (regs->pstate & hook->pstate_mask) == hook->pstate_val)
>> +                     fn = hook->fn;
>> +
>> +     raw_spin_unlock_irqrestore(&undef_lock, flags);
>> +
>> +     return fn ? fn(regs, instr) : 1;
>> +}
>> +
>>  asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
>>  {
>>       siginfo_t info;
>> @@ -266,6 +329,9 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
>>       if (!aarch32_break_handler(regs))
>>               return;
>>
>> +     if (call_undef_hook(regs) == 0)
>> +             return;
>
> I'd like to reuse this hook for the aarch32 break hooks (you can see the
> direct call in the context above). That means adding support for thumb
> after all. Is there a reason you've been avoiding that?
>
> Will
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
