From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 1 Jul 2013 08:17:22 +0200
Subject: [PATCH v10] i2c: exynos5: add High Speed I2C controller driver
In-Reply-To: <1371638905-30633-1-git-send-email-ch.naveen@samsung.com>
References: <1354021236-28596-2-git-send-email-ch.naveen@samsung.com>
 <1371638905-30633-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <20130701061722.GB2976@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 04:18:25PM +0530, Naveen Krishna Chatradhi wrote:
> Adds support for High Speed I2C driver found in Exynos5 and
> later SoCs from Samsung.
> 
> Driver only supports Device Tree method.
> 
> Changes since v1:
> 1. Added FIFO functionality
> 2. Added High speed mode functionality
> 3. Remove SMBUS_QUICK
> 4. Remove the debugfs functionality
> 5. Use devm_* functions where ever possible
> 6. Driver is free from GPIO configs
> 7. Use OF data string "clock-frequency" to get the bus operating frequencies
> 8. Split the clock divisor calculation function
> 9. Add resets for the failed transacton cases
> 10. Removed retries as core does retries if -EAGAIN is returned
> 11. Removed mode from device tree info (use speed to distinguish
>     the mode of operation)
> 12. Use wait_for_completion_timeout as the interruptible case is not tested well
> 13. few other bug fixes and cosmetic changes
> 
> Signed-off-by: Taekgyun Ko <taeggyun.ko@samsung.com>
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> Reviewed-by: Simon Glass <sjg@google.com>
> Tested-by: Andrew Bresticker <abrestic@google.com>
> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> Signed-off-by: Andrew Bresticker <abrestic@google.com>
> ---
> 
> +Optional properties:
> +  - clock-frequency: Desired operating frequency in Hz of the bus.
> +    -> If not specified, the default value is 100khz in fast-speed mode and
> +       1Mhz in high-speed mode.

? If not specified, the default is 100kHz. There is no way to get 1MHz,
or?

...

> +static int exynos5_i2c_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct exynos5_i2c *i2c;
> +	struct resource *mem;
> +	unsigned int op_clock;

My compiler says:

drivers/i2c/busses/i2c-exynos5.c: In function ?exynos5_i2c_probe?:
drivers/i2c/busses/i2c-exynos5.c:687:5: warning: ?op_clock? may be used uninitialized in this function [-Wuninitialized]

so...

> +	int ret;
> +
> +	if (!np) {
> +		dev_err(&pdev->dev, "no device node\n");
> +		return -ENOENT;
> +	}
> +
> +	i2c = devm_kzalloc(&pdev->dev, sizeof(struct exynos5_i2c), GFP_KERNEL);
> +	if (!i2c) {
> +		dev_err(&pdev->dev, "no memory for state\n");
> +		return -ENOMEM;
> +	}
> +
> +	if (of_property_read_u32(np, "clock-frequency", &op_clock)) {
> +		i2c->speed_mode = HSI2C_FAST_SPD;
> +		i2c->fs_clock = HSI2C_FS_TX_CLOCK;
> +	}
> +
> +	if (op_clock >= HSI2C_HS_TX_CLOCK) {

... this should be 'else if'

> +		i2c->speed_mode = HSI2C_HIGH_SPD;
> +		i2c->fs_clock = HSI2C_FS_TX_CLOCK;
> +		i2c->hs_clock = op_clock;
> +	} else {
> +		i2c->speed_mode = HSI2C_FAST_SPD;
> +		i2c->fs_clock = op_clock;
> +	}

...

> +	i2c->bus_id = of_alias_get_id(i2c->adap.dev.of_node, "hsi2c");

Huh, the core already gets an alias for you. Can't you use 'adap.nr'?

Rest looks good.

Thanks!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130701/5b228867/attachment.sig>
