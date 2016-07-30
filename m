From: julian.calaby@gmail.com (Julian Calaby)
Date: Sun, 31 Jul 2016 00:40:48 +1000
Subject: [linux-sunxi] [PATCH 2/2] ASoC: sunxi: compatibility for sun6i to
 SPDIF
In-Reply-To: <20160730142716.29377-3-codekipper@gmail.com>
References: <20160730142716.29377-1-codekipper@gmail.com>
 <20160730142716.29377-3-codekipper@gmail.com>
Message-ID: <CAGRGNgU-7skLeRNOxfVpqNXSaLTLA+vAZrm8=sdo0NJLbopJ7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcus,

On Sun, Jul 31, 2016 at 12:27 AM,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> The A31 SoC uses the same SPDIF block as found in earlier SoCs, but its
> reset is controlled via a separate reset controller.
>
> The DMA also complains when the maxburst is set to 4 so it's been adjusted
> to 8 which suites both the older and newer SoCs.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-spdif.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
> index 0b04fb0..88fbb3a 100644
> --- a/sound/soc/sunxi/sun4i-spdif.c
> +++ b/sound/soc/sunxi/sun4i-spdif.c
> @@ -482,11 +485,23 @@ static int sun4i_spdif_probe(struct platform_device *pdev)
>         }
>
>         host->dma_params_tx.addr = res->start + SUN4I_SPDIF_TXFIFO;
> -       host->dma_params_tx.maxburst = 4;
> +       host->dma_params_tx.maxburst = 8;
>         host->dma_params_tx.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
>
>         platform_set_drvdata(pdev, host);
>
> +       if (of_device_is_compatible(pdev->dev.of_node,
> +                                   "allwinner,sun6i-a31-spdif")) {

Given how much Allwinner likes to shuffle stuff around with each SoC
generation, would it make sense to add a flag for this in some
compatible specific config structure instead of checking against the
compatible?

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
