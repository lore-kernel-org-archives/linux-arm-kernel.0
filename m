From: julien.grall@citrix.com (Julien Grall)
Date: Tue, 17 Nov 2015 12:33:48 +0000
Subject: [PATCH v3 55/62] arm/acpi: Route all Xen unused SPIs to Dom0
In-Reply-To: <1447753261-7552-56-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-56-git-send-email-shannon.zhao@linaro.org>
Message-ID: <564B1EAC.2050904@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shannon,

On 17/11/15 09:40, shannon.zhao at linaro.org wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Route all SPIs to Dom0 except the interrupts that Xen uses. Since Xen
> already uses the uart interrupt, the desc->action will not be NULL, so
> it will skip it.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  xen/arch/arm/domain_build.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/xen/arch/arm/domain_build.c b/xen/arch/arm/domain_build.c
> index 6d8536b..6945f89 100644
> --- a/xen/arch/arm/domain_build.c
> +++ b/xen/arch/arm/domain_build.c
> @@ -1360,6 +1360,35 @@ static int prepare_dtb(struct domain *d, struct kernel_info *kinfo)
>  #define XEN_HYPERVISOR_ID 0x000058656E564D4D  /* "XenVMM" */
>  #define ACPI_DOM0_FDT_MIN_SIZE 4096
>  
> +static int acpi_route_spi(struct domain *d)
> +{
> +    int i, res;
> +    struct irq_desc *desc;
> +
> +    /* Don't route Xen used interrupt to Dom0. Since Xen already uses the uart
> +     * interrupt, the desc->action will not be NULL, so it will skip it.
> +     */
> +    for( i = NR_LOCAL_IRQS; i < vgic_num_irqs(d); i++ )
> +    {
> +        /* Don't route uart interrupt to Dom0 */

Your comments are wrong. desc->action != NULL means Xen is using the
interrupt. It could be for the SMMU, the UART...

> +        desc = irq_to_desc(i);
> +        if( desc->action != NULL)

Coding style.

> +            continue;
> +
> +        vgic_reserve_virq(d, i);
> +        irq_set_type(i, ACPI_IRQ_TYPE_NONE);
> +        res = route_irq_to_guest(d, i, i, NULL);
> +        if ( res )
> +        {
> +            printk(XENLOG_ERR "Unable to route IRQ %u to domain %u\n",
> +                   i, d->domain_id);
> +            continue;
> +        }
> +    }
> +
> +    return 0;
> +}
> +

Regards,

-- 
Julien Grall
