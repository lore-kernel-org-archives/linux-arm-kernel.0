From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Jul 2014 11:25:13 +0100
Subject: drm/i2c: tda998x: Set CEC I2C address from TDA I2C address
In-Reply-To: <53B3D1F8.7080106@arm.com>
References: <53B3D1F8.7080106@arm.com>
Message-ID: <20140702102513.GF32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

You missed me as the maintainer of the driver:

NXP TDA998X DRM DRIVER
M:      Russell King <rmk+kernel@arm.linux.org.uk>
S:      Supported
F:      drivers/gpu/drm/i2c/tda998x_drv.c
F:      include/drm/i2c/tda998x.h

On Wed, Jul 02, 2014 at 10:33:44AM +0100, Andrew Jackson wrote:
> @@ -1274,9 +1275,9 @@ tda998x_encoder_init(struct i2c_client *client,
> 
>         priv->current_page = 0xff;
>         priv->hdmi = client;
> -       priv->cec = i2c_new_dummy(client->adapter, 0x34);
> -       if (!priv->cec)
> -               priv->cec = i2c_new_dummy(client->adapter, 0x35);
> +       /* CEC I2C address bound to TDA998x I2C addr by configuration pins */
> +       cec_addr = 0x34 + (client->addr & 3);
> +       priv->cec = i2c_new_dummy(client->adapter, cec_addr);

We discussed the issue of the I2C CEC address when the DT binding first
came up...

Do we know for certain that the above is always true for all the devices
that this driver supports?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
