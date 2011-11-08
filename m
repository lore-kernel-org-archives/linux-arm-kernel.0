From: robherring2@gmail.com (Rob Herring)
Date: Tue, 08 Nov 2011 08:17:40 -0600
Subject: [RFC 3/6] ARM: vexpress: Add DT support in v2m
In-Reply-To: <1320758169-22668-4-git-send-email-pawel.moll@arm.com>
References: <1320758169-22668-1-git-send-email-pawel.moll@arm.com>
 <1320758169-22668-4-git-send-email-pawel.moll@arm.com>
Message-ID: <4EB93A04.1020009@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/2011 07:16 AM, Pawel Moll wrote:
> This patch provides hooks for DT-based tile machine implementations.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  arch/arm/mach-vexpress/Kconfig |    8 ++++
>  arch/arm/mach-vexpress/core.h  |   13 +++++++
>  arch/arm/mach-vexpress/v2m.c   |   79 +++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 99 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
> index 9311484..9370f5b 100644
> --- a/arch/arm/mach-vexpress/Kconfig
> +++ b/arch/arm/mach-vexpress/Kconfig
> @@ -1,6 +1,9 @@
>  menu "Versatile Express platform type"
>  	depends on ARCH_VEXPRESS
>  
> +config ARCH_VEXPRESS_LEGACY
> +	bool
> +
>  config ARCH_VEXPRESS_CA9X4
>  	bool "Versatile Express Cortex-A9x4 tile"
>  	select CPU_V7
> @@ -8,5 +11,10 @@ config ARCH_VEXPRESS_CA9X4
>  	select ARM_ERRATA_720789
>  	select ARM_ERRATA_751472
>  	select ARM_ERRATA_753970
> +	select ARCH_VEXPRESS_LEGACY
> +
> +config ARCH_VEXPRESS_DT
> +	bool
> +	select OF
>  
>  endmenu
> diff --git a/arch/arm/mach-vexpress/core.h b/arch/arm/mach-vexpress/core.h
> index 7a3ce7a..0ea502a 100644
> --- a/arch/arm/mach-vexpress/core.h
> +++ b/arch/arm/mach-vexpress/core.h
> @@ -27,3 +27,16 @@ extern void (*vexpress_init_cpu_map)(void);
>  extern void (*vexpress_smp_enable)(unsigned int);
>  #endif
>  
> +extern struct sys_timer v2m_timer;
> +
> +#if defined(CONFIG_ARCH_VEXPRESS_DT)
> +
> +enum v2m_memory_map {
> +	v2m_memory_map_legacy,
> +};
> +
> +void __init v2m_dt_map_io(enum v2m_memory_map map);
> +void __init v2m_dt_init_early(void);
> +struct of_dev_auxdata * __init v2m_dt_get_auxdata(enum v2m_memory_map map);
> +
> +#endif
> diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
> index 2f44425..39900c4 100644
> --- a/arch/arm/mach-vexpress/v2m.c
> +++ b/arch/arm/mach-vexpress/v2m.c
> @@ -6,6 +6,9 @@
>  #include <linux/amba/mmci.h>
>  #include <linux/io.h>
>  #include <linux/init.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of_fdt.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/ata_platform.h>
>  #include <linux/smsc911x.h>
> @@ -70,7 +73,8 @@ static void __init v2m_timer_init(void)
>  		"v2m-timer0");
>  }
>  
> -static struct sys_timer v2m_timer = {
> +/* May be used by DT-powered machines */
> +struct sys_timer v2m_timer = {
>  	.init	= v2m_timer_init,
>  };
>  
> @@ -468,3 +472,76 @@ MACHINE_START(VEXPRESS, "ARM-Versatile Express")
>  	.timer		= &v2m_timer,
>  	.init_machine	= v2m_init,
>  MACHINE_END
> +
> +
> +
> +#if defined(CONFIG_ARCH_VEXPRESS_DT)
> +
> +static unsigned long __init v2m_dt_periph_offset(const char *alias)
> +{
> +	unsigned long node;
> +	__be32 *reg;
> +	unsigned long len;
> +
> +	if (of_flat_dt_find_node_by_alias(alias, &node) != 0)
> +		panic("%s: Can't get offset for '%s'!\n", __func__, alias);
> +
> +	reg = of_get_flat_dt_prop(node, "reg", &len);
> +	if (!reg)
> +		panic("%s: Can't get reg property for '%s'!\n",
> +				__func__, alias);
> +
> +	return be32_to_cpup(reg);
> +}
> +
> +void __init v2m_dt_map_io(enum v2m_memory_map map)
> +{
> +	switch (map) {
> +	case v2m_memory_map_legacy:
> +		iotable_init(v2m_io_desc, ARRAY_SIZE(v2m_io_desc));
> +		break;
> +	default:
> +		panic("%s: Unknown memory map requested!\n", __func__);
> +		break;

I don't like this approach. Why don't you either have 2 DT machine_descs
for legacy and new memory map or use the machine compatible strings to
select the io table.

> +	}
> +
> +	/* Will become nice ioremap()-s once allowed */
> +	v2m_sysreg_base = V2M_PERIPH_P2V(v2m_dt_periph_offset("sysreg"));
> +	v2m_sysctl_base = V2M_PERIPH_P2V(v2m_dt_periph_offset("sysctl"));
> +	v2m_timer01_base = V2M_PERIPH_P2V(v2m_dt_periph_offset("timer01"));

Generally, timers can be ioremapped already.

> +}
> +
> +void __init v2m_dt_init_early(void)
> +{
> +	clkdev_add_table(v2m_lookups, ARRAY_SIZE(v2m_lookups));
> +	versatile_sched_clock_init(v2m_sysreg_base + V2M_SYS_24MHZ, 24000000);
> +	pm_power_off = v2m_power_off;
> +	arm_pm_restart = v2m_restart;
> +}
> +
> +static struct of_dev_auxdata v2m_legacy_dt_auxdata_lookup[] __initdata = {
> +	OF_DEV_AUXDATA("arm,vexpress-flash", V2M_NOR0, "physmap-flash",
> +			&v2m_flash_data),
> +	OF_DEV_AUXDATA("arm,primecell", V2M_WDT, "mb:wdt", NULL),
> +	OF_DEV_AUXDATA("arm,primecell", V2M_MMCI, "mb:mmci", &v2m_mmci_data),
> +	OF_DEV_AUXDATA("arm,primecell", V2M_KMI0, "mb:kmi0", NULL),
> +	OF_DEV_AUXDATA("arm,primecell", V2M_KMI1, "mb:kmi1", NULL),
> +	OF_DEV_AUXDATA("arm,primecell", V2M_UART0, "mb:uart0", NULL),
> +	OF_DEV_AUXDATA("arm,primecell", V2M_UART1, "mb:uart1", NULL),
> +	OF_DEV_AUXDATA("arm,primecell", V2M_UART2, "mb:uart2", NULL),
> +	OF_DEV_AUXDATA("arm,primecell", V2M_UART3, "mb:uart3", NULL),

You are only adding platform_data in 2 cases, so that probably means the
rest are for clkdev lookups. You can just add the lookups directly.

> +	{}
> +};
> +
> +struct of_dev_auxdata * __init v2m_dt_get_auxdata(enum v2m_memory_map map)
> +{
> +	switch (map) {
> +	case v2m_memory_map_legacy:
> +		return v2m_legacy_dt_auxdata_lookup;

Because auxdata is matched against addresses, you can just put all
entries into 1 table for both legacy and new memory map.

Rob

> +	default:
> +		panic("%s: Unknown memory map requested!\n", __func__);
> +		return NULL;
> +	}
> +}
> +
> +#endif
