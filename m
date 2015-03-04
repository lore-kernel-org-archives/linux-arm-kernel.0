From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 04 Mar 2015 23:40 +0100
Subject: [PATCH v9 12/21] ACPI / table: Print GIC information when MADT is
 parsed
In-Reply-To: <1424853601-6675-13-git-send-email-hanjun.guo@linaro.org>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-13-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1559116.NBxTWyWPs4@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, February 25, 2015 04:39:52 PM Hanjun Guo wrote:
> When MADT is parsed, print GIC information as debug message:
> 
> ACPI: GICC (acpi_id[0x0000] address[00000000e112f000] MPIDR[0x0] enabled)
> ACPI: GICC (acpi_id[0x0001] address[00000000e112f000] MPIDR[0x1] enabled)
> ...
> ACPI: GICC (acpi_id[0x0201] address[00000000e112f000] MPIDR[0x201] enabled)
> 
> Those debug information will be very helpful to bring up early systems to
> see if acpi_id and MPIDR are matched or not as spec defined.
> 
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> Tested-by: Jon Masters <jcm@redhat.com>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/tables.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index f4e5b88..2e19189 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -185,6 +185,28 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>  		}
>  		break;
>  
> +	case ACPI_MADT_TYPE_GENERIC_INTERRUPT:
> +		{
> +			struct acpi_madt_generic_interrupt *p =
> +				(struct acpi_madt_generic_interrupt *)header;
> +			pr_debug("GICC (acpi_id[0x%04x] address[%llx] MPIDR[0x%llx] %s)\n",
> +				 p->uid, p->base_address,
> +				 p->arm_mpidr,
> +				 (p->flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
> +
> +		}
> +		break;
> +
> +	case ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR:
> +		{
> +			struct acpi_madt_generic_distributor *p =
> +				(struct acpi_madt_generic_distributor *)header;
> +			pr_debug("GIC Distributor (gic_id[0x%04x] address[%llx] gsi_base[%d])\n",
> +				 p->gic_id, p->base_address,
> +				 p->global_irq_base);
> +		}
> +		break;
> +
>  	default:
>  		pr_warn("Found unsupported MADT entry (type = 0x%x)\n",
>  			header->type);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
