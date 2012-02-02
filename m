From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 2 Feb 2012 12:48:29 +0000
Subject: [RFC 2/7] MFD: twl6040: Convert to i2c driver, and separate it
 from twl core
In-Reply-To: <1328185019-29575-3-git-send-email-peter.ujfalusi@ti.com>
References: <1328185019-29575-1-git-send-email-peter.ujfalusi@ti.com>
 <1328185019-29575-3-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120202124828.GI7428@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2012 at 02:16:54PM +0200, Peter Ujfalusi wrote:

> +static int twl6040_i2c_read(struct i2c_client *i2c, u8 *value, u8 reg)
> +{
> +	struct i2c_msg msg[2];
> +	int ret;

May as well convert to regmap while you're at it, saves some code and
will get you access to the regmap features - you have to make updates in
all the relevant places anyway.  We should be pushing to remove use of
the ASoC level code for register cache and whatnot to cut down on code
duplication (especially for MFDs where it has a few issues interacting
with the MFD) and this seems like a good opportunity.

The calling convention here seems a bit weird too, you've got value then
register but normally we have register then value for I2C/SPI devices.
Except when we don't :(

> -module_platform_driver(twl6040_driver);
> +static int __devinit twl6040_init(void)
> +{
> +	return i2c_add_driver(&twl6040_driver);
> +}
> +module_init(twl6040_init);
> +
> +static void __devexit twl6040_exit(void)
> +{
> +	i2c_del_driver(&twl6040_driver);
> +}
> +
> +module_exit(twl6040_exit);

There's module_i2c_driver() in mainline as of the last merge window.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120202/1319fb4b/attachment-0001.sig>
