From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 26 Nov 2015 12:33:41 +0000
Subject: [Xen-devel] [PATCH v3 31/62] arm/acpi: Add a helper function to
 get interrupt type
In-Reply-To: <1447753261-7552-32-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-32-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511261229320.1107@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Add a helper funtion to get the type of interrupts in ACPI table.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  xen/arch/arm/acpi/lib.c    | 27 +++++++++++++++++++++++++++
>  xen/include/asm-arm/acpi.h | 39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/xen/arch/arm/acpi/lib.c b/xen/arch/arm/acpi/lib.c
> index d8b7635..47f4c6a 100644
> --- a/xen/arch/arm/acpi/lib.c
> +++ b/xen/arch/arm/acpi/lib.c
> @@ -43,3 +43,30 @@ bool_t __init acpi_psci_hvc_present(void)
>  {
>      return acpi_gbl_FADT.arm_boot_flags & ACPI_FADT_PSCI_USE_HVC;
>  }
> +
> +unsigned int acpi_get_irq_type(u32 flags)
> +{
> +    int trigger, polarity;
> +
> +    trigger = (flags & ACPI_GTDT_INTERRUPT_MODE) ? ACPI_EDGE_SENSITIVE

                         ^ GTDT? This is not specific to the GTDT table, right?


> +               : ACPI_LEVEL_SENSITIVE;
> +
> +    polarity = (flags & ACPI_GTDT_INTERRUPT_POLARITY) ? ACPI_ACTIVE_LOW

same here


> +                : ACPI_ACTIVE_HIGH;
> +
> +    switch (polarity) {
> +    case ACPI_ACTIVE_LOW:
> +        return trigger == ACPI_EDGE_SENSITIVE ?
> +            ACPI_IRQ_TYPE_EDGE_FALLING :
> +            ACPI_IRQ_TYPE_LEVEL_LOW;
> +    case ACPI_ACTIVE_HIGH:
> +        return trigger == ACPI_EDGE_SENSITIVE ?
> +            ACPI_IRQ_TYPE_EDGE_RISING :
> +            ACPI_IRQ_TYPE_LEVEL_HIGH;
> +    case ACPI_ACTIVE_BOTH:
> +        if (trigger == ACPI_EDGE_SENSITIVE)
> +            return ACPI_IRQ_TYPE_EDGE_BOTH;
> +    default:
> +        return ACPI_IRQ_TYPE_NONE;
> +    }
> +}
> diff --git a/xen/include/asm-arm/acpi.h b/xen/include/asm-arm/acpi.h
> index 714e596..214fc4e 100644
> --- a/xen/include/asm-arm/acpi.h
> +++ b/xen/include/asm-arm/acpi.h
> @@ -34,10 +34,12 @@ extern bool_t acpi_disabled;
>  bool_t __init acpi_psci_present(void);
>  bool_t __init acpi_psci_hvc_present(void);
>  void __init acpi_smp_init_cpus(void);
> +unsigned int acpi_get_irq_type(u32 flags);
>  #else
>  static inline bool_t acpi_psci_present(void) { return false; }
>  static inline bool_t acpi_psci_hvc_present(void) {return false; }
>  static inline void acpi_smp_init_cpus(void) { }
> +static inline unsigned int acpi_get_irq_type(u32 flags) { return 0; }
>  #endif /* CONFIG_ACPI */
>  
>  /* Basic configuration for ACPI */
> @@ -48,4 +50,41 @@ static inline void disable_acpi(void)
>  
>  #define ACPI_GTDT_INTR_MASK ( ACPI_GTDT_INTERRUPT_MODE | ACPI_GTDT_INTERRUPT_POLARITY )
>  
> +/* Triggering */
> +
> +#define ACPI_LEVEL_SENSITIVE            (u8) 0x00
> +#define ACPI_EDGE_SENSITIVE             (u8) 0x01
> +
> +/* Polarity */
> +
> +#define ACPI_ACTIVE_HIGH                (u8) 0x00
> +#define ACPI_ACTIVE_LOW                 (u8) 0x01
> +#define ACPI_ACTIVE_BOTH                (u8) 0x02
> +
> +/**
> + * IRQ line type.
> + *
> + * ACPI_IRQ_TYPE_NONE            - default, unspecified type
> + * ACPI_IRQ_TYPE_EDGE_RISING     - rising edge triggered
> + * ACPI_IRQ_TYPE_EDGE_FALLING    - falling edge triggered
> + * ACPI_IRQ_TYPE_EDGE_BOTH       - rising and falling edge triggered
> + * ACPI_IRQ_TYPE_LEVEL_HIGH      - high level triggered
> + * ACPI_IRQ_TYPE_LEVEL_LOW       - low level triggered
> + * ACPI_IRQ_TYPE_LEVEL_MASK      - Mask to filter out the level bits
> + * ACPI_IRQ_TYPE_SENSE_MASK      - Mask for all the above bits
> + * ACPI_IRQ_TYPE_INVALID         - Use to initialize the type
> + */
> +#define ACPI_IRQ_TYPE_NONE           0x00000000
> +#define ACPI_IRQ_TYPE_EDGE_RISING    0x00000001
> +#define ACPI_IRQ_TYPE_EDGE_FALLING   0x00000002
> +#define ACPI_IRQ_TYPE_EDGE_BOTH                           \
> +    (ACPI_IRQ_TYPE_EDGE_FALLING | ACPI_IRQ_TYPE_EDGE_RISING)
> +#define ACPI_IRQ_TYPE_LEVEL_HIGH     0x00000004
> +#define ACPI_IRQ_TYPE_LEVEL_LOW      0x00000008
> +#define ACPI_IRQ_TYPE_LEVEL_MASK                          \
> +    (ACPI_IRQ_TYPE_LEVEL_LOW | ACPI_IRQ_TYPE_LEVEL_HIGH)
> +#define ACPI_IRQ_TYPE_SENSE_MASK     0x0000000f
> +
> +#define ACPI_IRQ_TYPE_INVALID        0x00000010

Given that these are actually physical irq properties, they don't really
depend on ACPI or DT, in fact I believe these are taken from the device
tree definitions and renamed.

Instead of duplicating the irq types, I would make the device tree irq
types generic.
