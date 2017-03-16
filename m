From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 16 Mar 2017 14:01:19 +0100
Subject: [PATCH v2 3/4] mmc: pwrseq_simple: Add an optional
 pre-power-on-delay
In-Reply-To: <20170306141716.19120-4-romain.perier@collabora.com>
References: <20170306141716.19120-1-romain.perier@collabora.com>
 <20170306141716.19120-4-romain.perier@collabora.com>
Message-ID: <CAPDyKFr90kj9QuCVromx5A24U0WDh1gwVjmdwDsr1JmQbt=DPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 March 2017 at 15:17, Romain Perier <romain.perier@collabora.com> wrote:
> Some devices need a while between the enablement of its clk and the time
> where the reset line is asserted. When this time happens between the
> pre_power_on and the post_power_on callbacks, there is a need to do an
> msleep at the end of the pre_power_on callback.
>
> This commit adds an optional DT property for such devices.
>
> Signed-off-by: Romain Perier <romain.perier@collabora.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt | 2 ++

Split DT documentation for code changes. And make sure DT maintainers
are in the loop discussing new DT bindings.

>  drivers/mmc/core/pwrseq_simple.c                            | 6 ++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
> index e254368..821feaaf 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
> @@ -18,6 +18,8 @@ Optional properties:
>    "ext_clock" (External clock provided to the card).
>  - post-power-on-delay-ms : Delay in ms after powering the card and
>         de-asserting the reset-gpios (if any)
> +- pre-power-on-delay-ms : Delay in ms before powering the card and
> +       asserting the reset-gpios (if any)

We have been thinking of adding this before. It seems reasonable to
me, however in the earlier case we ended up adding a new mmc pwrseq
variant.

Let's see where we ends up here...

>
>  Example:
>
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
> index e27019f..d8d7166 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -27,6 +27,7 @@ struct mmc_pwrseq_simple {
>         struct mmc_pwrseq pwrseq;
>         bool clk_enabled;
>         u32 post_power_on_delay_ms;
> +       u32 pre_power_on_delay_ms;
>         struct clk *ext_clk;
>         struct gpio_descs *reset_gpios;
>  };
> @@ -60,6 +61,9 @@ static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
>         }
>
>         mmc_pwrseq_simple_set_gpios_value(pwrseq, 1);
> +
> +       if (pwrseq->pre_power_on_delay_ms)
> +               msleep(pwrseq->pre_power_on_delay_ms);
>  }
>
>  static void mmc_pwrseq_simple_post_power_on(struct mmc_host *host)
> @@ -130,6 +134,8 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
>
>         device_property_read_u32(dev, "post-power-on-delay-ms",
>                                  &pwrseq->post_power_on_delay_ms);
> +       device_property_read_u32(dev, "pre-power-on-delay-ms",
> +                                &pwrseq->pre_power_on_delay_ms);
>
>         pwrseq->pwrseq.dev = dev;
>         if (device_property_read_bool(dev, "post-ios-power-on"))
> --
> 2.9.3
>

Kind regards
Uffe
