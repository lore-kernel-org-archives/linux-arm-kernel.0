From: a.hajda@samsung.com (Andrzej Hajda)
Date: Mon, 12 Jun 2017 15:16:21 +0200
Subject: [PATCH 2/3] drm/panel: Add support for s6e63j0x03 panel driver
In-Reply-To: <1496984354-5271-3-git-send-email-hoegeun.kwon@samsung.com>
References: <1496984354-5271-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170609045938epcas5p216c0ff705d60a32ee57ecb55de9233b5@epcas5p2.samsung.com>
 <1496984354-5271-3-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <04f1d0f1-0010-d21a-1d02-e4e5f9440e56@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hoegeun,

Nice to see patches completing support for mainlined platforms.

On 09.06.2017 06:59, Hoegeun Kwon wrote:
> This patch adds MIPI-DSI based S6E63J0X03 AMOLED LCD panel driver
> which uses mipi_dsi bus to communicate with panel. The panel has
> 320?320 resolution in 1.63" physical panel. This panel is used in
> Samsung Galaxy Gear 2.
>
> Signed-off-by: Inki Dae <inki.dae@samsung.com>
> Signed-off-by: Hyungwon Hwang <human.hwang@samsung.com>
> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> ---
>  drivers/gpu/drm/panel/Kconfig                    |   7 +
>  drivers/gpu/drm/panel/Makefile                   |   1 +
>  drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c | 491 +++++++++++++++++++++++
>  3 files changed, 499 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
>
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 3e29a99..e47e56d 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -68,6 +68,13 @@ config DRM_PANEL_SAMSUNG_S6E3HA2
>  	depends on DRM_MIPI_DSI
>  	select VIDEOMODE_HELPERS
>  
> +config DRM_PANEL_SAMSUNG_S6E63J0X03
> +	tristate "Samsung S6E63J0X03 DSI video mode panel"

I suspect it is command mode panel, isn't?

> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	select VIDEOMODE_HELPERS
> +
>  config DRM_PANEL_SAMSUNG_S6E8AA0
>  	tristate "Samsung S6E8AA0 DSI video mode panel"
>  	depends on OF
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index 292b3c7..f028269 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -5,6 +5,7 @@ obj-$(CONFIG_DRM_PANEL_LG_LG4573) += panel-lg-lg4573.o
>  obj-$(CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00) += panel-panasonic-vvx10f034n00.o
>  obj-$(CONFIG_DRM_PANEL_SAMSUNG_LD9040) += panel-samsung-ld9040.o
>  obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2) += panel-samsung-s6e3ha2.o
> +obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03) += panel-samsung-s6e63j0x03.o
>  obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0) += panel-samsung-s6e8aa0.o
>  obj-$(CONFIG_DRM_PANEL_SHARP_LQ101R1SX01) += panel-sharp-lq101r1sx01.o
>  obj-$(CONFIG_DRM_PANEL_SHARP_LS043T1LE01) += panel-sharp-ls043t1le01.o
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c b/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
> new file mode 100644
> index 0000000..bf70a20
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
> @@ -0,0 +1,491 @@
> +/*
> + * MIPI-DSI based S6E63J0X03 AMOLED lcd 1.63 inch panel driver.
> + *
> + * Copyright (c) 2014 Samsung Electronics Co., Ltd

Maybe range 2014-2017 would be better.

> + *
> + * Inki Dae, <inki.dae@samsung.com>
> + * Hoegeun Kwon, <hoegeun.kwon@samsung.com>

No comma after name.

> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <drm/drmP.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_panel.h>
> +#include <linux/backlight.h>
> +#include <linux/gpio.h>

Probably linux/gpio/consumer.h should be used here.

> +#include <linux/regulator/consumer.h>
> +#include <video/mipi_display.h>
> +
> +#define MCS_LEVEL2_KEY		0xf0
> +#define MCS_MTP_KEY		0xf1
> +#define MCS_MTP_SET3		0xd4
> +
> +#define MIN_BRIGHTNESS		0
> +#define MAX_BRIGHTNESS		100
> +#define DEFAULT_BRIGHTNESS	80
> +
> +#define NUM_GAMMA_STEPS		9
> +#define GAMMA_CMD_CNT		28
> +
> +struct s6e63j0x03 {
> +	struct device *dev;
> +	struct drm_panel panel;
> +	struct backlight_device *bl_dev;
> +
> +	struct regulator_bulk_data supplies[2];
> +	struct gpio_desc *reset_gpio;
> +};
> +
> +static const unsigned char gamma_tbl[NUM_GAMMA_STEPS][GAMMA_CMD_CNT] = {
> +	{	/* Gamma 10 */
> +		MCS_MTP_SET3,
> +		0x00, 0x00, 0x00, 0x7f, 0x7f, 0x7f, 0x52, 0x6b, 0x6f, 0x26,
> +		0x28, 0x2d, 0x28, 0x26, 0x27, 0x33, 0x34, 0x32, 0x36, 0x36,
> +		0x35, 0x00, 0xab, 0x00, 0xae, 0x00, 0xbf
> +	},
> +	{	/* gamma 30 */
> +		MCS_MTP_SET3,
> +		0x00, 0x00, 0x00, 0x70, 0x7f, 0x7f, 0x4e, 0x64, 0x69, 0x26,
> +		0x27, 0x2a, 0x28, 0x29, 0x27, 0x31, 0x32, 0x31, 0x35, 0x34,
> +		0x35, 0x00, 0xc4, 0x00, 0xca, 0x00, 0xdc
> +	},
> +	{	/* gamma 60 */
> +		MCS_MTP_SET3,
> +		0x00, 0x00, 0x00, 0x65, 0x7b, 0x7d, 0x5f, 0x67, 0x68, 0x2a,
> +		0x28, 0x29, 0x28, 0x2a, 0x27, 0x31, 0x2f, 0x30, 0x34, 0x33,
> +		0x34, 0x00, 0xd9, 0x00, 0xe4, 0x00, 0xf5
> +	},
> +	{	/* gamma 90 */
> +		MCS_MTP_SET3,
> +		0x00, 0x00, 0x00, 0x4d, 0x6f, 0x71, 0x67, 0x6a, 0x6c, 0x29,
> +		0x28, 0x28, 0x28, 0x29, 0x27, 0x30, 0x2e, 0x30, 0x32, 0x31,
> +		0x31, 0x00, 0xea, 0x00, 0xf6, 0x01, 0x09
> +	},
> +	{	/* gamma 120 */
> +		MCS_MTP_SET3,
> +		0x00, 0x00, 0x00, 0x3d, 0x66, 0x68, 0x69, 0x69, 0x69, 0x28,
> +		0x28, 0x27, 0x28, 0x28, 0x27, 0x30, 0x2e, 0x2f, 0x31, 0x31,
> +		0x30, 0x00, 0xf9, 0x01, 0x05, 0x01, 0x1b
> +	},
> +	{	/* gamma 150 */
> +		MCS_MTP_SET3,
> +		0x00, 0x00, 0x00, 0x31, 0x51, 0x53, 0x66, 0x66, 0x67, 0x28,
> +		0x29, 0x27, 0x28, 0x27, 0x27, 0x2e, 0x2d, 0x2e, 0x31, 0x31,
> +		0x30, 0x01, 0x04, 0x01, 0x11, 0x01, 0x29
> +	},
> +	{	/* gamma 200 */
> +		MCS_MTP_SET3,
> +		0x00, 0x00, 0x00, 0x2f, 0x4f, 0x51, 0x67, 0x65, 0x65, 0x29,
> +		0x2a, 0x28, 0x27, 0x25, 0x26, 0x2d, 0x2c, 0x2c, 0x30, 0x30,
> +		0x30, 0x01, 0x14, 0x01, 0x23, 0x01, 0x3b
> +	},
> +	{	/* gamma 240 */
> +		MCS_MTP_SET3,
> +		0x00, 0x00, 0x00, 0x2c, 0x4d, 0x50, 0x65, 0x63, 0x64, 0x2a,
> +		0x2c, 0x29, 0x26, 0x24, 0x25, 0x2c, 0x2b, 0x2b, 0x30, 0x30,
> +		0x30, 0x01, 0x1e, 0x01, 0x2f, 0x01, 0x47
> +	},
> +	{	/* gamma 300 */
> +		MCS_MTP_SET3,
> +		0x00, 0x00, 0x00, 0x38, 0x61, 0x64, 0x65, 0x63, 0x64, 0x28,
> +		0x2a, 0x27, 0x26, 0x23, 0x25, 0x2b, 0x2b, 0x2a, 0x30, 0x2f,
> +		0x30, 0x01, 0x2d, 0x01, 0x3f, 0x01, 0x57
> +	}
> +};
> +
> +static const unsigned char prepare_cmds1[][15] = {
> +	{ 3, 0xf2, 0x1c, 0x28 },		/* porch_adjustment */
> +	{ 4, 0xb5, 0x00, 0x02, 0x00 },		/* frame_freq */
> +	{ 5, 0x2a, 0x00, 0x14, 0x01, 0x53 },	/* mem_addr_set_0 */
> +	{ 5, 0x2b, 0x00, 0x00, 0x01, 0x3f },	/* mem_addr_set_1 */
Two commands above are realized by mipi_dsi_dcs_set_column_address and
mipi_dsi_dcs_set_page_address helpers.
> +	{ 14, 0xf8, 0x08, 0x08, 0x08, 0x17,	/* ltps_timming_set_0_60hz */
> +	      0x00, 0x2a, 0x02, 0x26,
> +	      0x00, 0x00, 0x02, 0x00, 0x00 },
> +	{ 2, 0xf7, 0x02 },			/* ltps_timming_set_1 */
> +	{ 2, 0xb0, 0x01 },			/* param_pos_te_edge */
> +	{ 2, 0xe2, 0x0f },			/* te_rising_edge */
> +	{ 2, 0xb0, 0x00 },			/* param_pos_default */
> +	{ 1, MIPI_DCS_EXIT_SLEEP_MODE },

mipi_dsi_dcs_exit_sleep_mode, I am not a big fan of these helpers, but
at least the code will be consistent with current drm_panel drivers.

> +};
> +
> +static const  unsigned char prepare_cmds2[][4] = {
> +	{ 3, 0xb1, 0x00, 0x09 },	/* elvss_cond */
> +	{ 2, 0x36, 0x40 },		/* set_pos */

It is standard DCS command:

    MIPI_DCS_SET_ADDRESS_MODE    = 0x36,
> +	{ 2, 0x51, 0xff },		/* white_brightness_default */
> +	{ 2, 0x53, 0x20 },		/* white_ctrl */
> +	{ 2, 0x55, 0x00 },		/* acl_off */
    MIPI_DCS_SET_DISPLAY_BRIGHTNESS = 0x51,        /* MIPI DCS 1.3 */
    MIPI_DCS_WRITE_CONTROL_DISPLAY  = 0x53,        /* MIPI DCS 1.3 */
    MIPI_DCS_WRITE_POWER_SAVE    = 0x55,        /* MIPI DCS 1.3 */

> +	{ 1, MIPI_DCS_SET_TEAR_ON },

mipi_dsi_dcs_set_tear_on

> +};
> +


I think it would be probably better to remove prepare_cmds[12] arrays
and code commands directly,
maybe with some helper allowing variable number of parameters for DCS
command, it has chances to be accepted[1].

[1]: http://marc.info/?l=dri-devel&m=148637093704184&w=2

> +
> +static inline struct s6e63j0x03 *panel_to_s6e63j0x03(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct s6e63j0x03, panel);
> +}
> +
> +static inline ssize_t s6e63j0x03_dcs_write_seq(struct s6e63j0x03 *ctx,
> +					const void *seq, size_t len)
> +{
> +	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
> +
> +	return mipi_dsi_dcs_write_buffer(dsi, seq, len);
> +}
> +
> +static inline int s6e63j0x03_enable_lv2_command(struct s6e63j0x03 *ctx)
> +{
> +	unsigned char seq[] = { MCS_LEVEL2_KEY, 0x5a, 0x5a };
> +
> +	return s6e63j0x03_dcs_write_seq(ctx, seq, ARRAY_SIZE(seq));
> +}
> +
> +static inline int s6e63j0x03_apply_mtp_key(struct s6e63j0x03 *ctx, bool on)
> +{
> +	unsigned char seq1[3] = { MCS_MTP_KEY, 0x5a, 0x5a };
> +	unsigned char seq2[3] = { MCS_MTP_KEY, 0xa5, 0xa5 };
> +
> +	return s6e63j0x03_dcs_write_seq(ctx, on ? seq1 : seq2,
> +					ARRAY_SIZE(seq1));
> +}
> +
> +static int s6e63j0x03_power_on(struct s6e63j0x03 *ctx)
> +{
> +	int ret;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> +	if (ret < 0)
> +		return ret;
> +
> +	msleep(30);
> +
> +	gpiod_set_value(ctx->reset_gpio, 0);
> +	usleep_range(1000, 2000);
> +	gpiod_set_value(ctx->reset_gpio, 1);
> +	usleep_range(5000, 6000);
> +
> +	return 0;
> +}
> +
> +static int s6e63j0x03_power_off(struct s6e63j0x03 *ctx)
> +{
> +	int ret;
> +
> +	gpiod_set_value(ctx->reset_gpio, 0);
> +
> +	ret = regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int s6e63j0x03_get_brightness(struct backlight_device *bl_dev)
> +{
> +	return bl_dev->props.brightness;
> +}

This callback can be omitted.

> +
> +static unsigned int s6e63j0x03_get_brightness_index(unsigned int brightness)
> +{
> +	unsigned int index;
> +
> +	index = brightness / (MAX_BRIGHTNESS / NUM_GAMMA_STEPS);
> +
> +	if (index >= NUM_GAMMA_STEPS)
> +		index = NUM_GAMMA_STEPS - 1;
> +
> +	return index;
> +}
> +
> +static int s6e63j0x03_update_gamma(struct s6e63j0x03 *ctx,
> +					unsigned int brightness)
> +{
> +	struct backlight_device *bl_dev = ctx->bl_dev;
> +	unsigned int index = s6e63j0x03_get_brightness_index(brightness);
> +	int ret;
> +
> +	ret = s6e63j0x03_apply_mtp_key(ctx, true);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = s6e63j0x03_dcs_write_seq(ctx, gamma_tbl[index], GAMMA_CMD_CNT);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = s6e63j0x03_apply_mtp_key(ctx, false);
> +	if (ret < 0)
> +		return ret;
> +
> +	bl_dev->props.brightness = brightness;
> +
> +	return 0;
> +}
> +
> +static int s6e63j0x03_set_brightness(struct backlight_device *bl_dev)
> +{
> +	struct s6e63j0x03 *ctx = (struct s6e63j0x03 *)bl_get_data(bl_dev);
> +	unsigned int brightness = bl_dev->props.brightness;
> +	int ret;
> +
> +	if (brightness < MIN_BRIGHTNESS ||
> +		brightness > bl_dev->props.max_brightness) {
> +		dev_err(ctx->dev, "Invalid brightness: %u\n", brightness);
> +		return -EINVAL;
> +	}

Range check is performed already by the framework, so it can be removed.

> +
> +	if (bl_dev->props.power > FB_BLANK_NORMAL)
> +		return -EPERM;

I guess this is unnecessary as almost nobody checks error code returned
by backlight_update_status.
I suspect the function is missing props.power handling but the whole
backlight framework is not clear for me :)

> +
> +	ret = s6e63j0x03_update_gamma(ctx, brightness);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static const struct backlight_ops s6e63j0x03_bl_ops = {
> +	.get_brightness = s6e63j0x03_get_brightness,
> +	.update_status = s6e63j0x03_set_brightness,
> +};
> +
> +static int s6e63j0x03_disable(struct drm_panel *panel)
> +{
> +	struct s6e63j0x03 *ctx = panel_to_s6e63j0x03(panel);
> +	struct backlight_device *bl_dev = ctx->bl_dev;
> +	u8 seq[] = { MIPI_DCS_SET_DISPLAY_OFF };
> +	int ret;
> +
> +	ret = s6e63j0x03_dcs_write_seq(ctx, seq, ARRAY_SIZE(seq));

 Use mipi_dsi_dcs_set_display_off instead.

> +	if (ret > 0)
> +		bl_dev->props.power = FB_BLANK_NORMAL;
> +
> +	return 0;
> +}
> +
> +static int s6e63j0x03_unprepare(struct drm_panel *panel)
> +{
> +	struct s6e63j0x03 *ctx = panel_to_s6e63j0x03(panel);
> +	struct backlight_device *bl_dev = ctx->bl_dev;
> +	u8 seq[] = { MIPI_DCS_ENTER_SLEEP_MODE };
> +	int ret;
> +
> +	ret = s6e63j0x03_dcs_write_seq(ctx, seq, ARRAY_SIZE(seq));

mipi_dsi_dcs_enter_sleep_mode

> +	if (ret < 0)
> +		return ret;
> +
> +	msleep(120);
> +
> +	ret = s6e63j0x03_power_off(ctx);
> +	if (ret < 0)
> +		return ret;
> +
> +	bl_dev->props.power = FB_BLANK_POWERDOWN;
> +
> +	return 0;
> +}
> +
> +static int s6e63j0x03_prepare(struct drm_panel *panel)
> +{
> +	struct s6e63j0x03 *ctx = panel_to_s6e63j0x03(panel);
> +	struct backlight_device *bl_dev = ctx->bl_dev;
> +	int ret;
> +	int i;
> +
> +	ret = s6e63j0x03_power_on(ctx);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = s6e63j0x03_enable_lv2_command(ctx);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = s6e63j0x03_apply_mtp_key(ctx, true);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(prepare_cmds1); i++) {
> +		ret = s6e63j0x03_dcs_write_seq(ctx, &prepare_cmds1[i][1],
> +						prepare_cmds1[i][0]);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	msleep(120);
> +
> +	for (i = 0; i < ARRAY_SIZE(prepare_cmds2); i++) {
> +		ret = s6e63j0x03_dcs_write_seq(ctx, &prepare_cmds2[i][1],
> +						prepare_cmds2[i][0]);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = s6e63j0x03_apply_mtp_key(ctx, false);
> +	if (ret < 0)
> +		return ret;
> +
> +	bl_dev->props.power = FB_BLANK_NORMAL;
> +
> +	return 0;
> +}
> +
> +static int s6e63j0x03_enable(struct drm_panel *panel)
> +{
> +	struct s6e63j0x03 *ctx = panel_to_s6e63j0x03(panel);
> +	struct backlight_device *bl_dev = ctx->bl_dev;
> +	u8 seq[] = { MIPI_DCS_SET_DISPLAY_ON };
> +	int ret;
> +
> +	ret = s6e63j0x03_dcs_write_seq(ctx, seq, ARRAY_SIZE(seq));
> +	if (ret > 0)
> +		bl_dev->props.power = FB_BLANK_UNBLANK;
> +
> +	return 0;
> +}

For many (maybe most) panels power on sequence is as follows:
0. Enable power supplies and gpios.
1. Initialization, including MIPI_DCS_EXIT_SLEEP_MODE
2. Wait for 120ms, to avoid display glitches.
3. Unblanking and adjusting display, including MIPI_DCS_SET_DISPLAY_ON.

And power-off:
4. MIPI_DCS_SET_DISPLAY_OFF
5. MIPI_DCS_ENTER_SLEEP_MODE
6. Wait for 120ms
7. Disable power supplies and gpios.

I suppose waiting for 120ms is a good indicator what should be put into
prepare/enable/disable/unprepare phase.
In my opinion it should be as follows:
Prepare: 0, 1
Enable: 2, 3
Disable: 4,5,6
Unprepare: 7

What do you think about it?
Could you arrange the code this way and test if it works correctly?
Maybe you/other developers have some opinions about it?

> +
> +static const struct drm_display_mode default_mode = {
> +	.clock = 4644,
> +	.hdisplay = 320,
> +	.hsync_start = 320 + 1,
> +	.hsync_end = 320 + 1 + 1,
> +	.htotal = 320 + 1 + 1 + 1,
> +	.vdisplay = 320,
> +	.vsync_start = 320 + 150,
> +	.vsync_end = 320 + 150 + 1,
> +	.vtotal = 320 + 150 + 1 + 2,
> +	.vrefresh = 30,
> +	.flags = 0,
> +};

clock should be equal vtotal*htotal*vrefresh, it is little higher? what
is the reason?
What is actual refresh rate?


> +
> +static int s6e63j0x03_get_modes(struct drm_panel *panel)
> +{
> +	struct drm_connector *connector = panel->connector;
> +	struct drm_display_mode *mode;
> +
> +	mode = drm_mode_duplicate(panel->drm, &default_mode);
> +	if (!mode) {
> +		DRM_ERROR("failed to add mode %ux%ux@%u\n",
> +				default_mode.hdisplay, default_mode.vdisplay,
> +				default_mode.vrefresh);
> +		return -ENOMEM;
> +	}
> +
> +	drm_mode_set_name(mode);
> +
> +	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> +	drm_mode_probed_add(connector, mode);
> +
> +	connector->display_info.width_mm = 29;
> +	connector->display_info.height_mm = 29;
> +
> +	return 1;
> +}
> +
> +static const struct drm_panel_funcs s6e63j0x03_funcs = {
> +	.disable = s6e63j0x03_disable,
> +	.unprepare = s6e63j0x03_unprepare,
> +	.prepare = s6e63j0x03_prepare,
> +	.enable = s6e63j0x03_enable,
> +	.get_modes = s6e63j0x03_get_modes,
> +};
> +
> +static int s6e63j0x03_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev = &dsi->dev;
> +	struct s6e63j0x03 *ctx;
> +	int ret;
> +
> +	ctx = devm_kzalloc(dev, sizeof(struct s6e63j0x03), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	mipi_dsi_set_drvdata(dsi, ctx);
> +
> +	ctx->dev = dev;
> +
> +	dsi->lanes = 1;
> +	dsi->format = MIPI_DSI_FMT_RGB888;
> +	dsi->mode_flags = MIPI_DSI_MODE_EOT_PACKET | MIPI_DSI_MODE_VIDEO_BURST;

MIPI_DSI_MODE_VIDEO_BURST flag is only valid with MIPI_DSI_MODE_VIDEO,
ie in video mode.

--
Regards
Andrzej

> +
> +	ctx->supplies[0].supply = "vdd3";
> +	ctx->supplies[1].supply = "vci";
> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies),
> +				      ctx->supplies);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to get regulators: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(ctx->reset_gpio)) {
> +		dev_err(dev, "cannot get reset-gpio: %ld\n",
> +				PTR_ERR(ctx->reset_gpio));
> +		return PTR_ERR(ctx->reset_gpio);
> +	}
> +
> +	drm_panel_init(&ctx->panel);
> +	ctx->panel.dev = dev;
> +	ctx->panel.funcs = &s6e63j0x03_funcs;
> +
> +	ctx->bl_dev = backlight_device_register("s6e63j0x03", dev, ctx,
> +						&s6e63j0x03_bl_ops, NULL);
> +	if (IS_ERR(ctx->bl_dev)) {
> +		dev_err(dev, "failed to register backlight device\n");
> +		return PTR_ERR(ctx->bl_dev);
> +	}
> +
> +	ctx->bl_dev->props.max_brightness = MAX_BRIGHTNESS;
> +	ctx->bl_dev->props.brightness = DEFAULT_BRIGHTNESS;
> +	ctx->bl_dev->props.power = FB_BLANK_POWERDOWN;
> +
> +	ret = drm_panel_add(&ctx->panel);
> +	if (ret < 0)
> +		goto unregister_backlight;
> +
> +	ret = mipi_dsi_attach(dsi);
> +	if (ret < 0)
> +		goto remove_panel;
> +
> +	return ret;
> +
> +remove_panel:
> +	drm_panel_remove(&ctx->panel);
> +
> +unregister_backlight:
> +	backlight_device_unregister(ctx->bl_dev);
> +
> +	return ret;
> +}
> +
> +static int s6e63j0x03_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct s6e63j0x03 *ctx = mipi_dsi_get_drvdata(dsi);
> +
> +	mipi_dsi_detach(dsi);
> +	drm_panel_remove(&ctx->panel);
> +
> +	backlight_device_unregister(ctx->bl_dev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id s6e63j0x03_of_match[] = {
> +	{ .compatible = "samsung,s6e63j0x03" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, s6e63j0x03_of_match);
> +
> +static struct mipi_dsi_driver s6e63j0x03_driver = {
> +	.probe = s6e63j0x03_probe,
> +	.remove = s6e63j0x03_remove,
> +	.driver = {
> +		.name = "panel_samsung_s6e63j0x03",
> +		.of_match_table = s6e63j0x03_of_match,
> +	},
> +};
> +module_mipi_dsi_driver(s6e63j0x03_driver);
> +
> +MODULE_AUTHOR("Inki Dae <inki.dae@samsung.com>");
> +MODULE_AUTHOR("Hoegeun Kwon <hoegeun.kwon@samsung.com>");
> +MODULE_DESCRIPTION("MIPI-DSI based s6e63j0x03 AMOLED LCD Panel Driver");
> +MODULE_LICENSE("GPL v2");
