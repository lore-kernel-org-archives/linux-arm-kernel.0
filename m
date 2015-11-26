From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 26 Nov 2015 12:54:21 +0000
Subject: [Xen-devel] [PATCH v3 32/62] arm/acpi: Parse GTDT to initialize
 timer
In-Reply-To: <1447753261-7552-33-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-33-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511261247480.1107@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Parth Dixit <parth.dixit@linaro.org>
> 
> Parse GTDT (Generic Timer Descriptor Table) to initialize timer. Using
> the information presented by GTDT to initialize the arch timer (not
> memory-mapped).
> 
> Signed-off-by: Naresh Bhat <naresh.bhat@linaro.org>
> Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  xen/arch/arm/time.c | 73 +++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 62 insertions(+), 11 deletions(-)
> 
> diff --git a/xen/arch/arm/time.c b/xen/arch/arm/time.c
> index 5ded30c..adbfc2a 100644
> --- a/xen/arch/arm/time.c
> +++ b/xen/arch/arm/time.c
> @@ -29,6 +29,7 @@
>  #include <xen/time.h>
>  #include <xen/sched.h>
>  #include <xen/event.h>
> +#include <xen/acpi.h>
>  #include <asm/system.h>
>  #include <asm/time.h>
>  #include <asm/gic.h>
> @@ -65,8 +66,45 @@ unsigned int timer_get_irq(enum timer_ppi ppi)
>  
>  static __initdata struct dt_device_node *timer;
>  
> +#ifdef CONFIG_ACPI
> +/* Initialize per-processor generic timer */
> +static int __init arch_timer_acpi_init(struct acpi_table_header *table)
> +{
> +    unsigned int irq_type;
> +    struct acpi_table_gtdt *gtdt;
> +
> +    gtdt = container_of(table, struct acpi_table_gtdt, header);
> +
> +    /* Initialize all the generic timer IRQ variable from GTDT table */
> +    irq_type = acpi_get_irq_type(gtdt->non_secure_el1_flags);
> +    irq_set_type(gtdt->non_secure_el1_interrupt, irq_type);
> +    timer_irq[TIMER_PHYS_NONSECURE_PPI] = gtdt->non_secure_el1_interrupt;
> +
> +    irq_type = acpi_get_irq_type(gtdt->secure_el1_flags);
> +    irq_set_type(gtdt->secure_el1_interrupt, irq_type);
> +    timer_irq[TIMER_PHYS_SECURE_PPI] = gtdt->secure_el1_interrupt;
> +
> +    irq_type = acpi_get_irq_type(gtdt->virtual_timer_flags);
> +    irq_set_type(gtdt->virtual_timer_interrupt, irq_type);
> +    timer_irq[TIMER_VIRT_PPI] = gtdt->virtual_timer_interrupt;
> +
> +    irq_type = acpi_get_irq_type(gtdt->non_secure_el2_flags);
> +    irq_set_type(gtdt->non_secure_el2_interrupt, irq_type);
> +    timer_irq[TIMER_HYP_PPI] = gtdt->non_secure_el2_interrupt;
> +
> +    return 0;
> +}
> +
> +void __init acpi_preinit_xen_time(void)

static?


> +{
> +	acpi_table_parse(ACPI_SIG_GTDT, arch_timer_acpi_init);
> +}
> +#else
> +static inline void acpi_preinit_xen_time(void) { }
> +#endif
> +
>  /* Set up the timer on the boot CPU (early init function) */
> -void __init preinit_xen_time(void)
> +static void __init dt_preinit_xen_time(void)
>  {
>      static const struct dt_device_match timer_ids[] __initconst =
>      {
> @@ -74,7 +112,6 @@ void __init preinit_xen_time(void)
>          { /* sentinel */ },
>      };
>      int res;
> -    u32 rate;
>  
>      timer = dt_find_matching_node(NULL, timer_ids);
>      if ( !timer )
> @@ -86,8 +123,19 @@ void __init preinit_xen_time(void)
>      if ( res )
>          panic("Timer: Cannot initialize platform timer");

Don't we want to call platform_init_time on ARM too? It doesn't look
like something DT specific. I guess we should move the call to the
generic init function?


> -    res = dt_property_read_u32(timer, "clock-frequency", &rate);
> -    if ( res )

I think we should keep the clock-frequency DT read in
dt_preinit_xen_time.


> +}
> +
> +void __init preinit_xen_time(void)
> +{
> +    u32 rate;
> +
> +    /* Initialize all the generic timers presented in GTDT */
> +    if ( acpi_disabled )
> +        dt_preinit_xen_time();
> +    else
> +        acpi_preinit_xen_time();
> +
> +    if( acpi_disabled && dt_property_read_u32(timer, "clock-frequency", &rate) )
>      {
>          cpu_khz = rate / 1000;
>          timer_dt_clock_frequency = rate;

I don't think we want to read a DT property from a generic
initialization function.


> @@ -104,14 +152,17 @@ int __init init_xen_time(void)
>      int res;
>      unsigned int i;
>  
> -    /* Retrieve all IRQs for the timer */
> -    for ( i = TIMER_PHYS_SECURE_PPI; i < MAX_TIMER_PPI; i++ )
> +    if( acpi_disabled )
>      {
> -        res = platform_get_irq(timer, i);
> -
> -        if ( res < 0 )
> -            panic("Timer: Unable to retrieve IRQ %u from the device tree", i);
> -        timer_irq[i] = res;
> +        /* Retrieve all IRQs for the timer */
> +        for ( i = TIMER_PHYS_SECURE_PPI; i < MAX_TIMER_PPI; i++ )
> +        {
> +            res = platform_get_irq(timer, i);
> +
> +            if ( res < 0 )
> +                panic("Timer: Unable to retrieve IRQ %u from the device tree", i);
> +            timer_irq[i] = res;
> +        }
>      }

Can't be just move this into the DT specific init function?


>  
>      /* Check that this CPU supports the Generic Timer interface */
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel at lists.xen.org
> http://lists.xen.org/xen-devel
> 
