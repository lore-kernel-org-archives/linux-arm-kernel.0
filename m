From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 26 Nov 2015 15:43:56 +0000
Subject: [PATCH v3 36/62] arm/acpi: Initialize serial port from ACPI SPCR
 table
In-Reply-To: <1447753261-7552-37-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-37-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511261536090.8984@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Parth Dixit <parth.dixit@linaro.org>
> 
> Parse ACPI SPCR (Serial Port Console Redirection table) table and
> initialize the serial port pl011.
> 
> Signed-off-by: Naresh Bhat <naresh.bhat@linaro.org>
> Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  xen/drivers/char/pl011.c  | 37 +++++++++++++++++++++++++++++++++++++
>  xen/include/acpi/actbl2.h |  5 +++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/xen/drivers/char/pl011.c b/xen/drivers/char/pl011.c
> index 1efb1cf..7106f1c 100644
> --- a/xen/drivers/char/pl011.c
> +++ b/xen/drivers/char/pl011.c
> @@ -27,6 +27,7 @@
>  #include <asm/device.h>
>  #include <xen/mm.h>
>  #include <xen/vmap.h>
> +#include <xen/acpi.h>
>  #include <asm/pl011-uart.h>
>  #include <asm/io.h>
>  
> @@ -308,6 +309,42 @@ DT_DEVICE_START(pl011, "PL011 UART", DEVICE_SERIAL)
>          .init = dt_pl011_uart_init,
>  DT_DEVICE_END
>  
> +#ifdef CONFIG_ACPI
> +static int __init acpi_pl011_uart_init(const void *data)
> +{
> +    acpi_status status;
> +    struct acpi_table_spcr *spcr=NULL;

coding style


> +    int res;
> +
> +    status = acpi_get_table(ACPI_SIG_SPCR, 0,
> +                            (struct acpi_table_header **)&spcr);
> +
> +    if ( ACPI_FAILURE(status) )
> +    {
> +        printk("pl011: Failed to get SPCR table\n");
> +        return -EINVAL;
> +    }
> +
> +    /* trigger/polarity information is not available in spcr */
> +    irq_set_type(spcr->interrupt, ACPI_IRQ_TYPE_EDGE_BOTH);
> +
> +    res = pl011_uart_init(spcr->interrupt, spcr->serial_port.address,
> +                          PAGE_SIZE);
> +    if ( res < 0 )
> +    {
> +        printk("pl011: Unable to initialize\n");
> +        return res;
> +    }
> +
> +    return 0;
> +}
> +
> +ACPI_DEVICE_START(apl011, "PL011 UART", DEVICE_SERIAL)
> +        .class_type = ACPI_SPCR_TYPE_PL011,
> +        .init = acpi_pl011_uart_init,
> +ACPI_DEVICE_END
> +#endif
> +
>  /*
>   * Local variables:
>   * mode: C
> diff --git a/xen/include/acpi/actbl2.h b/xen/include/acpi/actbl2.h
> index 87bc6b3..25be429 100644
> --- a/xen/include/acpi/actbl2.h
> +++ b/xen/include/acpi/actbl2.h
> @@ -815,6 +815,11 @@ struct acpi_table_spcr {
>  
>  #define ACPI_SPCR_DO_NOT_DISABLE    (1)
>  
> +/* UART Interface type */
> +#define ACPI_SPCR_TYPE_16550 0
> +#define ACPI_SPCR_TYPE_16550_SUB 1
> +#define ACPI_SPCR_TYPE_PL011 3

Since you are at it, please also add the other fields as specified in
the DBG2.



>  /*******************************************************************************
>   *
>   * SPMI - Server Platform Management Interface table
> -- 
> 2.1.0
> 
