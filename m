From: yt.shen@mediatek.com (YT Shen)
Date: Mon, 12 Sep 2016 18:16:00 +0800
Subject: [PATCH v7 6/9] drm/mediatek: add dsi interrupt control
In-Reply-To: <1473212348.11736.16.camel@mtksdaap41>
References: <1472815484-43821-1-git-send-email-yt.shen@mediatek.com>
 <1472815484-43821-7-git-send-email-yt.shen@mediatek.com>
 <1473212348.11736.16.camel@mtksdaap41>
Message-ID: <1473675360.12398.25.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi CK,

On Wed, 2016-09-07 at 09:39 +0800, CK Hu wrote:
> Hi, YT:
> 
> On Fri, 2016-09-02 at 19:24 +0800, YT Shen wrote:
> > From: shaoming chen <shaoming.chen@mediatek.com>
> > 
> > add dsi interrupt control
> > 
> > Signed-off-by: shaoming chen <shaoming.chen@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dsi.c | 76 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> > 
> 
> [snip...]
> 
> >  
> > +static wait_queue_head_t _dsi_irq_wait_queue;
> 
> I think it's better to move this global variable into platform driver
> data. Maybe one day you have two dsi device and one global variable is
> not enough.
OK, we will move _dsi_irq_wait_queue into platform driver data.

> 
> > +
> 
> [snip...]
> 
> > +
> > +static irqreturn_t mtk_dsi_irq(int irq, void *dev_id)
> > +{
> > +	struct mtk_dsi *dsi = dev_id;
> > +	u32 status, tmp;
> > +	u32 flag = LPRX_RD_RDY_INT_FLAG | CMD_DONE_INT_FLAG | VM_DONE_INT_FLAG;
> > +
> > +	status = readl(dsi->regs + DSI_INTSTA);
> 
> If you define as
> 
> status = readl(dsi->regs + DSI_INTSTA) & flag;
> 
> You can remove 'flag' in below statements and reduce code size.
Will do.

> 
> > +
> > +	if (status & flag) {
> > +		do {
> > +			mtk_dsi_mask(dsi, DSI_RACK, RACK, RACK);
> > +			tmp = readl(dsi->regs + DSI_INTSTA);
> > +		} while (tmp & DSI_BUSY);
> > +
> > +		mtk_dsi_mask(dsi, DSI_INTSTA, status & flag, 0);
> > +		mtk_dsi_irq_data_set(dsi, status & flag);
> > +		wake_up_interruptible(&_dsi_irq_wait_queue);
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> 
> [snip...]
> 
> >  
> > @@ -869,8 +926,27 @@ static int mtk_dsi_probe(struct platform_device *pdev)
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
> 
> You use devm_kzalloc() to allocate 'dsi', so this statement is
> redundant.
Will remove.

Regards,
yt.shen

> 
> > +	dev_info(dev, "dsi irq num is 0x%x\n", irq_num);
> > +
> >  	platform_set_drvdata(pdev, dsi);
> >  
> > +	init_waitqueue_head(&_dsi_irq_wait_queue);
> > +
> >  	return component_add(&pdev->dev, &mtk_dsi_component_ops);
> >  }
> 
> 
> Regards,
> CK 
> 
> 
