From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 31 Mar 2016 19:41:48 +0800
Subject: [PATCH 10/18] tty: serial: fsl_lpuart: support suspend/resume
In-Reply-To: <1457576219-7971-11-git-send-email-stefan@agner.ch>
References: <1457576219-7971-1-git-send-email-stefan@agner.ch>
 <1457576219-7971-11-git-send-email-stefan@agner.ch>
Message-ID: <20160331114148.GC18833@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2016 at 06:16:51PM -0800, Stefan Agner wrote:
> In order to allow wake support in STOP sleep mode, clocks are
> needed. Use imx_clk_gate2_cgr to disable automatic clock gating
> in low power mode STOP. This allows to enable wake by UART using:
> echo enabled > /sys/class/tty/ttyLP0/power/wakeup
> 
> However, if wake is not enabled, the driver should disable the
> clocks explicitly to save power.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/clk/imx/clk-vf610.c     | 12 ++++++------

It should go to a separate patch.

Shawn

>  drivers/tty/serial/fsl_lpuart.c | 16 ++++++++++++++--
>  2 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-vf610.c b/drivers/clk/imx/clk-vf610.c
> index e2e2c43..170a96c 100644
> --- a/drivers/clk/imx/clk-vf610.c
> +++ b/drivers/clk/imx/clk-vf610.c
> @@ -315,12 +315,12 @@ static void __init vf610_clocks_init(struct device_node *ccm_node)
>  
>  	clk[VF610_CLK_PIT] = imx_clk_gate2("pit", "ipg_bus", CCM_CCGR1, CCM_CCGRx_CGn(7));
>  
> -	clk[VF610_CLK_UART0] = imx_clk_gate2("uart0", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(7));
> -	clk[VF610_CLK_UART1] = imx_clk_gate2("uart1", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(8));
> -	clk[VF610_CLK_UART2] = imx_clk_gate2("uart2", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(9));
> -	clk[VF610_CLK_UART3] = imx_clk_gate2("uart3", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(10));
> -	clk[VF610_CLK_UART4] = imx_clk_gate2("uart4", "ipg_bus", CCM_CCGR6, CCM_CCGRx_CGn(9));
> -	clk[VF610_CLK_UART5] = imx_clk_gate2("uart5", "ipg_bus", CCM_CCGR6, CCM_CCGRx_CGn(10));
> +	clk[VF610_CLK_UART0] = imx_clk_gate2_cgr("uart0", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(7), 0x2);
> +	clk[VF610_CLK_UART1] = imx_clk_gate2_cgr("uart1", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(8), 0x2);
> +	clk[VF610_CLK_UART2] = imx_clk_gate2_cgr("uart2", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(9), 0x2);
> +	clk[VF610_CLK_UART3] = imx_clk_gate2_cgr("uart3", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(10), 0x2);
> +	clk[VF610_CLK_UART4] = imx_clk_gate2_cgr("uart4", "ipg_bus", CCM_CCGR6, CCM_CCGRx_CGn(9), 0x2);
> +	clk[VF610_CLK_UART5] = imx_clk_gate2_cgr("uart5", "ipg_bus", CCM_CCGR6, CCM_CCGRx_CGn(10), 0x2);
>  
>  	clk[VF610_CLK_I2C0] = imx_clk_gate2("i2c0", "ipg_bus", CCM_CCGR4, CCM_CCGRx_CGn(6));
>  	clk[VF610_CLK_I2C1] = imx_clk_gate2("i2c1", "ipg_bus", CCM_CCGR4, CCM_CCGRx_CGn(7));
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 3d79003..94e29ba 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -483,9 +483,8 @@ static void lpuart_dma_rx_complete(void *arg)
>  	spin_unlock_irqrestore(&sport->port.lock, flags);
>  }
>  
> -static void lpuart_timer_func(unsigned long data)
> +static void lpuart_dma_rx_terminate(struct lpuart_port *sport)
>  {
> -	struct lpuart_port *sport = (struct lpuart_port *)data;
>  	struct tty_port *port = &sport->port.state->port;
>  	struct dma_tx_state state;
>  	unsigned long flags;
> @@ -510,6 +509,11 @@ static void lpuart_timer_func(unsigned long data)
>  	spin_unlock_irqrestore(&sport->port.lock, flags);
>  }
>  
> +static void lpuart_timer_func(unsigned long data)
> +{
> +	lpuart_dma_rx_terminate((struct lpuart_port *)data);
> +}
> +
>  static inline void lpuart_prepare_rx(struct lpuart_port *sport)
>  {
>  	unsigned long flags;
> @@ -1915,7 +1919,12 @@ static int lpuart_suspend(struct device *dev)
>  		writeb(temp, sport->port.membase + UARTCR2);
>  	}
>  
> +	if (sport->dma_rx_in_progress)
> +		lpuart_dma_rx_terminate(sport);
> +
>  	uart_suspend_port(&lpuart_reg, &sport->port);
> +	if (sport->port.suspended && !sport->port.irq_wake)
> +		clk_disable_unprepare(sport->clk);
>  
>  	return 0;
>  }
> @@ -1925,6 +1934,9 @@ static int lpuart_resume(struct device *dev)
>  	struct lpuart_port *sport = dev_get_drvdata(dev);
>  	unsigned long temp;
>  
> +	if (sport->port.suspended && !sport->port.irq_wake)
> +		clk_prepare_enable(sport->clk);
> +
>  	if (sport->lpuart32) {
>  		lpuart32_setup_watermark(sport);
>  		temp = lpuart32_read(sport->port.membase + UARTCTRL);
> -- 
> 2.7.2
> 
> 
