From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 26 Nov 2015 15:22:32 +0000
Subject: [PATCH v3 34/62] pl011: Refactor pl011 driver to dt and common
 initialization parts
In-Reply-To: <1447753261-7552-35-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-35-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511261522250.8984@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Refactor pl011 driver to dt and common initialization parts. This will
> be useful later when acpi specific uart initialization function is
> introduced.
> 
> Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>

Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>


>  xen/drivers/char/pl011.c | 64 ++++++++++++++++++++++++++++--------------------
>  1 file changed, 38 insertions(+), 26 deletions(-)
> 
> diff --git a/xen/drivers/char/pl011.c b/xen/drivers/char/pl011.c
> index 67e6df5..16abaa5 100644
> --- a/xen/drivers/char/pl011.c
> +++ b/xen/drivers/char/pl011.c
> @@ -226,12 +226,42 @@ static struct uart_driver __read_mostly pl011_driver = {
>      .vuart_info   = pl011_vuart,
>  };
>  
> +static int __init pl011_uart_init(int irq, u64 addr, u64 size)
> +{
> +    struct pl011 *uart;
> +
> +    uart = &pl011_com;
> +    uart->irq       = irq;
> +    uart->clock_hz  = 0x16e3600;
> +    uart->baud      = BAUD_AUTO;
> +    uart->data_bits = 8;
> +    uart->parity    = PARITY_NONE;
> +    uart->stop_bits = 1;
> +
> +    uart->regs = ioremap_nocache(addr, size);
> +    if ( !uart->regs )
> +    {
> +        printk("pl011: Unable to map the UART memory\n");
> +        return -ENOMEM;
> +    }
> +
> +    uart->vuart.base_addr = addr;
> +    uart->vuart.size = size;
> +    uart->vuart.data_off = DR;
> +    uart->vuart.status_off = FR;
> +    uart->vuart.status = 0;
> +
> +    /* Register with generic serial driver. */
> +    serial_register_uart(SERHND_DTUART, &pl011_driver, uart);
> +
> +    return 0;
> +}
> +
>  /* TODO: Parse UART config from the command line */
> -static int __init pl011_uart_init(struct dt_device_node *dev,
> -                                  const void *data)
> +static int __init dt_pl011_uart_init(struct dt_device_node *dev,
> +                                     const void *data)
>  {
>      const char *config = data;
> -    struct pl011 *uart;
>      int res;
>      u64 addr, size;
>  
> @@ -240,14 +270,6 @@ static int __init pl011_uart_init(struct dt_device_node *dev,
>          printk("WARNING: UART configuration is not supported\n");
>      }
>  
> -    uart = &pl011_com;
> -
> -    uart->clock_hz  = 0x16e3600;
> -    uart->baud      = BAUD_AUTO;
> -    uart->data_bits = 8;
> -    uart->parity    = PARITY_NONE;
> -    uart->stop_bits = 1;
> -
>      res = dt_device_get_address(dev, 0, &addr, &size);
>      if ( res )
>      {
> @@ -262,24 +284,14 @@ static int __init pl011_uart_init(struct dt_device_node *dev,
>          printk("pl011: Unable to retrieve the IRQ\n");
>          return -EINVAL;
>      }
> -    uart->irq = res;
>  
> -    uart->regs = ioremap_nocache(addr, size);
> -    if ( !uart->regs )
> +    res = pl011_uart_init(res, addr, size);
> +    if ( res < 0 )
>      {
> -        printk("pl011: Unable to map the UART memory\n");
> -        return -ENOMEM;
> +        printk("pl011: Unable to initialize\n");
> +        return res;
>      }
>  
> -    uart->vuart.base_addr = addr;
> -    uart->vuart.size = size;
> -    uart->vuart.data_off = DR;
> -    uart->vuart.status_off = FR;
> -    uart->vuart.status = 0;
> -
> -    /* Register with generic serial driver. */
> -    serial_register_uart(SERHND_DTUART, &pl011_driver, uart);
> -
>      dt_device_set_used_by(dev, DOMID_XEN);
>  
>      return 0;
> @@ -293,7 +305,7 @@ static const struct dt_device_match pl011_dt_match[] __initconst =
>  
>  DT_DEVICE_START(pl011, "PL011 UART", DEVICE_SERIAL)
>          .dt_match = pl011_dt_match,
> -        .init = pl011_uart_init,
> +        .init = dt_pl011_uart_init,
>  DT_DEVICE_END
>  
>  /*
> -- 
> 2.1.0
> 
