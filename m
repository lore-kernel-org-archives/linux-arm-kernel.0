From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 5 Nov 2009 03:20:09 -0500
Subject: [PATCH 01/02] backlight: control WLED output current in da9034
In-Reply-To: <771cded00911042357m7785312ewf29e39dd93b6d389@mail.gmail.com>
References: <771cded00911042357m7785312ewf29e39dd93b6d389@mail.gmail.com>
Message-ID: <771cded00911050020w3d9ef572h392603dcb9456f96@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 5, 2009 at 2:57 AM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
> From ff0d136a181ce431a0db9582f18733425a51411d Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Thu, 5 Nov 2009 10:27:13 -0500
> Subject: [PATCH] backlight: control WLED output current in da9034
>
> Update WLED output current source before changing brightness.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
> ?drivers/video/backlight/da903x_bl.c | ? 15 ++++++++++++++-
> ?include/linux/mfd/da903x.h ? ? ? ? ?| ? ?7 +++++++
> ?2 files changed, 21 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/video/backlight/da903x_bl.c
> b/drivers/video/backlight/da903x_bl.c
> index 701a108..9aba516 100644
> --- a/drivers/video/backlight/da903x_bl.c
> +++ b/drivers/video/backlight/da903x_bl.c
> @@ -35,6 +35,7 @@ struct da903x_backlight_data {
> ? ? ? ?struct device *da903x_dev;
> ? ? ? ?int id;
> ? ? ? ?int current_brightness;
> + ? ? ? int out_current; ? ? ? ? ? ? ? ?/* output current */
> ?};
>
> ?static int da903x_backlight_set(struct backlight_device *bl, int brightness)
> @@ -56,10 +57,17 @@ static int da903x_backlight_set(struct
> backlight_device *bl, int brightness)
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?DA9034_WLED_CONTROL2,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?DA9034_WLED_BOOST_EN);
>
> - ? ? ? ? ? ? ? if (data->current_brightness == 0 && brightness)
> + ? ? ? ? ? ? ? if (data->current_brightness == 0 && brightness) {
> + ? ? ? ? ? ? ? ? ? ? ? if (data->out_current) {
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ret = da903x_write(dev, DA9034_WLED_CONTROL2,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? data->out_current);
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? if (ret)
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? return ret;
> + ? ? ? ? ? ? ? ? ? ? ? }
> ? ? ? ? ? ? ? ? ? ? ? ?ret = da903x_set_bits(dev,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?DA9034_WLED_CONTROL2,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?DA9034_WLED_BOOST_EN);
> + ? ? ? ? ? ? ? }
> ? ? ? ? ? ? ? ?break;
> ? ? ? ?case DA9030_ID_WLED:
> ? ? ? ? ? ? ? ?val = DA9030_WLED_TRIM(brightness);
> @@ -101,6 +109,7 @@ static struct backlight_ops da903x_backlight_ops = {
>
> ?static int da903x_backlight_probe(struct platform_device *pdev)
> ?{
> + ? ? ? struct da9034_backlight_pdata *pdata = pdev->dev.platform_data;
> ? ? ? ?struct da903x_backlight_data *data;
> ? ? ? ?struct backlight_device *bl;
> ? ? ? ?int max_brightness;
> @@ -127,6 +136,10 @@ static int da903x_backlight_probe(struct
> platform_device *pdev)
> ? ? ? ?data->da903x_dev = pdev->dev.parent;
> ? ? ? ?data->current_brightness = 0;
>
> + ? ? ? /* set output current */
> + ? ? ? if (pdata)
> + ? ? ? ? ? ? ? data->out_current = pdata->out_current;
> +
> ? ? ? ?bl = backlight_device_register(pdev->name, data->da903x_dev,
> ? ? ? ? ? ? ? ? ? ? ? ?data, &da903x_backlight_ops);
> ? ? ? ?if (IS_ERR(bl)) {
> diff --git a/include/linux/mfd/da903x.h b/include/linux/mfd/da903x.h
> index c63b65c..240a893 100644
> --- a/include/linux/mfd/da903x.h
> +++ b/include/linux/mfd/da903x.h
> @@ -96,6 +96,13 @@ struct da9034_touch_pdata {
> ? ? ? ?int ? ? y_inverted;
> ?};
>
> +#define DA9034_WLED_OUT_MASK ? ((1 << 5) - 1)
> +#define DA9034_WLED_CURRENT(x) (x & DA9034_WLED_OUT_MASK)
> +
> +struct da9034_backlight_pdata {
> + ? ? ? int ? ? out_current; ? ?/* output current of WLED, unit is mA */
> +};
> +
> ?/* DA9030 battery charger data */
> ?struct power_supply_info;
>
> --
> 1.5.6.5
>
