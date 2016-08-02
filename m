From: yt.shen@mediatek.com (YT Shen)
Date: Tue, 2 Aug 2016 17:14:15 +0800
Subject: [PATCH v5 06/10] drm/mediatek: add dsi interrupt control
In-Reply-To: <1470118057.16554.5.camel@mtksdaap41>
References: <1469698084-20185-1-git-send-email-yt.shen@mediatek.com>
 <1469698084-20185-7-git-send-email-yt.shen@mediatek.com>
 <1470118057.16554.5.camel@mtksdaap41>
Message-ID: <1470129255.30671.12.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi CK,

On Tue, 2016-08-02 at 14:07 +0800, CK Hu wrote:
> Hi, YT:
> 
> On Thu, 2016-07-28 at 17:28 +0800, YT Shen wrote:
> > From: shaoming chen <shaoming.chen@mediatek.com>
> > 
> > add dsi interrupt control
> > 
> > Signed-off-by: shaoming chen <shaoming.chen@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dsi.c |   92 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 92 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > index a9cf5a1..553443a 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > @@ -18,6 +18,7 @@
> >  #include <drm/drm_panel.h>
> >  #include <linux/clk.h>
> >  #include <linux/component.h>
> > +#include <linux/irq.h>
> >  #include <linux/of.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/of_graph.h>
> > @@ -29,6 +30,17 @@
> >  
> >  #define DSI_START		0x00
> >  
> > +#define DSI_INTEN		0x08
> > +
> > +#define DSI_INTSTA		0x0c
> > +#define LPRX_RD_RDY_INT_FLAG		BIT(0)
> > +#define CMD_DONE_INT_FLAG		BIT(1)
> > +#define TE_RDY_INT_FLAG			BIT(2)
> > +#define VM_DONE_INT_FLAG		BIT(3)
> > +#define EXT_TE_RDY_INT_FLAG		BIT(4)
> > +#define DSI_INT_ALL_BITS		0x7f
> > +#define DSI_BUSY			BIT(31)
> > +
> >  #define DSI_CON_CTRL		0x10
> >  #define DSI_RESET			BIT(0)
> >  #define DSI_EN				BIT(1)
> > @@ -71,6 +83,9 @@
> >  
> >  #define DSI_HSTX_CKL_WC		0x64
> >  
> > +#define DSI_RACK		0x84
> > +#define RACK				BIT(0)
> > +
> >  #define DSI_PHY_LCCON		0x104
> >  #define LC_HS_TX_EN			BIT(0)
> >  #define LC_ULPM_EN			BIT(1)
> > @@ -131,8 +146,13 @@ struct mtk_dsi {
> >  	struct videomode vm;
> >  	int refcount;
> >  	bool enabled;
> > +	int irq_data;
> >  };
> >  
> > +static wait_queue_head_t _dsi_cmd_done_wait_queue;
> > +static wait_queue_head_t _dsi_dcs_read_wait_queue;
> > +static wait_queue_head_t _dsi_wait_vm_done_queue;
> 
> I think for difference irq status we can use only one wait queue. So
> multiple client wait on the same wait queue, but each client has
> different wake up condition.
Yes, we will implement only one wait queue to handle different irq
status here.

> 
> > +
> >  static inline struct mtk_dsi *encoder_to_dsi(struct drm_encoder *e)
> >  {
> >  	return container_of(e, struct mtk_dsi, encoder);
> > @@ -437,6 +457,55 @@ static void mtk_dsi_start(struct mtk_dsi *dsi)
> >  	writel(1, dsi->regs + DSI_START);
> >  }
> >  
> > +static void mtk_dsi_set_interrupt_enable(struct mtk_dsi *dsi)
> > +{
> > +	u32 inten = DSI_INT_ALL_BITS;
> > +
> > +	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO)
> > +		inten &= ~(TE_RDY_INT_FLAG | EXT_TE_RDY_INT_FLAG);
> > +
> > +	writel(inten, dsi->regs + DSI_INTEN);
> > +}
> > +
> > +static void mtk_dsi_irq_wakeup(struct mtk_dsi *dsi, u32 irq_bit)
> > +{
> > +	dsi->irq_data |= irq_bit;
> > +}
> > +
> > +static irqreturn_t mtk_dsi_irq(int irq, void *dev_id)
> > +{
> > +	struct mtk_dsi *dsi = dev_id;
> > +
> > +	u32 status, tmp;
> > +
> > +	status = readl(dsi->regs + DSI_INTSTA);
> > +
> > +	if (status & LPRX_RD_RDY_INT_FLAG) {
> > +		do {
> > +			mtk_dsi_mask(dsi, DSI_RACK, RACK, RACK);
> > +			tmp = readl(dsi->regs + DSI_INTSTA);
> > +		} while (tmp & DSI_BUSY);
> > +
> > +		mtk_dsi_mask(dsi, DSI_INTSTA, LPRX_RD_RDY_INT_FLAG, 0);
> > +		mtk_dsi_irq_wakeup(dsi, LPRX_RD_RDY_INT_FLAG);
> > +		wake_up_interruptible(&_dsi_dcs_read_wait_queue);
> > +	}
> > +
> > +	if (status & CMD_DONE_INT_FLAG) {
> > +		mtk_dsi_mask(dsi, DSI_INTSTA, CMD_DONE_INT_FLAG, 0);
> > +		mtk_dsi_irq_wakeup(dsi, CMD_DONE_INT_FLAG);
> > +		wake_up_interruptible(&_dsi_cmd_done_wait_queue);
> > +	}
> > +
> > +	if (status & VM_DONE_INT_FLAG) {
> > +		mtk_dsi_mask(dsi, DSI_INTSTA, VM_DONE_INT_FLAG, 0);
> > +		mtk_dsi_irq_wakeup(dsi, VM_DONE_INT_FLAG);
> > +		wake_up_interruptible(&_dsi_wait_vm_done_queue);
> > +	}
> 
> I think these three part can be merged into one.
> u32 deal_status = LPRX_RD_RDY_INT_FLAG | CMD_DONE_INT_FLAG |
> VM_DONE_INT_FLAG;
> if (status & deal_status) {
>     mtk_dsi_mask(dsi, DSI_INTSTA, deal_status, 0);
>     mtk_dsi_irq_wakeup(dsi, status & deal_status);
>     wake_up_interruptible(&_dsi_irq_wait_queue);
> }
> 
> Otherwise, why enable DSI_INT_ALL_BITS, but deal only
> LPRX_RD_RDY_INT_FLAG, CMD_DONE_INT_FLAG, and VM_DONE_INT_FLAG?
OK, we will merge these parts into one and update the definition of
DSI_INT_ALL_BITS.

Regards,
yt.shen

> 
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> >  static void mtk_dsi_poweroff(struct mtk_dsi *dsi)
> >  {
> >  	if (WARN_ON(dsi->refcount == 0))
> > @@ -485,6 +554,7 @@ static void mtk_output_dsi_enable(struct mtk_dsi *dsi)
> >  
> >  	mtk_dsi_ps_control_vact(dsi);
> >  	mtk_dsi_config_vdo_timing(dsi);
> > +	mtk_dsi_set_interrupt_enable(dsi);
> >  
> >  	mtk_dsi_set_mode(dsi);
> >  	mtk_dsi_clk_hs_mode(dsi, 1);
> > @@ -804,6 +874,7 @@ static int mtk_dsi_probe(struct platform_device *pdev)
> >  	struct device *dev = &pdev->dev;
> >  	struct device_node *remote_node, *endpoint;
> >  	struct resource *regs;
> > +	int irq_num;
> >  	int comp_id;
> >  	int ret;
> >  
> > @@ -880,8 +951,29 @@ static int mtk_dsi_probe(struct platform_device *pdev)
> >  		return ret;
> >  	}
> >  
> > +	irq_num = platform_get_irq(pdev, 0);
> > +	if (irq_num < 0) {
> > +		dev_err(&pdev->dev, "failed to request dsi irq resource\n");
> > +		return -EPROBE_DEFER;
> > +	}
> > +
> > +	irq_set_status_flags(irq_num, IRQ_TYPE_LEVEL_LOW);
> > +	ret = devm_request_irq(&pdev->dev, irq_num, mtk_dsi_irq,
> > +			       IRQF_TRIGGER_LOW, dev_name(&pdev->dev), dsi);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "failed to request mediatek dsi irq\n");
> > +		return -EPROBE_DEFER;
> > +	}
> > +
> > +	dsi->irq_data = 0;
> > +	dev_info(dev, "dsi irq num is 0x%x\n", irq_num);
> > +
> >  	platform_set_drvdata(pdev, dsi);
> >  
> > +	init_waitqueue_head(&_dsi_cmd_done_wait_queue);
> > +	init_waitqueue_head(&_dsi_dcs_read_wait_queue);
> > +	init_waitqueue_head(&_dsi_wait_vm_done_queue);
> > +
> >  	return component_add(&pdev->dev, &mtk_dsi_component_ops);
> >  }
> >  
> 
> Regards,
> CK
> 
