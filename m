From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 24 May 2017 18:30:15 +0800
Subject: [linux-sunxi] [PATCH v3 5/9] dmaengine: sun6i: make gate bit in
 sun8i's DMA engines a common quirk
In-Reply-To: <20170524100607.29790-6-icenowy@aosc.io>
References: <20170524100607.29790-1-icenowy@aosc.io>
 <20170524100607.29790-6-icenowy@aosc.io>
Message-ID: <CAGb2v65uBhnyR5fwhPuTyt_Nss-6WMNaXPFT3X_HpH23YGp1Hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 24, 2017 at 6:06 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> From: Icenowy Zheng <icenowy@aosc.xyz>
>
> Originally we enable a special gate bit when the compatible indicates
> A23/33.
>
> But according to BSP sources and user manuals, more SoCs will need this
> gate bit.
>
> So make it a common quirk configured in the config struct.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
> Changes in v3:
> - Stripped out the A83T gate bit set.
>
>  drivers/dma/sun6i-dma.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index a2358780ab2c..69840cf6fe98 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -101,6 +101,11 @@ struct sun6i_dma_config {
>         u32 nr_max_channels;
>         u32 nr_max_requests;
>         u32 nr_max_vchans;
> +       /*
> +        * The hardware has a special gate bit, which is needed to
> +        * be enabled for some SoCs with a sun6i-style DMA engine.
> +        */
> +       bool gate_needed;

The user manual identifies the gate bit as "DMA MCLK interface circuit
auto gating bit", which, when set to 1, disables auto gating. It also
has a footnote saying "When initializing DMA Controller, bit 2 (this
bit) should be set up."

Please include this information in the comment. Also you might want to
merge the two comment blocks and keep all the information in one place.

Curiously on the A83T I didn't need to set the bit for DMA to work.
ChenYu

>  };
>
>  /*
> @@ -1009,6 +1014,7 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg = {
>         .nr_max_channels = 8,
>         .nr_max_requests = 24,
>         .nr_max_vchans   = 37,
> +       .gate_needed     = true,
>  };
>
>  static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
> @@ -1177,10 +1183,10 @@ static int sun6i_dma_probe(struct platform_device *pdev)
>         /*
>          * sun8i variant requires us to toggle a dma gating register,
>          * as seen in Allwinner's SDK. This register is not documented
> -        * in the A23 user manual.
> +        * in the A23 user manual, but documented at least in V3s user
> +        * manual.
>          */
> -       if (of_device_is_compatible(pdev->dev.of_node,
> -                                   "allwinner,sun8i-a23-dma"))
> +       if (sdc->cfg->gate_needed)
>                 writel(SUN8I_DMA_GATE_ENABLE, sdc->base + SUN8I_DMA_GATE);
>
>         return 0;
> --
> 2.12.2
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
