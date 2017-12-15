From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 15 Dec 2017 10:17:30 +0100
Subject: [PATCH 1/6 v3] mmc: meson-gx-mmc: Fix platform_get_irq's error
 checking
In-Reply-To: <c1c27676e9f141ace1254b40807bf2dc03f072c6.1511066652.git.arvind.yadav.cs@gmail.com>
References: <c1c27676e9f141ace1254b40807bf2dc03f072c6.1511066652.git.arvind.yadav.cs@gmail.com>
Message-ID: <CAPDyKFoLvrZ2PK7EAcoVdk4wQp81FPBEcrTcHKW5UfazzjXpcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 November 2017 at 05:52, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
> The platform_get_irq() function returns negative if an error occurs.
> zero or positive number on success. platform_get_irq() error checking
> for zero is not correct.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
> changes in v2 :
>               Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.
> changes in v3 :
>               return -EINVAL instead of irq.
>
>  drivers/mmc/host/meson-gx-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index e0862d3..32a6a22 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -1208,7 +1208,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
>         }
>
>         irq = platform_get_irq(pdev, 0);
> -       if (!irq) {
> +       if (irq <= 0) {
>                 dev_err(&pdev->dev, "failed to get interrupt resource.\n");
>                 ret = -EINVAL;
>                 goto free_host;
> --
> 2.7.4
>
