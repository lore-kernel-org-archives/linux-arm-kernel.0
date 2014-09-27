From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 27 Sep 2014 11:07:38 +0100
Subject: [PATCH 2/4] serial: mxs-auart: use mctrl_gpio helpers for
 handling modem signals
In-Reply-To: <1411811197-12638-3-git-send-email-j.uzycki@elproma.com.pl>
References: <1411811197-12638-1-git-send-email-j.uzycki@elproma.com.pl>
 <1411811197-12638-3-git-send-email-j.uzycki@elproma.com.pl>
Message-ID: <20140927100737.GC5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 27, 2014 at 11:46:35AM +0200, Janusz Uzycki wrote:
> @@ -635,7 +645,12 @@ static void mxs_auart_settermios(struct uart_port *u,
>  		ctrl |= AUART_LINECTRL_STP2;
>  
>  	/* figure out the hardware flow control settings */
> -	if (cflag & CRTSCTS) {
> +	/* FIXME: Likely DMA could be enabled not only for HW flow control */
> +	if (cflag & CRTSCTS &&
> +			(IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(s->gpios,
> +					 UART_GPIO_RTS)) ||
> +			 IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(s->gpios,
> +					 UART_GPIO_CTS)))) {

There has to be a better way to do this.

> +static int mxs_auart_init_gpios(struct mxs_auart_port *s, struct device *dev)
> +{
> +	s->gpios = mctrl_gpio_init(dev, 0);
> +	if (IS_ERR_OR_NULL(s->gpios))
> +		return -1;
> +	return 0;

I personally hate the practise of returning -1 - it ends up getting returned
to userspace as an error code, and it means EPERM.  If you want to indicate
success/failure, use the bool return type, and return true/false.

> @@ -1074,6 +1100,11 @@ static int mxs_auart_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, s);
>  
> +	ret = mxs_auart_init_gpios(s, &pdev->dev);
> +	if (ret < 0)
> +		dev_err(&pdev->dev, "%s",
> +			"Failed to initialize GPIOs. The serial port may not work as expected");

Does the "%s" do anything for this message?  More importantly though, it's
lacking a newline.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
