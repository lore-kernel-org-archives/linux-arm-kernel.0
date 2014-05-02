From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 2 May 2014 21:39:49 +0530
Subject: [PATCH 6/6] dma: mmp_pdma: Add support externel DMA requests
In-Reply-To: <1397574817-15559-7-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1397574817-15559-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1397574817-15559-7-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <20140502160949.GX32284@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 05:13:37PM +0200, Laurent Pinchart wrote:
> The MMP/PXA DMA engine supports transfer initiation by external chips
> through DMA request (DREQ) signals. Support them by clearing pending DMA
> requests for the associated source when starting a channel.
> 
> The request ID to DREQ index mapping depends on the hardware and is
> passed through platform data or DT.
> 
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  Documentation/devicetree/bindings/dma/mmp-dma.txt |  2 +
>  drivers/dma/mmp_pdma.c                            | 96 ++++++++++++++++++++---
>  include/linux/platform_data/mmp_dma.h             |  2 +
>  3 files changed, 87 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/mmp-dma.txt b/Documentation/devicetree/bindings/dma/mmp-dma.txt
> index 7a802f6..edb9ff3 100644
> --- a/Documentation/devicetree/bindings/dma/mmp-dma.txt
> +++ b/Documentation/devicetree/bindings/dma/mmp-dma.txt
> @@ -12,6 +12,8 @@ Required properties:
>  Optional properties:
>  - #dma-channels: Number of DMA channels supported by the controller (defaults
>    to 32 when not specified)
> +- marvell,dreq: Array of the DMA request IDs corresponding to each of the
> +  external device request (DREQ) lines
>  
>  "marvell,pdma-1.0"
>  Used platforms: pxa25x, pxa27x, pxa3xx, pxa93x, pxa168, pxa910, pxa688.
Can you please split the binding to separate patch and we need to get an ACK on
it from DT folks.

The below looks fine to me

-- 
~Vinod

> diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
> index 849bf75..4546a1c 100644
> --- a/drivers/dma/mmp_pdma.c
> +++ b/drivers/dma/mmp_pdma.c
> @@ -27,6 +27,7 @@
>  
>  #define DCSR		0x0000
>  #define DALGN		0x00a0
> +#define DRQSR(n)	(0x00e0 + ((n) << 2))
>  #define DINT		0x00f0
>  #define DDADR		0x0200
>  #define DSADR		0x0204
> @@ -50,6 +51,9 @@
>  #define DCSR_CMPST	BIT(10)	/* The Descriptor Compare Status */
>  #define DCSR_EORINTR	BIT(9)	/* The end of Receive */
>  
> +#define DRQSR_CLR	BIT(8)	/* Clear Pending Requests */
> +#define DRQSR_REQPEND	0x1f	/* Requests Pending */
> +
>  #define DRCMR(n)	((((n) < 64) ? 0x0100 : 0x1100) + (((n) & 0x3f) << 2))
>  #define DRCMR_MAPVLD	BIT(7)	/* Map Valid (read / write) */
>  #define DRCMR_CHLNUM	0x1f	/* mask for Channel Number (read / write) */
> @@ -108,6 +112,7 @@ struct mmp_pdma_chan {
>  	u32 dcmd;
>  	u32 drcmr;
>  	u32 dev_addr;
> +	int drq;
>  
>  	/* list for desc */
>  	spinlock_t desc_lock;		/* Descriptor list lock */
> @@ -127,6 +132,8 @@ struct mmp_pdma_phy {
>  
>  struct mmp_pdma_device {
>  	int				dma_channels;
> +	unsigned int			num_dreq;
> +	const u32			*dreq;
>  	void __iomem			*base;
>  	struct device			*dev;
>  	struct dma_device		device;
> @@ -167,6 +174,9 @@ static void enable_chan(struct mmp_pdma_phy *phy)
>  		dalgn &= ~(1 << phy->idx);
>  	writel(dalgn, phy->base + DALGN);
>  
> +	if (phy->vchan->drq != -1)
> +		writel(DRQSR_CLR, phy->base + DRQSR(phy->vchan->drq));
> +
>  	reg = (phy->idx << 2) + DCSR;
>  	writel(readl(phy->base + reg) | DCSR_RUN, phy->base + reg);
>  }
> @@ -685,6 +695,22 @@ fail:
>  	return NULL;
>  }
>  
> +static void mmp_pdma_set_drcmr(struct mmp_pdma_chan *chan, unsigned int drmcr)
> +{
> +	struct mmp_pdma_device *pdev = to_mmp_pdma_dev(cchan->chan.device);
> +	unsigned int i;
> +
> +	chan->drcmr = drmcr;
> +	chan->drq = -1;
> +
> +	for (i = 0; i < pdev->num_dreq; ++i) {
> +		if (pdev->dreq[i] == drmcr) {
> +			chan->drq = i;
> +			break;
> +		}
> +	}
> +}
> +
>  static int mmp_pdma_control(struct dma_chan *dchan, enum dma_ctrl_cmd cmd,
>  			    unsigned long arg)
>  {
> @@ -745,7 +771,7 @@ static int mmp_pdma_control(struct dma_chan *dchan, enum dma_ctrl_cmd cmd,
>  		 * be removed.
>  		 */
>  		if (cfg->slave_id)
> -			chan->drcmr = cfg->slave_id;
> +			mmp_pdma_set_drcmr(chan, cfg->slave_id);
>  		break;
>  	default:
>  		return -ENOSYS;
> @@ -909,16 +935,64 @@ static struct dma_chan *mmp_pdma_dma_xlate(struct of_phandle_args *dma_spec,
>  	if (!chan)
>  		return NULL;
>  
> -	to_mmp_pdma_chan(chan)->drcmr = dma_spec->args[0];
> +	mmp_pdma_set_drcmr(to_mmp_pdma_chan(chan), dma_spec->args[0]);
>  
>  	return chan;
>  }
>  
> +static int mmap_pdma_parse_platform_data(struct mmp_pdma_device *pdev)
> +{
> +	struct device_node *np = pdev->dev->of_node;
> +	struct property *prop;
> +
> +	/* Default values: 32 channels, no external DREQ. */
> +	pdev->dma_channels = 32;
> +	pdev->num_dreq = 0;
> +
> +	if (!IS_ENABLED(CONFIG_OF) || !np) {
> +		struct mmp_dma_platdata *pdata = dev_get_platdata(pdev->dev);
> +
> +		if (!pdata)
> +			return 0;
> +
> +		if (pdata->dma_channels)
> +			pdev->dma_channels = pdata->dma_channels;
> +		if (pdata->num_dreq) {
> +			pdev->num_dreq = pdata->num_dreq;
> +			pdev->dreq = pdata->dreq;
> +		}
> +
> +		return 0;
> +	}
> +
> +	of_property_read_u32(np, "#dma-channels", &pdev->dma_channels);
> +
> +	prop = of_find_property(np, "marvell,dreq");
> +	if (prop) {
> +		unsigned int num_dreq = prop->length / sizeof(unsigned long);
> +		u32 *dreq;
> +
> +		dreq = devm_kcalloc(pdev->dev, num_dreq, sizeof(*pdreq),
> +				    GFP_KERNEL);
> +		if (dreq == NULL)
> +			return -ENOMEM;
> +
> +		ret = of_property_read_u32_array(np, "marvell,dreq", dreq,
> +						 num_dreq);
> +		if (ret < 0)
> +			return ret;
> +
> +		pdev->num_dreq = num_dreq;
> +		pdev->dreq = dreq;
> +	}
> +
> +	return 0;
> +}
> +
>  static int mmp_pdma_probe(struct platform_device *op)
>  {
>  	struct mmp_pdma_device *pdev;
>  	const struct of_device_id *of_id;
> -	struct mmp_dma_platdata *pdata = dev_get_platdata(&op->dev);
>  	struct resource *iores;
>  	int i, ret, irq = 0;
>  	int dma_channels = 0, irq_num = 0;
> @@ -936,15 +1010,11 @@ static int mmp_pdma_probe(struct platform_device *op)
>  	if (IS_ERR(pdev->base))
>  		return PTR_ERR(pdev->base);
>  
> -	of_id = of_match_device(mmp_pdma_dt_ids, pdev->dev);
> -	if (of_id)
> -		of_property_read_u32(pdev->dev->of_node, "#dma-channels",
> -				     &dma_channels);
> -	else if (pdata && pdata->dma_channels)
> -		dma_channels = pdata->dma_channels;
> -	else
> -		dma_channels = 32;	/* default 32 channel */
> -	pdev->dma_channels = dma_channels;
> +	ret = mmp_pdma_parse_platform_data(pdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	dma_channels = pdev->dma_channels;
>  
>  	for (i = 0; i < dma_channels; i++) {
>  		if (platform_get_irq(op, i) > 0)
> @@ -1038,7 +1108,7 @@ bool mmp_pdma_filter_fn(struct dma_chan *chan, void *param)
>  	if (chan->device->dev->driver != &mmp_pdma_driver.driver)
>  		return false;
>  
> -	c->drcmr = *(unsigned int *)param;
> +	mmp_pdma_set_drcmr(c, *(unsigned int *)param);
>  
>  	return true;
>  }
> diff --git a/include/linux/platform_data/mmp_dma.h b/include/linux/platform_data/mmp_dma.h
> index 2a330ec..32595b8 100644
> --- a/include/linux/platform_data/mmp_dma.h
> +++ b/include/linux/platform_data/mmp_dma.h
> @@ -14,6 +14,8 @@
>  
>  struct mmp_dma_platdata {
>  	int dma_channels;
> +	unsigned int num_dreq;
> +	const u32 *dreq;
>  };
>  
>  #endif /* MMP_DMA_H */
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
