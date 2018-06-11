From: tudor.ambarus@microchip.com (Tudor Ambarus)
Date: Mon, 11 Jun 2018 12:46:23 +0300
Subject: [PATCH 2/9] crypto: atmel-ecc: Silently ignore missing clock
 frequency
In-Reply-To: <20180605134950.6605-2-linus.walleij@linaro.org>
References: <20180605134950.6605-1-linus.walleij@linaro.org>
 <20180605134950.6605-2-linus.walleij@linaro.org>
Message-ID: <e33b8860-2ff4-da8f-8500-ad24ab6c1e4e@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Linus, Wolfram,

On 06/05/2018 04:49 PM, Linus Walleij wrote:
> The Atmel ECC driver contains a check for the I2C bus clock
> frequency, so as to check that the I2C adapter in use
> satisfies the device specs.
> 
> If the device is connected to a device tree node that does not
> contain a clock frequency setting, such as an I2C mux or gate,
> this blocks the probe. Make the probe continue silently if
> no clock frequency can be found, assuming all is safe.

I don't think it's safe. We use bus_clk_rate to compute the ecc508's
wake token. If you can't wake the device, it will ignore all your
commands.

My proposal was to introduce a bus_freq_hz member in the i2c_adapter
structure (https://patchwork.kernel.org/patch/10307637/), but I haven't
received feedback yet, Wolfram?

I would say first to check the bus_freq_hz from adapter (if it will be
accepted) else to look into dt and, in the last case, if nowhere
provided, to block the probe.

Thanks,
ta

> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>   drivers/crypto/atmel-ecc.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/crypto/atmel-ecc.c b/drivers/crypto/atmel-ecc.c
> index e66f18a0ddd0..145ab3a39a56 100644
> --- a/drivers/crypto/atmel-ecc.c
> +++ b/drivers/crypto/atmel-ecc.c
> @@ -657,14 +657,13 @@ static int atmel_ecc_probe(struct i2c_client *client,
>   		return -ENODEV;
>   	}
>   
> +	/*
> +	 * Silently assume all is fine if there is no
> +	 * "clock-frequency" property.
> +	 */
>   	ret = of_property_read_u32(client->adapter->dev.of_node,
>   				   "clock-frequency", &bus_clk_rate);
> -	if (ret) {
> -		dev_err(dev, "of: failed to read clock-frequency property\n");
> -		return ret;
> -	}
> -
> -	if (bus_clk_rate > 1000000L) {
> +	if (!ret && (bus_clk_rate > 1000000L)) {
>   		dev_err(dev, "%d exceeds maximum supported clock frequency (1MHz)\n",
>   			bus_clk_rate);
>   		return -EINVAL;
> 
