From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 15 Dec 2017 10:17:36 +0100
Subject: [PATCH 2/6 v3] mmc: s3cmci: Fix platform_get_irq's error checking
In-Reply-To: <870b1a28108a8c0f3885bd345f3d27dda67621d5.1511066652.git.arvind.yadav.cs@gmail.com>
References: <c1c27676e9f141ace1254b40807bf2dc03f072c6.1511066652.git.arvind.yadav.cs@gmail.com>
 <870b1a28108a8c0f3885bd345f3d27dda67621d5.1511066652.git.arvind.yadav.cs@gmail.com>
Message-ID: <CAPDyKFrXmV8OgLj_YcBTqVWCUKFO=Q19fJU1iFPm61=TFLCjOw@mail.gmail.com>
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
>               return -EINVAL instead of host->irq.
>
>  drivers/mmc/host/s3cmci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
> index f7f157a..36daee1 100644
> --- a/drivers/mmc/host/s3cmci.c
> +++ b/drivers/mmc/host/s3cmci.c
> @@ -1658,7 +1658,7 @@ static int s3cmci_probe(struct platform_device *pdev)
>         }
>
>         host->irq = platform_get_irq(pdev, 0);
> -       if (host->irq == 0) {
> +       if (host->irq <= 0) {
>                 dev_err(&pdev->dev, "failed to get interrupt resource.\n");
>                 ret = -EINVAL;
>                 goto probe_iounmap;
> --
> 2.7.4
>
