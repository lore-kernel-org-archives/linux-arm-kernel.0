From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 21 Jun 2016 20:49:38 +0300
Subject: [PATCH v4 07/13] ARM: shmobile: apmu: Add APMU DT support via
 Enable method
In-Reply-To: <1466072862-28030-8-git-send-email-geert+renesas@glider.be>
References: <1466072862-28030-1-git-send-email-geert+renesas@glider.be>
 <1466072862-28030-8-git-send-email-geert+renesas@glider.be>
Message-ID: <b524c939-d546-65b8-72da-359136c2aebe@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/16/2016 01:27 PM, Geert Uytterhoeven wrote:

> From: Magnus Damm <damm+renesas@opensource.se>
>
> Allow DT configuration of the APMU hardware in the case when the APMU is
> pointed out in the DTB via the enable-method. The ability to configure
> the APMU via C code is still kept intact to prevent DTB breakage for older
> SoCs that do not rely on the enable-method for SMP support.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> [geert: Fix CONFIG_SMP=n build]
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[...]

> diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
> index c1558ef0c590dd3e..0c6bb458b7a45128 100644
> --- a/arch/arm/mach-shmobile/platsmp-apmu.c
> +++ b/arch/arm/mach-shmobile/platsmp-apmu.c
[...]
> +static int shmobile_smp_apmu_boot_secondary_md21(unsigned int cpu,
> +						 struct task_struct *idle)
> +{
> +	/* Error out when hardware debug mode is enabled */
> +	if (rcar_gen2_read_mode_pins() & BIT(21)) {
> +		pr_warn("Unable to boot CPU%u when MD21 is set\n", cpu);
> +		return -ENOTSUPP;
> +	}
> +
> +	return shmobile_smp_apmu_boot_secondary(cpu, idle);
> +}
> +
> +static struct smp_operations apmu_smp_ops __initdata = {
> +	.smp_prepare_cpus	= shmobile_smp_apmu_prepare_cpus_dt,
> +	.smp_boot_secondary	= shmobile_smp_apmu_boot_secondary_md21,
> +#ifdef CONFIG_HOTPLUG_CPU
> +	.cpu_can_disable	= shmobile_smp_cpu_can_disable,
> +	.cpu_die		= shmobile_smp_apmu_cpu_die,
> +	.cpu_kill		= shmobile_smp_apmu_cpu_kill,
>  #endif

    For the record: it turned out that I tested my non-DT SMP on 
R8A7792/Blanche with MD21 bit set. And I've just made sure it still works with 
this implementation (by commenting out the check above.
    Also, I was going to try the workaround for MD21 I saw in the BSP tree -- 
perhaps it'll help get R8A7791 working w/MD21 set...

MBR, Sergei
