From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 5 Feb 2010 16:41:00 +0100
Subject: [PATCH 2/5] mfd: use i2c_dummy in 88pm860x
In-Reply-To: <771cded01002030502p74c1071aof66e0cc44ead9f66@mail.gmail.com>
References: <771cded01002030502p74c1071aof66e0cc44ead9f66@mail.gmail.com>
Message-ID: <20100205154059.GD3448@sortiz.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

On Wed, Feb 03, 2010 at 08:02:38AM -0500, Haojian Zhuang wrote:
> From 24df51edbe48c9648dd0c563994c8f158f655086 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Wed, 3 Feb 2010 15:38:12 -0500
> Subject: [PATCH] mfd: use i2c_dummy in 88pm860x
> 
> Use i2c_dummy in 88pm860x driver to avoid using static in probe function.
Patch applied, many thanks.

Cheers,
Samuel.


> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  drivers/mfd/88pm860x-i2c.c |   72 ++++++++++++-------------------------------
>  1 files changed, 20 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/mfd/88pm860x-i2c.c b/drivers/mfd/88pm860x-i2c.c
> index 6d7dba2..c37e12b 100644
> --- a/drivers/mfd/88pm860x-i2c.c
> +++ b/drivers/mfd/88pm860x-i2c.c
> @@ -157,18 +157,24 @@ static int __devinit pm860x_probe(struct
> i2c_client *client,
>  				  const struct i2c_device_id *id)
>  {
>  	struct pm860x_platform_data *pdata = client->dev.platform_data;
> -	static struct pm860x_chip *chip;
> -	struct i2c_board_info i2c_info = {
> -		.type		= "88PM860x",
> -		.platform_data	= client->dev.platform_data,
> -	};
> -	int addr_c, found_companion = 0;
> -
> -	if (pdata == NULL) {
> +	struct pm860x_chip *chip;
> +
> +	if (!pdata) {
>  		pr_info("No platform data in %s!\n", __func__);
>  		return -EINVAL;
>  	}
> 
> +	chip = kzalloc(sizeof(struct pm860x_chip), GFP_KERNEL);
> +	if (chip == NULL)
> +		return -ENOMEM;
> +
> +	chip->id = verify_addr(client);
> +	chip->client = client;
> +	i2c_set_clientdata(client, chip);
> +	chip->dev = &client->dev;
> +	mutex_init(&chip->io_lock);
> +	dev_set_drvdata(chip->dev, chip);
> +
>  	/*
>  	 * Both client and companion client shares same platform driver.
>  	 * Driver distinguishes them by pdata->companion_addr.
> @@ -176,46 +182,14 @@ static int __devinit pm860x_probe(struct
> i2c_client *client,
>  	 * At the same time, the companion_addr shouldn't equal to client
>  	 * address.
>  	 */
> -	addr_c = pdata->companion_addr;
> -	if (addr_c && (addr_c != client->addr)) {
> -		i2c_info.addr = addr_c;
> -		found_companion = 1;
> -	}
> -
> -	if (found_companion || (addr_c == 0)) {
> -		chip = kzalloc(sizeof(struct pm860x_chip), GFP_KERNEL);
> -		if (chip == NULL)
> -			return -ENOMEM;
> -
> -		chip->id = verify_addr(client);
> -		chip->companion_addr = addr_c;
> -		chip->client = client;
> -		i2c_set_clientdata(client, chip);
> -		chip->dev = &client->dev;
> -		mutex_init(&chip->io_lock);
> -		dev_set_drvdata(chip->dev, chip);
> -
> -		if (found_companion) {
> -			/*
> -			 * If this driver is built in, probe function is
> -			 * recursive.
> -			 * If this driver is built as module, the next probe
> -			 * function is called after the first one finished.
> -			 */
> -			chip->companion = i2c_new_device(client->adapter,
> -							 &i2c_info);
> -		}
> -	}
> -
> -	/*
> -	 * If companion chip existes, it's called by companion probe.
> -	 * If there's no companion chip, it's called by client probe.
> -	 */
> -	if ((addr_c == 0) || (addr_c == client->addr)) {
> -		chip->companion = client;
> +	if (pdata->companion_addr && (pdata->companion_addr != client->addr)) {
> +		chip->companion_addr = pdata->companion_addr;
> +		chip->companion = i2c_new_dummy(chip->client->adapter,
> +						chip->companion_addr);
>  		i2c_set_clientdata(chip->companion, chip);
> -		pm860x_device_init(chip, pdata);
>  	}
> +
> +	pm860x_device_init(chip, pdata);
>  	return 0;
>  }
> 
> @@ -223,12 +197,6 @@ static int __devexit pm860x_remove(struct
> i2c_client *client)
>  {
>  	struct pm860x_chip *chip = i2c_get_clientdata(client);
> 
> -	/*
> -	 * If companion existes, companion client is removed first.
> -	 * Because companion client is registered last and removed first.
> -	 */
> -	if (chip->companion_addr == client->addr)
> -		return 0;
>  	pm860x_device_exit(chip);
>  	i2c_unregister_device(chip->companion);
>  	i2c_set_clientdata(chip->companion, NULL);
> -- 
> 1.5.6.5

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
