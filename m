From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 28 Jun 2016 07:54:43 +0100
Subject: [PATCH v3 04/10] mfd: tps65218: Use mfd_add_devices instead of
 of_platform_populate
In-Reply-To: <1467093980-11458-5-git-send-email-j-keerthy@ti.com>
References: <1467093980-11458-1-git-send-email-j-keerthy@ti.com>
 <1467093980-11458-5-git-send-email-j-keerthy@ti.com>
Message-ID: <20160628065443.GD6720@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Jun 2016, Keerthy wrote:

> mfd_add_devices enables parsing device tree nodes without compatibles
> for regulators and gpio modules. Replace of_platform_populate with
> mfd_add_devices. mfd_cell currently is populated with regulators,
> gpio and powerbutton.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/mfd/tps65218.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
> index f20a531..107d695 100644
> --- a/drivers/mfd/tps65218.c
> +++ b/drivers/mfd/tps65218.c
> @@ -33,6 +33,15 @@
>  
>  #define TPS65218_PASSWORD_REGS_UNLOCK   0x7D
>  
> +static const struct mfd_cell tps65218_cells[] = {
> +	{ .name = "tps65218-regulator", },
> +	{
> +		.name = "tps65218-pwrbutton",
> +		.of_compatible = "ti,tps65218-pwrbutton",
> +	},
> +	{ .name = "tps65218-gpio", },
> +};

If there are no ordering dependencies, please move and group the one
line entries to the bottom of the table.

>  /**
>   * tps65218_reg_write: Write a single tps65218 register.
>   *
> @@ -236,8 +245,10 @@ static int tps65218_probe(struct i2c_client *client,
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
