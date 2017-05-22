From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 22 May 2017 11:30:50 -0600
Subject: [PATCH] coresight: tmc: Configure DMA mask appropriately
In-Reply-To: <c93205f17b2d7609a1eb76fab74a7f929f4d25fb.1495119556.git.robin.murphy@arm.com>
References: <c93205f17b2d7609a1eb76fab74a7f929f4d25fb.1495119556.git.robin.murphy@arm.com>
Message-ID: <CANLsYkw6nk8vfD4YHHPJgbzBDc_mbJP8mJzjJm5PurX_vJFyvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 May 2017 at 09:14, Robin Murphy <robin.murphy@arm.com> wrote:
> Before making any DMA API calls, the ETR driver should really be setting
> its masks to ensure that DMA is possible. Especially since it can
> address more than the 32-bit default mask set by the AMBA bus code.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tmc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
> index d8517d2a968c..864488793f09 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> @@ -362,6 +362,13 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>                 desc.type = CORESIGHT_DEV_TYPE_SINK;
>                 desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
>                 desc.ops = &tmc_etr_cs_ops;
> +               /*
> +                * ETR configuration uses a 40-bit AXI master in place of
> +                * the embedded SRAM of ETB/ETF.
> +                */
> +               ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
> +               if (ret)
> +                       goto out;
>         } else {
>                 desc.type = CORESIGHT_DEV_TYPE_LINKSINK;
>                 desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_FIFO;

Applied - thanks.
Mathieu

> --
> 2.12.2.dirty
>
