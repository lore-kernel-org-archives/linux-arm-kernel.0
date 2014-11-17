From: punit.agrawal@arm.com (Punit Agrawal)
Date: Mon, 17 Nov 2014 18:58:07 +0000
Subject: [PATCHv4 3/5] arm64: Port SWP/SWPB emulation support from arm
In-Reply-To: <20141114182426.GE6755@e104818-lin.cambridge.arm.com> (Catalin
 Marinas's message of "Fri, 14 Nov 2014 18:24:26 +0000")
References: <1415792692-11189-1-git-send-email-punit.agrawal@arm.com>
 <1415792692-11189-4-git-send-email-punit.agrawal@arm.com>
 <20141114182426.GE6755@e104818-lin.cambridge.arm.com>
Message-ID: <9hhd28lvem8.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

Thanks for reviewing the series.

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Wed, Nov 12, 2014 at 11:44:50AM +0000, Punit Agrawal wrote:
>>  Documentation/arm64/legacy_instructions.txt |  40 +++
>>  arch/arm64/Kconfig                          |  39 +++
>>  arch/arm64/include/asm/insn.h               |   6 +
>>  arch/arm64/kernel/Makefile                  |   1 +
>>  arch/arm64/kernel/armv8_deprecated.c        | 419 ++++++++++++++++++++++++++++
>>  arch/arm64/kernel/insn.c                    |   8 +
>
> I would have split this in two patches, one adding the framework and
> another the emulation. I'm not too bothered (can leave them as a single
> patch) but I have some comments below for grouping the code a bit as it
> looks like it's a mix of API for emulation, swp emulation, the API again
> making it hard to follow.

I will split them out. It's easier to follow.

>
>> --- /dev/null
>> +++ b/arch/arm64/kernel/armv8_deprecated.c
>> @@ -0,0 +1,419 @@
>> +/*
>> + *  Copyright (C) 2014 ARM Limited
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/list.h>
>> +#include <linux/perf_event.h>
>> +#include <linux/sched.h>
>> +#include <linux/slab.h>
>> +#include <linux/sysctl.h>
>> +
>> +#include <asm/insn.h>
>> +#include <asm/opcodes.h>
>> +#include <asm/system_misc.h>
>> +#include <asm/traps.h>
>> +#include <asm/uaccess.h>
>> +
>> +/*
>> + * The runtime support for deprecated instruction support can be in one of
>> + * following three states -
>> + *
>> + * 0 = undef
>> + * 1 = emulate (software emulation)
>> + * 2 = hw (supported in hardware)
>> + */
>> +enum insn_emulation_mode {
>> +       INSN_UNDEF,
>> +       INSN_EMULATE,
>> +       INSN_HW,
>> +};
>> +
>> +enum legacy_insn_status {
>> +       INSN_DEPRECATED,
>> +       INSN_OBSOLETE,
>> +};
>> +
>> +struct insn_emulation_ops {
>> +       const char              *name;
>> +       enum legacy_insn_status status;
>> +       struct undef_hook       *hooks;
>> +       int                     (*set_hw_mode)(bool enable);
>> +};
>> +
>> +struct insn_emulation {
>> +       struct list_head node;
>> +       struct insn_emulation_ops *ops;
>> +       int current_mode;
>> +       int min;
>> +       int max;
>> +};
>
> Please move the register_* etc. functions here and let the swp emulation
> grouped together.
>

Done.

>> +/*
>> + * Only emulate SWP/SWPB executed in ARM state/User mode.
>> + * The kernel must be SWP free and SWP{B} does not exist in Thumb.
>> + */
>> +static struct undef_hook swp_hooks[] = {
>> +               {
>> +                       .instr_mask     = 0x0fb00ff0,
>> +                       .instr_val      = 0x01000090,
>> +                       .pstate_mask    = COMPAT_PSR_MODE_MASK,
>> +                       .pstate_val     = COMPAT_PSR_MODE_USR,
>> +                       .fn             = swp_handler
>> +               },
>> +               { }
>> +};
>
> It may be the email client but it looks like too much indentation
> here.

Fixed.

>
>> +
>> +static struct insn_emulation_ops swp_ops = {
>> +       .name = "swp",
>> +       .status = INSN_OBSOLETE,
>> +       .hooks = swp_hooks,
>> +       .set_hw_mode = NULL,
>> +};
>> +
>
> Code below up to armv8_deprecated_init should be moved earlier.
>
>> +static LIST_HEAD(insn_emulation);
>> +static int nr_insn_emulated;
>> +static DEFINE_RAW_SPINLOCK(insn_emulation_lock);
>> +
>> +static bool register_emulation_hooks(struct insn_emulation_ops *ops)
>> +{
>> +       bool success = true;
>> +       struct undef_hook *hook;
>> +
>> +       if (!ops->hooks) {
>> +               success = false;
>> +               goto ret;
>> +       }
>> +
>> +       for (hook = ops->hooks; hook->instr_mask; hook++)
>> +               if (register_undef_hook(hook)) {
>> +                       success = false;
>> +                       break;
>> +               }
>> +
>> +ret:
>> +       return success;
>> +}
>
> I don't really think this code needs so much checking and error
> returning. As I already commented, register_undef_hook() should not
> return anything and for the ops->hooks check I think we could just use
> BUG_ON(!ops->hooks).

I've simplified both the above function and the one below with the BUG_ON.

>
> Do we need to add support for instructions that can't be emulated? I
> wouldn't go there yet until we see some real use-case.

Thanks! Some of the checks were put in anticipation of exactly such
features.

>
>> +static void remove_emulation_hooks(struct insn_emulation_ops *ops)
>> +{
>> +       struct undef_hook *hook;
>> +
>> +       if (!ops->hooks)
>> +               return;
>
> Same here.
>
>> +
>> +       for (hook = ops->hooks; hook->instr_mask; hook++)
>> +               unregister_undef_hook(hook);
>> +
>> +       pr_notice("Removed %s emulation handler\n", ops->name);
>> +}
>> +
>> +static int update_insn_emulation_mode(struct insn_emulation *insn,
>> +                                      enum insn_emulation_mode prev)
>> +{
>> +       int ret = 0;
>> +
>> +       switch (prev) {
>> +       case INSN_UNDEF: /* Nothing to be done */
>> +               break;
>> +       case INSN_EMULATE:
>> +               remove_emulation_hooks(insn->ops);
>> +               break;
>> +       case INSN_HW:
>> +               if (insn->ops->set_hw_mode) {
>> +                       insn->ops->set_hw_mode(false);
>> +                       pr_notice("Disabled %s support\n", insn->ops->name);
>> +               }
>> +               break;
>> +       }
>> +
>> +       switch (insn->current_mode) {
>> +       case INSN_UNDEF:
>> +               break;
>> +       case INSN_EMULATE:
>> +               if (!register_emulation_hooks(insn->ops)) {
>> +                       insn->current_mode = INSN_UNDEF;
>> +                       ret = -EINVAL;
>> +               } else
>> +                       pr_notice("Registered %s emulation handler\n",
>> +                                 insn->ops->name);
>> +               break;
>
> If we assume that register_emulation_hooks() doesn't fail, we could
> simplify slightly here.

Done.

>
>> +       case INSN_HW:
>> +               if (insn->ops->set_hw_mode && insn->ops->set_hw_mode(true)) {
>> +                       pr_notice("Enabled %s support\n", insn->ops->name);
>> +               } else {
>> +                       insn->current_mode = INSN_UNDEF;
>> +                       ret = -EINVAL;
>> +               }
>> +               break;
>
> I would rather let it fall back to the previous. So in the caller, we
> could re-instate the previous mode rather than undef.

Ok.

>
>> +static void register_insn_emulation(struct insn_emulation_ops *ops)
>> +{
>> +       unsigned long flags;
>> +       struct insn_emulation *insn;
>> +
>> +       insn = kzalloc(sizeof(*insn), GFP_KERNEL);
>> +       insn->ops = ops;
>> +       insn->min = INSN_UNDEF;
>> +
>> +       switch (ops->status) {
>> +       case INSN_DEPRECATED:
>> +               insn->current_mode = INSN_EMULATE;
>> +               insn->max = INSN_HW;
>> +               break;
>> +       case INSN_OBSOLETE:
>> +               insn->current_mode = INSN_UNDEF;
>> +               insn->max = INSN_EMULATE;
>> +               break;
>> +       }
>> +
>> +       raw_spin_lock_irqsave(&insn_emulation_lock, flags);
>> +       list_add(&insn->node, &insn_emulation);
>> +       nr_insn_emulated++;
>> +       raw_spin_unlock_irqrestore(&insn_emulation_lock, flags);
>> +
>> +       /* Register any handlers if required */
>> +       update_insn_emulation_mode(insn, INSN_UNDEF);
>> +}
>> +
>> +static int emulation_proc_handler(struct ctl_table *table, int write,
>> +                                 void __user *buffer, size_t *lenp,
>> +                                 loff_t *ppos)
>> +{
>> +       int ret = 0;
>> +       struct insn_emulation *insn = (struct insn_emulation *) table->data;
>> +       enum insn_emulation_mode prev_mode = insn->current_mode;
>> +
>> +       table->data = &insn->current_mode;
>> +       ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>> +
>> +       if (ret || !write || prev_mode == insn->current_mode)
>> +               goto ret;
>> +
>> +       ret = update_insn_emulation_mode(insn, prev_mode);
>
> After this instruction, something like below to restore the previous
> mode:
>
> 	if (!ret) {
> 		enum insn_emulation mode = insn_mode->current_mode;
> 		insn->current_mode = prev_mode;
> 		update_insn_emulation_mode(insn, prev_mode);
> 	}

I've added code similar to your suggestion to revert to previous mode.

I'll post a new version with your's (and Steven's) comments addressed
soon.

Thanks,
Punit

>
> --
> Catalin
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
