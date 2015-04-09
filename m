From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 9 Apr 2015 10:09:51 +0200
Subject: [PATCH RFC v9 15/20] drm: panel: Add support for Himax HX8369A
 MIPI DSI panel
In-Reply-To: <1423720903-24806-16-git-send-email-Ying.Liu@freescale.com>
References: <1423720903-24806-1-git-send-email-Ying.Liu@freescale.com>
 <1423720903-24806-16-git-send-email-Ying.Liu@freescale.com>
Message-ID: <20150409080950.GC12103@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 12, 2015 at 02:01:38PM +0800, Liu Ying wrote:
> This patch adds support for Himax HX8369A MIPI DSI panel.

If we're going to go ahead with this solution, this should read
something like:

	Add support for panels driven by the Himax HX8369A MIPI DSI
	bridge.

> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index d845837..cd6fbb7 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -17,6 +17,11 @@ config DRM_PANEL_SIMPLE
>  	  that it can be automatically turned off when the panel goes into a
>  	  low power state.
>  
> +config DRM_PANEL_HIMAX_HX8369A
> +	tristate "Himax HX8369A panel"

Same here.

> diff --git a/drivers/gpu/drm/panel/panel-himax-hx8369a.c b/drivers/gpu/drm/panel/panel-himax-hx8369a.c
[...]
> +struct hx8369a {
> +	struct device *dev;
> +	struct drm_panel panel;

Maybe put this first in the structure so that the container_of() further
below can be optimized away in most cases? Also, can you not reuse the
dev field of struct drm_panel instead of adding another reference to it
in the driver-private structure?

> +	const struct hx8369a_panel_desc *pd;
> +
> +	struct regulator_bulk_data supplies[5];
> +	struct gpio_desc *reset_gpio;
> +	struct gpio_desc *bs_gpio[4];
> +	u8 res_sel;

The only purpose of this field seems to be to temporarily store a value
that you could just as well simply return. See below.

> +static int hx8369a_dcs_write(struct hx8369a *ctx, const char *func,
> +			     const void *data, size_t len)
> +{
> +	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
> +	ssize_t ret;
> +
> +	ret = mipi_dsi_dcs_write_buffer(dsi, data, len);
> +	if (ret < 0)
> +		dev_err(ctx->dev, "%s failed: %d\n", func, ret);

I think I'd put this error message into the caller. See below.

> +#define hx8369a_dcs_write_seq(ctx, seq...) \
> +({ \
> +	const u8 d[] = { seq }; \
> +	BUILD_BUG_ON_MSG(ARRAY_SIZE(d) > 64, \
> +			 "DCS sequence too big for stack"); \

That's not necessarily true. The stack is usually much larger than 64
bytes. But this seems to be common practice with MIPI DSI drivers, so
you get to keep it if you really must have it. Note that the compiler
will usually complain itself if you exceed the stack size, so this is
somewhat redundant.

> +static int hx8369a_dsi_set_display_related_register(struct hx8369a *ctx)
> +{
> +	u8 sec_p = (ctx->res_sel << 4) | 0x03;

You could call hx8369a_vm_to_res_sel() here and return the proper value
rather than taking it from the driver-private data.

> +static int hx8369a_dsi_set_mipi(struct hx8369a *ctx)
> +{
> +	u8 eleventh_p = ctx->pd->dsi_lanes == 2 ? 0x11 : 0x10;

I wish datasheets would be more verbose so that we could avoid this kind
of meaningless names. Is there really no more documentation for any of
these commands than just a fixed set of values with maybe one or two
variable parameters?

If we ever need to support more than one panel with this driver this
could get tricky.

> +static int hx8369a_dsi_set_interface_pixel_fomat(struct hx8369a *ctx)
> +{
> +	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
> +	u8 format;
> +	int ret;
> +
> +	switch (dsi->format) {
> +	case MIPI_DSI_FMT_RGB888:
> +	case MIPI_DSI_FMT_RGB666:
> +		format = 0x77;
> +		break;
> +	case MIPI_DSI_FMT_RGB565:
> +		format = 0x55;
> +		break;
> +	case MIPI_DSI_FMT_RGB666_PACKED:
> +		format = 0x66;
> +		break;
> +	default:
> +		dev_err(ctx->dev, "unsupported DSI pixel format\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = mipi_dsi_dcs_set_pixel_format(dsi, format);
> +	if (ret < 0)
> +		dev_err(ctx->dev, "%s failed: %d\n", __func__, ret);
> +	return ret;
> +}

This looks like something that could be extracted into a common helper.
But that can be done separately and when a clear pattern emerges.

> +static int hx8369a_dsi_panel_init(struct hx8369a *ctx)
> +{
> +	int (*funcs[])(struct hx8369a *ctx) = {
> +		hx8369a_dsi_set_display_related_register,
> +		hx8369a_dsi_set_display_waveform_cycle,
> +		hx8369a_dsi_set_gip,
> +		hx8369a_dsi_set_power,
> +		hx8369a_dsi_set_vcom_voltage,
> +		hx8369a_dsi_set_panel,
> +		hx8369a_dsi_set_gamma_curve,
> +		hx8369a_dsi_set_mipi,
> +		hx8369a_dsi_set_interface_pixel_fomat,
> +		hx8369a_dsi_set_column_address,
> +		hx8369a_dsi_set_page_address,
> +		hx8369a_dsi_write_cabc,
> +		hx8369a_dsi_write_control_display,
> +	};
> +	int ret, i;
> +
> +	for (i = 0; i < ARRAY_SIZE(funcs); i++) {
> +		ret = funcs[i](ctx);
> +		if (ret)
> +			return ret;

I think you should be able to output an error message here in the form
of:

	dev_err(ctx->panel.dev, "%ps() failed: %d\n", funcs[i], ret);

%ps should print the name associated with the funcs[i] symbol. That way
you can remove error reporting from the low-level macro/function.

> +static int hx8369a_dsi_set_maximum_return_packet_size(struct hx8369a *ctx,
> +						      u16 size)
> +{
> +	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
> +	int ret;
> +
> +	ret = mipi_dsi_set_maximum_return_packet_size(dsi, size);
> +	if (ret < 0)
> +		dev_err(ctx->dev,
> +			"error %d setting maximum return packet size to %d\n",
> +			ret, size);
> +	return ret;
> +}
> +
> +static int hx8369a_dsi_set_sequence(struct hx8369a *ctx)
> +{
> +	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
> +	int ret;
> +
> +	ret = hx8369a_dsi_set_extension_command(ctx);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = hx8369a_dsi_set_maximum_return_packet_size(ctx, 4);
> +	if (ret < 0)
> +		goto out;

Why this wrapper? Since you already have the struct mipi_dsi_device *,
can't you just do:

	ret = mipi_dsi_set_maximum_return_packet_size(dsi, 4);

instead?

> +static int hx8369a_dsi_disable(struct drm_panel *panel)
> +{
> +	struct hx8369a *ctx = panel_to_hx8369a(panel);
> +
> +	return hx8369a_dsi_write_display_brightness(ctx,
> +						HX8369A_MIN_BRIGHTNESS);
> +}

Is brightness control something that you'd like to export to userspace
using the backlight class perhaps?

> +static int hx8369a_dsi_prepare(struct drm_panel *panel)
> +{
> +	struct hx8369a *ctx = panel_to_hx8369a(panel);
> +
> +	return hx8369a_dsi_set_sequence(ctx);
> +}

Why the indirection? Can't you just expand this function here? It isn't
called anywhere else, so you gain nothing by putting it into a separate
function.

> +static int hx8369a_power_on(struct hx8369a *ctx)
> +{
> +	int ret;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> +	if (ret < 0)
> +		return ret;
> +
> +	msleep(ctx->pd->power_on_delay);
> +
> +	gpiod_set_value(ctx->reset_gpio, 1);
> +	usleep_range(50, 60);
> +	gpiod_set_value(ctx->reset_gpio, 0);

Perhaps use gpiod_set_value_cansleep() to make this work with I2C GPIO
expanders as well? You're sleeping in this function already, so it
shouldn't be called from interrupt context anyway.

> +static void hx8369a_vm_to_res_sel(struct hx8369a *ctx)
> +{
> +	const struct drm_display_mode *mode = ctx->pd->mode;
> +
> +	switch (mode->hdisplay) {
> +	case 480:
> +		switch (mode->vdisplay) {
> +		case 864:
> +			ctx->res_sel = HX8369A_RES_480_864;
> +			break;
> +		case 854:
> +			ctx->res_sel = HX8369A_RES_480_854;
> +			break;
> +		case 800:
> +			ctx->res_sel = HX8369A_RES_480_800;
> +			break;
> +		case 640:
> +			ctx->res_sel = HX8369A_RES_480_640;
> +			break;
> +		case 720:
> +			ctx->res_sel = HX8369A_RES_480_720;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	case 360:
> +		if (mode->vdisplay == 640)
> +			ctx->res_sel = HX8369A_RES_360_640;
> +		break;
> +	default:
> +		break;
> +	}
> +}

Why not make this return an integer and remove the need for the res_sel
field? Also, perhaps you'll want to error-check to make sure somebody
isn't passing in an unsupported mode?

> +static int hx8369a_dsi_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev = &dsi->dev;
> +	const struct of_device_id *of_id =
> +			of_match_device(hx8369a_dsi_of_match, dev);
> +	struct hx8369a *ctx;
> +	int ret, i;

i should be unsigned.

> +
> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ctx->dev = dev;
> +
> +	if (of_id) {
> +		ctx->pd = of_id->data;
> +	} else {
> +		dev_err(dev, "cannot find compatible device\n");
> +		return -ENODEV;
> +	}

You should move this check up, before the allocation so that you can
avoid it if not needed. Then again, I don't see a case where of_id would
actually be NULL, so you might as well just skip the check. If somebody
really added an entry with NULL data, they'll realize their mistake soon
enough.

> +	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(ctx->reset_gpio)) {
> +		dev_info(dev, "cannot get reset-gpios %ld\n",
> +			 PTR_ERR(ctx->reset_gpio));

This should be dev_err(). Also the message is confusing because it could
produce something like:

	"cannot get reset-gpios -517"

and it isn't immediately obvious if -517 is a bogus GPIO number or an
error code. A better error message would be, in my opinion:

	"cannot get reset GPIO: %ld\n"

> +	for (i = 0; i < 4; i++) {
> +		ctx->bs_gpio[i] = devm_gpiod_get_index_optional(dev, "bs", i,
> +								GPIOD_OUT_HIGH);
> +		if (!IS_ERR_OR_NULL(ctx->bs_gpio[i])) {
> +			dev_dbg(dev, "bs%d-gpio is configured\n", i);
> +		} else if (IS_ERR(ctx->bs_gpio[i])) {
> +			dev_info(dev, "failed to get bs%d-gpio\n", i);

Should be dev_err() here, too. Also the names are somewhat confusing
because they refer to a non-existing DT property. Perhaps it'd be better
to name them after what the datasheet has. If the datasheet names them
BS[0..3] for example, maybe make the error message:

	dev_err(dev, "failed to get BS[%u] GPIO: %ld\n", i,
		PTR_ERR(ctx->bs_gpio[i]));

> +			return PTR_ERR(ctx->bs_gpio[i]);
> +		}
> +	}

You don't seem to be using these GPIOs either. I understand that you're
only supporting a single mode, but maybe it'd be better to check that
the chip is properly connected by matching the BS to the MIPI DSI video
mode enum value.

> +	ret = hx8369a_power_on(ctx);
> +	if (ret < 0) {
> +		dev_err(dev, "cannot power on\n");
> +		return ret;
> +	}

Why power on here? Can't you postpone that until the panel is actually
used (for example in ->prepare())?

> +static struct mipi_dsi_driver hx8369a_dsi_driver = {
> +	.probe = hx8369a_dsi_probe,
> +	.remove = hx8369a_dsi_remove,
> +	.driver = {
> +		.name = "panel-hx8369a-dsi",

Are there variants of hx8369a that don't use DSI as their control
interface? If not, I'd simply omit the -dsi suffix.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150409/1e4cd885/attachment.sig>
