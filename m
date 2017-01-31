From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 31 Jan 2017 22:07:19 +0100
Subject: [PATCH 09/11] drm/panel: Add support for the Raspberry Pi 7"
 Touchscreen.
In-Reply-To: <20161214194621.16499-10-eric@anholt.net>
References: <20161214194621.16499-1-eric@anholt.net>
 <20161214194621.16499-10-eric@anholt.net>
Message-ID: <20170131210717.GA872@mithrandir.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2016 at 11:46:19AM -0800, Eric Anholt wrote:
[...]
> diff --git a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
[...]
> +/**
> + * DOC: Raspberry Pi 7" touchscreen panel driver.
> + *
> + * The 7" touchscreen consists of a DPI LCD panel, a Toshiba
> + * TC358762XBG DSI-DPI bridge, and an I2C-connected Atmel ATTINY88-MUR
> + * controlling power management, the LCD PWM, and the touchscreen.
> + *
> + * This driver presents this device as a MIPI DSI panel to the DRM
> + * driver, and should expose the touchscreen as a HID device.
> + */

This sounds like these should be multiple drivers rather than wrapping
it all in a single one.

It might not be worth enforcing this now, provided that at least the
device tree is done properly, which would allow the driver structure
to change later on if, for example, a different panel needs to be
supported.

> +struct rpi_touchscreen {
> +	struct drm_panel base;
> +	struct mipi_dsi_device *dsi;
> +	struct i2c_client *bridge_i2c;
> +
> +	/* Version of the firmware on the bridge chip */
> +	int atmel_ver;

I don't see this used other than to store a version number. There's no
code in the driver that's conditional on this version.

> +static int rpi_touchscreen_enable(struct drm_panel *panel)
> +{
> +	struct rpi_touchscreen *ts = panel_to_ts(panel);
> +	int i;
> +
> +	rpi_touchscreen_i2c_write(ts, REG_POWERON, 1);
> +	/* Wait for nPWRDWN to go low to indicate poweron is done. */
> +	for (i = 0; i < 100; i++) {
> +		if (rpi_touchscreen_i2c_read(ts, REG_PORTB) & 1)
> +			break;
> +	}

Don't you want to fail when power on doesn't succeed? Seems kind of
pointless to continue if the panel doesn't power on.

> +
> +	rpi_touchscreen_write(ts, DSI_LANEENABLE,
> +			      DSI_LANEENABLE_CLOCK |
> +			      DSI_LANEENABLE_D0 |
> +			      (ts->dsi->lanes > 1 ? DSI_LANEENABLE_D1 : 0));

ts->dsi->lanes is set to 1 in ->probe(), so effectively this is dead
code, but I guess it can't hurt to leave it in in case you ever want to
extend this to support other display panels.

Which makes me think even more that this should really be at least two
drivers: a bridge driver and a panel driver, with the bridge getting
parameters from the panel to program registers accordingly.

> +	rpi_touchscreen_write(ts, PPI_D0S_CLRSIPOCOUNT, 0x05);
> +	rpi_touchscreen_write(ts, PPI_D1S_CLRSIPOCOUNT, 0x05);
> +	rpi_touchscreen_write(ts, PPI_D0S_ATMR, 0x00);
> +	rpi_touchscreen_write(ts, PPI_D1S_ATMR, 0x00);
> +	rpi_touchscreen_write(ts, PPI_LPTXTIMECNT, 0x03);
> +
> +	rpi_touchscreen_write(ts, SPICMR, 0x00);
> +	rpi_touchscreen_write(ts, LCDCTRL, 0x00100150);
> +	rpi_touchscreen_write(ts, SYSCTRL, 0x040f);
> +	msleep(100);
> +
> +	rpi_touchscreen_write(ts, PPI_STARTPPI, 0x01);
> +	rpi_touchscreen_write(ts, DSI_STARTDSI, 0x01);
> +	msleep(100);
> +
> +	/* Turn on the backklight. */
> +	rpi_touchscreen_i2c_write(ts, REG_PWM, 255);

It might be worth implementing a backlight here so that you can control
it from userspace like you would any other backlight.

> +static int rpi_touchscreen_dsi_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev = &dsi->dev;
> +	struct rpi_touchscreen *ts;
> +	int ret, ver;
> +
> +	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
> +	if (!ts)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, ts);
> +
> +	ts->dsi = dsi;
> +	dsi->mode_flags = (MIPI_DSI_MODE_VIDEO |
> +			   MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
> +			   MIPI_DSI_MODE_LPM);
> +	dsi->format = MIPI_DSI_FMT_RGB888;
> +	dsi->lanes = 1;
> +
> +	ts->bridge_i2c =
> +		rpi_touchscreen_get_i2c(dev, "raspberrypi,touchscreen-bridge");
> +	if (!ts->bridge_i2c) {
> +		ret = -EPROBE_DEFER;
> +		return ret;
> +	}
> +
> +	ver = rpi_touchscreen_i2c_read(ts, REG_ID);
> +	if (ver < 0) {
> +		dev_err(dev, "Atmel I2C read failed: %d\n", ver);
> +		return -ENODEV;
> +	}

Should this not goto err_release_bridge?

> +
> +	switch (ver) {
> +	case 0xde:
> +		ts->atmel_ver = 1;
> +		break;
> +	case 0xc3:
> +		ts->atmel_ver = 2;
> +		break;
> +	default:
> +		dev_err(dev, "Unknown Atmel firmware revision: 0x%02x\n", ver);
> +		return -ENODEV;
> +	}

Same here.

> +
> +	/* Turn off at boot, so we can cleanly sequence powering on. */
> +	rpi_touchscreen_i2c_write(ts, REG_POWERON, 0);
> +
> +	drm_panel_init(&ts->base);
> +	ts->base.dev = dev;
> +	ts->base.funcs = &rpi_touchscreen_funcs;
> +
> +	ret = drm_panel_add(&ts->base);
> +	if (ret < 0)
> +		goto err_release_bridge;
> +
> +	return mipi_dsi_attach(dsi);
> +
> +err_release_bridge:
> +	put_device(&ts->bridge_i2c->dev);
> +	return ret;
> +}
> +
> +static int rpi_touchscreen_dsi_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev = &dsi->dev;
> +	struct rpi_touchscreen *ts = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = mipi_dsi_detach(dsi);
> +	if (ret < 0) {
> +		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
> +		return ret;
> +	}

You might want to continue after this anyway, because the driver will be
unloaded regardless of your error code and you'll leave behind a
dangling panel and leak a reference to the I2C bridge.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170131/4f82fc12/attachment.sig>
