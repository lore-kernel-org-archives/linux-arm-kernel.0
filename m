From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 8 Jul 2014 14:33:09 +0200
Subject: [PATCH] s3cmci: Move to clk_prepare_enable/clk_disable_unprepare
In-Reply-To: <1404155466-2971-1-git-send-email-anarsoul@gmail.com>
References: <1404155466-2971-1-git-send-email-anarsoul@gmail.com>
Message-ID: <CAPDyKFqqgCPp6j_nnAs_2PoyGhEubN_sKv8zWd8UkLy6mAXVVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 June 2014 21:11, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> Use clk_prepare_enable/clk_disable_unprepare to make the driver
> work properly with common clock framework.
>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Thanks! Applied for next.

I took the liberty to add the prefix "mmc" to heading of the commit msg.

Kind regards
Uffe


> ---
>  drivers/mmc/host/s3cmci.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
> index 0d115a8..e5516a2 100644
> --- a/drivers/mmc/host/s3cmci.c
> +++ b/drivers/mmc/host/s3cmci.c
> @@ -1707,7 +1707,7 @@ static int s3cmci_probe(struct platform_device *pdev)
>                 goto probe_free_dma;
>         }
>
> -       ret = clk_enable(host->clk);
> +       ret = clk_prepare_enable(host->clk);
>         if (ret) {
>                 dev_err(&pdev->dev, "failed to enable clock source.\n");
>                 goto clk_free;
> @@ -1765,7 +1765,7 @@ static int s3cmci_probe(struct platform_device *pdev)
>         s3cmci_cpufreq_deregister(host);
>
>   free_dmabuf:
> -       clk_disable(host->clk);
> +       clk_disable_unprepare(host->clk);
>
>   clk_free:
>         clk_put(host->clk);
> @@ -1817,7 +1817,7 @@ static void s3cmci_shutdown(struct platform_device *pdev)
>         s3cmci_debugfs_remove(host);
>         s3cmci_cpufreq_deregister(host);
>         mmc_remove_host(mmc);
> -       clk_disable(host->clk);
> +       clk_disable_unprepare(host->clk);
>  }
>
>  static int s3cmci_remove(struct platform_device *pdev)
> --
> 2.0.0
>
