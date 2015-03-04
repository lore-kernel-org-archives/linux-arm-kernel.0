From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 04 Mar 2015 23:33:32 +0100
Subject: [PATCH v9 01/21] ACPI / table: Use pr_debug() instead of
 pr_info() for MADT table scanning
In-Reply-To: <1424853601-6675-2-git-send-email-hanjun.guo@linaro.org>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-2-git-send-email-hanjun.guo@linaro.org>
Message-ID: <5472111.MIDVrBN6XB@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, February 25, 2015 04:39:41 PM Hanjun Guo wrote:
> For a normal 8 cpu sockets system, it will up to 240 cpu threads (Xeon E7
> v2 family for now), and we need 240 entries for local apic or local x2apic
> in MADT table, so it will be much verbose information printed with a slow
> uart console when system booted, this will be even worse with large system
> with 16/32 cpu sockets.
> 
> This patch just use pr_debug() instead of pr_info() for ioapic/iosapic,
> local apic/x2apic/sapic structures when scanning the MADT table to remove
> those verbose information, but leave other structures unchanged.
> 
> CC: Rafael J Wysocki <rjw@rjwysocki.net>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/tables.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 93b8152..f4e5b88 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -23,6 +23,8 @@
>   *
>   */
>  
> +/* Uncomment next line to get verbose printout */
> +/* #define DEBUG */
>  #define pr_fmt(fmt) "ACPI: " fmt
>  
>  #include <linux/init.h>
> @@ -61,9 +63,9 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>  		{
>  			struct acpi_madt_local_apic *p =
>  			    (struct acpi_madt_local_apic *)header;
> -			pr_info("LAPIC (acpi_id[0x%02x] lapic_id[0x%02x] %s)\n",
> -				p->processor_id, p->id,
> -				(p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
> +			pr_debug("LAPIC (acpi_id[0x%02x] lapic_id[0x%02x] %s)\n",
> +				 p->processor_id, p->id,
> +				 (p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
>  		}
>  		break;
>  
> @@ -71,9 +73,9 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>  		{
>  			struct acpi_madt_local_x2apic *p =
>  			    (struct acpi_madt_local_x2apic *)header;
> -			pr_info("X2APIC (apic_id[0x%02x] uid[0x%02x] %s)\n",
> -				p->local_apic_id, p->uid,
> -				(p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
> +			pr_debug("X2APIC (apic_id[0x%02x] uid[0x%02x] %s)\n",
> +				 p->local_apic_id, p->uid,
> +				 (p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
>  		}
>  		break;
>  
> @@ -81,8 +83,8 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>  		{
>  			struct acpi_madt_io_apic *p =
>  			    (struct acpi_madt_io_apic *)header;
> -			pr_info("IOAPIC (id[0x%02x] address[0x%08x] gsi_base[%d])\n",
> -				p->id, p->address, p->global_irq_base);
> +			pr_debug("IOAPIC (id[0x%02x] address[0x%08x] gsi_base[%d])\n",
> +				 p->id, p->address, p->global_irq_base);
>  		}
>  		break;
>  
> @@ -155,9 +157,9 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>  		{
>  			struct acpi_madt_io_sapic *p =
>  			    (struct acpi_madt_io_sapic *)header;
> -			pr_info("IOSAPIC (id[0x%x] address[%p] gsi_base[%d])\n",
> -				p->id, (void *)(unsigned long)p->address,
> -				p->global_irq_base);
> +			pr_debug("IOSAPIC (id[0x%x] address[%p] gsi_base[%d])\n",
> +				 p->id, (void *)(unsigned long)p->address,
> +				 p->global_irq_base);
>  		}
>  		break;
>  
> @@ -165,9 +167,9 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>  		{
>  			struct acpi_madt_local_sapic *p =
>  			    (struct acpi_madt_local_sapic *)header;
> -			pr_info("LSAPIC (acpi_id[0x%02x] lsapic_id[0x%02x] lsapic_eid[0x%02x] %s)\n",
> -				p->processor_id, p->id, p->eid,
> -				(p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
> +			pr_debug("LSAPIC (acpi_id[0x%02x] lsapic_id[0x%02x] lsapic_eid[0x%02x] %s)\n",
> +				 p->processor_id, p->id, p->eid,
> +				 (p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
>  		}
>  		break;
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
