From: ck.hu@mediatek.com (CK Hu)
Date: Thu, 28 Jul 2016 17:41:05 +0800
Subject: [PATCH v4 4/8] drm/mediatek: add support for Mediatek SoC MT2701
In-Reply-To: <1469690256.28644.42.camel@mtksdaap41>
References: <1468577274-6178-1-git-send-email-yt.shen@mediatek.com>
 <1468577274-6178-5-git-send-email-yt.shen@mediatek.com>
 <1468997599.11841.49.camel@mtksdaap41>
 <1469529774.4678.34.camel@mtksdaap41>
 <1469613816.2470.50.camel@pengutronix.de>
 <1469671655.11841.85.camel@mtksdaap41>
 <1469690256.28644.42.camel@mtksdaap41>
Message-ID: <1469698865.11841.94.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, YT:


On Thu, 2016-07-28 at 15:17 +0800, YT Shen wrote:
> Hi Philipp, CK,
> 
> On Thu, 2016-07-28 at 10:07 +0800, CK Hu wrote:
> > Hi, YT:
> > 
> > On Wed, 2016-07-27 at 12:03 +0200, Philipp Zabel wrote:
> > > Am Dienstag, den 26.07.2016, 18:42 +0800 schrieb YT Shen:
> > > > Hi CK,
> > > > 
> > > > On Wed, 2016-07-20 at 14:53 +0800, CK Hu wrote:
> > > > > Hi, YT:
> > > > > 
> > > > > Some comments inline.
> > > > > 
> > > > > On Fri, 2016-07-15 at 18:07 +0800, YT Shen wrote:
> > > > > > This patch add support for the Mediatek MT2701 DISP subsystem.
> > > > > > There is only one OVL engine in MT2701.
> > > > > > 
> > > > > > Signed-off-by: YT Shen <yt.shen@mediatek.com>
> > > > > > ---
> > > > > >  drivers/gpu/drm/mediatek/mtk_disp_ovl.c     |    6 ++++
> > > > > >  drivers/gpu/drm/mediatek/mtk_disp_rdma.c    |    6 ++++
> > > > > >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c      |   41 +++++++++++++++++++++++++++
> > > > > >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |    7 +++++
> > > > > >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |    1 +
> > > > > >  drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   31 ++++++++++++++++++++
> > > > > >  6 files changed, 92 insertions(+)
> > > > > > 
> > > > > 
> > > > > [snip...]
> > > > > 
> > > > > >  
> > > > > >  static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
> > > > > > +	{ .compatible = "mediatek,mt2701-disp-ovl",   .data = (void *)MTK_DISP_OVL },
> > > > > >  	{ .compatible = "mediatek,mt8173-disp-ovl",   .data = (void *)MTK_DISP_OVL },
> > > > > > +	{ .compatible = "mediatek,mt2701-disp-rdma",  .data = (void *)MTK_DISP_RDMA },
> > > > > >  	{ .compatible = "mediatek,mt8173-disp-rdma",  .data = (void *)MTK_DISP_RDMA },
> > > > > > +	{ .compatible = "mediatek,mt2701-disp-wdma",  .data = (void *)MTK_DISP_WDMA },
> > > > > 
> > > > > Is WDMA different from MT8173 to MT2701. If they are the same, you need
> > > > > not to add compatible of 'mediatek,mt2701-disp-wdma' because use
> > > > > 'mediatek,mt8173-disp-wdma' is enough.
> > > > Yes, the hardware has differences, so we need add new compatible
> > > > 'mt2701-disp-wdma'
> > > 
> > > It would be nice if you could add a short paragraph to the patch
> > > description about what the hardware differences are (probably just
> > > changed register layout in most cases).
> Thanks for the suggestions, we will add more descriptions in the future.
> 
> > 
> > If you don't want to add description, you may separate the modification
> > of OVL, RDMA, WDMA, PWM to different patch. And you send patch of OVL
> > and RDMA first because you have related code modification for these two.
> > You temporarily treat WDMA and PWM as MT8173 and it works. And one day
> > you need to modify code of WDMA and PWM for MT2701, then you send the
> > patch of WDMA and PWM and you need not to add any description because we
> > can find out the difference from source code.
> 
> The display module connections is shown in mt2701_mtk_ddp_main[] and
> mt2701_mtk_ddp_ext[].
> OVL -> RDMA -> COLOR -> BLS(pwm) -> DSI
> RDMA -> DPI
> 
> This patch series mainly focus on DSI support for MT2701 SoC and the
> basic functions.  The BLS(pwm) and DPI parts are not included here.
> 
> We will remove 'mt2701-disp-wdma'. We didn't implement its driver and it
> is unused now.
> 
> For the pwm part, we need the device node to establish the display
> module connections.  The pwm compatible string is described in
> "dt-bindings: pwm: Add MediaTek display PWM bindings" [1] and the
> control is implemented in "pwm: Add MediaTek MT2701 display PWM driver
> support" [2].
> 
> For the dpi part, we need the device node to establish the display
> module connections.  The dpi patch will be in another patch series,
> split out from "drm/mediatek: fix the wrong pixel clock when resolution
> is 4K" [3].

For dpi part, I think you need not to include it in this patch. You can
send it with the MT2701 DPI patch. For module connection, you can use
"mediatek,mt8173-dpi" and it works. If you want to add it in this patch,
please describe the difference of mt8173-dpi and mt2701-dpi in this
patch.

> 
> 
> [1] https://patchwork.kernel.org/patch/9222997/
> [2] https://patchwork.kernel.org/patch/9223001/
> [3] https://patchwork.kernel.org/patch/9249471/ 
> 
> Regards,
> yt.shen
> 
> > 
> > > 
> > > regards
> > > Philipp
> > > 
> > 
> > Regards,
> > CK
> > 
> 
> 

Regards,
CK
