From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 17 Nov 2009 19:12:26 +0800
Subject: [PATCH 01/02] backlight: control WLED output current in da9034
In-Reply-To: <f17812d70911170304p11b73172of0a85dda378e83b3@mail.gmail.com>
References: <771cded00911042357m7785312ewf29e39dd93b6d389@mail.gmail.com>
	<771cded00911050020w3d9ef572h392603dcb9456f96@mail.gmail.com>
	<771cded00911162327i2f0f6b15gf9a7cb7b1391ed74@mail.gmail.com>
	<f17812d70911170304p11b73172of0a85dda378e83b3@mail.gmail.com>
Message-ID: <771cded00911170312n10114eeam8c676c3b892a932d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2009 at 7:04 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Tue, Nov 17, 2009 at 1:27 AM, Haojian Zhuang
> <haojian.zhuang@gmail.com> wrote:
>> On Thu, Nov 5, 2009 at 3:20 AM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
>>> On Thu, Nov 5, 2009 at 2:57 AM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
>>>> From ff0d136a181ce431a0db9582f18733425a51411d Mon Sep 17 00:00:00 2001
>>>> From: Haojian Zhuang <haojian.zhuang@marvell.com>
>>>> Date: Thu, 5 Nov 2009 10:27:13 -0500
>>>> Subject: [PATCH] backlight: control WLED output current in da9034
>>>>
>>>> Update WLED output current source before changing brightness.
>>>>
>>>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>
> Haojian,
>
> I've updated the patch as follows, changes:
>
> 1. out_current --> output_current
> 2. output_current will be set only once during probe - we don't need to
> adjust it every time backlight is changed, right?
> 3. and thus removing the out_current field within da903x_backlight_data
>
> Please help review and verify, thanks.
>
> From 1351ae291bd237d3a754bedd550ab1f6f9fdbb20 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Thu, 5 Nov 2009 10:27:13 -0500
> Subject: [PATCH] da903x_bl: control WLED output current in da9034
>
> Update WLED output current source before changing brightness.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
> ---
> ?drivers/video/backlight/da903x_bl.c | ? ?7 +++++++
> ?include/linux/mfd/da903x.h ? ? ? ? ?| ? ?4 ++++
> ?2 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/video/backlight/da903x_bl.c
> b/drivers/video/backlight/da903x_bl.c
> index 701a108..9cbd01d 100644
> --- a/drivers/video/backlight/da903x_bl.c
> +++ b/drivers/video/backlight/da903x_bl.c
> @@ -25,6 +25,7 @@
>
> ?#define DA9034_WLED_CONTROL1 ? 0x3C
> ?#define DA9034_WLED_CONTROL2 ? 0x3D
> +#define DA9034_WLED_ISET(x) ? ?((x) & 0x1f)
>
> ?#define DA9034_WLED_BOOST_EN ? (1 << 5)
>
> @@ -101,6 +102,7 @@ static struct backlight_ops da903x_backlight_ops = {
>
> ?static int da903x_backlight_probe(struct platform_device *pdev)
> ?{
> + ? ? ? struct da9034_backlight_pdata *pdata = pdev->dev.platform_data;
> ? ? ? ?struct da903x_backlight_data *data;
> ? ? ? ?struct backlight_device *bl;
> ? ? ? ?int max_brightness;
> @@ -127,6 +129,11 @@ static int da903x_backlight_probe(struct
> platform_device *pdev)
> ? ? ? ?data->da903x_dev = pdev->dev.parent;
> ? ? ? ?data->current_brightness = 0;
>
> + ? ? ? /* adjust the WLED output current */
> + ? ? ? if (pdata)
> + ? ? ? ? ? ? ? da903x_write(dev, DA9034_WLED_CONTROL2,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? DA9034_WLED_ISET(pdata->output_current));
> +
> ? ? ? ?bl = backlight_device_register(pdev->name, data->da903x_dev,
> ? ? ? ? ? ? ? ? ? ? ? ?data, &da903x_backlight_ops);
> ? ? ? ?if (IS_ERR(bl)) {
> diff --git a/include/linux/mfd/da903x.h b/include/linux/mfd/da903x.h
> index c63b65c..0aa3a1a 100644
> --- a/include/linux/mfd/da903x.h
> +++ b/include/linux/mfd/da903x.h
> @@ -96,6 +96,10 @@ struct da9034_touch_pdata {
> ? ? ? ?int ? ? y_inverted;
> ?};
>
> +struct da9034_backlight_pdata {
> + ? ? ? int ? ? output_current; /* output current of WLED, from 0-31 (in mA) */
> +};
> +
> ?/* DA9030 battery charger data */
> ?struct power_supply_info;
>
> --
> 1.6.3.3
>

I'm OK on this patch.

Thanks
Haojian
