From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 8 May 2013 15:59:35 +0200
Subject: [PATCH 39/63] crypto: ux500/cryp - Prepare clock before enabling
 it
In-Reply-To: <1367591569-32197-40-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-40-git-send-email-lee.jones@linaro.org>
Message-ID: <CAPDyKFqiLt=xC8NNXxKZpKh49+ewHuLt=0r+HogZ-aFrKh99NQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 May 2013 16:32, Lee Jones <lee.jones@linaro.org> wrote:
> If we fail to prepare the ux500-cryp clock before enabling it the
> platform will fail to boot. Here we insure this happens.
>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Andreas Westin <andreas.westin@stericsson.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-crypto at vger.kernel.org
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/crypto/ux500/cryp/cryp_core.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/crypto/ux500/cryp/cryp_core.c b/drivers/crypto/ux500/cryp/cryp_core.c
> index 22c9063..bf78d60 100644
> --- a/drivers/crypto/ux500/cryp/cryp_core.c
> +++ b/drivers/crypto/ux500/cryp/cryp_core.c
> @@ -1459,11 +1459,17 @@ static int ux500_cryp_probe(struct platform_device *pdev)
>                 goto out_regulator;
>         }
>
> +       ret = clk_prepare(device_data->clk);
> +       if (ret) {
> +               dev_err(dev, "[%s]: clk_prepare() failed!", __func__);
> +               goto out_clk;
> +       }
> +
>         /* Enable device power (and clock) */
>         ret = cryp_enable_power(device_data->dev, device_data, false);
>         if (ret) {
>                 dev_err(dev, "[%s]: cryp_enable_power() failed!", __func__);
> -               goto out_clk;
> +               goto out_clk_unprepare;
>         }
>
>         cryp_error = cryp_check(device_data);
> @@ -1524,6 +1530,9 @@ static int ux500_cryp_probe(struct platform_device *pdev)
>  out_power:
>         cryp_disable_power(device_data->dev, device_data, false);
>
> +out_clk_unprepare:
> +       clk_unprepare(device_data->clk);
> +
>  out_clk:
>         clk_put(device_data->clk);
>
> @@ -1594,6 +1603,7 @@ static int ux500_cryp_remove(struct platform_device *pdev)
>                 dev_err(&pdev->dev, "[%s]: cryp_disable_power() failed",
>                         __func__);
>
> +       clk_unprepare(device_data->clk);
>         clk_put(device_data->clk);
>         regulator_put(device_data->pwr_regulator);
>
> --
> 1.7.10.4
>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
