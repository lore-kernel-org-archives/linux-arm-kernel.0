From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 11 Dec 2011 14:01:35 +0800
Subject: [PATCH v4] tty: serial: imx: Allow UART to be a source for wakeup
In-Reply-To: <1323456065-6240-1-git-send-email-festevam@gmail.com>
References: <1323434541-27689-1-git-send-email-festevam@gmail.com>
 <1323456065-6240-1-git-send-email-festevam@gmail.com>
Message-ID: <20111211060133.GA9470@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2011 at 04:41:05PM -0200, Fabio Estevam wrote:
> Allow UART to be a source for wakeup from low power mode.
> 
> Tested on a MX27PDK by doing:
> 
> echo enabled > /sys/devices/platform/imx21-uart.0/power/wakeup
> 
> echo mem > /sys/power/state
> 
> and then pressing a key in the console will wakeup the sytem.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v3:
> - Remove IMXUART_CANWAKE flag. Let userspace write in /sys/ file
> in order to enable UART wakeup source.
> Changes since v2:
> - Remove incorrect enable_irq_wake from serial_imx_resume
> Changes since v1:
> - Pass the can-wake property via DT correctly
>  drivers/tty/serial/imx.c |   24 ++++++++++++++++++++++++
>  1 files changed, 24 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 163fc90..283bf21 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -566,6 +566,9 @@ static irqreturn_t imx_int(int irq, void *dev_id)
>  	if (sts & USR1_RTSD)
>  		imx_rtsint(irq, dev_id);
>  
> +	if (sts & USR1_AWAKE)
> +		writel(USR1_AWAKE, sport->port.membase + USR1);
> +
>  	return IRQ_HANDLED;
>  }
>  
> @@ -1269,6 +1272,15 @@ static struct uart_driver imx_reg = {
>  static int serial_imx_suspend(struct platform_device *dev, pm_message_t state)
>  {
>  	struct imx_port *sport = platform_get_drvdata(dev);
> +	unsigned int val;
> +
> +	if (device_may_wakeup(&dev->dev)) {
> +		enable_irq_wake(sport->rxirq);
> +		/* enable wakeup from i.MX UART */
> +		val = readl(sport->port.membase + UCR3);
> +		val |= UCR3_AWAKEN;
> +		writel(val, sport->port.membase + UCR3);
> +	}
>  
>  	if (sport)
>  		uart_suspend_port(&imx_reg, &sport->port);
> @@ -1279,6 +1291,15 @@ static int serial_imx_suspend(struct platform_device *dev, pm_message_t state)
>  static int serial_imx_resume(struct platform_device *dev)
>  {
>  	struct imx_port *sport = platform_get_drvdata(dev);
> +	unsigned int val;
> +
> +	if (device_may_wakeup(&dev->dev)) {
> +		/* disable wakeup from i.MX UART */
> +		val = readl(sport->port.membase + UCR3);
> +		val &= ~UCR3_AWAKEN;
> +		writel(val, sport->port.membase + UCR3);
> +		disable_irq_wake(sport->rxirq);
> +	}
>  
>  	if (sport)
>  		uart_resume_port(&imx_reg, &sport->port);
> @@ -1408,6 +1429,9 @@ static int serial_imx_probe(struct platform_device *pdev)
>  		goto deinit;
>  	platform_set_drvdata(pdev, &sport->port);
>  
> +	device_init_wakeup(&pdev->dev, 1);
> +	device_set_wakeup_enable(&pdev->dev, 0);
> +
Rather than calling these two functions, simply calling 

	device_set_wakeup_capable(&pdev->dev, true);

can just do what we want to do here.

Other than that,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

(Tested on i.MX6Q ARM2 board)

-- 
Regards,
Shawn
