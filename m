From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 16 Mar 2017 15:45:53 +0100
Subject: [PATCH] mmc: mediatek: Fixed bug where clock frequency could be
 set wrong
In-Reply-To: <1488611403-30186-2-git-send-email-yong.mao@mediatek.com>
References: <1488611403-30186-1-git-send-email-yong.mao@mediatek.com>
 <1488611403-30186-2-git-send-email-yong.mao@mediatek.com>
Message-ID: <CAPDyKFqzj-UT12rorqZ9536608=Zs37s1LhQb=4GpqV95QoNNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 March 2017 at 08:10, Yong Mao <yong.mao@mediatek.com> wrote:
> From: yong mao <yong.mao@mediatek.com>
>
> This patch can fix two issues:
>
> Issue 1:
> In previous code, div may be overflow when setting clock frequency
> as f_min. We can use DIV_ROUND_UP to fix this boundary related
> issue.
>
> Issue 2:
> In previous code, we can not set the correct clock frequency when
> div equals 0xff.
>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 07f3236..3ad5228 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -591,7 +591,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>                 }
>         }
>         sdr_set_field(host->base + MSDC_CFG, MSDC_CFG_CKMOD | MSDC_CFG_CKDIV,
> -                       (mode << 8) | (div % 0xff));
> +                     (mode << 8) | div);
>         sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_CKPDN);
>         while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
>                 cpu_relax();
> @@ -1692,7 +1692,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
>         host->src_clk_freq = clk_get_rate(host->src_clk);
>         /* Set host parameters to mmc */
>         mmc->ops = &mt_msdc_ops;
> -       mmc->f_min = host->src_clk_freq / (4 * 255);
> +       mmc->f_min = DIV_ROUND_UP(host->src_clk_freq, 4 * 255);
>
>         mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23;
>         /* MMC core transfer sizes tunable parameters */
> --
> 1.7.9.5
>

Thanks, applied for fixes!

Kind regards
Uffe
