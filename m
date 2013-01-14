From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Jan 2013 09:20:07 +0000
Subject: [PATCH 3/4] serial: vt8500: UART uses gated clock rather than
 24Mhz reference
In-Reply-To: <1358129060-9399-4-git-send-email-linux@prisktech.co.nz>
References: <1358129060-9399-1-git-send-email-linux@prisktech.co.nz>
 <1358129060-9399-4-git-send-email-linux@prisktech.co.nz>
Message-ID: <20130114092007.GW23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 03:04:18PM +1300, Tony Prisk wrote:
> -	if (vt8500_port->clk) {
> -		vt8500_port->uart.uartclk = clk_get_rate(vt8500_port->clk);
> -	} else {
> -		/* use the default of 24Mhz if not specified and warn */
> -		pr_warn("%s: serial clock source not specified\n", __func__);
> -		vt8500_port->uart.uartclk = 24000000;
> +	if (IS_ERR(vt8500_port->clk)) {
> +		dev_err(&pdev->dev, "failed to get clock\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	ret = clk_prepare_enable(vt8500_port->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to enable clock\n");
> +		goto err;

Looks like you get rid of the initialization of vt8500_port->uart.uartclk
here.  Was that intentional?
