From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 02 Jul 2014 11:32:25 +0200
Subject: [PATCH] serial: 8250_dw: add ability to handle the peripheral
 clock
In-Reply-To: <3755576.qE86Ikox0a@diego>
References: <3755576.qE86Ikox0a@diego>
Message-ID: <1678206.c13HhIevJ5@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 16. Juni 2014, 15:25:17 schrieb Heiko St?bner:
> First try to find the named clock variants then fall back to the already
> existing handling of a nameless declared baudclk.
> 
> This also adds the missing documentation for this already existing variant.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

any comments?


Thanks
Heiko


> ---
>  .../bindings/serial/snps-dw-apb-uart.txt           | 31
> ++++++++++++++++++++++ drivers/tty/serial/8250/8250_dw.c                  |
> 31 +++++++++++++++++++--- 2 files changed, 59 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt
> b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt index
> f13f1c5..3601399 100644
> --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt
> +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt
> @@ -4,7 +4,15 @@ Required properties:
>  - compatible : "snps,dw-apb-uart"
>  - reg : offset and length of the register set for the device.
>  - interrupts : should contain uart interrupt.
> +
> +Clock handling:
> +The clock rate of the input clock needs to be supplied by one of
>  - clock-frequency : the input clock frequency for the UART.
> +- clocks : phandle to the input clock
> +
> +The supplying peripheral clock can also be handled, needing a second
> property +- clock-names: tuple listing input clock names.
> +	Required elements: "baudclk", "apb_pclk"
> 
>  Optional properties:
>  - reg-shift : quantity to shift the register offsets by.  If this property
> is @@ -23,3 +31,26 @@ Example:
>  		reg-shift = <2>;
>  		reg-io-width = <4>;
>  	};
> +
> +Example with one clock:
> +
> +	uart at 80230000 {
> +		compatible = "snps,dw-apb-uart";
> +		reg = <0x80230000 0x100>;
> +		clocks = <&baudclk>;
> +		interrupts = <10>;
> +		reg-shift = <2>;
> +		reg-io-width = <4>;
> +	};
> +
> +Example with two clocks:
> +
> +	uart at 80230000 {
> +		compatible = "snps,dw-apb-uart";
> +		reg = <0x80230000 0x100>;
> +		clocks = <&baudclk>, <&apb_pclk>;
> +		clock-names = "baudclk", "apb_pclk";
> +		interrupts = <10>;
> +		reg-shift = <2>;
> +		reg-io-width = <4>;
> +	};
> diff --git a/drivers/tty/serial/8250/8250_dw.c
> b/drivers/tty/serial/8250/8250_dw.c index 51b307a..024cd58 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -59,6 +59,7 @@ struct dw8250_data {
>  	int			last_mcr;
>  	int			line;
>  	struct clk		*clk;
> +	struct clk		*pclk;
>  	struct uart_8250_dma	dma;
>  };
> 
> @@ -402,10 +403,25 @@ static int dw8250_probe(struct platform_device *pdev)
>  		return -ENOMEM;
> 
>  	data->usr_reg = DW_UART_USR;
> -	data->clk = devm_clk_get(&pdev->dev, NULL);
> +	data->clk = devm_clk_get(&pdev->dev, "baudclk");
> +	if (IS_ERR(data->clk))
> +		data->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (!IS_ERR(data->clk)) {
> -		clk_prepare_enable(data->clk);
> -		uart.port.uartclk = clk_get_rate(data->clk);
> +		err = clk_prepare_enable(data->clk);
> +		if (err)
> +			dev_warn(&pdev->dev, "could not enable optional baudclk: %d\n",
> +				 err);
> +		else
> +			uart.port.uartclk = clk_get_rate(data->clk);
> +	}
> +
> +	data->pclk = devm_clk_get(&pdev->dev, "apb_pclk");
> +	if (!IS_ERR(data->pclk)) {
> +		err = clk_prepare_enable(data->pclk);
> +		if (err) {
> +			dev_err(&pdev->dev, "could not enable apb_pclk\n");
> +			return err;
> +		}
>  	}
> 
>  	data->dma.rx_chan_id = -1;
> @@ -451,6 +467,9 @@ static int dw8250_remove(struct platform_device *pdev)
> 
>  	serial8250_unregister_port(data->line);
> 
> +	if (!IS_ERR(data->pclk))
> +		clk_disable_unprepare(data->pclk);
> +
>  	if (!IS_ERR(data->clk))
>  		clk_disable_unprepare(data->clk);
> 
> @@ -488,6 +507,9 @@ static int dw8250_runtime_suspend(struct device *dev)
>  	if (!IS_ERR(data->clk))
>  		clk_disable_unprepare(data->clk);
> 
> +	if (!IS_ERR(data->pclk))
> +		clk_disable_unprepare(data->pclk);
> +
>  	return 0;
>  }
> 
> @@ -495,6 +517,9 @@ static int dw8250_runtime_resume(struct device *dev)
>  {
>  	struct dw8250_data *data = dev_get_drvdata(dev);
> 
> +	if (!IS_ERR(data->pclk))
> +		clk_prepare_enable(data->pclk);
> +
>  	if (!IS_ERR(data->clk))
>  		clk_prepare_enable(data->clk);
