From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 25 Aug 2011 15:30:27 +0800
Subject: [PATCH v2 2/4] ARM: CSR: add PM sleep entry for SiRFprimaII
In-Reply-To: <20110825072719.GA17748@S2100-06.ap.freescale.net>
References: <1314080152-30503-1-git-send-email-Baohua.Song@csr.com>
	<1314080152-30503-3-git-send-email-Baohua.Song@csr.com>
	<20110825072719.GA17748@S2100-06.ap.freescale.net>
Message-ID: <CAGsJ_4zA0yaRu3O+cwSKDCORBDr5EVtKSmSGEMxWj90=_+oiNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,
2011/8/25 Shawn Guo <shawn.guo@freescale.com>:
> On Mon, Aug 22, 2011 at 11:15:50PM -0700, Barry Song wrote:
>> From: Rongjun Ying <rongjun.ying@csr.com>
>>
>> Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>> ?-v2:
>> ?delete redundant ARM mode registers save/restore
>> ?use generic cpu suspend
>> ?move l2 cache suspend/resume codes out
>> ?make memc become a device driver
>>
>> ?arch/arm/mach-prima2/pm.c ? ?| ?158 ++++++++++++++++++++++++++++++++++++++++++
>> ?arch/arm/mach-prima2/pm.h ? ?| ? 31 ++++++++
>> ?arch/arm/mach-prima2/sleep.S | ? 61 ++++++++++++++++
>> ?3 files changed, 250 insertions(+), 0 deletions(-)
>> ?create mode 100644 arch/arm/mach-prima2/pm.c
>> ?create mode 100644 arch/arm/mach-prima2/pm.h
>> ?create mode 100644 arch/arm/mach-prima2/sleep.S
>>
>> diff --git a/arch/arm/mach-prima2/pm.c b/arch/arm/mach-prima2/pm.c
>> new file mode 100644
>> index 0000000..75167df
>> --- /dev/null
>> +++ b/arch/arm/mach-prima2/pm.c
>> @@ -0,0 +1,158 @@
>> +/*
>> + * power management entry for CSR SiRFprimaII
>> + *
>> + * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
>> + *
>> + * Licensed under GPLv2 or later.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/suspend.h>
>> +#include <linux/slab.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/io.h>
>> +#include <linux/rtc/sirfsoc_rtciobrg.h>
>> +#include <asm/suspend.h>
>> +
>> +#include "pm.h"
>> +
>> +static u32 sirfsoc_pwrc_base;
>> +void __iomem *sirfsoc_memc_base;
>> +
>> +static void sirfsoc_set_wakeup_source(void)
>> +{
>> + ? ? ? ?u32 pwr_trigger_en_reg;
>> + ? ? ? ?pwr_trigger_en_reg = sirfsoc_rtc_iobrg_readl(sirfsoc_pwrc_base +
>> + ? ? ? ? ? ? SIRFSOC_PWRC_TRIGGER_EN);
>> +#define X_ON_KEY_B (1 << 0)
>> + ? ? ? ?sirfsoc_rtc_iobrg_writel(pwr_trigger_en_reg | X_ON_KEY_B,
>> + ? ? ? ? ? ? ? ? ? ? ? ?sirfsoc_pwrc_base + SIRFSOC_PWRC_TRIGGER_EN);
>> +}
>> +
>> +static void sirfsoc_set_sleep_mode(u32 mode)
>> +{
>> + ? ? ? ?u32 sleep_mode = sirfsoc_rtc_iobrg_readl(sirfsoc_pwrc_base +
>> + ? ? ? ? ? ? SIRFSOC_PWRC_PDN_CTRL);
>> + ? ? ? ?sleep_mode &= ~(SIRFSOC_SLEEP_MODE_MASK << 1);
>> + ? ? ? ?sleep_mode |= ((mode << 1));
>
> Redundant parentheses.
>
>> + ? ? ? ?sirfsoc_rtc_iobrg_writel(sleep_mode, sirfsoc_pwrc_base +
>> + ? ? ? ? ? ? SIRFSOC_PWRC_PDN_CTRL);
>> +}
>> +
>> +int sirfsoc_pre_suspend_power_off(void)
>> +{
>> + ? ? u32 wakeup_entry = virt_to_phys(cpu_resume);
>> +
>> + ? ? sirfsoc_rtc_iobrg_writel(wakeup_entry,
>> + ? ? ? ? ? ? SIRFSOC_PWRC_SCRATCH_PAD1);
>> +
>> + ? ? sirfsoc_set_wakeup_source();
>> +
>> + ? ? sirfsoc_set_sleep_mode(SIRFSOC_DEEP_SLEEP_MODE);
>> +
>> + ? ? return 0;
>> +}
>> +
> If I read it correctly, this function sets up resume entry, but I
> failed to see it being called anywhere? ?Am I missing anything?

lose this while sending patch, it is before cpu_suspend() called.
Thanks for review.

>
>> +static void sirfsoc_save_register(u32 *ptr)
>> +{
>> + ? ? /* todo: save necessary system registers here */
>> +}
>> +
>> +static void sirfsoc_restore_regs(u32 *ptr)
>> +{
>> + ? ? /* todo: restore saved system registers here */
>> +}
>> +
>> +static int sirfsoc_pm_enter(suspend_state_t state)
>> +{
>> + ? ? u32 *saved_regs;
>> +
>> + ? ? switch (state) {
>> + ? ? case PM_SUSPEND_MEM:
>> + ? ? ? ? ? ? saved_regs = kmalloc(1024, GFP_ATOMIC);
>> + ? ? ? ? ? ? if (!saved_regs)
>> + ? ? ? ? ? ? ? ? ? ? return -ENOMEM;
>> +
>> + ? ? ? ? ? ? sirfsoc_save_register(saved_regs);
>> +
>> + ? ? ? ? ? ? /* go zzz */
>> + ? ? ? ? ? ? cpu_suspend(0, sirfsoc_finish_suspend);
>> +
>> + ? ? ? ? ? ? sirfsoc_restore_regs(saved_regs);
>> + ? ? ? ? ? ? kfree(saved_regs);
>> + ? ? ? ? ? ? break;
>> + ? ? default:
>> + ? ? ? ? ? ? return -EINVAL;
>> + ? ? }
>> + ? ? return 0;
>> +}
>> +
>> +static const struct platform_suspend_ops sirfsoc_pm_ops = {
>> + ? ? .enter = sirfsoc_pm_enter,
>> + ? ? .valid = suspend_valid_only_mem,
>> +};
>> +
>> +static int __init sirfsoc_pm_init(void)
>> +{
>> + ? ? suspend_set_ops(&sirfsoc_pm_ops);
>> + ? ? return 0;
>> +}
>> +late_initcall(sirfsoc_pm_init);
>> +
>
> 8<---
>> +static struct of_device_id pwrc_ids[] = {
>> + ? ? { .compatible = "sirf,prima2-pwrc" },
>> +};
>> +
>> +static int __init sirfsoc_of_pwrc_init(void)
>> +{
>> + ? ? struct device_node *np;
>> + ? ? const __be32 ? ?*addrp;
>> +
>> + ? ? np = of_find_matching_node(NULL, pwrc_ids);
>> + ? ? if (!np)
>> + ? ? ? ? ? ? panic("unable to find compatible pwrc node in dtb\n");
>> +
>> + ? ? addrp = of_get_property(np, "reg", NULL);
>> + ? ? if (!addrp)
>> + ? ? ? ? ? ? panic("unable to find base address of pwrc node in dtb\n");
>> +
>> + ? ? sirfsoc_pwrc_base = be32_to_cpup(addrp);
>> +
>> + ? ? of_node_put(np);
> --->8
>
> To me, it seems that the above code snippet can be as simply as the
> following.
>
> ? ? ? ?np = of_find_compatible_node(NULL, NULL, "sirf,prima2-pwrc");
> ? ? ? ?sirfsoc_pwrc_base = of_iomap(np, 0);
> ? ? ? ?if (!sirfsoc_pwrc_base)
> ? ? ? ? ? ? ? ?return -ENOMEM;

you might want to read earlier thread in v1. PWRC is not in memory space.

>
>> +
>> + ? ? return 0;
>> +}
>> +postcore_initcall(sirfsoc_of_pwrc_init);
>> +
>> +static struct of_device_id memc_ids[] = {
>> + ? ? { .compatible = "sirf,prima2-memc" },
>> +};
>> +
>> +static int __devinit sirfsoc_memc_probe(struct platform_device *op)
>> +{
>> + ? ? struct device_node *np = op->dev.of_node;
>> +
>> + ? ? sirfsoc_memc_base = of_iomap(np, 0);
>> + ? ? if (!sirfsoc_memc_base)
>> + ? ? ? ? ? ? panic("unable to map memc registers\n");
>> +
>> + ? ? return 0;
>> +}
>> +
>> +static struct platform_driver sirfsoc_memc_driver = {
>> + ? ? .probe ? ? ? ? ?= sirfsoc_memc_probe,
>> + ? ? .driver = {
>> + ? ? ? ? ? ? .name = "sirfsoc-memc",
>> + ? ? ? ? ? ? .owner = THIS_MODULE,
>> + ? ? ? ? ? ? .of_match_table = memc_ids,
>> + ? ? },
>> +};
>> +
>> +static int __init sirfsoc_memc_init(void)
>> +{
>> + ? ? return platform_driver_register(&sirfsoc_memc_driver);
>> +}
>> +postcore_initcall(sirfsoc_memc_init);
>
> Doing the same thing - mapping address, why sirfsoc_pwrc_base uses
> a function, while sirfsoc_memc_base needs a platform_driver? ?You
> will have more stuff about memc to add there?

memc is in memory space, actually simple_bus, then a platform device
has existed for it.
pwrc is now not compitable with simple_bus. it looks like not worth a
platform for the moment too.

>
> --
> Regards,
> Shawn

Thanks
Barry
