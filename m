From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 8 May 2013 15:59:08 +0200
Subject: [PATCH 36/63] crypto: ux500/hash - Prepare clock before enabling
 it
In-Reply-To: <1367591569-32197-37-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-37-git-send-email-lee.jones@linaro.org>
Message-ID: <CAPDyKFqD93K_vBKpoWmLjFHaY06seARDpxb-KJJFv4LAzXa1Vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 May 2013 16:32, Lee Jones <lee.jones@linaro.org> wrote:
> If we fail to prepare the ux500-hash clock before enabling it the
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
>  drivers/crypto/ux500/hash/hash_core.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/crypto/ux500/hash/hash_core.c b/drivers/crypto/ux500/hash/hash_core.c
> index 632c333..1e8b2f3 100644
> --- a/drivers/crypto/ux500/hash/hash_core.c
> +++ b/drivers/crypto/ux500/hash/hash_core.c
> @@ -1727,11 +1727,17 @@ static int ux500_hash_probe(struct platform_device *pdev)
>                 goto out_regulator;
>         }
>
> +       ret = clk_prepare(device_data->clk);
> +       if (ret) {
> +               dev_err(dev, "[%s] clk_prepare() failed!", __func__);
> +               goto out_clk;
> +       }
> +
>         /* Enable device power (and clock) */
>         ret = hash_enable_power(device_data, false);
>         if (ret) {
>                 dev_err(dev, "[%s]: hash_enable_power() failed!", __func__);
> -               goto out_clk;
> +               goto out_clk_unprepare;
>         }
>
>         ret = hash_check_hw(device_data);
> @@ -1763,6 +1769,9 @@ static int ux500_hash_probe(struct platform_device *pdev)
>  out_power:
>         hash_disable_power(device_data, false);
>
> +out_clk_unprepare:
> +       clk_unprepare(device_data->clk);
> +
>  out_clk:
>         clk_put(device_data->clk);
>
> @@ -1827,6 +1836,7 @@ static int ux500_hash_remove(struct platform_device *pdev)
>                 dev_err(dev, "[%s]: hash_disable_power() failed",
>                         __func__);
>
> +       clk_unprepare(device_data->clk);
>         clk_put(device_data->clk);
>         regulator_put(device_data->regulator);
>
> --
> 1.7.10.4
>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
