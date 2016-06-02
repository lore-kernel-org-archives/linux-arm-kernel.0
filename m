From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 2 Jun 2016 18:35:34 +0200
Subject: [PATCH] i2c: bcm2835: Set up the clock stretching timeout at boot.
In-Reply-To: <1464818845-5348-1-git-send-email-eric@anholt.net>
References: <1464818845-5348-1-git-send-email-eric@anholt.net>
Message-ID: <30fcc305-971d-4a1c-18c1-08c28585e260@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

Am 02.06.2016 um 00:07 schrieb Eric Anholt:
> The register at poweron contains 0x40, which at our typical 100khz bus
> rate means .64ms instead of the desired 25ms.
>
> Fixes many clock stretching timeouts when talking to the DSI panel's
> bridge chip, and will hopefully fix talking to the FXL6408 GPIO
> expander on the Pi3 as well.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/i2c/busses/i2c-bcm2835.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
> index 818b051d25e6..1348f224013d 100644
> --- a/drivers/i2c/busses/i2c-bcm2835.c
> +++ b/drivers/i2c/busses/i2c-bcm2835.c
> @@ -28,6 +28,11 @@
>  #define BCM2835_I2C_FIFO	0x10
>  #define BCM2835_I2C_DIV		0x14
>  #define BCM2835_I2C_DEL		0x18
> +/*
> + * 16-bit field for the number of SCL cycles to wait after rising SCL
> + * before deciding the slave is not responding.  0 disables the
> + * timeout detection.
> + */
>  #define BCM2835_I2C_CLKT	0x1c
>  
>  #define BCM2835_I2C_C_READ	BIT(0)
> @@ -238,6 +243,7 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
>  	u32 bus_clk_rate, divider;
>  	int ret;
>  	struct i2c_adapter *adap;
> +	u32 clkt;
>  
>  	i2c_dev = devm_kzalloc(&pdev->dev, sizeof(*i2c_dev), GFP_KERNEL);
>  	if (!i2c_dev)
> @@ -280,6 +286,15 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
>  	}
>  	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DIV, divider);
>  
> +	/*
> +	 * SMBUS says "Devices participating in a transfer will
> +	 * timeout when any clock low exceeds the value of
> +	 * T_TIMEOUT,MIN of 25 ms."
> +	 */
> +	clkt = DIV_ROUND_UP(25 * bus_clk_rate, 1000);
> +	clkt = min(clkt, 0xffffu);
> +	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_CLKT, clkt);
> +

could we really assume that the clk rate never change after driver probing?

This also affects Gerd's patch [PATCH 28/32] i2c: bcm2835: Set up the
rising/falling edge delays.

Stefan

>  	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>  	if (!irq) {
>  		dev_err(&pdev->dev, "No IRQ resource\n");
