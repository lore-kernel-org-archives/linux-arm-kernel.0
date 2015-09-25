From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sat, 26 Sep 2015 01:54:18 +0200
Subject: [PATCH v2 1/5] acpi: Add basic device probing infrastructure
In-Reply-To: <1442152943-24493-2-git-send-email-marc.zyngier@arm.com>
References: <1442152943-24493-1-git-send-email-marc.zyngier@arm.com>
 <1442152943-24493-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <12040863.OFfZIfOccM@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, September 13, 2015 03:02:19 PM Marc Zyngier wrote:

The subject is slightly confusing IMO (there is a device probing infrastructure
in the ACPI subsystem, but not for the kind of devices in question here).

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
>  include/linux/acpi.h              | 65 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 114 insertions(+)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 01136b8..ac3030b 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1933,3 +1933,42 @@ int __init acpi_scan_init(void)
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
> +	if (!ape->validate_subtbl || ape->validate_subtbl(header, ape))
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
> index 7235c48..c63fbda 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -759,6 +759,61 @@ int acpi_dev_prop_read(struct acpi_device *adev, const char *propname,
>  
>  struct acpi_device *acpi_get_next_child(struct device *dev,
>  					struct acpi_device *child);
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
> + * @validate_subtbl:	Optional callback to check the validity of
> + *			the subtable

I'd call this subtbl_valid (or even subtable_valid for that matter, the two extra
vowels in the name don't really hurt IMO).

> + * @probe_table:	Callback to the driver being probed when table
> + *			match is successful
> + * @probe_subtbl:	Callback to the driver being probed when table and
> + *			subtable match (and optionnal callback is successful)

s/optionnal/optional/

> + * @driver_data:	Sideband data provided back to the driver
> + */
> +struct acpi_probe_entry {
> +	__u8 id[ACPI_TABLE_ID_LEN];
> +	__u8 type;
> +	acpi_probe_entry_validate_subtbl validate_subtbl;
> +	union {
> +		acpi_tbl_table_handler probe_table;
> +		acpi_tbl_entry_handler probe_subtbl;
> +	};
> +	kernel_ulong_t driver_data;
> +};
> +
> +#define ACPI_DECLARE(table, name, table_id, subtable, valid, data, fn)	\

The name of this macro might be a bit less generic and more self-explaining IMO.

Like ACPI_DECLARE_PROBE_ENTRY()?

> +	static const struct acpi_probe_entry __acpi_probe_##name	\
> +		__used __section(__##table##_acpi_probe_table)		\
> +		 = {							\
> +			.id = table_id,					\
> +			.type = subtable,				\
> +			.validate_subtbl = valid,			\
> +			.probe_table = (acpi_tbl_table_handler)fn,	\
> +			.driver_data = data, 				\
> +		   }
> +
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
> @@ -809,6 +864,16 @@ static inline struct acpi_device *acpi_get_next_child(struct device *dev,
>  	return NULL;
>  }
>  
> +#define ACPI_DECLARE(table, name, table_id, subtable, validate, data, fn) \
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

Thanks,
Rafael
