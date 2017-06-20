From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Tue, 20 Jun 2017 13:36:35 +0900
Subject: [PATCH v2 2/4] drm/panel: Add support for s6e63j0x03 panel driver
In-Reply-To: <3b0f0616-b2e2-8dab-af38-f4d0bae696e8@samsung.com>
References: <1497521010-8429-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170615100342epcas1p4b15ffce9ea2018e2bc90bb04061aded5@epcas1p4.samsung.com>
 <1497521010-8429-3-git-send-email-hoegeun.kwon@samsung.com>
 <3b0f0616-b2e2-8dab-af38-f4d0bae696e8@samsung.com>
Message-ID: <71394f7a-d826-8468-fbb1-e3db0ea11e1c@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/19/2017 06:14 PM, Andrzej Hajda wrote:

> On 15.06.2017 12:03, Hoegeun Kwon wrote:
>> This patch adds MIPI-DSI based S6E63J0X03 AMOLED LCD panel driver
>> which uses mipi_dsi bus to communicate with panel. The panel has
>> 320?320 resolution in 1.63" physical panel. This panel is used in
>> Samsung Galaxy Gear 2.
>>
>> Signed-off-by: Inki Dae <inki.dae@samsung.com>
>> Signed-off-by: Hyungwon Hwang <human.hwang@samsung.com>
>> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
>> ---
>>   drivers/gpu/drm/panel/Kconfig                    |   7 +
>>   drivers/gpu/drm/panel/Makefile                   |   1 +
>>   drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c | 476 +++++++++++++++++++++++
>>   3 files changed, 484 insertions(+)
>>   create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
>>
>> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
>> index 3e29a99..3f4afde 100644
>> --- a/drivers/gpu/drm/panel/Kconfig
>> +++ b/drivers/gpu/drm/panel/Kconfig
>> @@ -68,6 +68,13 @@ config DRM_PANEL_SAMSUNG_S6E3HA2
>>   	depends on DRM_MIPI_DSI
>>   	select VIDEOMODE_HELPERS
>>   
>> +config DRM_PANEL_SAMSUNG_S6E63J0X03
>> +	tristate "Samsung S6E63J0X03 DSI command mode panel"
>> +	depends on OF
>> +	depends on DRM_MIPI_DSI
>> +	depends on BACKLIGHT_CLASS_DEVICE
>> +	select VIDEOMODE_HELPERS
>> +
>>   config DRM_PANEL_SAMSUNG_S6E8AA0
>>   	tristate "Samsung S6E8AA0 DSI video mode panel"
>>   	depends on OF
>> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
>> index 292b3c7..f028269 100644
>> --- a/drivers/gpu/drm/panel/Makefile
>> +++ b/drivers/gpu/drm/panel/Makefile
>> @@ -5,6 +5,7 @@ obj-$(CONFIG_DRM_PANEL_LG_LG4573) += panel-lg-lg4573.o
>>   obj-$(CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00) += panel-panasonic-vvx10f034n00.o
>>   obj-$(CONFIG_DRM_PANEL_SAMSUNG_LD9040) += panel-samsung-ld9040.o
>>   obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2) += panel-samsung-s6e3ha2.o
>> +obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03) += panel-samsung-s6e63j0x03.o
>>   obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0) += panel-samsung-s6e8aa0.o
>>   obj-$(CONFIG_DRM_PANEL_SHARP_LQ101R1SX01) += panel-sharp-lq101r1sx01.o
>>   obj-$(CONFIG_DRM_PANEL_SHARP_LS043T1LE01) += panel-sharp-ls043t1le01.o
>> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c b/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
>> new file mode 100644
>> index 0000000..dd038bc
>> --- /dev/null
>> +++ b/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
>> @@ -0,0 +1,476 @@
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
>> +#define MIN_BRIGHTNESS		0
> This macro is not used at all and according to API it must be 0, so it
> can be removed.
>
>> +#define MAX_BRIGHTNESS		100
>> +#define DEFAULT_BRIGHTNESS	80
>> +
>> +#define NUM_GAMMA_STEPS		9
>> +#define GAMMA_CMD_CNT		28
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
>> +#define s6e63j0x03_dcs_write_seq_static(ctx, seq...) do {	\
>> +	static const u8 d[] = { seq };				\
>> +	int ret;						\
>> +	ret = s6e63j0x03_dcs_write_seq(ctx, d, ARRAY_SIZE(d));	\
>> +	if (ret < 0)						\
>> +		return ret;					\
>> +} while (0)
>> +
>> +#define s6e63j0x03_call_write_func(ret, func) do {	\
>> +	ret = (func);					\
>> +	if (ret < 0)					\
>> +		return ret;				\
>> +} while (0)
> Both above macros violate kernel coding style: macros that affect
> control flow are the 1st thing to avoid, see relevant chapter in the
> kernel docs [1].
> I know similar macros have been already merged with two latest panel
> drivers, so I suspect you have just followed current practice. So this
> question
> is rather to Thierry, is it the method you want to use to avoid 'if
> (ret) return ret' plague? What about explicit violation of kernel coding
> style?
>
> [1]:
> https://www.kernel.org/doc/html/v4.10/process/coding-style.html#macros-enums-and-rtl

Thanks for your comment.

Yes, I want avoid 'if (tet) return ret' plague.
But, this method is violation of kernel coding style.
So then we should use 'if (ret) return ret' style,
if we don't want toviolation of kernel coding style.
Do you want to do that?

Best regards,
Hoegeun
