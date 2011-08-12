From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Aug 2011 15:54:11 +0200
Subject: [RFC PATCH 2/2] ARM: CSR: add PM sleep entry for SiRFprimaII
In-Reply-To: <1312512888-25070-3-git-send-email-bs14@csr.com>
References: <1312512888-25070-1-git-send-email-bs14@csr.com>
	<1312512888-25070-3-git-send-email-bs14@csr.com>
Message-ID: <201108121554.11316.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 August 2011, Barry Song wrote:
> From: Rongjun Ying <rongjun.ying@csr.com>
> 
> Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
> Signed-off-by: Barry Song <baohua.song@csr.com>

Hi Barry and Rongjun,

My impression of this code is that you just add hooks into
a number of places, while this should really be a proper device
driver.

> diff --git a/arch/arm/mach-prima2/common.h b/arch/arm/mach-prima2/common.h
> index 83e5d21..894e361 100644
> --- a/arch/arm/mach-prima2/common.h
> +++ b/arch/arm/mach-prima2/common.h
> @@ -16,6 +16,7 @@ extern struct sys_timer sirfsoc_timer;
>  
>  extern void __init sirfsoc_of_irq_init(void);
>  extern void __init sirfsoc_of_clk_init(void);
> +extern void sirfsoc_l2x_init(void);
>  
>  #ifndef CONFIG_DEBUG_LL
>  static inline void sirfsoc_map_lluart(void)  {}

You now call the sirfsoc_l2x_init function from two different places,
which is very confusing. Better make sure that the idle code is
only inialized after all the other subsystems it relies on have been
activated.

> diff --git a/arch/arm/mach-prima2/l2x0.c b/arch/arm/mach-prima2/l2x0.c
> index 9cda205..adc9840 100644
> --- a/arch/arm/mach-prima2/l2x0.c
> +++ b/arch/arm/mach-prima2/l2x0.c
> @@ -18,25 +18,14 @@
>  #define L2X0_ADDR_FILTERING_START       0xC00
>  #define L2X0_ADDR_FILTERING_END         0xC04
>  
> +void __iomem *sirfsoc_l2x_base;
> +
>  static struct of_device_id l2x_ids[]  = {
>  	{ .compatible = "arm,pl310-cache" },
>  };

Exporting the base address registers from one driver into another
is a layering violation, don't do that. There are global functions
that are used for managing the cache, so you should be calling those,
or extend them to do what you need if necessary.

> diff --git a/arch/arm/mach-prima2/pm.c b/arch/arm/mach-prima2/pm.c
> new file mode 100644
> index 0000000..bae7241
> --- /dev/null
> +++ b/arch/arm/mach-prima2/pm.c
> @@ -0,0 +1,139 @@
> +/*
> + * power management entry for CSR SiRFprimaII
> + *
> + * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
> + *
> + * Licensed under GPLv2 or later.
> + */
> +
> +#include <linux/suspend.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/io.h>
> +#include <linux/rtc/sirfsoc_rtciobrg.h>
> +
> +#include "common.h"
> +#include "pm.h"
> +
> +static u32 sirfsoc_pwrc_base;
> +void __iomem *sirfsoc_memc_base;
> +
> +static void sirfsoc_set_wakeup_source(void)
> +{
> +        u32 pwr_trigger_en_reg;
> +        pwr_trigger_en_reg = sirfsoc_rtc_iobrg_readl(sirfsoc_pwrc_base +
> +		SIRFSOC_PWRC_TRIGGER_EN);
> +#define X_ON_KEY_B (1 << 0)
> +        sirfsoc_rtc_iobrg_writel(pwr_trigger_en_reg | X_ON_KEY_B,
> +                        sirfsoc_pwrc_base + SIRFSOC_PWRC_TRIGGER_EN);
> +}
> +
> +static void sirfsoc_set_sleep_mode(u32 mode)
> +{
> +        u32 sleep_mode = sirfsoc_rtc_iobrg_readl(sirfsoc_pwrc_base +
> +		SIRFSOC_PWRC_PDN_CTRL);
> +        sleep_mode &= ~(SIRFSOC_SLEEP_MODE_MASK << 1);
> +        sleep_mode |= ((mode << 1));
> +        sirfsoc_rtc_iobrg_writel(sleep_mode, sirfsoc_pwrc_base +
> +		SIRFSOC_PWRC_PDN_CTRL);
> +}

This again looks like a bad abstraction, and it gets the locking wrong,
since you need a spinlock around both the read and write of the register
to make the update atomic.

These functions therefore belong into the rtc_iobrg driver.

> +static struct of_device_id pwrc_ids[] = {
> +	{ .compatible = "sirf,prima2-pwrc" },
> +};
> +
> +static void __init sirfsoc_of_pwrc_init(void)
> +{
> +	struct device_node *np;
> +	const __be32    *addrp;
> +
> +	np = of_find_matching_node(NULL, pwrc_ids);
> +	if (!np)
> +		panic("unable to find compatible pwrc node in dtb\n");

Don't use of_find_matching_node to look for stuff that is really more
a device that you want to talk to. Instead, register a platform
driver with that match_table and load a proper device driver for
it.

> +
> +	addrp = of_get_property(np, "reg", NULL);
> +	if (!addrp)
> +		panic("unable to find base address of pwrc node in dtb\n");
> +
> +	sirfsoc_pwrc_base = be32_to_cpup(addrp);
> +
> +	of_node_put(np);
> +}

Why do you store the physical base address here, instead doing an of_iomap?

> +static struct of_device_id memc_ids[] = {
> +	{ .compatible = "sirf,prima2-memc" },
> +};
>
> +static void __init sirfsoc_of_memc_map(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_matching_node(NULL, memc_ids);
> +	if (!np)
> +		panic("unable to find compatible memc node in dtb\n");
> +
> +	sirfsoc_memc_base = of_iomap(np, 0);
> +	if (!np)
> +		panic("unable to map compatible memc node in dtb\n");
> +
> +	of_node_put(np);
> +}

Same as for the other one, I think this should be another device
driver.

> +#include <linux/linkage.h>
> +#include <asm/ptrace.h>
> +#include <asm/assembler.h>
> +#include <asm/hardware/cache-l2x0.h>
> +
> +#include "pm.h"
> +
> +#define DENALI_CTL_22_OFF	0x58
> +#define DENALI_CTL_112_OFF	0x1c0
> +
> +ENTRY(sirfsoc_get_wakeup_pointer)
> +	stmfd	sp!, {lr}	@ save registers on stack
> +	adr	r0, sirfsoc_wakeup
> +	ldmfd	sp!, {pc}	@ restore regs and return
> +
> +ENTRY(sirfsoc_sleep)
> +sirfsoc_sleep:
> +	stmdb  sp!, {r0-r12, lr}		@ Push SVC state onto our stack
> +
> +	mrc     p15, 0, r2, c1, c0, 1           @ cp15 c1 auxiliary Control register
> +	mrc     p15, 0, r3, c1, c0, 2           @ cp15 c1 coprocessor access control register
> +	mrc     p15, 0, r4, c2, c0, 0           @ cp15 c2_r0 translation table base resigter 0
> +	mrc     p15, 0, r5, c2, c0, 1          	@ cp15 c2_r1 translation table base resigter 1
> +
> +	mrc     p15, 0, r6, c2, c0, 2          	@ cp15 c2_r2 translation table base control resigter
> +
> +	mrc     p15, 0, r7, c3, c0, 0           @ load r2 with domain access control.
> +	mrc     p15, 0, r8, c1, c0, 0           @ MMU Control
> +	mrc	p15, 0, r9, c10,c2, 0		@ cp15 PRRR register
> +	mrc     p15, 0, r10, c10,c2, 1		@ cp15 NMRR register
> +	mov	r11, sp
> +	ldr	r0, =save_context
> +	add	r0, r0, #124
> +	stmdb	r0!, {r2-r11}			@ Save CP15 and the SP to stack

It's not really clear why this code needs to be assembly. Would it be
possible to write the same in C, with just a few inline assembly statements?
	
	Arnd
