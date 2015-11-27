From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 27 Nov 2015 15:12:23 +0000
Subject: [PATCH v3 58/62] xen/acpi: Fix event-channel interrupt when
 booting with ACPI
In-Reply-To: <1447753261-7552-59-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-59-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511271510350.8984@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> When booting with ACPI, store the event-channel interrupt number and
> flag in HVM parameter HVM_PARAM_CALLBACK_IRQ. Then Dom0 could get it
> through hypercall HVMOP_get_param.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  xen/arch/arm/domain_build.c | 45 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 28 insertions(+), 17 deletions(-)
> 
> diff --git a/xen/arch/arm/domain_build.c b/xen/arch/arm/domain_build.c
> index 9532807..36917be 100644
> --- a/xen/arch/arm/domain_build.c
> +++ b/xen/arch/arm/domain_build.c
> @@ -2067,23 +2067,34 @@ static void evtchn_fixup(struct domain *d, struct kernel_info *kinfo)
>      printk("Allocating PPI %u for event channel interrupt\n",
>             d->arch.evtchn_irq);
>  
> -    /* Fix up "interrupts" in /hypervisor node */
> -    node = fdt_path_offset(kinfo->fdt, "/hypervisor");
> -    if ( node < 0 )
> -        panic("Cannot find the /hypervisor node");
> -
> -    /* Interrupt event channel upcall:
> -     *  - Active-low level-sensitive
> -     *  - All CPUs
> -     *
> -     *  TODO: Handle properly the cpumask
> -     */
> -    set_interrupt_ppi(intr, d->arch.evtchn_irq, 0xf,
> -                      DT_IRQ_TYPE_LEVEL_LOW);
> -    res = fdt_setprop_inplace(kinfo->fdt, node, "interrupts",
> -                              &intr, sizeof(intr));
> -    if ( res )
> -        panic("Cannot fix up \"interrupts\" property of the hypervisor node");
> +    if ( acpi_disabled )
> +    {
> +        /* Fix up "interrupts" in /hypervisor node */
> +        node = fdt_path_offset(kinfo->fdt, "/hypervisor");
> +        if ( node < 0 )
> +            panic("Cannot find the /hypervisor node");
> +
> +        /* Interrupt event channel upcall:
> +         *  - Active-low level-sensitive
> +         *  - All CPUs
> +         *
> +         *  TODO: Handle properly the cpumask
> +         */
> +        set_interrupt_ppi(intr, d->arch.evtchn_irq, 0xf,
> +                          DT_IRQ_TYPE_LEVEL_LOW);
> +        res = fdt_setprop_inplace(kinfo->fdt, node, "interrupts",
> +                                  &intr, sizeof(intr));
> +        if ( res )
> +            panic("Cannot fix up \"interrupts\" property of the hypervisor node");

This code could be moved out to a dt_set_evtchn_irq function


> +    }
> +    else
> +    {
> +        int type = 3;
> +        int flag = 2; /* Active-low level-sensitive  */
> +        d->arch.hvm_domain.params[HVM_PARAM_CALLBACK_IRQ] = (u64)type << 56
> +                                                            | flag << 8
> +                                                            | d->arch.evtchn_irq;
> +    }
>  }

Actually there is no point in setting HVM_PARAM_CALLBACK_IRQ only on
ACPI: I would just set it on all cases.
