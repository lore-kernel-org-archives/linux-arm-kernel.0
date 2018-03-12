From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 12 Mar 2018 08:39:33 +0100
Subject: [PATCH v3 5/7] drm/panel: Add Ilitek ILI9881c panel driver
In-Reply-To: <4ebd47038b1ee1cc6b7d9738313f43f985268463.1520344489.git-series.maxime.ripard@bootlin.com>
References: <cover.14d017af44a2140bea674731b60a0dd7f992f5f6.1520344489.git-series.maxime.ripard@bootlin.com>
 <4ebd47038b1ee1cc6b7d9738313f43f985268463.1520344489.git-series.maxime.ripard@bootlin.com>
Message-ID: <20180312073933.GD23060@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2018 at 02:56:02PM +0100, Maxime Ripard wrote:
> From: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> The LHR050H41 panel is the panel shipped with the BananaPi M2-Magic, and is
> based on the Ilitek ILI9881c Controller. Add a driver for it, modelled
> after the other Ilitek controller drivers.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/gpu/drm/panel/Kconfig                 |   9 +-
>  drivers/gpu/drm/panel/Makefile                |   1 +-
>  drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 506 +++++++++++++++++++-
>  3 files changed, 516 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
[...]
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
[...]
> +static int ili9881c_prepare(struct drm_panel *panel)
> +{
> +	struct ili9881c *ctx = panel_to_ili9881c(panel);
> +	int i, ret;

i can be unsigned.

> +
> +	/* Power the panel */
> +	gpiod_set_value(ctx->power, 1);
> +	mdelay(5);
> +
> +	/* And reset it */
> +	gpiod_set_value(ctx->reset, 1);
> +	mdelay(20);
> +
> +	gpiod_set_value(ctx->reset, 0);
> +	mdelay(20);

5 and 20 milliseconds are much too long to busy loop. Use usleep_range()
and msleep() instead. It's probably fine to use msleep(5) in this case
regardless of the advice in Documentation/timers/timers-howto.txt since
a few milliseconds more aren't going to matter here.

> +
> +	for (i = 0; i < ARRAY_SIZE(ili9881c_init); i++) {
> +		struct ili9881c_instr *instr = &ili9881c_init[i];
> +
> +		if (instr->op == ILI9881C_SWITCH_PAGE)
> +			ret = ili9881c_switch_page(ctx, instr->arg.page);
> +		else if (instr->op == ILI9881C_COMMAND)
> +			ret = ili9881c_send_cmd_data(ctx, instr->arg.cmd.cmd,
> +						      instr->arg.cmd.data);
> +
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = ili9881c_switch_page(ctx, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = mipi_dsi_dcs_set_tear_on(ctx->dsi, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
> +	if (ret)
> +		return ret;
> +
> +	mipi_dsi_dcs_exit_sleep_mode(ctx->dsi);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static void ili9881c_enable_bl(struct ili9881c *ctx, bool enable)
> +{
> +	if (!ctx->backlight)
> +		return;
> +
> +	if (enable) {
> +		ctx->backlight->props.state &= ~BL_CORE_FBBLANK;
> +		ctx->backlight->props.power = FB_BLANK_UNBLANK;
> +	} else {
> +		ctx->backlight->props.power = FB_BLANK_POWERDOWN;
> +		ctx->backlight->props.state |= BL_CORE_FBBLANK;
> +	}
> +
> +	backlight_update_status(ctx->backlight);
> +}

There's a new pair of functions, backlight_enable() and
backlight_disable() that do this now. Please use those. They also work
fine when passed a NULL pointer, so should be perfect to replace this
with.

> +
> +static int ili9881c_enable(struct drm_panel *panel)
> +{
> +	struct ili9881c *ctx = panel_to_ili9881c(panel);
> +
> +	mdelay(120);

Hogging the CPU for 120 milliseconds like this is a really bad idea. Use
msleep() instead.

> +	mipi_dsi_dcs_set_display_on(ctx->dsi);
> +
> +	ili9881c_enable_bl(ctx, true);
> +
> +	return 0;
> +}
> +
> +static int ili9881c_disable(struct drm_panel *panel)
> +{
> +	struct ili9881c *ctx = panel_to_ili9881c(panel);
> +
> +	ili9881c_enable_bl(ctx, false);
> +
> +	return mipi_dsi_dcs_set_display_off(ctx->dsi);
> +}
> +
> +static int ili9881c_unprepare(struct drm_panel *panel)
> +{
> +	struct ili9881c *ctx = panel_to_ili9881c(panel);
> +
> +	mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
> +	gpiod_set_value(ctx->power, 0);
> +	gpiod_set_value(ctx->reset, 1);
> +
> +	return 0;
> +}
> +
> +static const struct drm_display_mode default_mode = {
> +	.clock		= 62000,
> +	.vrefresh	= 60,
> +
> +	.hdisplay	= 720,
> +	.hsync_start	= 720 + 10,
> +	.hsync_end	= 720 + 10 + 20,
> +	.htotal		= 720 + 10 + 20 + 30,
> +
> +	.vdisplay	= 1280,
> +	.vsync_start	= 1280 + 10,
> +	.vsync_end	= 1280 + 10 + 10,
> +	.vtotal		= 1280 + 10 + 10 + 20,
> +};

You may want to consider using struct display_timing instead, since that
will allow the driver to be used on a broader range of devices.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180312/5519d059/attachment-0001.sig>
