From: a.hajda@samsung.com (Andrzej Hajda)
Date: Mon, 19 Jun 2017 11:14:40 +0200
Subject: [PATCH v2 2/4] drm/panel: Add support for s6e63j0x03 panel driver
In-Reply-To: <1497521010-8429-3-git-send-email-hoegeun.kwon@samsung.com>
References: <1497521010-8429-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170615100342epcas1p4b15ffce9ea2018e2bc90bb04061aded5@epcas1p4.samsung.com>
 <1497521010-8429-3-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <3b0f0616-b2e2-8dab-af38-f4d0bae696e8@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.06.2017 12:03, Hoegeun Kwon wrote:
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
>  drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c | 476 +++++++++++++++++++++++
>  3 files changed, 484 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
>
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 3e29a99..3f4afde 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -68,6 +68,13 @@ config DRM_PANEL_SAMSUNG_S6E3HA2
>  	depends on DRM_MIPI_DSI
>  	select VIDEOMODE_HELPERS
>  
> +config DRM_PANEL_SAMSUNG_S6E63J0X03
> +	tristate "Samsung S6E63J0X03 DSI command mode panel"
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
> index 0000000..dd038bc
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
> @@ -0,0 +1,476 @@
> +/*
> + * MIPI-DSI based S6E63J0X03 AMOLED lcd 1.63 inch panel driver.
> + *
> + * Copyright (c) 2014-2017 Samsung Electronics Co., Ltd
> + *
> + * Inki Dae <inki.dae@samsung.com>
> + * Hoegeun Kwon <hoegeun.kwon@samsung.com>
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
> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
> +#include <video/mipi_display.h>
> +
> +#define MCS_LEVEL2_KEY		0xf0
> +#define MCS_MTP_KEY		0xf1
> +#define MCS_MTP_SET3		0xd4
> +
> +#define MIN_BRIGHTNESS		0

This macro is not used at all and according to API it must be 0, so it
can be removed.

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
> +#define s6e63j0x03_dcs_write_seq_static(ctx, seq...) do {	\
> +	static const u8 d[] = { seq };				\
> +	int ret;						\
> +	ret = s6e63j0x03_dcs_write_seq(ctx, d, ARRAY_SIZE(d));	\
> +	if (ret < 0)						\
> +		return ret;					\
> +} while (0)
> +
> +#define s6e63j0x03_call_write_func(ret, func) do {	\
> +	ret = (func);					\
> +	if (ret < 0)					\
> +		return ret;				\
> +} while (0)

Both above macros violate kernel coding style: macros that affect
control flow are the 1st thing to avoid, see relevant chapter in the
kernel docs [1].
I know similar macros have been already merged with two latest panel
drivers, so I suspect you have just followed current practice. So this
question
is rather to Thierry, is it the method you want to use to avoid 'if
(ret) return ret' plague? What about explicit violation of kernel coding
style?

[1]:
https://www.kernel.org/doc/html/v4.10/process/coding-style.html#macros-enums-and-rtl

> +
> +static inline int s6e63j0x03_enable_lv2_command(struct s6e63j0x03 *ctx)
> +{
> +	s6e63j0x03_dcs_write_seq_static(ctx, MCS_LEVEL2_KEY, 0x5a, 0x5a);
> +	return 0;
> +}
> +
> +static inline int s6e63j0x03_apply_mtp_key(struct s6e63j0x03 *ctx, bool on)
> +{
> +	if (on)
> +		s6e63j0x03_dcs_write_seq_static(ctx, MCS_MTP_KEY, 0x5a, 0x5a);
> +	else
> +		s6e63j0x03_dcs_write_seq_static(ctx, MCS_MTP_KEY, 0xa5, 0xa5);
> +
> +	return 0;
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
> +	gpiod_set_value(ctx->reset_gpio, 1);
> +	usleep_range(1000, 2000);
> +	gpiod_set_value(ctx->reset_gpio, 0);
> +	usleep_range(5000, 6000);
> +
> +	return 0;
> +}
> +
> +static int s6e63j0x03_power_off(struct s6e63j0x03 *ctx)
> +{
> +	return regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> +}
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
> +	s6e63j0x03_call_write_func(ret, s6e63j0x03_apply_mtp_key(ctx, true));
> +	s6e63j0x03_call_write_func(ret,
> +		s6e63j0x03_dcs_write_seq(ctx, gamma_tbl[index], GAMMA_CMD_CNT));
> +	s6e63j0x03_call_write_func(ret, s6e63j0x03_apply_mtp_key(ctx, false));
> +
> +	bl_dev->props.brightness = brightness;
> +
> +	return 0;
> +}
> +
> +static int s6e63j0x03_set_brightness(struct backlight_device *bl_dev)
> +{
> +	struct s6e63j0x03 *ctx = (struct s6e63j0x03 *)bl_get_data(bl_dev);

Explicit casting can be removed.

> +	unsigned int brightness = bl_dev->props.brightness;
> +	int ret;
> +
> +	s6e63j0x03_call_write_func(ret,
> +		s6e63j0x03_update_gamma(ctx, brightness));
> +
> +	return 0;
> +}
> +
> +static const struct backlight_ops s6e63j0x03_bl_ops = {
> +	.update_status = s6e63j0x03_set_brightness,
> +};
> +
> +static int s6e63j0x03_disable(struct drm_panel *panel)
> +{
> +	struct s6e63j0x03 *ctx = panel_to_s6e63j0x03(panel);
> +	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
> +	int ret;
> +
> +	s6e63j0x03_call_write_func(ret, mipi_dsi_dcs_set_display_off(dsi));
> +	ctx->bl_dev->props.power = FB_BLANK_NORMAL;
> +
> +	s6e63j0x03_call_write_func(ret, mipi_dsi_dcs_enter_sleep_mode(dsi));
> +	msleep(120);
> +
> +	return 0;
> +}
> +
> +static int s6e63j0x03_unprepare(struct drm_panel *panel)
> +{
> +	struct s6e63j0x03 *ctx = panel_to_s6e63j0x03(panel);
> +	int ret;
> +
> +	ret = s6e63j0x03_power_off(ctx);
> +	if (ret < 0)
> +		return ret;
> +
> +	ctx->bl_dev->props.power = FB_BLANK_POWERDOWN;
> +
> +	return 0;
> +}
> +
> +static int s6e63j0x03_panel_init(struct s6e63j0x03 *ctx)
> +{
> +	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
> +	int ret;
> +
> +	s6e63j0x03_call_write_func(ret, s6e63j0x03_enable_lv2_command(ctx));
> +	s6e63j0x03_call_write_func(ret, s6e63j0x03_apply_mtp_key(ctx, true));
> +
> +	/* set porch adjustment */
> +	s6e63j0x03_dcs_write_seq_static(ctx, 0xf2, 0x1c, 0x28);
> +	/* set frame freq */
> +	s6e63j0x03_dcs_write_seq_static(ctx, 0xb5, 0x00, 0x02, 0x00);
> +	/* set caset, paset */
> +	s6e63j0x03_call_write_func(ret,
> +		mipi_dsi_dcs_set_column_address(dsi, 0x0014, 0x0153));
> +	s6e63j0x03_call_write_func(ret,
> +		mipi_dsi_dcs_set_page_address(dsi, 0x0000, 0x013f));

For two calls above arguments are line or column number, you should use
decimals here, sth like below:

    #define FIRST_COLUMN 20
    mipi_dsi_dcs_set_column_address(dsi, FIRST_COLUMN,
default_mode.hdisplay - 1 + FIRST_COLUMN );
    mipi_dsi_dcs_set_page_address(dsi, 0, default_mode.hdisplay - 1);

This way it will be easier to understand what is going on here.

Regards
Andrzej
