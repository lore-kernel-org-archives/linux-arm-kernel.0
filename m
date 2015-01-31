From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 31 Jan 2015 10:42:22 +0000
Subject: [PATCH v2 3/5] ARM: Alpine: smp support
In-Reply-To: <54cc931d.9PqMlkwMeqHvUr4h%tsahee@annapurnalabs.com>
References: <54cc931d.9PqMlkwMeqHvUr4h%tsahee@annapurnalabs.com>
Message-ID: <20150131104222.GS26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 31, 2015 at 10:32:29AM +0200, Tsahee Zidenberg wrote:
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +
> +#include <asm/io.h>

linux/io.h please.

> +
> +#include "alpine_cpu_pm.h"
> +#include "alpine_cpu_resume.h"
> +
> +/* NB registers */
> +#define AL_SYSFAB_POWER_CONTROL(cpu)	(0x2000 + (cpu)*0x100 + 0x20)
> +
> +static struct regmap *al_sysfabric;
> +static struct al_cpu_resume_regs __iomem *al_cpu_resume_regs;
> +static int wakeup_supported;
> +
> +int alpine_cpu_wakeup(unsigned int phys_cpu, uint32_t phys_resume_addr)
> +{
> +	if (!wakeup_supported)
> +		return -ENOSYS;
> +
> +	/* Set CPU resume address -
> +	 * secure firmware running on boot will jump to this address
> +	 * after setting proper CPU mode, and initialiing e.g. secure regs
> +	 * (the same mode all CPUs are booted to - usually HYP) */

Please stick to the kernel coding style:

	/*
	 * Set CPU resume address -
	 * secure firmware running on boot will jump to this address
	 * after setting proper CPU mode, and initialiing e.g. secure regs
	 * (the same mode all CPUs are booted to - usually HYP)
	 */

and you might as well move "regs" to the next line to even up the line
length between each line.

> +	writel(phys_resume_addr,
> +	       &al_cpu_resume_regs->per_cpu[phys_cpu].resume_addr);
> +
> +	/* Power-up the CPU */
> +	regmap_write(al_sysfabric, AL_SYSFAB_POWER_CONTROL(phys_cpu), 0);
> +
> +	return 0;
> +}
> +
> +void __init alpine_cpu_pm_init(void)
> +{
> +	struct device_node *np;
> +	uint32_t watermark;
> +
> +	al_sysfabric = syscon_regmap_lookup_by_compatible("al,alpine-sysfabric-service");
> +
> +	np = of_find_compatible_node(NULL, NULL, "al,alpine-cpu-resume");

What if "np" is NULL?

> +	al_cpu_resume_regs = of_iomap(np, 0);
> +
> +	wakeup_supported = (!IS_ERR(al_sysfabric)) && al_cpu_resume_regs;

	wakeup_supported = !IS_ERR(al_sysfabric) && al_cpu_resume_regs;

is entirely sufficient - no need for additional parens.

> +
> +	if (wakeup_supported) {
> +		watermark = readl(&al_cpu_resume_regs->watermark);
> +		wakeup_supported = ((watermark & AL_CPU_RESUME_MAGIC_NUM_MASK)
> +				    == AL_CPU_RESUME_MAGIC_NUM);

		wakeup_supported = (watermark & AL_CPU_RESUME_MAGIC_NUM_MASK)
				   == AL_CPU_RESUME_MAGIC_NUM;

is also sufficient.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
