From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 16 Mar 2017 14:05:04 +0100
Subject: [PATCH v2 2/4] mmc: pwrseq-simple: Add optional op. for
 post_ios_power_on callback
In-Reply-To: <20170306141716.19120-3-romain.perier@collabora.com>
References: <20170306141716.19120-1-romain.perier@collabora.com>
 <20170306141716.19120-3-romain.perier@collabora.com>
Message-ID: <CAPDyKFo=0H_Uum3_ak7__C4g2oOOmqD-sxDgZP3O9zb5a_q4rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 March 2017 at 15:17, Romain Perier <romain.perier@collabora.com> wrote:
> Some devices require to do their entire power sequence after that the
> power supply of the MMC has been powered on. This can be done by
> only implementing the optional post_ios_power_on() callback that rely on
> pre_power_on/post_power_on functions, other functions being NULL. Then
> we introduce a new DT property "post_ios_power_on", when this property
> is set the driver will use its post_ios_power_on operations, otherwise
> it fallbacks to the default operations with pre_power_on/post_power_on.
>
> Signed-off-by: Romain Perier <romain.perier@collabora.com>
> ---
>
> Changes in v2:
>  - Added missing power_off function in mmc_pwrseq_post_ios_ops
>
>  drivers/mmc/core/pwrseq_simple.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
> index 1304160..e27019f 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -84,12 +84,23 @@ static void mmc_pwrseq_simple_power_off(struct mmc_host *host)
>         }
>  }
>
> +static void mmc_pwrseq_simple_post_ios_power_on(struct mmc_host *host)
> +{
> +       mmc_pwrseq_simple_pre_power_on(host);
> +       mmc_pwrseq_simple_post_power_on(host);
> +}
> +
>  static const struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
>         .pre_power_on = mmc_pwrseq_simple_pre_power_on,
>         .post_power_on = mmc_pwrseq_simple_post_power_on,
>         .power_off = mmc_pwrseq_simple_power_off,
>  };
>
> +static const struct mmc_pwrseq_ops mmc_pwrseq_post_ios_ops = {
> +       .post_ios_power_on = mmc_pwrseq_simple_post_ios_power_on,
> +       .power_off = mmc_pwrseq_simple_power_off,
> +};
> +
>  static const struct of_device_id mmc_pwrseq_simple_of_match[] = {
>         { .compatible = "mmc-pwrseq-simple",},
>         {/* sentinel */},
> @@ -121,7 +132,10 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
>                                  &pwrseq->post_power_on_delay_ms);
>
>         pwrseq->pwrseq.dev = dev;
> -       pwrseq->pwrseq.ops = &mmc_pwrseq_simple_ops;
> +       if (device_property_read_bool(dev, "post-ios-power-on"))
> +               pwrseq->pwrseq.ops = &mmc_pwrseq_post_ios_ops;

No, this is not going to work "post-ios-power-on" is never going to be
accepted as new mmc pwrseq DT binding.

> +       else
> +               pwrseq->pwrseq.ops = &mmc_pwrseq_simple_ops;
>         pwrseq->pwrseq.owner = THIS_MODULE;
>         platform_set_drvdata(pdev, pwrseq);
>
> --
> 2.9.3
>

Kind regards
Uffe
