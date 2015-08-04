From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 04 Aug 2015 13:27:14 +0100
Subject: [PATCH v4 02/10] ACPI / irqchip: Add self-probe infrastructure
 to initialize IRQ controller
In-Reply-To: <1438164539-29256-3-git-send-email-hanjun.guo@linaro.org>
References: <1438164539-29256-1-git-send-email-hanjun.guo@linaro.org>
 <1438164539-29256-3-git-send-email-hanjun.guo@linaro.org>
Message-ID: <55C0AFA2.8050704@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/07/15 11:08, Hanjun Guo wrote:
> This self-probe infrastructure works in the similar way as OF,
> but there is some different in the mechanism:
> 
> For DT, the init fn will be called once it finds compatible strings
> in DT,  but for ACPI, we init irqchips by static tables, and in
> static ACPI tables, there are no compatible strings to indicate
> irqchips, but thanks to the GIC version presented in ACPI table,
> we can call the corresponding GIC drivers matching the GIC version
> with this framework.
> 
> This mechanism can also be used for clock declare and may also works
> on x86 for some table parsing too.
> 
> This patch is based on Tomasz Nowicki <tomasz.nowicki@linaro.org>'s
> work.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/irqchip/irq-gic-acpi.c    | 33 +++++++++++++++++++++++++++++++++
>  include/asm-generic/vmlinux.lds.h | 13 +++++++++++++
>  include/linux/acpi.h              | 16 ++++++++++++++++
>  include/linux/irqchip.h           | 13 +++++++++++++
>  include/linux/mod_devicetable.h   |  8 ++++++++
>  5 files changed, 83 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-acpi.c b/drivers/irqchip/irq-gic-acpi.c
> index 6537b43..011468d 100644
> --- a/drivers/irqchip/irq-gic-acpi.c
> +++ b/drivers/irqchip/irq-gic-acpi.c
> @@ -107,3 +107,36 @@ static int __init acpi_gic_version_init(void)
>  
>  	return 0;
>  }
> +
> +/*
> + * This special acpi_table_id is the sentinel at the end of the
> + * acpi_table_id[] array of all irqchips. It is automatically placed at
> + * the end of the array by the linker, thanks to being part of a
> + * special section.
> + */
> +static const struct acpi_table_id
> +irqchip_acpi_match_end __used __section(__irqchip_acpi_table_end);

What is this thing for? Nobody refers to it (I know
drivers/irqchip/irqchip.c has a similar thing, but that's not enough a
reason...).

> +
> +extern struct acpi_table_id __irqchip_acpi_table[];
> +
> +void __init acpi_irqchip_init(void)
> +{
> +	struct acpi_table_id *id;
> +
> +	if (acpi_disabled)
> +		return;
> +
> +	if (acpi_gic_version_init())
> +		return;

This is the only place where we need the version, right? So just get
acpi_gic_version_init to return the version number, and loose the global
variable.

> +
> +	/* scan the irqchip table to match the GIC version and its driver */
> +	for (id = __irqchip_acpi_table; id->id[0]; id++) {
> +		if (gic_version == (u8)id->driver_data) {
> +			acpi_table_parse(id->id,
> +					 (acpi_tbl_table_handler)id->handler);
> +			return;
> +		}
> +	}
> +
> +	pr_err("No matched driver GIC version %d\n", gic_version);
> +}
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 8bd374d..625776c 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -181,6 +181,18 @@
>  #define CPUIDLE_METHOD_OF_TABLES() OF_TABLE(CONFIG_CPU_IDLE, cpuidle_method)
>  #define EARLYCON_OF_TABLES()	OF_TABLE(CONFIG_SERIAL_EARLYCON, earlycon)
>  
> +#ifdef CONFIG_ACPI
> +#define ACPI_TABLE(name)						\
> +	. = ALIGN(8);							\
> +	VMLINUX_SYMBOL(__##name##_acpi_table) = .;			\
> +	*(__##name##_acpi_table)					\
> +	*(__##name##_acpi_table_end)
> +
> +#define IRQCHIP_ACPI_MATCH_TABLE()	ACPI_TABLE(irqchip)
> +#else
> +#define IRQCHIP_ACPI_MATCH_TABLE()
> +#endif
> +
>  #define KERNEL_DTB()							\
>  	STRUCT_ALIGN();							\
>  	VMLINUX_SYMBOL(__dtb_start) = .;				\
> @@ -516,6 +528,7 @@
>  	CPUIDLE_METHOD_OF_TABLES()					\
>  	KERNEL_DTB()							\
>  	IRQCHIP_OF_MATCH_TABLE()					\
> +	IRQCHIP_ACPI_MATCH_TABLE()					\
>  	EARLYCON_TABLE()						\
>  	EARLYCON_OF_TABLES()
>  
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 0820cb1..04dd0bb 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -829,4 +829,20 @@ static inline struct acpi_device *acpi_get_next_child(struct device *dev,
>  
>  #endif
>  
> +#ifdef CONFIG_ACPI
> +#define ACPI_DECLARE(table, name, table_id, data, fn)			\
> +	static const struct acpi_table_id __acpi_table_##name		\
> +		__used __section(__##table##_acpi_table)		\
> +		 = { .id = table_id,					\
> +		     .handler = (void *)fn,				\
> +		     .driver_data = data }
> +#else
> +#define ACPI_DECLARE(table, name, table_id, data, fn)			\
> +	static const struct acpi_table_id __acpi_table_##name		\
> +		__attribute__((unused))					\
> +		 = { .id = table_id,					\
> +		     .handler = (void *)fn,				\
> +		     .driver_data = data }
> +#endif
> +
>  #endif	/*_LINUX_ACPI_H*/
> diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
> index 6388873..6b66d3e 100644
> --- a/include/linux/irqchip.h
> +++ b/include/linux/irqchip.h
> @@ -11,6 +11,7 @@
>  #ifndef _LINUX_IRQCHIP_H
>  #define _LINUX_IRQCHIP_H
>  
> +#include <linux/acpi.h>
>  #include <linux/of.h>
>  
>  /*
> @@ -25,6 +26,18 @@
>   */
>  #define IRQCHIP_DECLARE(name, compat, fn) OF_DECLARE_2(irqchip, name, compat, fn)
>  
> +/*
> + * This macro must be used by the different ARM GIC drivers to declare
> + * the association between their version and their initialization function.
> + *
> + * @name: name that must be unique accross all IRQCHIP_ACPI_DECLARE of the
> + * same file.
> + * @gic_version: version of GIC
> + * @fn: initialization function
> + */
> +#define IRQCHIP_ACPI_DECLARE(name, gic_version, fn)	\
> +	ACPI_DECLARE(irqchip, name, ACPI_SIG_MADT, gic_version, fn)

I don't think this is the right approach. The MADT table has a *huge*
number of possible subtables, and none of them is matched by the GIC
version.

What you *really* want is MADT -> GICD -> GIC type. Your ACPI_DECLARE
macro doesn't reflect this at all (you've basically cloned OF, and
that's clearly not good enough).

This probably require an intermediate matching function, ending up with
something like:

#define IRQCHIP_ACPI_DECLARE(name, subtable, version, fn) \
	ACPI_DECLARE(irqchip, name, ACPI_SIG_MADT, match_madt_subtable,\
		subtable, version, fn)

where match_madt_subtable is going to check that a given subtable is
really suitable for a given irqchip. None of that should be GIC
specific, really.

> +
>  #ifdef CONFIG_IRQCHIP
>  void irqchip_init(void);
>  #else
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index 34f25b7..105be1f 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -193,6 +193,14 @@ struct acpi_device_id {
>  	__u32 cls_msk;
>  };
>  
> +#define ACPI_TABLE_ID_LEN	5
> +
> +struct acpi_table_id {
> +	__u8 id[ACPI_TABLE_ID_LEN];
> +	const void *handler;
> +	kernel_ulong_t driver_data;
> +};
> +
>  #define PNP_ID_LEN	8
>  #define PNP_MAX_DEVICES	8
>  
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
