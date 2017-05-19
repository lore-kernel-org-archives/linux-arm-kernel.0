From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 19 May 2017 14:29:14 +0100
Subject: [PATCH] coresight: tmc: Configure DMA mask appropriately
In-Reply-To: <c93205f17b2d7609a1eb76fab74a7f929f4d25fb.1495119556.git.robin.murphy@arm.com>
References: <c93205f17b2d7609a1eb76fab74a7f929f4d25fb.1495119556.git.robin.murphy@arm.com>
Message-ID: <3659c485-88ca-4fa9-ce7b-dfb77d8a050a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/05/17 16:14, Robin Murphy wrote:
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
>  		desc.type = CORESIGHT_DEV_TYPE_SINK;
>  		desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
>  		desc.ops = &tmc_etr_cs_ops;
> +		/*
> +		 * ETR configuration uses a 40-bit AXI master in place of
> +		 * the embedded SRAM of ETB/ETF.
> +		 */
> +		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
> +		if (ret)
> +			goto out;
>  	} else {
>  		desc.type = CORESIGHT_DEV_TYPE_LINKSINK;
>  		desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_FIFO;
>

Tested this patch on Juno, with the SMMU enabled for the etr. I was able to
allocate 32M using (the CMA was only 16M). FWIW :

Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
