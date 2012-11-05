From: will.deacon@arm.com (Will Deacon)
Date: Mon, 5 Nov 2012 14:05:58 +0000
Subject: [PATCH V2 2/5] arm: mvebu: Added initial support for power
 managmement service unit
In-Reply-To: <1351545108-18954-3-git-send-email-gregory.clement@free-electrons.com>
References: <1351545108-18954-1-git-send-email-gregory.clement@free-electrons.com>
 <1351545108-18954-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20121105140558.GP3351@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2012 at 09:11:45PM +0000, Gregory CLEMENT wrote:
> diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
> new file mode 100644
> index 0000000..cee020b
> --- /dev/null
> +++ b/arch/arm/mach-mvebu/pmsu.c
> @@ -0,0 +1,78 @@
> +/*
> + * Power Management Service Unit(PMSU) support for Armada 370/XP platforms.
> + *
> + * Copyright (C) 2012 Marvell
> + *
> + * Yehuda Yitschak <yehuday@marvell.com>
> + * Gregory Clement <gregory.clement@free-electrons.com>
> + * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + *
> + * The Armada 370 and Armada XP SOCs have a power management service
> + * unit which is responsible for powering down and waking up CPUs and
> + * other SOC units
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/of_address.h>
> +#include <linux/io.h>
> +#include <linux/smp.h>
> +#include <asm/smp_plat.h>
> +
> +static void __iomem *pmsu_mp_base;
> +static void __iomem *pmsu_reset_base;
> +
> +#define PMSU_BOOT_ADDR_REDIRECT_OFFSET(cpu)	((cpu * 0x100) + 0x24)
> +#define PMSU_RESET_CTL_OFFSET(cpu)		(cpu * 0x8)
> +
> +static struct of_device_id of_pmsu_table[] = {
> +	{.compatible = "marvell,armada-370-xp-pmsu"},
> +	{ /* end of list */ },
> +};
> +
> +#ifdef CONFIG_SMP
> +int armada_xp_boot_cpu(unsigned int cpu_id, void __iomem *boot_addr)
> +{
> +	int reg, hw_cpu;
> +
> +	if (!pmsu_mp_base || !pmsu_reset_base) {
> +		pr_warn("Can't boot CPU. PMSU is uninitialized\n");
> +		return 1;
> +	}
> +
> +	hw_cpu = cpu_logical_map(cpu_id);
> +
> +	writel(virt_to_phys(boot_addr), pmsu_mp_base +
> +			PMSU_BOOT_ADDR_REDIRECT_OFFSET(hw_cpu));

virt_to_phys on an __iomem * doesn't feel right to me...

> +	/* Make sure value hits memory before reset */
> +	dsb();

writel has barrier semantics -- you shouldn't need this dsb.

Will
