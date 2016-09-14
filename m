From: ck.hu@mediatek.com (CK Hu)
Date: Wed, 14 Sep 2016 15:34:57 +0800
Subject: [PATCH v7 7/9] drm/mediatek: add dsi transfer function
In-Reply-To: <1473837742.24354.28.camel@mtksdaap41>
References: <1472815484-43821-1-git-send-email-yt.shen@mediatek.com>
 <1472815484-43821-8-git-send-email-yt.shen@mediatek.com>
 <1473215632.11736.21.camel@mtksdaap41>
 <1473675381.12398.27.camel@mtksdaap41>
 <1473758754.28437.40.camel@mtksdaap41>
 <1473833946.24354.8.camel@mtksdaap41> <1473835151.10216.2.camel@mtksdaap41>
 <1473837742.24354.28.camel@mtksdaap41>
Message-ID: <1473838497.10216.5.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, YT:

On Wed, 2016-09-14 at 15:22 +0800, YT Shen wrote:
> Hi CK,
> 
> On Wed, 2016-09-14 at 14:39 +0800, CK Hu wrote:
> > Hi, YT:
> > 
> > On Wed, 2016-09-14 at 14:19 +0800, YT Shen wrote:
> > > Hi CK,
> > > 
> > > On Tue, 2016-09-13 at 17:25 +0800, CK Hu wrote:
> > > > Hi, YT:
> > > > 
> > > > On Mon, 2016-09-12 at 18:16 +0800, YT Shen wrote:
> > > > > Hi CK,
> > > > > 
> > > > > On Wed, 2016-09-07 at 10:33 +0800, CK Hu wrote:
> > > > > > Hi, YT:
> > > > > > 
> > > > > > On Fri, 2016-09-02 at 19:24 +0800, YT Shen wrote:
> > > > > > > From: shaoming chen <shaoming.chen@mediatek.com>
> > > > > > > 
> > > > > > > add dsi read/write commands for transfer function
> > > > > > > 
> > > > > > > Signed-off-by: shaoming chen <shaoming.chen@mediatek.com>
> > > > > > > ---
> > > > > > >  drivers/gpu/drm/mediatek/mtk_dsi.c | 188 +++++++++++++++++++++++++++++++++++++
> > > > > > >  1 file changed, 188 insertions(+)
> > > > > > > 
> > > > > > 
> > > > > > [snip...]
> > > > > > 
> > > > > > >  
> > > > > > > +static void mtk_dsi_irq_data_clear(struct mtk_dsi *dsi, u32 irq_bit)
> > > > > > > +{
> > > > > > > +	dsi->irq_data &= ~irq_bit;
> > > > > > > +}
> > > > > > > +
> > > > > > 
> > > > > > [snip...]
> > > > > > 
> > > > > > > +
> > > > > > > +static s32 mtk_dsi_wait_for_irq_done(struct mtk_dsi *dsi, u32 irq_flag,
> > > > > > > +				     unsigned int timeout)
> > > > > > > +{
> > > > > > > +	s32 ret = 0;
> > > > > > > +	unsigned long jiffies = msecs_to_jiffies(timeout);
> > > > > > > +
> > > > > > > +	ret = wait_event_interruptible_timeout(_dsi_irq_wait_queue,
> > > > > > > +					       dsi->irq_data & irq_flag,
> > > > > > > +					       jiffies);
> > > > > > > +	if (ret == 0) {
> > > > > > > +		dev_info(dsi->dev, "Wait DSI IRQ(0x%08x) Timeout\n", irq_flag);
> > > > > > > +
> > > > > > > +		mtk_dsi_enable(dsi);
> > > > > > > +		mtk_dsi_reset_engine(dsi);
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	return ret;
> > > > > > > +}
> > > > > > 
> > > > > > I think mtk_dsi_irq_data_clear() and mtk_dsi_wait_for_irq_done() should
> > > > > > be moved to the 6th patch [1] of this series because these two functions
> > > > > > deal the irq control.
> > > > > We will move mtk_dsi_irq_data_clear() to patch "drm/mediatek: add dsi
> > > > > interrupt control" and put mtk_dsi_wait_for_irq_done() here, because it
> > > > > is used in the transfer function.
> > > > 
> > > > mtk_dsi_irq_data_clear() is also only used in transfer function now. I
> > > > think both function could be used for other application rather than
> > > > transfer function, so these two function are general function for irq
> > > > control.
> > > We will rollback the changes here.  Move mtk_dsi_irq_data_clear() to
> > > original place.
> > > 
> > > Add new functions could be used in the future will have problems.
> > > warning: 'mtk_dsi_wait_for_irq_done' defined but not used
> > > [-Wunused-function]
> > >  static s32 mtk_dsi_wait_for_irq_done(struct mtk_dsi *dsi, u32 irq_flag,
> > > warning: 'mtk_dsi_irq_data_clear' defined but not used
> > > [-Wunused-function]
> > >  static void mtk_dsi_irq_data_clear(struct mtk_dsi *dsi, u32 irq_bit)
> > 
> > Please refer to [1], '__maybe_unused' can fix your problem.
> > 
> > [1]
> > http://lxr.free-electrons.com/source/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c#L76
> Add __maybe_unused just let GCC not produce a warning for this function.
> So you want add patch like this?
> 
> [PATCH v7 6/9] drm/mediatek: add dsi interrupt control
> +static __maybe_unused s32 mtk_dsi_wait_for_irq_done(struct mtk_dsi
> *dsi, u32 irq_flag,
> 
> +static __maybe_unused void mtk_dsi_irq_data_set(struct mtk_dsi *dsi,
> u32 irq_bit)
> 
> [PATCH v7 7/9] drm/mediatek: add dsi transfer function
> -static __maybe_unused s32 mtk_dsi_wait_for_irq_done(struct mtk_dsi
> *dsi, u32 irq_flag,
> +static s32 mtk_dsi_wait_for_irq_done(struct mtk_dsi *dsi, u32 irq_flag,
> 
> -static __maybe_unused void mtk_dsi_irq_data_clear(struct mtk_dsi *dsi,
> u32 irq_bit)
> +static void mtk_dsi_irq_data_clear(struct mtk_dsi *dsi, u32 irq_bit)
> 
> Put the static function earlier and add __maybe_unused annotations.
> Then remove _maybe_unused annotations later.  Or you want to keep
> __maybe_unused annotations inside?  Sounds unnecessary, it is different
> from your reference sharp_panel_read().

Removing '__maybe_unused' in later patch looks good to me.

Regards,
CK

> 
> > 
> > Regards,
> > CK
> > 
> > > 
> > > > Regards,
> > > > CK
> > > > 
> > > > > 
> > > > > Regards,
> > > > > yt.shen
> > > > > > 
> > > > > > 
> > > > > > [1] https://patchwork.kernel.org/patch/9310819/
> > > > > > 
> > > > > > 
> > > > > > Regards,
> > > > > > CK
> > > > > > 
> > > > > 
> > > > > 
> > > > 
> > > > 
> > > 
> > > 
> > 
> > 
> 
> 
