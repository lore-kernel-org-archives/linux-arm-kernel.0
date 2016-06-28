From: cwchoi00@gmail.com (Chanwoo Choi)
Date: Tue, 28 Jun 2016 21:10:58 +0900
Subject: [PATCH] PM / devfreq: exynos-ppmu: fix error path in
 exynos_ppmu_probe()
In-Reply-To: <1467112869-30488-1-git-send-email-b.zolnierkie@samsung.com>
References: <1467112869-30488-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <CAGTfZH2iTwPgEqYWqXf-+nwg8P8ZZJ7+t-aDWeWThBMTA5OhjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-06-28 20:21 GMT+09:00 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>:
> iounmap() needs to be called in case of memory allocation
> (for devfreq-event devices) failure.  Fix it.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/devfreq/event/exynos-ppmu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
> index f312485..845bf25 100644
> --- a/drivers/devfreq/event/exynos-ppmu.c
> +++ b/drivers/devfreq/event/exynos-ppmu.c
> @@ -482,7 +482,8 @@ static int exynos_ppmu_probe(struct platform_device *pdev)
>         if (!info->edev) {
>                 dev_err(&pdev->dev,
>                         "failed to allocate memory devfreq-event devices\n");
> -               return -ENOMEM;
> +               ret = -ENOMEM;
> +               goto err;
>         }
>         edev = info->edev;
>         platform_set_drvdata(pdev, info);
> --
> 1.9.1
>

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Also, this patch fix the bug. So, this patch should be included in v4.7-rc.

Thanks,
Chanwoo Choi
