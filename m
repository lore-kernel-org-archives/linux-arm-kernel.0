From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 22 Aug 2018 11:48:08 +0200
Subject: [PATCH] mmc: sdhci-of-arasan: Do now show error message in case
 of deffered probe
In-Reply-To: <c9688c600633ce9f4d7b6319366116e6e7c4b97d.1533544988.git.michal.simek@xilinx.com>
References: <c9688c600633ce9f4d7b6319366116e6e7c4b97d.1533544988.git.michal.simek@xilinx.com>
Message-ID: <CAPDyKFqS8k53TvQ8ON_+uQ3ynZ0JGGWxv1k9K5pDPMZ4hYkOpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 August 2018 at 10:43, Michal Simek <michal.simek@xilinx.com> wrote:
> When mmc-pwrseq property is passed mmc_pwrseq_alloc() can return
> -EPROBE_DEFER because driver for power sequence provider is not probed
> yet. Do not show error message when this situation happens.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Thanks, queued for v4.20!

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/sdhci-of-arasan.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index e3332a522a5d..e65f3bce3643 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -772,7 +772,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>
>         ret = mmc_of_parse(host->mmc);
>         if (ret) {
> -               dev_err(&pdev->dev, "parsing dt failed (%d)\n", ret);
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(&pdev->dev, "parsing dt failed (%d)\n", ret);
>                 goto unreg_clk;
>         }
>
> --
> 1.9.1
>
