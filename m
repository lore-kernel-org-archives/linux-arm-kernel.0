From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 2 Dec 2013 10:17:29 +0100
Subject: [PATCH v2 1/3] mfd: tps6586x: add version detection
In-Reply-To: <2d5282f031a16d2ff227694daaabc977440fbd2e.1385913228.git.stefan@agner.ch>
References: <cover.1385913227.git.stefan@agner.ch>
 <2d5282f031a16d2ff227694daaabc977440fbd2e.1385913228.git.stefan@agner.ch>
Message-ID: <20131202091728.GE17834@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 01, 2013 at 04:59:13PM +0100, Stefan Agner wrote:
> Use the VERSIONCRC to determine the exact device version. According to
> the datasheet this register can be used as device identifier. The
> identification is needed since some tps6586x regulators use a different
> voltage table.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/mfd/tps6586x.c       | 47 +++++++++++++++++++++++++++++++++++++-------
>  include/linux/mfd/tps6586x.h |  7 +++++++
>  2 files changed, 47 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
> index ee61fd7..8fc5a68 100644
> --- a/drivers/mfd/tps6586x.c
> +++ b/drivers/mfd/tps6586x.c
> @@ -124,6 +124,7 @@ struct tps6586x {
>  	struct device		*dev;
>  	struct i2c_client	*client;
>  	struct regmap		*regmap;
> +	int			version;
>  
>  	int			irq;
>  	struct irq_chip		irq_chip;
> @@ -208,6 +209,14 @@ int tps6586x_irq_get_virq(struct device *dev, int irq)
>  }
>  EXPORT_SYMBOL_GPL(tps6586x_irq_get_virq);
>  
> +int tps6586x_get_version(struct device *dev)
> +{
> +	struct tps6586x *tps6586x = dev_get_drvdata(dev);
> +
> +	return tps6586x->version;
> +}
> +EXPORT_SYMBOL_GPL(tps6586x_get_version);
> +
>  static int __remove_subdev(struct device *dev, void *unused)
>  {
>  	platform_device_unregister(to_platform_device(dev));
> @@ -472,6 +481,31 @@ static void tps6586x_power_off(void)
>  	tps6586x_set_bits(tps6586x_dev, TPS6586X_SUPPLYENE, SLEEP_MODE_BIT);
>  }
>  
> +static void tps6586x_print_version(struct i2c_client *client, int version)
> +{
> +	const char *name;
> +
> +	switch (version) {
> +	case TPS658621A:
> +		name = "TPS658621A";
> +		break;
> +	case TPS658621CD:
> +		name = "TPS658621C/D";
> +		break;
> +	case TPS658623:
> +		name = "TPS658623";
> +		break;
> +	case TPS658643:
> +		name = "TPS658643";
> +		break;
> +	default:
> +		name = "TPS6586X";
> +		break;
> +	}
> +
> +	dev_info(&client->dev, "Found %s, VERSIONCRC is %02x\n", name, version);
> +}
> +
>  static int tps6586x_i2c_probe(struct i2c_client *client,
>  					const struct i2c_device_id *id)
>  {
> @@ -487,19 +521,18 @@ static int tps6586x_i2c_probe(struct i2c_client *client,
>  		return -ENOTSUPP;
>  	}
>  
> +	tps6586x = devm_kzalloc(&client->dev, sizeof(*tps6586x), GFP_KERNEL);
> +	if (!tps6586x)
> +		return -ENOMEM;
> +

This hunk is being needlessly moved around....

>  	ret = i2c_smbus_read_byte_data(client, TPS6586X_VERSIONCRC);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "Chip ID read failed: %d\n", ret);
>  		return -EIO;
>  	}
>  
> -	dev_info(&client->dev, "VERSIONCRC is %02x\n", ret);
> -
> -	tps6586x = devm_kzalloc(&client->dev, sizeof(*tps6586x), GFP_KERNEL);
> -	if (tps6586x == NULL) {
> -		dev_err(&client->dev, "memory for tps6586x alloc failed\n");
> -		return -ENOMEM;
> -	}
> +	tps6586x->version = ret;
> +	tps6586x_print_version(client, tps6586x->version);

... none of this new code overwrites "ret", so you could just keep the
previous order of operations. It probably doesn't matter all that much,
but deferring allocation until we're sure that the chip actually exists
is a minor optimization. Also not moving that hunk around makes the
patch simpler.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131202/343b80b9/attachment-0001.sig>
