From: yt.shen@mediatek.com (YT Shen)
Date: Tue, 19 Jul 2016 19:08:38 +0800
Subject: [PATCH v4 5/8] drm/mediatek: add dsi interrupt control
In-Reply-To: <1468906767.30644.66.camel@mtksdaap41>
References: <1468577274-6178-1-git-send-email-yt.shen@mediatek.com>
 <1468577274-6178-6-git-send-email-yt.shen@mediatek.com>
 <1468906767.30644.66.camel@mtksdaap41>
Message-ID: <1468926518.24098.33.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi CK,

On Tue, 2016-07-19 at 13:39 +0800, CK Hu wrote:
> Hi, YT:
> 
> Some comments inline.
> 
> On Fri, 2016-07-15 at 18:07 +0800, YT Shen wrote:
> > From: shaoming chen <shaoming.chen@mediatek.com>
> > 
> > add dsi interrupt control
> > 
> > Signed-off-by: shaoming chen <shaoming.chen@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dsi.c |  130 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 130 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > index 2d808e5..de5ad7f 100644
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
> > @@ -32,6 +33,13 @@
> >  
> >  #define DSI_START		0x00
> >  
> > +#define DSI_INTEN		0x08
> > +
> > +#define DSI_INTSTA		0x0c
> > +#define LPRX_RD_RDY_INT_FLAG	BIT(0)
> > +#define CMD_DONE_INT_FLAG	BIT(1)
> > +#define DSI_BUSY		BIT(31)
> 
> Why need LPRX_RD_RDY_INT_FLAG, CMD_DONE_INT_FLAG, and DSI_BUSY? Maybe
> these three should be moved to other patch.
OK.

> 
> > +
> >  #define DSI_CON_CTRL		0x10
> >  #define DSI_RESET			BIT(0)
> >  #define DSI_EN				BIT(1)
> > @@ -74,6 +82,9 @@
> >  
> >  #define DSI_HSTX_CKL_WC		0x64
> >  
> > +#define DSI_RACK		0x84
> > +#define RACK			BIT(0)
> > +
> >  #define DSI_PHY_LCCON		0x104
> >  #define LC_HS_TX_EN			BIT(0)
> >  #define LC_ULPM_EN			BIT(1)
> > @@ -134,6 +145,18 @@ struct mtk_dsi {
> >  	struct videomode vm;
> >  	int refcount;
> >  	bool enabled;
> > +	int irq_num, irq_data;
> > +};
> > +
> > +enum {
> > +	DSI_INT_SLEEPOUT_DONE_FLAG	= BIT(6),
> > +	DSI_INT_VM_CMD_DONE_FLAG	= BIT(5),
> > +	DSI_INT_EXT_TE_RDY_FLAG		= BIT(4),
> > +	DSI_INT_VM_DONE_FLAG		= BIT(3),
> > +	DSI_INT_TE_RDY_FLAG		= BIT(2),
> > +	DSI_INT_CMD_DONE_FLAG		= BIT(1),
> > +	DSI_INT_LPRX_RD_RDY_FLAG	= BIT(0),
> > +	DSI_INT_ALL_BITS		= (0x7f)
> >  };
> 
> I think you should use '#define' instead of 'enum'. The code would be
> like below, and these definition should be moved to after DSI_INTEN or
> DSI_INTSTA.
> 
> #define DSI_INT_LPRX_RD_RDY_FLAG	BIT(0)
> #define DSI_INT_CMD_DONE_FLAG		BIT(1)
> #define DSI_INT_TE_RDY_FLAG		BIT(2)
> #define DSI_INT_VM_DONE_FLAG		BIT(3)
> #define DSI_INT_EXT_TE_RDY_FLAG		BIT(4)
> #define DSI_INT_VM_CMD_DONE_FLAG	BIT(5)
> #define DSI_INT_SLEEPOUT_DONE_FLAG	BIT(6)
> #define DSI_INT_ALL_BITS		(DSI_INT_LPRX_RD_RDY_FLAG | \
> 					DSI_INT_CMD_DONE_FLAG | \
> 					DSI_INT_TE_RDY_FLAG | \
> 					DSI_INT_VM_DONE_FLAG | \
> 					DSI_INT_EXT_TE_RDY_FLAG | \
> 					DSI_INT_VM_CMD_DONE_FLAG | \
> 					DSI_INT_SLEEPOUT_DONE_FLAG)
> 
I will update this part in the next version.

> >  
> >  static inline struct mtk_dsi *encoder_to_dsi(struct drm_encoder *e)
> > @@ -440,6 +463,94 @@ static void mtk_dsi_start(struct mtk_dsi *dsi)
> >  	writel(1, dsi->regs + DSI_START);
> >  }
> >  
> > +static void mtk_dsi_set_interrupt_enable(struct mtk_dsi *dsi)
> > +{
> > +	u32 inten = DSI_INT_ALL_BITS;
> > +
> > +	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO)
> > +		inten &= ~(DSI_INT_TE_RDY_FLAG | DSI_INT_EXT_TE_RDY_FLAG);
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
> > +	if (status & DSI_INT_LPRX_RD_RDY_FLAG) {
> > +		/* write clear RD_RDY interrupt */
> > +		/* write clear RD_RDY interrupt must be before DSI_RACK */
> > +		/* because CMD_DONE will raise after DSI_RACK, */
> > +		/* so write clear RD_RDY after that will clear CMD_DONE too */
> > +		do {
> > +			/* send read ACK */
> > +			mtk_dsi_mask(dsi, DSI_RACK, RACK, RACK);
> > +			tmp = readl(dsi->regs + DSI_INTSTA);
> > +		} while (tmp & DSI_BUSY);
> > +
> > +		mtk_dsi_mask(dsi, DSI_INTSTA, DSI_INT_LPRX_RD_RDY_FLAG, 0);
> > +		mtk_dsi_irq_wakeup(dsi, DSI_INT_LPRX_RD_RDY_FLAG);
> > +	}
> > +
> > +	if (status & DSI_INT_CMD_DONE_FLAG) {
> > +		mtk_dsi_mask(dsi, DSI_INTSTA, DSI_INT_CMD_DONE_FLAG, 0);
> > +		mtk_dsi_irq_wakeup(dsi, DSI_INT_CMD_DONE_FLAG);
> > +	}
> > +
> > +	if (status & DSI_INT_TE_RDY_FLAG) {
> > +		mtk_dsi_mask(dsi, DSI_INTSTA, DSI_INT_TE_RDY_FLAG, 0);
> > +		mtk_dsi_irq_wakeup(dsi, DSI_INT_TE_RDY_FLAG);
> > +	}
> > +
> > +	if (status & DSI_INT_VM_DONE_FLAG) {
> > +		mtk_dsi_mask(dsi, DSI_INTSTA, DSI_INT_VM_DONE_FLAG, 0);
> > +		mtk_dsi_irq_wakeup(dsi, DSI_INT_VM_DONE_FLAG);
> > +	}
> > +
> > +	if (status & DSI_INT_EXT_TE_RDY_FLAG) {
> > +		mtk_dsi_mask(dsi, DSI_INTSTA, DSI_INT_EXT_TE_RDY_FLAG, 0);
> > +		mtk_dsi_irq_wakeup(dsi, DSI_INT_EXT_TE_RDY_FLAG);
> > +	}
> > +
> > +	if (status & DSI_INT_VM_CMD_DONE_FLAG) {
> > +		mtk_dsi_mask(dsi, DSI_INTSTA, DSI_INT_VM_CMD_DONE_FLAG, 0);
> > +		mtk_dsi_irq_wakeup(dsi, DSI_INT_VM_CMD_DONE_FLAG);
> > +	}
> > +
> > +	if (status & DSI_INT_SLEEPOUT_DONE_FLAG) {
> > +		mtk_dsi_mask(dsi, DSI_INTSTA, DSI_INT_SLEEPOUT_DONE_FLAG, 0);
> > +		mtk_dsi_irq_wakeup(dsi, DSI_INT_SLEEPOUT_DONE_FLAG);
> > +	}
> 
> All these 'if' statement do the same thing and I think these could be
> merge as:
> 
> status = readl(dsi->regs + DSI_INTSTA) & DSI_INT_ALL_BITS);
> if (status) {
> 	mtk_dsi_mask(dsi, DSI_INTSTA, status, 0);
> 	mtk_dsi_irq_wakeup(dsi, status);
> }
Will do.

> 
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static s32 mtk_dsi_wait_for_irq_timeout(struct mtk_dsi *dsi, u32 irq_bit,
> > +					u32 timeout_ms)
> > +{
> > +	while (timeout_ms--) {
> > +		if (dsi->irq_data & irq_bit) {
> > +			dsi->irq_data &= ~irq_bit;
> > +			return 0;
> > +		}
> > +
> > +		usleep_range(1000, 1100);
> > +	}
> 
> I think it's better to use wait_event() or something else. Polling with
> sleep could not react immediately.
Will check.

> 
> > +
> > +	dsi->irq_data = 0;
> 
> Why clear all bit after wait one bit timeout?
Will check.

> 
> > +
> > +	return -1;
> > +}
> > +
> >  static void mtk_dsi_poweroff(struct mtk_dsi *dsi)
> >  {
> >  	if (WARN_ON(dsi->refcount == 0))
> > @@ -488,6 +599,7 @@ static void mtk_output_dsi_enable(struct mtk_dsi *dsi)
> >  
> >  	dsi_ps_control_vact(dsi);
> >  	dsi_config_vdo_timing(dsi);
> > +	mtk_dsi_set_interrupt_enable(dsi);
> >  
> >  	dsi_set_mode(dsi);
> >  	dsi_clk_hs_mode(dsi, 1);
> > @@ -883,6 +995,24 @@ static int mtk_dsi_probe(struct platform_device *pdev)
> >  		return ret;
> >  	}
> >  
> > +	dsi->irq_num = platform_get_irq(pdev, 0);
> 
> You use irq_num only in this function, why keep it in dsi structure?
OK, will remove it from dsi structure.

Regards,
yt.shen

> 
> > +	if (dsi->irq_num < 0) {
> > +		dev_err(&pdev->dev, "failed to request dsi irq resource\n");
> > +		ret = dsi->irq_num;
> > +		return -EPROBE_DEFER;
> > +	}
> > +
> > +	irq_set_status_flags(dsi->irq_num, IRQ_TYPE_LEVEL_LOW);
> > +	ret = devm_request_irq(&pdev->dev, dsi->irq_num, mtk_dsi_irq,
> > +			       IRQF_TRIGGER_LOW, dev_name(&pdev->dev), dsi);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "failed to request mediatek dsi irq\n");
> > +		return -EPROBE_DEFER;
> > +	}
> > +
> > +	dsi->irq_data = 0;
> > +	dev_info(dev, "dsi irq num is 0x%x\n", dsi->irq_num);
> > +
> >  	platform_set_drvdata(pdev, dsi);
> >  
> >  	return component_add(&pdev->dev, &mtk_dsi_component_ops);
> 
> Regards,
> CK
> 
