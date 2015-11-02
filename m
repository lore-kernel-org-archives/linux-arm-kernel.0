From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Mon, 02 Nov 2015 16:22:56 +0000
Subject: [PATCH v8 2/2] arm-soc: Add support for arm-based tango4 platforms
In-Reply-To: <56377F09.6050805@sigmadesigns.com> (Marc Gonzalez's message of
 "Mon, 2 Nov 2015 16:19:37 +0100")
References: <56377E76.2080209@sigmadesigns.com>
 <56377F09.6050805@sigmadesigns.com>
Message-ID: <yw1xfv0o9xr3.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:

> diff --git a/arch/arm/mach-tangox/setup.c b/arch/arm/mach-tangox/setup.c
> new file mode 100644
> index 000000000000..a90e04140a0e
> --- /dev/null
> +++ b/arch/arm/mach-tangox/setup.c
> @@ -0,0 +1,32 @@
> +#include <linux/smp.h>
> +#include <asm/mach/arch.h>
> +#include <asm/hardware/cache-l2x0.h>
> +#include "smc.h"
> +
> +static int tango4_boot_secondary(unsigned int cpu, struct task_struct *idle)
> +{
> +	tango_set_aux_boot_addr(virt_to_phys(secondary_startup));
> +	tango_start_aux_core();
> +	return 0;
> +}
> +
> +static struct smp_operations tango4_smp_ops __initdata = {
> +	.smp_boot_secondary	= tango4_boot_secondary,
> +};
> +
> +CPU_METHOD_OF_DECLARE(tango4_smp, "sigma,tango4-smp", &tango4_smp_ops);

Unless I'm missing something, you should enable the SCU before starting
secondary CPUs.  It's also a good idea to structure the code with
separate prepare and boot functions even if all the current chips are
only dual-core.

> +static void tango_l2c_write(unsigned long val, unsigned int reg)
> +{
> +	pr_debug("%s: reg=0x%x val=0x%lx\n", __func__, reg, val);
> +	if (reg == L2X0_CTRL)
> +		tango_set_l2_control(val);

What about other registers?  Does the firmware support setting the
prefetch control register?

> +}
> +
> +static const char *tango_dt_compat[] = { "sigma,tango4", NULL };
> +
> +DT_MACHINE_START(TANGO_DT, "Sigma Tango DT")
> +	.dt_compat	= tango_dt_compat,
> +	.l2c_aux_mask	= ~0,
> +	.l2c_write_sec	= tango_l2c_write,
> +MACHINE_END
> diff --git a/arch/arm/mach-tangox/smc.S b/arch/arm/mach-tangox/smc.S
> new file mode 100644
> index 000000000000..35f9623aedb1
> --- /dev/null
> +++ b/arch/arm/mach-tangox/smc.S
> @@ -0,0 +1,9 @@
> +#include <linux/linkage.h>
> +
> +ENTRY(tango_smc)
> +	push	{lr}
> +	mov	ip, r1
> +	dsb

Did you ever get a straight answer on the dsb here?

> +	smc	#0
> +	pop	{pc}
> +ENDPROC(tango_smc)
> diff --git a/arch/arm/mach-tangox/smc.h b/arch/arm/mach-tangox/smc.h
> new file mode 100644
> index 000000000000..4e704dcf8da8
> --- /dev/null
> +++ b/arch/arm/mach-tangox/smc.h
> @@ -0,0 +1,5 @@
> +extern int tango_smc(unsigned int val, unsigned int service);
> +
> +#define tango_set_l2_control(val)	tango_smc(val, 0x102)
> +#define tango_start_aux_core()		tango_smc(666, 0x104)

666?

> +#define tango_set_aux_boot_addr(val)	tango_smc((unsigned int)val, 0x105)
> -- 
> 2.4.5

-- 
M?ns Rullg?rd
mans at mansr.com
