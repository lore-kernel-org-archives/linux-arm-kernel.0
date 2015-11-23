From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 23 Nov 2015 14:56:17 +0000
Subject: [PATCH v3 17/62] arm/acpi: Print GIC information when MADT is
 parsed
In-Reply-To: <1447753261-7552-18-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-18-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511231454580.1107@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Naresh Bhat <naresh.bhat@linaro.org>
> 
> When MADT is parsed, print GIC information to make the boot
> log look pretty.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Signed-off-by: Naresh Bhat <naresh.bhat@linaro.org>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  xen/drivers/acpi/tables.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/xen/drivers/acpi/tables.c b/xen/drivers/acpi/tables.c
> index 60c4ab1..6573175 100644
> --- a/xen/drivers/acpi/tables.c
> +++ b/xen/drivers/acpi/tables.c
> @@ -189,6 +189,30 @@ void __init acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>  		}
>  		break;
>  
> +	case ACPI_MADT_TYPE_GENERIC_INTERRUPT:
> +		{
> +			struct acpi_madt_generic_interrupt *p =
> +				(struct acpi_madt_generic_interrupt *)header;
> +			printk(KERN_INFO PREFIX
> +			       "GICC (acpi_id[0x%04x] address[%llx] MPIDR[0x%llx] %s)\n",
> +			       p->uid, (long long unsigned int)p->base_address,
> +			       (long long unsigned int)p->arm_mpidr,
> +			       (p->flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");

PRIx64?


> +		}
> +		break;
> +
> +	case ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR:
> +		{
> +			struct acpi_madt_generic_distributor *p =
> +				(struct acpi_madt_generic_distributor *)header;
> +			printk(KERN_INFO PREFIX
> +			       "GIC Distributor (gic_id[0x%04x] address[%llx] gsi_base[%d])\n",
> +			       p->gic_id, (long long unsigned int)p->base_address,
> +			       p->global_irq_base);

ditto


> +		}
> +		break;
> +
>  	default:
>  		printk(KERN_WARNING PREFIX
>  		       "Found unsupported MADT entry (type = %#x)\n",
> -- 
> 2.1.0
> 
