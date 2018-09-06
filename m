From: nv@vosn.de (Nikolaus Voss)
Date: Thu, 6 Sep 2018 11:06:06 +0200 (CEST)
Subject: [PATCH v3 4/4] regmap-i2c: Add smbus i2c block support
In-Reply-To: <1440657872-24554-5-git-send-email-mpa@pengutronix.de>
References: <1440657872-24554-1-git-send-email-mpa@pengutronix.de>
 <1440657872-24554-5-git-send-email-mpa@pengutronix.de>
Message-ID: <alpine.DEB.2.20.1809061101560.24070@fox.voss.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,

On Thu, 27 Aug 2015, Markus Pargmann wrote:
> This allows to read/write up to 32 bytes of data and is to be prefered
> if supported before the register read/write smbus support.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
> drivers/base/regmap/regmap-i2c.c | 49 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 49 insertions(+)
>
> diff --git a/drivers/base/regmap/regmap-i2c.c b/drivers/base/regmap/regmap-i2c.c
> index 4b76e33110a2..ddb9b0efb724 100644
> --- a/drivers/base/regmap/regmap-i2c.c
> +++ b/drivers/base/regmap/regmap-i2c.c
> @@ -209,11 +209,60 @@ static struct regmap_bus regmap_i2c = {
> 	.val_format_endian_default = REGMAP_ENDIAN_BIG,
> };
>
> +static int regmap_i2c_smbus_i2c_write(void *context, const void *data,
> +				      size_t count)
> +{
> +	struct device *dev = context;
> +	struct i2c_client *i2c = to_i2c_client(dev);
> +
> +	if (count < 1)
> +		return -EINVAL;
> +	if (count >= I2C_SMBUS_BLOCK_MAX)
> +		return -E2BIG;
> +
> +	--count;
> +	return i2c_smbus_write_i2c_block_data(i2c, ((u8 *)data)[0], count,
> +					      ((u8 *)data + 1));
> +}
> +
> +static int regmap_i2c_smbus_i2c_read(void *context, const void *reg,
> +				     size_t reg_size, void *val,
> +				     size_t val_size)
> +{
> +	struct device *dev = context;
> +	struct i2c_client *i2c = to_i2c_client(dev);
> +	int ret;
> +
> +	if (reg_size != 1 || val_size < 1)
> +		return -EINVAL;
> +	if (val_size >= I2C_SMBUS_BLOCK_MAX)
> +		return -E2BIG;
> +
> +	ret = i2c_smbus_read_i2c_block_data(i2c, ((u8 *)reg)[0], val_size, val);
> +	if (ret == val_size)
> +		return 0;
> +	else if (ret < 0)
> +		return ret;
> +	else
> +		return -EIO;
> +}
> +
> +static struct regmap_bus regmap_i2c_smbus_i2c_block = {
> +	.write = regmap_i2c_smbus_i2c_write,
> +	.read = regmap_i2c_smbus_i2c_read,
> +	.max_raw_read = I2C_SMBUS_BLOCK_MAX,
> +	.max_raw_write = I2C_SMBUS_BLOCK_MAX,
> +};
> +
> static const struct regmap_bus *regmap_get_i2c_bus(struct i2c_client *i2c,
> 					const struct regmap_config *config)
> {
> 	if (i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C))
> 		return &regmap_i2c;
> +	else if (config->reg_bits == 8 &&
> +		 i2c_check_functionality(i2c->adapter,
> +					 I2C_FUNC_SMBUS_I2C_BLOCK))
> +		return &regmap_i2c_smbus_i2c_block;
> 	else if (config->val_bits == 16 && config->reg_bits == 8 &&
> 		 i2c_check_functionality(i2c->adapter,
> 					 I2C_FUNC_SMBUS_WORD_DATA))
>

using i2c_smbus_read/write_i2c_block_data() instead of
read/write_word_data() or i2c_transfer() actually changes what is
transferred on the bus. SMBus block transfers have a different
register model, they additionally read or write the byte count after
transmitting the register/command code, see SMBus spec:

+---+-------------+---+--+-------------+--+---------------+--+------------+----+
| S | Slave Addr  | Wr| A| Command Code| A| Byte Count = N| A| Data Byte 1| A  |
+---+-------------+---+--+-------------+--+---------------+--+------------+----+

So a driver using regmap must implement different transfers depending on
the i2c adapter capabilities, is this intentionally done so?

Specifically, there is no way of getting rid of the additional byte count
field if the adapter doesn't support I2C_FUNC_I2C although it would be
technically possible.

I would prefer regmap to always use the same register model (i.e. without
the byte count field), can you explain the rationale for this?

Niko
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 3493 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180906/7b7f3661/attachment-0001.p7s>
