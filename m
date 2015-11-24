From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 24 Nov 2015 10:51:42 +0000
Subject: [Xen-devel] [PATCH v3 22/62] arm/gic-v3: Refactor gicv3_init
 into generic and dt specific parts
In-Reply-To: <1447753261-7552-23-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-23-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511241046350.1107@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Refactor gic-v3 related functions into dt and generic parts. This will be
> helpful when adding acpi support for gic-v3.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  xen/arch/arm/gic-v3.c | 95 +++++++++++++++++++++++++++------------------------
>  1 file changed, 51 insertions(+), 44 deletions(-)
> 
> diff --git a/xen/arch/arm/gic-v3.c b/xen/arch/arm/gic-v3.c
> index 4fe0c37..bd13010 100644
> --- a/xen/arch/arm/gic-v3.c
> +++ b/xen/arch/arm/gic-v3.c
> @@ -1138,62 +1138,27 @@ static int __init cmp_rdist(const void *a, const void *b)
>      return ( l->base < r->base) ? -1 : 0;
>  }
>  
> +static paddr_t __initdata dbase = 0, cbase = 0, csize = 0, vbase = 0;

It might be best to initialize them to something like INVALID_PADDR
rather then 0, which is actually a possible address value.


>  /* If the GICv3 supports GICv2, initialize it */
> -static void __init gicv3_init_v2(const struct dt_device_node *node,
> -                                 paddr_t dbase)
> +static void __init gicv3_init_v2(void)
>  {
> -    int res;
> -    paddr_t cbase, csize;
> -    paddr_t vbase, vsize;
> -
> -    /*
> -     * For GICv3 supporting GICv2, GICC and GICV base address will be
> -     * provided.
> -     */
> -    res = dt_device_get_address(node, 1 + gicv3.rdist_count,
> -                                &cbase, &csize);
> -    if ( res )
> +    if ( cbase == 0 || vbase == 0 )
>          return;
>  
> -    res = dt_device_get_address(node, 1 + gicv3.rdist_count + 2,
> -                                &vbase, &vsize);
> -    if ( res )
> -        return;
> -
> -    /*
> -     * We emulate a vGICv2 using a GIC CPU interface of GUEST_GICC_SIZE.
> -     * So only support GICv2 on GICv3 when the virtual CPU interface is
> -     * at least GUEST_GICC_SIZE.
> -     */
> -    if ( vsize < GUEST_GICC_SIZE )
> -    {
> -        printk(XENLOG_WARNING
> -               "GICv3: WARNING: Not enabling support for GICv2 compat mode.\n"
> -               "Size of GICV (%#"PRIpaddr") must at least be %#llx.\n",
> -               vsize, GUEST_GICC_SIZE);
> -        return;
> -    }
> -
>      printk("GICv3 compatible with GICv2 cbase %#"PRIpaddr" vbase %#"PRIpaddr"\n",
>             cbase, vbase);
>  
>      vgic_v2_setup_hw(dbase, cbase, csize, vbase, 0);
>  }
>  
> -/* Set up the GIC */
> -static int __init gicv3_init(void)
> +static void __init dt_gicv3_init(void)
>  {
>      struct rdist_region *rdist_regs;
>      int res, i;
>      uint32_t reg;
>      const struct dt_device_node *node = gicv3_info.node;
> -    paddr_t dbase;
> -
> -    if ( !cpu_has_gicv3 )
> -    {
> -        dprintk(XENLOG_ERR, "GICv3: driver requires system register support\n");
> -        return -ENODEV;
> -    }
> +    paddr_t vsize;
>  
>      res = dt_device_get_address(node, 0, &dbase, NULL);
>      if ( res )
> @@ -1248,6 +1213,48 @@ static int __init gicv3_init(void)
>          panic("GICv3: Cannot find the maintenance IRQ");
>      gicv3_info.maintenance_irq = res;
>  
> +    /*
> +     * For GICv3 supporting GICv2, GICC and GICV base address will be
> +     * provided.
> +     */
> +    res = dt_device_get_address(node, 1 + gicv3.rdist_count,
> +                                &cbase, &csize);
> +    if ( res )
> +        return;
> +
> +    res = dt_device_get_address(node, 1 + gicv3.rdist_count + 2,
> +                                &vbase, &vsize);
> +    if ( res )
> +        return;
> +
> +    /*
> +     * We emulate a vGICv2 using a GIC CPU interface of GUEST_GICC_SIZE.
> +     * So only support GICv2 on GICv3 when the virtual CPU interface is
> +     * at least GUEST_GICC_SIZE.
> +     */
> +    if ( vsize < GUEST_GICC_SIZE )
> +    {
> +        printk(XENLOG_WARNING
> +               "GICv3: WARNING: Not enabling support for GICv2 compat mode.\n"
> +               "Size of GICV (%#"PRIpaddr") must at least be %#llx.\n",
> +               vsize, GUEST_GICC_SIZE);
> +        return;
> +    }
> +}
> +
> +/* Set up the GIC */
> +static int __init gicv3_init(void)
> +{
> +    int res, i;
> +
> +    if ( !cpu_has_gicv3 )
> +    {
> +        dprintk(XENLOG_ERR, "GICv3: driver requires system register support\n");
> +        return -ENODEV;
> +    }
> +
> +    dt_gicv3_init();

I think it would be best if we kept iall the ioremap calls here in the
common function, instead of duplicating them in the acpi and dt specific
init functions.

The GICD_PIDR2 check should common too.


>      for ( i = 0; i < gicv3.rdist_count; i++ )
>      {
>          /* map dbase & rdist regions */
> @@ -1277,7 +1284,7 @@ static int __init gicv3_init(void)
>  
>      vgic_v3_setup_hw(dbase, gicv3.rdist_count, gicv3.rdist_regions,
>                       gicv3.rdist_stride);
> -    gicv3_init_v2(node, dbase);
> +    gicv3_init_v2();
>  
>      spin_lock_init(&gicv3.lock);
>  
> @@ -1317,7 +1324,7 @@ static const struct gic_hw_operations gicv3_ops = {
>      .make_hwdom_dt_node  = gicv3_make_hwdom_dt_node,
>  };
>  
> -static int __init gicv3_preinit(struct dt_device_node *node, const void *data)
> +static int __init dt_gicv3_preinit(struct dt_device_node *node, const void *data)
>  {
>      gicv3_info.hw_version = GIC_V3;
>      gicv3_info.node = node;
> @@ -1335,7 +1342,7 @@ static const struct dt_device_match gicv3_dt_match[] __initconst =
>  
>  DT_DEVICE_START(gicv3, "GICv3", DEVICE_GIC)
>          .dt_match = gicv3_dt_match,
> -        .init = gicv3_preinit,
> +        .init = dt_gicv3_preinit,
>  DT_DEVICE_END
>  
>  /*
