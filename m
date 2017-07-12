From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 12 Jul 2017 16:52:03 +0200
Subject: [PATCH v3 2/3] drm/panel: Add support for s6e63j0x03 panel driver
In-Reply-To: <5e374a8b-1ec4-4cb8-3020-993dd749100e@samsung.com>
References: <1498529470-20652-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170627021124epcas5p12ef8d03c85405ceb35d75c6d4eea6b01@epcas5p1.samsung.com>
 <1498529470-20652-3-git-send-email-hoegeun.kwon@samsung.com>
 <5e374a8b-1ec4-4cb8-3020-993dd749100e@samsung.com>
Message-ID: <a1f370eb-0c09-aa9c-e63d-bb24cbc36a71@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.07.2017 15:25, Andrzej Hajda wrote:
> On 27.06.2017 04:11, Hoegeun Kwon wrote:
>> This patch adds MIPI-DSI based S6E63J0X03 AMOLED LCD panel driver
>> which uses mipi_dsi bus to communicate with panel. The panel has
>> 320?320 resolution in 1.63" physical panel. This panel is used in
>> Samsung Galaxy Gear 2.
>>
>> Signed-off-by: Inki Dae <inki.dae@samsung.com>
>> Signed-off-by: Hyungwon Hwang <human.hwang@samsung.com>
>> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
>> ---
>>  drivers/gpu/drm/panel/Kconfig                    |   7 +
>>  drivers/gpu/drm/panel/Makefile                   |   1 +
>>  drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c | 540 +++++++++++++++++++++++
>>  3 files changed, 548 insertions(+)
>>  create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
>>
>> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
>> index 3e29a99..3f4afde 100644
>> --- a/drivers/gpu/drm/panel/Kconfig
>> +++ b/drivers/gpu/drm/panel/Kconfig
>> @@ -68,6 +68,13 @@ config DRM_PANEL_SAMSUNG_S6E3HA2
>>  	depends on DRM_MIPI_DSI
>>  	select VIDEOMODE_HELPERS
>>  
>> +config DRM_PANEL_SAMSUNG_S6E63J0X03
>> +	tristate "Samsung S6E63J0X03 DSI command mode panel"
>> +	depends on OF
>> +	depends on DRM_MIPI_DSI
>> +	depends on BACKLIGHT_CLASS_DEVICE
>> +	select VIDEOMODE_HELPERS
>> +
>>  config DRM_PANEL_SAMSUNG_S6E8AA0
>>  	tristate "Samsung S6E8AA0 DSI video mode panel"
>>  	depends on OF
>> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
>> index 292b3c7..f028269 100644
>> --- a/drivers/gpu/drm/panel/Makefile
>> +++ b/drivers/gpu/drm/panel/Makefile
>> @@ -5,6 +5,7 @@ obj-$(CONFIG_DRM_PANEL_LG_LG4573) += panel-lg-lg4573.o
>>  obj-$(CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00) += panel-panasonic-vvx10f034n00.o
>>  obj-$(CONFIG_DRM_PANEL_SAMSUNG_LD9040) += panel-samsung-ld9040.o
>>  obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2) += panel-samsung-s6e3ha2.o
>> +obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03) += panel-samsung-s6e63j0x03.o
>>  obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0) += panel-samsung-s6e8aa0.o
>>  obj-$(CONFIG_DRM_PANEL_SHARP_LQ101R1SX01) += panel-sharp-lq101r1sx01.o
>>  obj-$(CONFIG_DRM_PANEL_SHARP_LS043T1LE01) += panel-sharp-ls043t1le01.o
>> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c b/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
>> new file mode 100644
>> index 0000000..c3d1b5d
>> --- /dev/null
>> +++ b/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
>> @@ -0,0 +1,540 @@
>> +/*
>> + * MIPI-DSI based S6E63J0X03 AMOLED lcd 1.63 inch panel driver.
>> + *
>> + * Copyright (c) 2014-2017 Samsung Electronics Co., Ltd
>> + *
>> + * Inki Dae <inki.dae@samsung.com>
>> + * Hoegeun Kwon <hoegeun.kwon@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <drm/drmP.h>
>> +#include <drm/drm_mipi_dsi.h>
>> +#include <drm/drm_panel.h>
>> +#include <linux/backlight.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <video/mipi_display.h>
>> +
>> +#define MCS_LEVEL2_KEY		0xf0
>> +#define MCS_MTP_KEY		0xf1
>> +#define MCS_MTP_SET3		0xd4
>> +
>> +#define MAX_BRIGHTNESS		100
>> +#define DEFAULT_BRIGHTNESS	80
>> +
>> +#define NUM_GAMMA_STEPS		9
>> +#define GAMMA_CMD_CNT		28
>> +
>> +#define FIRST_COLUMN 20
>> +
>> +struct s6e63j0x03 {
>> +	struct device *dev;
>> +	struct drm_panel panel;
>> +	struct backlight_device *bl_dev;
>> +
>> +	struct regulator_bulk_data supplies[2];
>> +	struct gpio_desc *reset_gpio;
>> +};
>> +
>> +static const struct drm_display_mode default_mode = {
>> +	.clock = 4649,
>> +	.hdisplay = 320,
>> +	.hsync_start = 320 + 1,
>> +	.hsync_end = 320 + 1 + 1,
>> +	.htotal = 320 + 1 + 1 + 1,
>> +	.vdisplay = 320,
>> +	.vsync_start = 320 + 150,
>> +	.vsync_end = 320 + 150 + 1,
>> +	.vtotal = 320 + 150 + 1 + 2,
>> +	.vrefresh = 30,
>> +	.flags = 0,
>> +};
>> +
>> +static const unsigned char gamma_tbl[NUM_GAMMA_STEPS][GAMMA_CMD_CNT] = {
>> +	{	/* Gamma 10 */
>> +		MCS_MTP_SET3,
>> +		0x00, 0x00, 0x00, 0x7f, 0x7f, 0x7f, 0x52, 0x6b, 0x6f, 0x26,
>> +		0x28, 0x2d, 0x28, 0x26, 0x27, 0x33, 0x34, 0x32, 0x36, 0x36,
>> +		0x35, 0x00, 0xab, 0x00, 0xae, 0x00, 0xbf
>> +	},
>> +	{	/* gamma 30 */
>> +		MCS_MTP_SET3,
>> +		0x00, 0x00, 0x00, 0x70, 0x7f, 0x7f, 0x4e, 0x64, 0x69, 0x26,
>> +		0x27, 0x2a, 0x28, 0x29, 0x27, 0x31, 0x32, 0x31, 0x35, 0x34,
>> +		0x35, 0x00, 0xc4, 0x00, 0xca, 0x00, 0xdc
>> +	},
>> +	{	/* gamma 60 */
>> +		MCS_MTP_SET3,
>> +		0x00, 0x00, 0x00, 0x65, 0x7b, 0x7d, 0x5f, 0x67, 0x68, 0x2a,
>> +		0x28, 0x29, 0x28, 0x2a, 0x27, 0x31, 0x2f, 0x30, 0x34, 0x33,
>> +		0x34, 0x00, 0xd9, 0x00, 0xe4, 0x00, 0xf5
>> +	},
>> +	{	/* gamma 90 */
>> +		MCS_MTP_SET3,
>> +		0x00, 0x00, 0x00, 0x4d, 0x6f, 0x71, 0x67, 0x6a, 0x6c, 0x29,
>> +		0x28, 0x28, 0x28, 0x29, 0x27, 0x30, 0x2e, 0x30, 0x32, 0x31,
>> +		0x31, 0x00, 0xea, 0x00, 0xf6, 0x01, 0x09
>> +	},
>> +	{	/* gamma 120 */
>> +		MCS_MTP_SET3,
>> +		0x00, 0x00, 0x00, 0x3d, 0x66, 0x68, 0x69, 0x69, 0x69, 0x28,
>> +		0x28, 0x27, 0x28, 0x28, 0x27, 0x30, 0x2e, 0x2f, 0x31, 0x31,
>> +		0x30, 0x00, 0xf9, 0x01, 0x05, 0x01, 0x1b
>> +	},
>> +	{	/* gamma 150 */
>> +		MCS_MTP_SET3,
>> +		0x00, 0x00, 0x00, 0x31, 0x51, 0x53, 0x66, 0x66, 0x67, 0x28,
>> +		0x29, 0x27, 0x28, 0x27, 0x27, 0x2e, 0x2d, 0x2e, 0x31, 0x31,
>> +		0x30, 0x01, 0x04, 0x01, 0x11, 0x01, 0x29
>> +	},
>> +	{	/* gamma 200 */
>> +		MCS_MTP_SET3,
>> +		0x00, 0x00, 0x00, 0x2f, 0x4f, 0x51, 0x67, 0x65, 0x65, 0x29,
>> +		0x2a, 0x28, 0x27, 0x25, 0x26, 0x2d, 0x2c, 0x2c, 0x30, 0x30,
>> +		0x30, 0x01, 0x14, 0x01, 0x23, 0x01, 0x3b
>> +	},
>> +	{	/* gamma 240 */
>> +		MCS_MTP_SET3,
>> +		0x00, 0x00, 0x00, 0x2c, 0x4d, 0x50, 0x65, 0x63, 0x64, 0x2a,
>> +		0x2c, 0x29, 0x26, 0x24, 0x25, 0x2c, 0x2b, 0x2b, 0x30, 0x30,
>> +		0x30, 0x01, 0x1e, 0x01, 0x2f, 0x01, 0x47
>> +	},
>> +	{	/* gamma 300 */
>> +		MCS_MTP_SET3,
>> +		0x00, 0x00, 0x00, 0x38, 0x61, 0x64, 0x65, 0x63, 0x64, 0x28,
>> +		0x2a, 0x27, 0x26, 0x23, 0x25, 0x2b, 0x2b, 0x2a, 0x30, 0x2f,
>> +		0x30, 0x01, 0x2d, 0x01, 0x3f, 0x01, 0x57
>> +	}
>> +};
>> +
>> +static inline struct s6e63j0x03 *panel_to_s6e63j0x03(struct drm_panel *panel)
>> +{
>> +	return container_of(panel, struct s6e63j0x03, panel);
>> +}
>> +
>> +static inline ssize_t s6e63j0x03_dcs_write_seq(struct s6e63j0x03 *ctx,
>> +					const void *seq, size_t len)
>> +{
>> +	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
>> +
>> +	return mipi_dsi_dcs_write_buffer(dsi, seq, len);
>> +}
>> +
>> +#define s6e63j0x03_dcs_write_seq_static(ret, ctx, seq...)		\
>> +	do {								\
>> +		static const u8 d[] = { seq };				\
>> +		ret = s6e63j0x03_dcs_write_seq(ctx, d, ARRAY_SIZE(d));	\
>> +	} while (0)
> I think better would be to use statement expression here [1]:
> #define s6e63j0x03_dcs_write_seq_static(ctx, seq...) \
> ({ \
>     static const u8 d[] = { seq }; \
>     s6e63j0x03_dcs_write_seq(ctx, d, ARRAY_SIZE(d)); \
> })
>
> This way instead of passing ret by reference you can use return value.
>
> [1]: https://gcc.gnu.org/onlinedocs/gcc/Statement-Exprs.html
>
>> +
>> +static inline int s6e63j0x03_enable_lv2_command(struct s6e63j0x03 *ctx)
>> +{
>> +	int ret;
>> +
>> +	s6e63j0x03_dcs_write_seq_static(ret, ctx, MCS_LEVEL2_KEY, 0x5a, 0x5a);
>> +	return ret;
>> +}
> With the construct above this function can be simplified to:
>
> +static inline int s6e63j0x03_enable_lv2_command(struct s6e63j0x03 *ctx)
> +{
> +	s6e63j0x03_dcs_write_seq_static(ctx, MCS_LEVEL2_KEY, 0x5a, 0x5a);

Ups, should be:
    return s6e63j0x03_dcs_write_seq_static(ctx, MCS_LEVEL2_KEY, 0x5a, 0x5a);

Regards
Andrzej

> +}
>
>
