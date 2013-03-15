From: heikki.krogerus@linux.intel.com (Heikki Krogerus)
Date: Fri, 15 Mar 2013 14:56:15 +0200
Subject: [PATCH 1/6] serial: 8250_dw: add support for clocks property
 when using DeviceTree
In-Reply-To: <1362694460-1919-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1362694460-1919-1-git-send-email-maxime.ripard@free-electrons.com>
 <1362694460-1919-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130315125615.GA27560@xps8300>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 07, 2013 at 11:14:15PM +0100, Maxime Ripard wrote:
> From: Emilio L?pez <emilio@elopez.com.ar>
> 
> This commit implements support for using the "clocks" DT property, instead
> of having to use clock-frequency.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> ---
>  drivers/tty/serial/8250/8250_dw.c |   32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)

<snip>

> @@ -137,8 +140,15 @@ static int dw8250_probe_of(struct uart_port *p)
>  		p->regshift = val;
>  
>  	if (of_property_read_u32(np, "clock-frequency", &val)) {
> -		dev_err(p->dev, "no clock-frequency property set\n");
> -		return -EINVAL;
> +		/* Get clk rate through clk driver if present */
> +		data->clk = clk_get(p->dev, NULL);
> +		if (IS_ERR(data->clk)) {
> +			dev_err(p->dev, "clk or clock-frequency not defined\n");
> +			return -EINVAL;
> +		}
> +
> +		clk_prepare_enable(data->clk);
> +		val = clk_get_rate(data->clk);

Don't get the clk here..

>  	}
>  	p->uartclk = val;
>  
> @@ -300,6 +310,12 @@ static int dw8250_probe(struct platform_device *pdev)

Get it here so it is then handled for also others besides DT users.
And prefer devm_clk_get(). Something like this:

        ...
        uart.port.membase = ioremap(regs->start, resource_size(regs));
        if (!uart.port.membase)
                return -ENOMEM;

+       data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+       if (!data)
+       	return -ENOMEM;
+        
+       data->clk = devm_clk_get(&pdev->dev, NULL);
+       clk_prepare_enable(data->clk);
+
        uart.port.iotype = UPIO_MEM;
        uart.port.serial_in = dw8250_serial_in;
        uart.port.serial_out = dw8250_serial_out;
+       uart.port.private_data = data;
+       uart.port.uartclk = clk_get_rate(data->clk);

  	dw8250_setup_port(&uart);
        ... 

Then in dw8250_probe_of() you need to use the "clock-frequency"
property only when p->uartclk is 0.

Thanks,

-- 
heikki
