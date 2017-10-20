From: julien.thierry@arm.com (Julien Thierry)
Date: Fri, 20 Oct 2017 11:40:11 +0100
Subject: [PATCH v7 1/3] arm: npcm: add basic support for Nuvoton BMCs
In-Reply-To: <20171019225050.25410-2-brendanhiggins@google.com>
References: <20171019225050.25410-1-brendanhiggins@google.com>
 <20171019225050.25410-2-brendanhiggins@google.com>
Message-ID: <83927acd-5daf-04fd-3faf-0b5d2773c1fd@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brendan,

On 19/10/17 23:50, Brendan Higgins wrote:
> Adds basic support for the Nuvoton NPCM750 BMC.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Tomer Maimon <tmaimon77@gmail.com>
> Reviewed-by: Avi Fishman <avifishman70@gmail.com>
> Tested-by: Tomer Maimon <tmaimon77@gmail.com>
> Tested-by: Avi Fishman <avifishman70@gmail.com>
> ---
>   arch/arm/Kconfig             |  2 +
>   arch/arm/Makefile            |  1 +
>   arch/arm/mach-npcm/Kconfig   | 48 ++++++++++++++++++++++++
>   arch/arm/mach-npcm/Makefile  |  3 ++
>   arch/arm/mach-npcm/headsmp.S | 17 +++++++++
>   arch/arm/mach-npcm/npcm7xx.c | 34 +++++++++++++++++
>   arch/arm/mach-npcm/platsmp.c | 88 ++++++++++++++++++++++++++++++++++++++++++++
>   7 files changed, 193 insertions(+)
>   create mode 100644 arch/arm/mach-npcm/Kconfig
>   create mode 100644 arch/arm/mach-npcm/Makefile
>   create mode 100644 arch/arm/mach-npcm/headsmp.S
>   create mode 100644 arch/arm/mach-npcm/npcm7xx.c
>   create mode 100644 arch/arm/mach-npcm/platsmp.c
> 

[...]

> diff --git a/arch/arm/mach-npcm/platsmp.c b/arch/arm/mach-npcm/platsmp.c
> new file mode 100644
> index 000000000000..450e83c3c531
> --- /dev/null
> +++ b/arch/arm/mach-npcm/platsmp.c
> @@ -0,0 +1,88 @@
> +/*
> + * Copyright 2017 Google, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#define pr_fmt(fmt) "PLATSMP: " fmt
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/smp.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_address.h>
> +#include <asm/cacheflush.h>
> +#include <asm/smp.h>
> +#include <asm/smp_plat.h>
> +#include <asm/smp_scu.h>
> +
> +#define NPCM7XX_SCRPAD_REG 0x13c
> +
> +extern void npcm7xx_secondary_startup(void);
> +
> +static int npcm7xx_smp_boot_secondary(unsigned int cpu,
> +				      struct task_struct *idle)
> +{
> +	struct device_node *gcr_np;
> +	void __iomem *gcr_base;
> +	int ret = 0;
> +
> +	gcr_np = of_find_compatible_node(NULL, NULL, "nuvoton,npcm750-gcr");
> +	if (!gcr_np) {
> +		pr_err("no gcr device node\n");
> +		ret = -EFAULT;
> +		goto out;
> +	}
> +	gcr_base = of_iomap(gcr_np, 0);
> +	if (!gcr_base) {
> +		pr_err("could not iomap gcr at: 0x%p\n", gcr_base);

nit:
 From the condition we know gcr_base is NULL here so we don't get much 
info from it. Did you intend to print the value of gcr_np instead?

> +		ret = -EFAULT;
> +		goto out;
> +	}
> +
> +	/* give boot ROM kernel start address. */
> +	iowrite32(__pa_symbol(npcm7xx_secondary_startup), gcr_base +
> +		  NPCM7XX_SCRPAD_REG);
> +	/* make sure npcm7xx_secondary_startup is seen by all observers. */
> +	smp_wmb();
> +	dsb_sev();
> +	/* make sure write buffer is drained */
> +	mb();
> +
> +	iounmap(gcr_base);
> +out:
> +	return ret;
> +}
> +
> +static void __init npcm7xx_smp_prepare_cpus(unsigned int max_cpus)
> +{
> +	struct device_node *scu_np;
> +	void __iomem *scu_base;
> +
> +	scu_np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
> +	if (!scu_np) {
> +		pr_err("no scu device node\n");
> +		return;
> +	}
> +	scu_base = of_iomap(scu_np, 0);
> +	if (!scu_base) {
> +		pr_err("could not iomap scu at: 0x%p\n", scu_base);

Same comment about scu_base.

Cheers,

-- 
Julien Thierry
