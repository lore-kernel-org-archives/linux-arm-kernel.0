From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 24 Nov 2016 13:04:40 +0800
Subject: [PATCH v4 3/3] dmaengine: sun6i: share the dma driver with sun50i
In-Reply-To: <1479638740-20520-4-git-send-email-hao5781286@gmail.com>
References: <1479638740-20520-1-git-send-email-hao5781286@gmail.com>
 <1479638740-20520-4-git-send-email-hao5781286@gmail.com>
Message-ID: <CAGb2v65trUUAr4SNCkwYANG7d3s2d4cu7nkqOeDcg6z4zkZNWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Nov 20, 2016 at 6:45 PM, Hao Zhang <hao5781286@gmail.com> wrote:
> Changes the limited buswith to 8 bytes,and add
> the test in sun6i_dma_config function
>
> Accroding to sun6i dma driver, i think ,if the client
> doesn't configure the address width with dmaengine_slave_config
> function, it would use the default width. So we can add the test
> in sun6i_dma_config function called by dmaengine_slave_config,
> and test the configuration whether is support for the device.
>

One thing people haven't really noticed is that starting with
A80, A83T, H3, the DMA channel configuration registers have
been slightly changed when compared to A31/A23/A33. The DMA
burst length field offset was changed by 1.

We need to fix this.

ChenYu

> Signed-off-by: Hao Zhang <hao5781286@gmail.com>
> ---
>  drivers/dma/sun6i-dma.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index a235878..f7c90b6 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -250,7 +250,7 @@ static inline s8 convert_burst(u32 maxburst)
>  static inline s8 convert_buswidth(enum dma_slave_buswidth addr_width)
>  {
>         if ((addr_width < DMA_SLAVE_BUSWIDTH_1_BYTE) ||
> -           (addr_width > DMA_SLAVE_BUSWIDTH_4_BYTES))
> +           (addr_width > DMA_SLAVE_BUSWIDTH_8_BYTES))
>                 return -EINVAL;
>
>         return addr_width >> 1;
> @@ -758,6 +758,18 @@ static int sun6i_dma_config(struct dma_chan *chan,
>  {
>         struct sun6i_vchan *vchan = to_sun6i_vchan(chan);
>
> +       if ((BIT(config->src_addr_width) | chan->device->src_addr_widths) !=
> +               chan->device->src_addr_widths) {
> +               dev_err(chan2dev(chan), "Invalid DMA configuration\n");
> +               return -EINVAL;
> +       }
> +
> +       if ((BIT(config->dst_addr_width) | chan->device->dst_addr_widths) !=
> +                       chan->device->dst_addr_widths) {
> +               dev_err(chan2dev(chan), "Invalid DMA configuration\n");
> +               return -EINVAL;
> +       }
> +
>         memcpy(&vchan->cfg, config, sizeof(*config));
>
>         return 0;
> @@ -1028,11 +1040,23 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
>         .nr_max_vchans   = 34,
>  };
>
> +/*
> + * The A64 has 8 physical channels, a maximum DRQ port id of 27,
> + * and a total of 38 usable source and destination endpoints.
> + */
> +
> +static struct sun6i_dma_config sun50i_a64_dma_cfg = {
> +       .nr_max_channels = 8,
> +       .nr_max_requests = 27,
> +       .nr_max_vchans   = 38,
> +};
> +
>  static const struct of_device_id sun6i_dma_match[] = {
>         { .compatible = "allwinner,sun6i-a31-dma", .data = &sun6i_a31_dma_cfg },
>         { .compatible = "allwinner,sun8i-a23-dma", .data = &sun8i_a23_dma_cfg },
>         { .compatible = "allwinner,sun8i-a83t-dma", .data = &sun8i_a83t_dma_cfg },
>         { .compatible = "allwinner,sun8i-h3-dma", .data = &sun8i_h3_dma_cfg },
> +       { .compatible = "allwinner,sun50i-a64-dma", .data = &sun50i_a64_dma_cfg },
>         { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sun6i_dma_match);
> @@ -1112,6 +1136,13 @@ static int sun6i_dma_probe(struct platform_device *pdev)
>                                                   BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
>         sdc->slave.directions                   = BIT(DMA_DEV_TO_MEM) |
>                                                   BIT(DMA_MEM_TO_DEV);
> +
> +       if (of_device_is_compatible(pdev->dev.of_node,
> +                                   "allwinner,sun50i-a64-dma")) {
> +               sdc->slave.src_addr_widths      |= BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> +               sdc->slave.dst_addr_widths      |= BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> +       }
> +
>         sdc->slave.residue_granularity          = DMA_RESIDUE_GRANULARITY_BURST;
>         sdc->slave.dev = &pdev->dev;
>
> --
> 2.7.4
>
