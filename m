From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 26 Nov 2015 15:32:03 +0000
Subject: [Xen-devel] [PATCH v3 35/62] serial: Rename SERHND_DTUART to
 SERHND_UART
In-Reply-To: <1447753261-7552-36-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-36-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511261531280.8984@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Rename SERHND_DTUART to SERHND_UART in order to reuse it when booting
> with ACPI.

But actually I fail to see where is it being used with ACPI.


> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  xen/arch/arm/vuart.c               | 2 +-
>  xen/drivers/char/cadence-uart.c    | 2 +-
>  xen/drivers/char/exynos4210-uart.c | 2 +-
>  xen/drivers/char/omap-uart.c       | 2 +-
>  xen/drivers/char/pl011.c           | 2 +-
>  xen/drivers/char/scif-uart.c       | 2 +-
>  xen/drivers/char/serial.c          | 2 +-
>  xen/include/xen/serial.h           | 2 +-
>  8 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/xen/arch/arm/vuart.c b/xen/arch/arm/vuart.c
> index b5c9288..6619b33 100644
> --- a/xen/arch/arm/vuart.c
> +++ b/xen/arch/arm/vuart.c
> @@ -59,7 +59,7 @@ int domain_vuart_init(struct domain *d)
>  {
>      ASSERT( is_hardware_domain(d) );
>  
> -    d->arch.vuart.info = serial_vuart_info(SERHND_DTUART);
> +    d->arch.vuart.info = serial_vuart_info(SERHND_UART);
>      if ( !d->arch.vuart.info )
>          return 0;
>  
> diff --git a/xen/drivers/char/cadence-uart.c b/xen/drivers/char/cadence-uart.c
> index 933672f..ed65004 100644
> --- a/xen/drivers/char/cadence-uart.c
> +++ b/xen/drivers/char/cadence-uart.c
> @@ -196,7 +196,7 @@ static int __init cuart_init(struct dt_device_node *dev, const void *data)
>      uart->vuart.status = UART_SR_INTR_TEMPTY;
>  
>      /* Register with generic serial driver. */
> -    serial_register_uart(SERHND_DTUART, &cuart_driver, uart);
> +    serial_register_uart(SERHND_UART, &cuart_driver, uart);
>  
>      dt_device_set_used_by(dev, DOMID_XEN);
>  
> diff --git a/xen/drivers/char/exynos4210-uart.c b/xen/drivers/char/exynos4210-uart.c
> index bac1c2b..43f5313 100644
> --- a/xen/drivers/char/exynos4210-uart.c
> +++ b/xen/drivers/char/exynos4210-uart.c
> @@ -345,7 +345,7 @@ static int __init exynos4210_uart_init(struct dt_device_node *dev,
>      uart->vuart.status = UTRSTAT_TXE | UTRSTAT_TXFE;
>  
>      /* Register with generic serial driver. */
> -    serial_register_uart(SERHND_DTUART, &exynos4210_uart_driver, uart);
> +    serial_register_uart(SERHND_UART, &exynos4210_uart_driver, uart);
>  
>      dt_device_set_used_by(dev, DOMID_XEN);
>  
> diff --git a/xen/drivers/char/omap-uart.c b/xen/drivers/char/omap-uart.c
> index d8f64ea..98c3892 100644
> --- a/xen/drivers/char/omap-uart.c
> +++ b/xen/drivers/char/omap-uart.c
> @@ -343,7 +343,7 @@ static int __init omap_uart_init(struct dt_device_node *dev,
>      uart->vuart.status = UART_LSR_THRE;
>  
>      /* Register with generic serial driver */
> -    serial_register_uart(SERHND_DTUART, &omap_uart_driver, uart);
> +    serial_register_uart(SERHND_UART, &omap_uart_driver, uart);
>  
>      dt_device_set_used_by(dev, DOMID_XEN);
>  
> diff --git a/xen/drivers/char/pl011.c b/xen/drivers/char/pl011.c
> index 16abaa5..1efb1cf 100644
> --- a/xen/drivers/char/pl011.c
> +++ b/xen/drivers/char/pl011.c
> @@ -252,7 +252,7 @@ static int __init pl011_uart_init(int irq, u64 addr, u64 size)
>      uart->vuart.status = 0;
>  
>      /* Register with generic serial driver. */
> -    serial_register_uart(SERHND_DTUART, &pl011_driver, uart);
> +    serial_register_uart(SERHND_UART, &pl011_driver, uart);
>  
>      return 0;
>  }
> diff --git a/xen/drivers/char/scif-uart.c b/xen/drivers/char/scif-uart.c
> index 51a2233..739317c 100644
> --- a/xen/drivers/char/scif-uart.c
> +++ b/xen/drivers/char/scif-uart.c
> @@ -339,7 +339,7 @@ static int __init scif_uart_init(struct dt_device_node *dev,
>      uart->vuart.status     = SCFSR_TDFE;
>  
>      /* Register with generic serial driver */
> -    serial_register_uart(SERHND_DTUART, &scif_uart_driver, uart);
> +    serial_register_uart(SERHND_UART, &scif_uart_driver, uart);
>  
>      dt_device_set_used_by(dev, DOMID_XEN);
>  
> diff --git a/xen/drivers/char/serial.c b/xen/drivers/char/serial.c
> index c583a48..659e10d 100644
> --- a/xen/drivers/char/serial.c
> +++ b/xen/drivers/char/serial.c
> @@ -312,7 +312,7 @@ int __init serial_parse_handle(char *conf)
>  
>      if ( !strncmp(conf, "dtuart", 5) )
>      {
> -        handle = SERHND_DTUART;
> +        handle = SERHND_UART;
>          goto common;
>      }
>  
> diff --git a/xen/include/xen/serial.h b/xen/include/xen/serial.h
> index 5e1a536..a6e7c22 100644
> --- a/xen/include/xen/serial.h
> +++ b/xen/include/xen/serial.h
> @@ -94,7 +94,7 @@ struct uart_driver {
>  # define SERHND_COM1    (0<<0)
>  # define SERHND_COM2    (1<<0)
>  # define SERHND_DBGP    (2<<0)
> -# define SERHND_DTUART  (0<<0) /* Steal SERHND_COM1 value */
> +# define SERHND_UART    (0<<0) /* Steal SERHND_COM1 value */
>  #define SERHND_HI       (1<<2) /* Mux/demux each transferred char by MSB. */
>  #define SERHND_LO       (1<<3) /* Ditto, except that the MSB is cleared.  */
>  #define SERHND_COOKED   (1<<4) /* Newline/carriage-return translation?    */
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel at lists.xen.org
> http://lists.xen.org/xen-devel
> 
