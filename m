From: wei@redhat.com (Wei Huang)
Date: Fri, 2 Oct 2015 16:06:05 -0500
Subject: [PATCH v3 1/7] acpi: Add early device probing infrastructure
In-Reply-To: <1443451758-22717-2-git-send-email-marc.zyngier@arm.com>
References: <1443451758-22717-1-git-send-email-marc.zyngier@arm.com>
 <1443451758-22717-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <560EF1BD.1020004@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 09/28/2015 09:49 AM, Marc Zyngier wrote:
> IRQ controllers and timers are the two types of device the kernel
> requires before being able to use the device driver model.
> 
> ACPI so far lacks a proper probing infrastructure similar to the one
> we have with DT, where we're able to declare IRQ chips and
> clocksources inside the driver code, and let the core code pick it up
> and call us back on a match. This leads to all kind of really ugly
> hacks all over the arm64 code and even in the ACPI layer.
> 
> In order to allow some basic probing based on the ACPI tables,
> introduce "struct acpi_probe_entry" which contains just enough
> data and callbacks to match a table, an optional subtable, and
> call a probe function. A driver can, at build time, register itself
> and expect being called if the right entry exists in the ACPI
> table.
> 
> A acpi_probe_device_table() is provided, taking an identifier for
> a set of acpi_prove_entries, and iterating over the registered
> entries.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/acpi/scan.c               | 39 +++++++++++++++++++++++
>  include/asm-generic/vmlinux.lds.h | 10 ++++++
>  include/linux/acpi.h              | 66 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 115 insertions(+)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index f834b8c..daf9fc8 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1913,3 +1913,42 @@ int __init acpi_scan_init(void)
>  	mutex_unlock(&acpi_scan_lock);
>  	return result;
>  }
> +
> +static struct acpi_probe_entry *ape;
> +static int acpi_probe_count;
> +static DEFINE_SPINLOCK(acpi_probe_lock);
> +
> +static int __init acpi_match_madt(struct acpi_subtable_header *header,
> +				  const unsigned long end)
> +{
> +	if (!ape->subtable_valid || ape->subtable_valid(header, ape))
> +		if (!ape->probe_subtbl(header, end))
> +			acpi_probe_count++;
> +
> +	return 0;
> +}
> +
> +int __init __acpi_probe_device_table(struct acpi_probe_entry *ap_head, int nr)
> +{
> +	int count = 0;
> +
> +	if (acpi_disabled)
> +		return 0;
> +
> +	spin_lock(&acpi_probe_lock);
> +	for (ape = ap_head; nr; ape++, nr--) {
> +		if (ACPI_COMPARE_NAME(ACPI_SIG_MADT, ape->id)) {
> +			acpi_probe_count = 0;
> +			acpi_table_parse_madt(ape->type, acpi_match_madt, 0);
> +			count += acpi_probe_count;
> +		} else {
> +			int res;
> +			res = acpi_table_parse(ape->id, ape->probe_table);
> +			if (!res)
> +				count++;
> +		}
> +	}
> +	spin_unlock(&acpi_probe_lock);
> +
> +	return count;
> +}
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 1781e54..efd7ed1 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -181,6 +181,16 @@
>  #define CPUIDLE_METHOD_OF_TABLES() OF_TABLE(CONFIG_CPU_IDLE, cpuidle_method)
>  #define EARLYCON_OF_TABLES()	OF_TABLE(CONFIG_SERIAL_EARLYCON, earlycon)
>  
> +#ifdef CONFIG_ACPI
> +#define ACPI_PROBE_TABLE(name)						\
> +	. = ALIGN(8);							\
> +	VMLINUX_SYMBOL(__##name##_acpi_probe_table) = .;		\
> +	*(__##name##_acpi_probe_table)					\
> +	VMLINUX_SYMBOL(__##name##_acpi_probe_table_end) = .;
> +#else
> +#define ACPI_PROBE_TABLE(name)
> +#endif
> +
>  #define KERNEL_DTB()							\
>  	STRUCT_ALIGN();							\
>  	VMLINUX_SYMBOL(__dtb_start) = .;				\
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 84e7055..51a96a8 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -787,6 +787,61 @@ int acpi_dev_prop_read(struct acpi_device *adev, const char *propname,
>  
>  struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
>  					    struct fwnode_handle *subnode);
> +
> +struct acpi_probe_entry;
> +typedef bool (*acpi_probe_entry_validate_subtbl)(struct acpi_subtable_header *,
> +						 struct acpi_probe_entry *);
> +
> +#define ACPI_TABLE_ID_LEN	5
> +
> +/**
> + * struct acpi_probe_entry - boot-time probing entry
> + * @id:			ACPI table name
> + * @type:		Optional subtable type to match
> + *			(if @id contains subtables)
> + * @subtable_valid:	Optional callback to check the validity of
> + *			the subtable
> + * @probe_table:	Callback to the driver being probed when table
> + *			match is successful
> + * @probe_subtbl:	Callback to the driver being probed when table and
> + *			subtable match (and optional callback is successful)
> + * @driver_data:	Sideband data provided back to the driver
> + */

A suggestion: could you add more details to the description above? I couldn't figure how to use it without reading __acpi_probe_device_table(). Something like "if @id matches the one defined in __acpi_probe_device_table(), then probe_subtbl() will be invoked; otherwise probe_table() will be invoked" would be helpful for programmers use this struct. 

> +struct acpi_probe_entry {
> +	__u8 id[ACPI_TABLE_ID_LEN];
> +	__u8 type;
> +	acpi_probe_entry_validate_subtbl subtable_valid;
> +	union {
> +		acpi_tbl_table_handler probe_table;
> +		acpi_tbl_entry_handler probe_subtbl;
> +	};

Could we avoid using union for probe_table & probe_subtbl? The benefit is that we don't need to do function casting below and compiler can automatically check the correctness.

> +	kernel_ulong_t driver_data;
> +};
> +
> +#define ACPI_DECLARE_PROBE_ENTRY(table, name, table_id, subtable, valid, data, fn)	\
> +	static const struct acpi_probe_entry __acpi_probe_##name	\
> +		__used __section(__##table##_acpi_probe_table)		\
> +		 = {							\
> +			.id = table_id,					\
> +			.type = subtable,				\
> +			.subtable_valid = valid,			\
> +			.probe_table = (acpi_tbl_table_handler)fn,	\
> +			.driver_data = data, 				\
> +		   }
> +

Something like: 

#define ACPI_DECLARE_PROBE_ENTRY(table, name, table_id, subtable, valid, data, fn, subfn)	\
	static const struct acpi_probe_entry __acpi_probe_##name	\
		__used __section(__##table##_acpi_probe_table)		\
		 = {							\
			.id = table_id,					\
			.type = subtable,				\
			.subtable_valid = valid,			\
			.probe_table = fn,				\
			.probe_subtbl = subfn,				\
			.driver_data = data, 				\
		   }

Then in patch 3, you can define new entries as:

IRQCHIP_ACPI_DECLARE(gic_v2, ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR,
		     gic_validate_dist, ACPI_MADT_GIC_VERSION_V2,
		     NULL, gic_v2_acpi_init);
IRQCHIP_ACPI_DECLARE(gic_v2_maybe, ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR,
		     gic_validate_dist, ACPI_MADT_GIC_VERSION_NONE,
		     NULL, gic_v2_acpi_init);


> +#define ACPI_PROBE_TABLE(name)		__##name##_acpi_probe_table
> +#define ACPI_PROBE_TABLE_END(name)	__##name##_acpi_probe_table_end
> +
> +int __acpi_probe_device_table(struct acpi_probe_entry *start, int nr);
> +
> +#define acpi_probe_device_table(t)					\
> +	({ 								\
> +		extern struct acpi_probe_entry ACPI_PROBE_TABLE(t),	\
> +			                       ACPI_PROBE_TABLE_END(t);	\
> +		__acpi_probe_device_table(&ACPI_PROBE_TABLE(t),		\
> +					  (&ACPI_PROBE_TABLE_END(t) -	\
> +					   &ACPI_PROBE_TABLE(t)));	\
> +	})
>  #else
>  static inline int acpi_dev_get_property(struct acpi_device *adev,
>  					const char *name, acpi_object_type type,
> @@ -845,6 +900,17 @@ static inline struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
>  {
>  	return NULL;
>  }
> +
> +#define ACPI_DECLARE_PROBE_ENTRY(table, name, table_id, subtable, validate, data, fn) \
> +	static const void * __acpi_table_##name[]			\
> +		__attribute__((unused))					\
> +		 = { (void *) table_id,					\
> +		     (void *) subtable,					\
> +		     (void *) valid,					\
> +		     (void *) fn,					\
> +		     (void *) data }
> +
> +#define acpi_probe_device_table(t)	({ int __r = 0; __r;})
>  #endif
>  
>  #endif	/*_LINUX_ACPI_H*/
> 
