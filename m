From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 15 Dec 2017 10:18:03 +0100
Subject: [PATCH 6/6 v3] mmc: sunxi-mmc: Handle return value of
 platform_get_irq
In-Reply-To: <6ad5c6077b96353a77ea30d1b64651c77d5622f6.1511066652.git.arvind.yadav.cs@gmail.com>
References: <c1c27676e9f141ace1254b40807bf2dc03f072c6.1511066652.git.arvind.yadav.cs@gmail.com>
 <6ad5c6077b96353a77ea30d1b64651c77d5622f6.1511066652.git.arvind.yadav.cs@gmail.com>
Message-ID: <CAPDyKFrNsTr9=fpzz2K+aQSS04ziOnLs1KxV-K0StzN=Tb=4MQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 November 2017 at 05:52, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
> platform_get_irq() can fail here and we must check its return value.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
> changes in v2 :
>               Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.
> changes in v3 :
>               return -EINVAL instead of host->irq.
>
>  drivers/mmc/host/sunxi-mmc.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index cc98355d..c926ac8 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1255,6 +1255,11 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
>                 goto error_assert_reset;
>
>         host->irq = platform_get_irq(pdev, 0);
> +       if (host->irq <= 0) {
> +               ret = -EINVAL;
> +               goto error_assert_reset;
> +       }
> +
>         return devm_request_threaded_irq(&pdev->dev, host->irq, sunxi_mmc_irq,
>                         sunxi_mmc_handle_manual_stop, 0, "sunxi-mmc", host);
>
> --
> 2.7.4
>
