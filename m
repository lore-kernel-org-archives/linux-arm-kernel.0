From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 21 Jan 2017 11:53:08 +0800
Subject: [PATCH 4/6] rtc: sun6i: Force the mux to the external oscillator
In-Reply-To: <409c56f0ed1c4b0026ad60cb1218c99fe1686408.1484927680.git-series.maxime.ripard@free-electrons.com>
References: <cover.180d5ae6bc36ead9625d208824f5cbd7114cf92e.1484927680.git-series.maxime.ripard@free-electrons.com>
 <409c56f0ed1c4b0026ad60cb1218c99fe1686408.1484927680.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v650f-4RZ6RrRBGcmPz8mJ4KbJwTTj6=w3HeSWUZtLAKcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 20, 2017 at 11:56 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The internal oscillator is way too inaccurate to do something useful with
> it. Switch to the external oscillator if it is available.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/rtc/rtc-sun6i.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> index edd5627da10f..1695fae24cd5 100644
> --- a/drivers/rtc/rtc-sun6i.c
> +++ b/drivers/rtc/rtc-sun6i.c
> @@ -493,6 +493,7 @@ static const struct rtc_class_ops sun6i_rtc_ops = {
>  static int sun6i_rtc_probe(struct platform_device *pdev)
>  {
>         struct sun6i_rtc_dev *chip = sun6i_rtc;
> +       struct clk *parent;
>         int ret;
>
>         if (!chip)
> @@ -540,6 +541,17 @@ static int sun6i_rtc_probe(struct platform_device *pdev)
>         /* disable alarm wakeup */
>         writel(0, chip->base + SUN6I_ALARM_CONFIG);
>
> +       parent = clk_get(&pdev->dev, NULL);
> +       if (!IS_ERR(parent)) {
> +               ret = clk_set_parent(chip->losc, parent);
> +               clk_put(parent);
> +
> +               if (ret) {
> +                       dev_err(&pdev->dev,
> +                               "Failed to reparent the RTC to the external oscillator\n");
> +                       return ret;
> +               }
> +       }

Following what I mentioned in patch 1, maybe it is easier to force
the mux before the clocks are registered by writing directly to
the registers? We could also backport the changes to stable?

ChenYu

>         clk_prepare_enable(chip->losc);
>
>         chip->rtc = rtc_device_register("rtc-sun6i", &pdev->dev,
> --
> git-series 0.8.11
