From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 27 Nov 2015 15:04:36 +0000
Subject: [PATCH v3 55/62] arm/acpi: Route all Xen unused SPIs to Dom0
In-Reply-To: <1447753261-7552-56-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-56-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511271456560.8984@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:

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
> +        desc = irq_to_desc(i);
> +        if( desc->action != NULL)
> +            continue;

Don't you need to call irq_permit_access too?


> +        vgic_reserve_virq(d, i);
> +        irq_set_type(i, ACPI_IRQ_TYPE_NONE);

I don't know if there is any point in setting the type to NONE. It's the
default, isn't it?


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
>  static int make_chosen_node(const struct kernel_info *kinfo,
>                              struct membank tbl_add[])
>  {
> @@ -1897,6 +1926,10 @@ static int prepare_acpi(struct domain *d, struct kernel_info *kinfo)
>      if ( rc != 0 )
>          return rc;
>  
> +    rc = acpi_route_spi(d);
> +    if ( rc != 0 )
> +        return rc;
> +
>      return 0;
>  }
>  #else
> -- 
> 2.1.0
> 
