From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 12 Jul 2011 15:21:07 +0200
Subject: [PATCH 4/5] DRM: Add support for the sii902x HDMI/DVI encoder
In-Reply-To: <CAHXqBFJX01ZFeYMi=weK3LWhhFTkJ-_R6WPO_d2FDJ9cbBxSLQ@mail.gmail.com>
References: <1307443550-25549-1-git-send-email-s.hauer@pengutronix.de>
	<1307443550-25549-5-git-send-email-s.hauer@pengutronix.de>
	<CAHXqBFJX01ZFeYMi=weK3LWhhFTkJ-_R6WPO_d2FDJ9cbBxSLQ@mail.gmail.com>
Message-ID: <20110712132107.GO6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 11:01:18PM +0200, Micha?? Miros??aw wrote:
> 2011/6/7 Sascha Hauer <s.hauer@pengutronix.de>:
> [...]
> > --- /dev/null
> > +++ b/drivers/gpu/drm/i2c/sii902x.c
> > @@ -0,0 +1,334 @@
> [...]
> > +static int sii902x_write(struct i2c_client *client, uint8_t addr, uint8_t val)
> > +{
> > + ? ? ? int ret;
> > +
> > + ? ? ? ret = i2c_smbus_write_byte_data(client, addr, val);
> > + ? ? ? if (ret) {
> > + ? ? ? ? ? ? ? dev_dbg(&client->dev, "%s failed with %d\n", __func__, ret);
> > + ? ? ? }
> > + ? ? ? return ret;
> > +}
> 
> Return value is never tested.

Yes, but there is not much I can do about it. This function is called
from void functions most of the time, so I can't even forward the error.

> 
> > +static irqreturn_t sii902x_detect_handler(int irq, void *data)
> > +{
> > + ? ? ? struct sii902x_priv *priv = data;
> > + ? ? ? struct i2c_client *client = priv->client;
> > + ? ? ? int dat;
> > +
> > + ? ? ? dat = sii902x_read(client, 0x3D);
> > + ? ? ? if (dat & 0x1) {
> > + ? ? ? ? ? ? ? /* cable connection changes */
> > + ? ? ? ? ? ? ? if (dat & 0x4) {
> > + ? ? ? ? ? ? ? ? ? ? ? printk("plugin\n");
> > + ? ? ? ? ? ? ? } else {
> > + ? ? ? ? ? ? ? ? ? ? ? printk("plugout\n");
> > + ? ? ? ? ? ? ? }
> 
> Missing code?

Yes. I will either remove interrupt support or put the missing code in.

> 
> > + ? ? ? }
> > + ? ? ? sii902x_write(client, 0x3D, dat);
> > +
> > + ? ? ? return IRQ_HANDLED;
> > +}
> [...]
> > +/* I2C driver functions */
> > +
> > +static int
> > +sii902x_probe(struct i2c_client *client, const struct i2c_device_id *id)
> > +{
> > + ? ? ? int dat, ret;
> > + ? ? ? struct sii902x_priv *priv;
> > + ? ? ? const char *drm_name = "imx-drm.0"; /* FIXME: pass from pdata */
> > + ? ? ? int encon_id = 0; /* FIXME: pass from pdata */
> > +
> > + ? ? ? priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> > + ? ? ? if (!priv)
> > + ? ? ? ? ? ? ? return -ENOMEM;
> > +
> > + ? ? ? priv->client = client;
> > +
> > + ? ? ? /* Set 902x in hardware TPI mode on and jump out of D3 state */
> > + ? ? ? if (sii902x_write(client, 0xc7, 0x00) < 0) {
> > + ? ? ? ? ? ? ? dev_err(&client->dev, "SII902x: cound not find device\n");
> > + ? ? ? ? ? ? ? return -ENODEV;
> 
> Leaks priv. Same on other error paths.

Jup, thanks for noting. There are some other bugs in the probe function,
like not checking the return value of drm_encon_register().

Will fix

> 
> > + ? ? ? }
> [...]
> 
> > +
> > +
> > +static int sii902x_remove(struct i2c_client *client)
> > +{
> > + ? ? ? struct sii902x_priv *priv;
> > + ? ? ? int ret;
> > +
> > + ? ? ? priv = i2c_get_clientdata(client);
> > +
> > + ? ? ? ret = drm_encon_unregister(&priv->encon);
> > + ? ? ? if (ret)
> > + ? ? ? ? ? ? ? return ret;
> 
> Leaks priv on error.

and forgets to free_irq()

Thanks
 Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
