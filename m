From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 26 Nov 2015 12:14:28 +0000
Subject: [Xen-devel] [PATCH v3 29/62] arm/acpi: Add GTDT support updated
 by ACPI 5.1
In-Reply-To: <1447753261-7552-30-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-30-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511261214210.1107@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Parth Dixit <parth.dixit@linaro.org>
> 
> With ACPI 5.0, we got per-processor timer support in GTDT,
> and ACPI 5.1 introduced the support for platform (memory-mapped)
> timers: GT Block and SBSA watchdog timer, add the code needed
> for the spec change.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Naresh Bhat <naresh.bhat@linaro.org>
> Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>

Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>


>  xen/include/acpi/actbl3.h  | 98 +++++++++++++++++++++++++++++++++++++++-------
>  xen/include/asm-arm/acpi.h |  2 +
>  2 files changed, 85 insertions(+), 15 deletions(-)
> 
> diff --git a/xen/include/acpi/actbl3.h b/xen/include/acpi/actbl3.h
> index 8c61b5f..fc96963 100644
> --- a/xen/include/acpi/actbl3.h
> +++ b/xen/include/acpi/actbl3.h
> @@ -241,33 +241,101 @@ struct acpi_s3pt_suspend {
>  
>  /*******************************************************************************
>   *
> - * GTDT - Generic Timer Description Table (ACPI 5.0)
> - *        Version 1
> + * GTDT - Generic Timer Description Table (ACPI 5.1)
> + *        Version 2
>   *
>   ******************************************************************************/
>  
>  struct acpi_table_gtdt {
>  	struct acpi_table_header header;	/* Common ACPI table header */
> -	u64 address;
> -	u32 flags;
> -	u32 secure_pl1_interrupt;
> -	u32 secure_pl1_flags;
> -	u32 non_secure_pl1_interrupt;
> -	u32 non_secure_pl1_flags;
> +	u64 counter_block_addresss;
> +	u32 reserved;
> +	u32 secure_el1_interrupt;
> +	u32 secure_el1_flags;
> +	u32 non_secure_el1_interrupt;
> +	u32 non_secure_el1_flags;
>  	u32 virtual_timer_interrupt;
>  	u32 virtual_timer_flags;
> -	u32 non_secure_pl2_interrupt;
> -	u32 non_secure_pl2_flags;
> +	u32 non_secure_el2_interrupt;
> +	u32 non_secure_el2_flags;
> +	u64 counter_read_block_address;
> +	u32 platform_timer_count;
> +	u32 platform_timer_offset;
>  };
>  
> -/* Values for Flags field above */
> +/* Flag Definitions: Timer Block Physical Timers and Virtual timers */
> +
> +#define ACPI_GTDT_INTERRUPT_MODE        (1)
> +#define ACPI_GTDT_INTERRUPT_POLARITY    (1<<1)
> +#define ACPI_GTDT_ALWAYS_ON             (1<<2)
> +
> +/* Common GTDT subtable header */
> +
> +struct acpi_gtdt_header {
> +	u8 type;
> +	u16 length;
> +};
> +
> +/* Values for GTDT subtable type above */
> +
> +enum acpi_gtdt_type {
> +	ACPI_GTDT_TYPE_TIMER_BLOCK = 0,
> +	ACPI_GTDT_TYPE_WATCHDOG = 1,
> +	ACPI_GTDT_TYPE_RESERVED = 2	/* 2 and greater are reserved */
> +};
> +
> +/* GTDT Subtables, correspond to Type in struct acpi_gtdt_header */
>  
> -#define ACPI_GTDT_MAPPED_BLOCK_PRESENT      1
> +/* 0: Generic Timer Block */
> +
> +struct acpi_gtdt_timer_block {
> +	struct acpi_gtdt_header header;
> +	u8 reserved;
> +	u64 block_address;
> +	u32 timer_count;
> +	u32 timer_offset;
> +};
> +
> +/* Timer Sub-Structure, one per timer */
> +
> +struct acpi_gtdt_timer_entry {
> +	u8 frame_number;
> +	u8 reserved[3];
> +	u64 base_address;
> +	u64 el0_base_address;
> +	u32 timer_interrupt;
> +	u32 timer_flags;
> +	u32 virtual_timer_interrupt;
> +	u32 virtual_timer_flags;
> +	u32 common_flags;
> +};
> +
> +/* Flag Definitions: timer_flags and virtual_timer_flags above */
> +
> +#define ACPI_GTDT_GT_IRQ_MODE               (1)
> +#define ACPI_GTDT_GT_IRQ_POLARITY           (1<<1)
> +
> +/* Flag Definitions: common_flags above */
> +
> +#define ACPI_GTDT_GT_IS_SECURE_TIMER        (1)
> +#define ACPI_GTDT_GT_ALWAYS_ON              (1<<1)
> +
> +/* 1: SBSA Generic Watchdog Structure */
> +
> +struct acpi_gtdt_watchdog {
> +	struct acpi_gtdt_header header;
> +	u8 reserved;
> +	u64 refresh_frame_address;
> +	u64 control_frame_address;
> +	u32 timer_interrupt;
> +	u32 timer_flags;
> +};
>  
> -/* Values for all "TimerFlags" fields above */
> +/* Flag Definitions: timer_flags above */
>  
> -#define ACPI_GTDT_INTERRUPT_MODE            1
> -#define ACPI_GTDT_INTERRUPT_POLARITY        2
> +#define ACPI_GTDT_WATCHDOG_IRQ_MODE         (1)
> +#define ACPI_GTDT_WATCHDOG_IRQ_POLARITY     (1<<1)
> +#define ACPI_GTDT_WATCHDOG_SECURE           (1<<2)
>  
>  /*******************************************************************************
>   *
> diff --git a/xen/include/asm-arm/acpi.h b/xen/include/asm-arm/acpi.h
> index 1efa29d..714e596 100644
> --- a/xen/include/asm-arm/acpi.h
> +++ b/xen/include/asm-arm/acpi.h
> @@ -46,4 +46,6 @@ static inline void disable_acpi(void)
>      acpi_disabled = 1;
>  }
>  
> +#define ACPI_GTDT_INTR_MASK ( ACPI_GTDT_INTERRUPT_MODE | ACPI_GTDT_INTERRUPT_POLARITY )
> +
>  #endif /*_ASM_ARM_ACPI_H*/
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel at lists.xen.org
> http://lists.xen.org/xen-devel
> 
