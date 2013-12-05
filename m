From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 05 Dec 2013 21:26:44 +0800
Subject: [RFC part3 PATCH 1/2] clocksource / arch_timer: Use ACPI GTDT
 table to initialize arch timer
In-Reply-To: <CAL_JsqJYUasvVDZjkuFwEiMxWhXNEzhhSP2ni1KKDeQQjmnzjg@mail.gmail.com>
References: <1386069328-22502-1-git-send-email-hanjun.guo@linaro.org>
 <1386069328-22502-2-git-send-email-hanjun.guo@linaro.org>
 <CAL_JsqJYUasvVDZjkuFwEiMxWhXNEzhhSP2ni1KKDeQQjmnzjg@mail.gmail.com>
Message-ID: <52A07F14.4020600@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013?12?04? 23:33, Rob Herring wrote:
> On Tue, Dec 3, 2013 at 5:15 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
[...]
>> +#ifdef CONFIG_ACPI
>> +void __init arch_timer_acpi_init(void)
>> +{
>> +       struct acpi_table_gtdt *gtdt;
>> +       acpi_size tbl_size;
>> +       int trigger, polarity;
>> +       void __iomem *base = NULL;
>> +
>> +       if (acpi_disabled)
> Wouldn't the core ACPI code never call this function if ACPI is disabled?

You inspired me for patches to remove some redundant if (acpi_disabled)
check for the current ACPI code, but this function will be called even
ACPI is disabled.

>> +               return;
>> +
>> +       if (arch_timers_present & ARCH_CP15_TIMER) {
>> +               pr_warn("arch_timer: already initialized, skipping\n");
>> +               return;
>> +       }
>> +
>> +       if (ACPI_FAILURE(acpi_get_table_with_size(ACPI_SIG_GTDT, 0,
>> +                       (struct acpi_table_header **)&gtdt, &tbl_size))) {
>> +               pr_err("arch_timer: GTDT table not defined\n");
>> +               return;
>> +       }
>> +
>> +       arch_timers_present |= ARCH_CP15_TIMER;
> So you have marked the timer as initialized, but then may fail on
> error later on here.
>
>> +
>> +       /*
>> +        * Get the timer frequency. Since there is no frequency info
>> +        * in the GTDT table, so we should read it from CNTFREG register
>> +        * or hard code here to wait for the new ACPI spec available.
>> +        */
>> +       if (!gtdt->address) {
>> +               arch_timer_rate = arch_timer_get_cntfrq();
>> +       } else {
>> +               base = ioremap(gtdt->address, CNTFRQ);
>> +               if (!base) {
>> +                       pr_warn("arch_timer: unable to map arch timer base address\n");
>> +                       return;
>> +               }
>> +
>> +               arch_timer_rate = readl_relaxed(base + CNTFRQ);
>> +               iounmap(base);
> This is for memory mapped timer? If so, then isn't setting
> ARCH_CP15_TIMER the wrong thing to do?

I'm trying to do that but it is wrong as you said, I will remove above code
and only keep

arch_timer_rate = arch_timer_get_cntfrq() here.

>> +       }
>> +
>> +       if (!arch_timer_rate) {
>> +               /* Hard code here to set frequence ? */
>> +               pr_warn("arch_timer: Could not get frequency from GTDT table or CNTFREG\n");
>> +       }
>> +
>> +       if (gtdt->secure_pl1_interrupt) {
> Really, I think the kernel should just ignore the secure interrupt.
> The DT code has the same issue, but that doesn't affect the code size.
>
>> +               trigger = (gtdt->secure_pl1_flags & ACPI_GTDT_INTERRUPT_MODE) ?
>> +                       ACPI_EDGE_SENSITIVE : ACPI_LEVEL_SENSITIVE;
> Why not use the already defined linux irq trigger types here and make
> acpi_register_gsi use them?
>
>> +               polarity =
>> +                       (gtdt->secure_pl1_flags & ACPI_GTDT_INTERRUPT_POLARITY)
>> +                       ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
>> +               arch_timer_ppi[0] = acpi_register_gsi(NULL,
>> +                               gtdt->secure_pl1_interrupt, trigger, polarity);
>> +       }
>> +       if (gtdt->non_secure_pl1_interrupt) {
>> +               trigger =
>> +                       (gtdt->non_secure_pl1_flags & ACPI_GTDT_INTERRUPT_MODE)
>> +                       ? ACPI_EDGE_SENSITIVE : ACPI_LEVEL_SENSITIVE;
>> +               polarity =
>> +               (gtdt->non_secure_pl1_flags & ACPI_GTDT_INTERRUPT_POLARITY)
>> +                       ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
>> +               arch_timer_ppi[1] = acpi_register_gsi(NULL,
>> +                       gtdt->non_secure_pl1_interrupt, trigger, polarity);
>> +       }
>> +       if (gtdt->virtual_timer_interrupt) {
>> +               trigger = (gtdt->virtual_timer_flags & ACPI_GTDT_INTERRUPT_MODE)
>> +                       ? ACPI_EDGE_SENSITIVE : ACPI_LEVEL_SENSITIVE;
>> +               polarity =
>> +               (gtdt->virtual_timer_flags & ACPI_GTDT_INTERRUPT_POLARITY)
>> +                       ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
>> +               arch_timer_ppi[2] = acpi_register_gsi(NULL,
>> +                       gtdt->virtual_timer_interrupt, trigger, polarity);
>> +       }
>> +       if (gtdt->non_secure_pl2_interrupt) {
>> +               trigger =
>> +                       (gtdt->non_secure_pl2_flags & ACPI_GTDT_INTERRUPT_MODE)
>> +                       ? ACPI_EDGE_SENSITIVE : ACPI_LEVEL_SENSITIVE;
>> +               polarity =
>> +               (gtdt->non_secure_pl2_flags & ACPI_GTDT_INTERRUPT_POLARITY)
>> +                       ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
>> +               arch_timer_ppi[3] = acpi_register_gsi(NULL,
>> +                       gtdt->non_secure_pl2_interrupt, trigger, polarity);
>> +       }
>> +
>> +       early_acpi_os_unmap_memory(gtdt, tbl_size);
> Who did the mapping? acpi_get_table_with_size? I think the core code
> should handle the mapping and unmapping of ACPI tables. We don't want
> to have to duplicate this in every initialization function. This seems
> error prone.

Yes, you are right, I will use the ACPI core function acpi_table_parse()
to fix it, thanks for you guidance.

Hanjun
