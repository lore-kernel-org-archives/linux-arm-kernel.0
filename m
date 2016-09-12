From: yt.shen@mediatek.com (YT Shen)
Date: Mon, 12 Sep 2016 18:16:21 +0800
Subject: [PATCH v7 7/9] drm/mediatek: add dsi transfer function
In-Reply-To: <1473215632.11736.21.camel@mtksdaap41>
References: <1472815484-43821-1-git-send-email-yt.shen@mediatek.com>
 <1472815484-43821-8-git-send-email-yt.shen@mediatek.com>
 <1473215632.11736.21.camel@mtksdaap41>
Message-ID: <1473675381.12398.27.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi CK,

On Wed, 2016-09-07 at 10:33 +0800, CK Hu wrote:
> Hi, YT:
> 
> On Fri, 2016-09-02 at 19:24 +0800, YT Shen wrote:
> > From: shaoming chen <shaoming.chen@mediatek.com>
> > 
> > add dsi read/write commands for transfer function
> > 
> > Signed-off-by: shaoming chen <shaoming.chen@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dsi.c | 188 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 188 insertions(+)
> > 
> 
> [snip...]
> 
> >  
> > +static void mtk_dsi_irq_data_clear(struct mtk_dsi *dsi, u32 irq_bit)
> > +{
> > +	dsi->irq_data &= ~irq_bit;
> > +}
> > +
> 
> [snip...]
> 
> > +
> > +static s32 mtk_dsi_wait_for_irq_done(struct mtk_dsi *dsi, u32 irq_flag,
> > +				     unsigned int timeout)
> > +{
> > +	s32 ret = 0;
> > +	unsigned long jiffies = msecs_to_jiffies(timeout);
> > +
> > +	ret = wait_event_interruptible_timeout(_dsi_irq_wait_queue,
> > +					       dsi->irq_data & irq_flag,
> > +					       jiffies);
> > +	if (ret == 0) {
> > +		dev_info(dsi->dev, "Wait DSI IRQ(0x%08x) Timeout\n", irq_flag);
> > +
> > +		mtk_dsi_enable(dsi);
> > +		mtk_dsi_reset_engine(dsi);
> > +	}
> > +
> > +	return ret;
> > +}
> 
> I think mtk_dsi_irq_data_clear() and mtk_dsi_wait_for_irq_done() should
> be moved to the 6th patch [1] of this series because these two functions
> deal the irq control.
We will move mtk_dsi_irq_data_clear() to patch "drm/mediatek: add dsi
interrupt control" and put mtk_dsi_wait_for_irq_done() here, because it
is used in the transfer function.

Regards,
yt.shen
> 
> 
> [1] https://patchwork.kernel.org/patch/9310819/
> 
> 
> Regards,
> CK
> 
