From: mirqus@gmail.com (=?ISO-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Fri, 8 Jul 2011 23:01:18 +0200
Subject: [PATCH 4/5] DRM: Add support for the sii902x HDMI/DVI encoder
In-Reply-To: <1307443550-25549-5-git-send-email-s.hauer@pengutronix.de>
References: <1307443550-25549-1-git-send-email-s.hauer@pengutronix.de>
	<1307443550-25549-5-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CAHXqBFJX01ZFeYMi=weK3LWhhFTkJ-_R6WPO_d2FDJ9cbBxSLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/6/7 Sascha Hauer <s.hauer@pengutronix.de>:
[...]
> --- /dev/null
> +++ b/drivers/gpu/drm/i2c/sii902x.c
> @@ -0,0 +1,334 @@
[...]
> +static int sii902x_write(struct i2c_client *client, uint8_t addr, uint8_t val)
> +{
> + ? ? ? int ret;
> +
> + ? ? ? ret = i2c_smbus_write_byte_data(client, addr, val);
> + ? ? ? if (ret) {
> + ? ? ? ? ? ? ? dev_dbg(&client->dev, "%s failed with %d\n", __func__, ret);
> + ? ? ? }
> + ? ? ? return ret;
> +}

Return value is never tested.

> +static irqreturn_t sii902x_detect_handler(int irq, void *data)
> +{
> + ? ? ? struct sii902x_priv *priv = data;
> + ? ? ? struct i2c_client *client = priv->client;
> + ? ? ? int dat;
> +
> + ? ? ? dat = sii902x_read(client, 0x3D);
> + ? ? ? if (dat & 0x1) {
> + ? ? ? ? ? ? ? /* cable connection changes */
> + ? ? ? ? ? ? ? if (dat & 0x4) {
> + ? ? ? ? ? ? ? ? ? ? ? printk("plugin\n");
> + ? ? ? ? ? ? ? } else {
> + ? ? ? ? ? ? ? ? ? ? ? printk("plugout\n");
> + ? ? ? ? ? ? ? }

Missing code?

> + ? ? ? }
> + ? ? ? sii902x_write(client, 0x3D, dat);
> +
> + ? ? ? return IRQ_HANDLED;
> +}
[...]
> +/* I2C driver functions */
> +
> +static int
> +sii902x_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +{
> + ? ? ? int dat, ret;
> + ? ? ? struct sii902x_priv *priv;
> + ? ? ? const char *drm_name = "imx-drm.0"; /* FIXME: pass from pdata */
> + ? ? ? int encon_id = 0; /* FIXME: pass from pdata */
> +
> + ? ? ? priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> + ? ? ? if (!priv)
> + ? ? ? ? ? ? ? return -ENOMEM;
> +
> + ? ? ? priv->client = client;
> +
> + ? ? ? /* Set 902x in hardware TPI mode on and jump out of D3 state */
> + ? ? ? if (sii902x_write(client, 0xc7, 0x00) < 0) {
> + ? ? ? ? ? ? ? dev_err(&client->dev, "SII902x: cound not find device\n");
> + ? ? ? ? ? ? ? return -ENODEV;

Leaks priv. Same on other error paths.

> + ? ? ? }
[...]

> +
> +
> +static int sii902x_remove(struct i2c_client *client)
> +{
> + ? ? ? struct sii902x_priv *priv;
> + ? ? ? int ret;
> +
> + ? ? ? priv = i2c_get_clientdata(client);
> +
> + ? ? ? ret = drm_encon_unregister(&priv->encon);
> + ? ? ? if (ret)
> + ? ? ? ? ? ? ? return ret;

Leaks priv on error.

> +
> + ? ? ? kfree(priv);
> +
> + ? ? ? return 0;
> +}
[...]

Best Regards,
Micha? Miros?aw
