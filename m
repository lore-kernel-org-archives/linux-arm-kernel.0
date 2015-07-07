From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 7 Jul 2015 08:30:16 +0100
Subject: [PATCH-V5 1/4] mfd: 88pm800: Add device tree support
In-Reply-To: <1435591877-18214-2-git-send-email-vaibhav.hiremath@linaro.org>
References: <1435591877-18214-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1435591877-18214-2-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <20150707073016.GO3182@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 29 Jun 2015, Vaibhav Hiremath wrote:

> Add DT support to the 88pm800 driver, along with compatible
> field for it's sub-devices (rtc, onkey and regulator)
> 
> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> ---
>  drivers/mfd/88pm800.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
> index 841717a..40fd014 100644
> --- a/drivers/mfd/88pm800.c
> +++ b/drivers/mfd/88pm800.c
> @@ -27,6 +27,7 @@
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/88pm80x.h>
>  #include <linux/slab.h>
> +#include <linux/of_device.h>
>  
>  /* Interrupt Registers */
>  #define PM800_INT_STATUS1		(0x05)
> @@ -121,6 +122,11 @@ static const struct i2c_device_id pm80x_id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, pm80x_id_table);
>  
> +static const struct of_device_id pm80x_of_match_table[] = {
> +	{ .compatible = "marvell,88pm800", },
> +	{},
> +};
> +
>  static struct resource rtc_resources[] = {
>  	{
>  	 .name = "88pm80x-rtc",
> @@ -133,6 +139,7 @@ static struct resource rtc_resources[] = {
>  static struct mfd_cell rtc_devs[] = {
>  	{
>  	 .name = "88pm80x-rtc",
> +	 .of_compatible = "marvell,88pm80x-rtc",
>  	 .num_resources = ARRAY_SIZE(rtc_resources),
>  	 .resources = &rtc_resources[0],
>  	 .id = -1,
> @@ -151,6 +158,7 @@ static struct resource onkey_resources[] = {
>  static const struct mfd_cell onkey_devs[] = {
>  	{
>  	 .name = "88pm80x-onkey",
> +	 .of_compatible = "marvell,88pm80x-onkey",
>  	 .num_resources = 1,
>  	 .resources = &onkey_resources[0],
>  	 .id = -1,
> @@ -160,6 +168,7 @@ static const struct mfd_cell onkey_devs[] = {
>  static const struct mfd_cell regulator_devs[] = {
>  	{
>  	 .name = "88pm80x-regulator",
> +	 .of_compatible = "marvell,88pm80x-regulator",
>  	 .id = -1,
>  	},
>  };
> @@ -544,8 +553,21 @@ static int pm800_probe(struct i2c_client *client,
>  	int ret = 0;
>  	struct pm80x_chip *chip;
>  	struct pm80x_platform_data *pdata = dev_get_platdata(&client->dev);
> +	struct device_node *np = client->dev.of_node;
>  	struct pm80x_subchip *subchip;
>  
> +	if (!pdata && !np) {
> +		dev_err(&client->dev,
> +			"pm80x requires platform data or of_node\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!pdata) {
> +		pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
> +		if (!pdata)
> +			return -ENOMEM;
> +	}
> +
>  	ret = pm80x_init(client);
>  	if (ret) {
>  		dev_err(&client->dev, "pm800_init fail\n");
> @@ -611,6 +633,7 @@ static struct i2c_driver pm800_driver = {
>  		.name = "88PM800",
>  		.owner = THIS_MODULE,
>  		.pm = &pm80x_pm_ops,
> +		.of_match_table	= pm80x_of_match_table,
>  		},
>  	.probe = pm800_probe,
>  	.remove = pm800_remove,

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
