From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 27 Jun 2016 13:23:45 +0100
Subject: [PATCH v2 3/8] mfd: tps65218: Use mfd_add_devices instead of
 of_platform_populate
In-Reply-To: <1467025305-13464-4-git-send-email-j-keerthy@ti.com>
References: <1467025305-13464-1-git-send-email-j-keerthy@ti.com>
 <1467025305-13464-4-git-send-email-j-keerthy@ti.com>
Message-ID: <20160627122345.GC24377@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 Jun 2016, Keerthy wrote:

> mfd_add_devices enables parsing device tree nodes without compatibles
> for child nodes. Replace of_platform_populate with mfd_add_devices.
> mfd_cell currently is populated with only regulators.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> Changes in v2:
> 
>   * Updated commit log.
> 
> As of now only regulators driver is in kernel. The PMIC contains
> a bunch of GPIOs, Over temperature warning / shutdown unit.
> 
>  drivers/mfd/tps65218.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
> index f20a531..b8b3a58 100644
> --- a/drivers/mfd/tps65218.c
> +++ b/drivers/mfd/tps65218.c
> @@ -33,6 +33,10 @@
>  
>  #define TPS65218_PASSWORD_REGS_UNLOCK   0x7D
>  
> +static const struct mfd_cell tps65218_cells[] = {
> +	{ .name = "tps65218-regulator", },
> +};
> +
>  /**
>   * tps65218_reg_write: Write a single tps65218 register.
>   *
> @@ -236,8 +240,10 @@ static int tps65218_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = of_platform_populate(client->dev.of_node, NULL, NULL,
> -				   &client->dev);
> +	ret = mfd_add_devices(tps->dev, PLATFORM_DEVID_AUTO, tps65218_cells,
> +			      ARRAY_SIZE(tps65218_cells), NULL, 0,
> +			      regmap_irq_get_domain(tps->irq_data));
> +
>  	if (ret < 0)
>  		goto err_irq;
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
