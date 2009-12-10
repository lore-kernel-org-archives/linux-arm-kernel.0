From: sameo@linux.intel.com (Samuel Ortiz)
Date: Thu, 10 Dec 2009 11:35:58 +0100
Subject: [PATCH v2 02/09] mfd: support 88pm8606 in 860x driver
In-Reply-To: <771cded00912090511s3f28dd7tf0dcbc54c0c50970@mail.gmail.com>
References: <771cded00912090511s3f28dd7tf0dcbc54c0c50970@mail.gmail.com>
Message-ID: <20091210103557.GA6873@sortiz.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

On Wed, Dec 09, 2009 at 08:11:22AM -0500, Haojian Zhuang wrote:
> 
> Now share one driver to these two devices. Only one I2C client is identified
> in platform init data. If another chip is also used, user should mark it in
> companion_addr field of platform init data. Then driver could create another
> I2C client for the companion chip.
> 
> All I2C operations are accessed by 860x-i2c driver. In order to support both
> I2C client address, the read/write API is changed in below.
The code looks better now. I still have a few comments though:

> -static inline int pm8607_read_device(struct pm8607_chip *chip,
> +static struct mutex io_lock;
Why do we need a static lock here ?

> +int pm860x_reg_read(struct i2c_client *i2c, int reg)
>  {
>  	unsigned char data;
>  	int ret;
> 
> -	mutex_lock(&chip->io_lock);
> -	ret = chip->read(chip, reg, 1, &data);
> -	mutex_unlock(&chip->io_lock);
> +	mutex_lock(&io_lock);
Why not keep mutex_unlock(&chip->io_lock); where chip is
i2c_get_clientdata(i2c) ?

>  static int __devinit pm860x_probe(struct i2c_client *client,
>  				  const struct i2c_device_id *id)
>  {
> -	struct pm8607_platform_data *pdata = client->dev.platform_data;
> -	struct pm8607_chip *chip;
> +	struct pm860x_platform_data *pdata = client->dev.platform_data;
> +	struct pm860x_chip *chip;
> +	struct i2c_board_info i2c_info = {
> +		.type		= "88PM860x",
> +		.platform_data	= client->dev.platform_data,
I dont think you want to use the same platform_data. At least you want to
reset the companion_addr field.


> +	};
> +	int addr_c, found_companion = 0;
>  	int ret;
> 
> -	chip = kzalloc(sizeof(struct pm8607_chip), GFP_KERNEL);
> -	if (chip == NULL)
> -		return -ENOMEM;
> -
> -	chip->client = client;
> -	chip->dev = &client->dev;
> -	chip->read = pm8607_read_device;
> -	chip->write = pm8607_write_device;
> -	memcpy(&chip->id, id, sizeof(struct i2c_device_id));
> -	i2c_set_clientdata(client, chip);
> -
> -	mutex_init(&chip->io_lock);
> -	dev_set_drvdata(chip->dev, chip);
> -
> -	ret = pm860x_device_init(chip, pdata);
> -	if (ret < 0)
> -		goto out;
> -
> +	if (pdata == NULL) {
> +		pr_info("No platform data in %s!\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	addr_c = pdata->companion_addr;
> +	if (addr_c && (addr_c != client->addr)) {
> +		i2c_info.addr = addr_c;
> +		found_companion = 1;
> +	}
> +
> +	if (found_companion || (addr_c == 0)) {
You probably dont need that check here.


> +		chip = kzalloc(sizeof(struct pm860x_chip), GFP_KERNEL);
> +		if (chip == NULL)
> +			return -ENOMEM;
> +
> +		chip->id = verify_addr(client);
> +		chip->client = client;
> +		i2c_set_clientdata(client, chip);
> +		chip->dev = &client->dev;
> +		mutex_init(&io_lock);
> +		dev_set_drvdata(chip->dev, chip);
> +
> +		if (found_companion) {
> +			chip->companion = i2c_new_device(client->adapter,
> +							 &i2c_info);
> +			i2c_set_clientdata(chip->companion, chip);
> +		}
I guess you've tested that code. I have a question: After returning from
i2c_new_device(), I'd expect pm860x_probe() to be called as the companion chip
is bound. Isnt that that the case ?

Cheers,
Samuel.
-- 
Intel Open Source Technology Centre
http://oss.intel.com/
