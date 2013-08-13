From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 13 Aug 2013 16:50:43 +0530
Subject: [PATCH v2 2/2] dmaengine: Add hisilicon k3 DMA engine driver
In-Reply-To: <1372423153-6742-3-git-send-email-zhangfei.gao@linaro.org>
References: <1372423153-6742-1-git-send-email-zhangfei.gao@linaro.org>
 <1372423153-6742-3-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20130813112043.GB32147@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 28, 2013 at 08:39:13PM +0800, Zhangfei Gao wrote:
> Add dmaengine driver for hisilicon k3 platform based on virt_dma
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Kai Yang <jean.yangkai@huawei.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---

> +#define DRIVER_NAME		"k3-dma"
> +#define DMA_ALIGN		3
> +#define DMA_MAX_SIZE		0x1ffc
> +
> +#define INT_STAT		0x00
> +#define INT_TC1			0x04
> +#define INT_ERR1		0x0c
> +#define INT_ERR2		0x10
> +#define INT_TC1_MASK		0x18
> +#define INT_ERR1_MASK		0x20
> +#define INT_ERR2_MASK		0x24
> +#define INT_TC1_RAW		0x600
> +#define INT_ERR1_RAW		0x608
> +#define INT_ERR2_RAW		0x610
> +#define CH_PRI			0x688
> +#define CH_STAT			0x690
> +#define CX_CUR_CNT		0x704
> +#define CX_LLI			0x800
> +#define CX_CNT			0x810
> +#define CX_SRC			0x814
> +#define CX_DST			0x818
> +#define CX_CONFIG		0x81c
> +#define AXI_CONFIG		0x820
> +#define DEF_AXI_CONFIG		0x201201
> +
> +#define CX_LLI_CHAIN_EN		0x2
> +#define CCFG_EN			0x1
> +#define CCFG_MEM2PER		(0x1 << 2)
> +#define CCFG_PER2MEM		(0x2 << 2)
> +#define CCFG_SRCINCR		(0x1 << 31)
> +#define CCFG_DSTINCR		(0x1 << 30)
I see these are not namespace aptly and can collide..

> +static int k3_dma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
> +	unsigned long arg)
> +{
> +	struct k3_dma_chan *c = to_k3_chan(chan);
> +	struct k3_dma_dev *d = to_k3_dma(chan->device);
> +	struct dma_slave_config *cfg = (void *)arg;
> +	struct k3_dma_phy *p = NULL;
> +	unsigned long flags;
> +	u32 maxburst = 0, val = 0;
> +	enum dma_slave_buswidth width = DMA_SLAVE_BUSWIDTH_UNDEFINED;
> +	LIST_HEAD(head);
> +
> +	if (c)
> +		p = c->phy;
> +
> +	switch (cmd) {
> +	case DMA_SLAVE_CONFIG:
> +		if (cfg == NULL)
> +			return -EINVAL;
> +		c->dir = cfg->direction;
> +		if (c->dir == DMA_DEV_TO_MEM) {
> +			c->ccfg = CCFG_DSTINCR;
> +			c->dev_addr = cfg->src_addr;
> +			maxburst = cfg->src_maxburst;
> +			width = cfg->src_addr_width;
> +		} else if (c->dir == DMA_MEM_TO_DEV) {
> +			c->ccfg = CCFG_SRCINCR;
> +			c->dev_addr = cfg->dst_addr;
> +			maxburst = cfg->dst_maxburst;
> +			width = cfg->dst_addr_width;
> +		}
> +		switch (width) {
> +		case DMA_SLAVE_BUSWIDTH_1_BYTE:
> +			val = 0;
> +			break;
> +		case DMA_SLAVE_BUSWIDTH_2_BYTES:
> +			val = 1;
> +			break;
> +		case DMA_SLAVE_BUSWIDTH_4_BYTES:
> +			val = 2;
> +			break;
> +		case DMA_SLAVE_BUSWIDTH_8_BYTES:
> +			val = 3;
DMA_SLAVE_BUSWIDTHS are 1, 2, 4, 8...
so if you can do val = ffs(width) as well?


> +	case DMA_PAUSE:
> +		dev_dbg(d->slave.dev, "vchan %p: pause\n", &c->vc);
> +		if (c->status == DMA_IN_PROGRESS) {
> +			c->status = DMA_PAUSED;
> +			if (p) {
> +				k3_dma_pause_dma(p, false);
> +			} else {
> +				spin_lock(&d->lock);
> +				list_del_init(&c->node);
> +				spin_unlock(&d->lock);
> +			}
why do we need the else part here?

> +		}
> +		break;
> +
> +	case DMA_RESUME:
> +		dev_dbg(d->slave.dev, "vchan %p: resume\n", &c->vc);
> +		spin_lock_irqsave(&c->vc.lock, flags);
> +		if (c->status == DMA_PAUSED) {
> +			c->status = DMA_IN_PROGRESS;
> +			if (p) {
> +				k3_dma_pause_dma(p, true);
> +			} else if (!list_empty(&c->vc.desc_issued)) {
> +				spin_lock(&d->lock);
> +				list_add_tail(&c->node, &d->chan_pending);
> +				spin_unlock(&d->lock);
> +			}
ditto?

> +		}
> +		spin_unlock_irqrestore(&c->vc.lock, flags);
> +		break;
> +	default:
> +		return -ENXIO;
> +	}
> +	return 0;
> +}
> +

> +
> +#ifdef CONFIG_PM_SLEEP
> +static int k3_dma_pltfm_suspend(struct device *dev)
> +{
> +	struct k3_dma_dev *d = dev_get_drvdata(dev);
> +	u32 stat = 0;
> +
> +	stat = k3_dma_get_chan_stat(d);
> +	if (stat) {
> +		dev_warn(d->slave.dev,
> +			"chan %d is running fail to suspend\n", stat);
> +		return -1;
> +	}
> +	k3_dma_enable_dma(d, false);
> +	clk_disable_unprepare(d->clk);
> +	return 0;
> +}
> +
> +static int k3_dma_pltfm_resume(struct device *dev)
> +{
> +	struct k3_dma_dev *d = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	ret = clk_prepare_enable(d->clk);
> +	if (ret < 0) {
> +		dev_err(d->slave.dev, "clk_prepare_enable failed: %d\n", ret);
> +		return -EINVAL;
> +	}
> +	k3_dma_enable_dma(d, true);
> +	return 0;
> +}
> +#else
> +#define k3_dma_pltfm_suspend	NULL
> +#define k3_dma_pltfm_resume	NULL
> +#endif /* CONFIG_PM_SLEEP */
you dont need #ifdef here, then whats the use of SIMPLE_DEV_PM_OPS below?
> +
> +SIMPLE_DEV_PM_OPS(k3_dma_pltfm_pmops, k3_dma_pltfm_suspend, k3_dma_pltfm_resume);
pltfm... can we skip this or use platform, plat...
> +
> +static struct platform_driver k3_pdma_driver = {
> +	.driver		= {
> +		.name	= DRIVER_NAME,
> +		.owner  = THIS_MODULE,
> +		.pm	= &k3_dma_pltfm_pmops,
> +		.of_match_table = k3_pdma_dt_ids,
> +	},
> +	.probe		= k3_dma_probe,
> +	.remove		= k3_dma_remove,
> +};
> +
> +module_platform_driver(k3_pdma_driver);
> +
> +MODULE_DESCRIPTION("Hisilicon k3 DMA Driver");
> +MODULE_LICENSE("GPL v2");
MODULE_ALIAS?

~Vinod
