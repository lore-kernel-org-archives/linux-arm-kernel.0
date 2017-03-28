From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 28 Mar 2017 21:16:02 +0200
Subject: [PATCH v2, 3/3] tty/serial: meson_uart: add the core clock
 handling to the driver
In-Reply-To: <20170328092545.4644-4-hgkr.klein@gmail.com>
References: <20170328092545.4644-1-hgkr.klein@gmail.com>
 <20170328092545.4644-4-hgkr.klein@gmail.com>
Message-ID: <1490728562.20764.9.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-03-28 at 11:25 +0200, Helmut Klein wrote:
> This patch gets the core clock as provided by the DT and enables it.
> The code was taken from Amlogic's serial driver, and was tested on my
> board.
> 
> Signed-off-by: Helmut Klein <hgkr.klein@gmail.com>
> ---
> ?drivers/tty/serial/meson_uart.c | 10 ++++++++++
> ?1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 60f16795d16b..cb99112288eb 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -600,6 +600,7 @@ static int meson_uart_probe(struct platform_device *pdev)
> ?	struct resource *res_mem, *res_irq;
> ?	struct uart_port *port;
> ?	struct clk *clk;
> +	struct clk *core_clk;
> ?	int ret = 0;
> 
> ?	if (pdev->dev.of_node)
> @@ -625,6 +626,15 @@ static int meson_uart_probe(struct platform_device *pdev)
> ?	if (!port)
> ?		return -ENOMEM;
> 
> +	core_clk = devm_clk_get(&pdev->dev, "core");
> +	if (!IS_ERR(core_clk)) {
> +		ret = clk_prepare_enable(core_clk);
> +		if (ret) {
> +			dev_err(&pdev->dev, "couldn't enable clkc\n");
> +			return ret;
> +		}
> +	}
> +
> ?	clk = clk_get(&pdev->dev, NULL);
Now that you have 2 clocks, shouldn't this be named as well ?

> ?	if (IS_ERR(clk))
> ?		return PTR_ERR(clk);
> --
> 2.11.0
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
