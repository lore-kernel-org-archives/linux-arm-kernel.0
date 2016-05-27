From: yt.shen@mediatek.com (YT Shen)
Date: Fri, 27 May 2016 15:29:00 +0800
Subject: [RFC v2 2/5] drm/mediatke: add support for Mediatek SoC MT2701
In-Reply-To: <1463994590.31921.14.camel@mtksdaap41>
References: <1463756736-46573-1-git-send-email-yt.shen@mediatek.com>
 <1463756736-46573-3-git-send-email-yt.shen@mediatek.com>
 <1463994590.31921.14.camel@mtksdaap41>
Message-ID: <1464334140.31149.14.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi CK,


On Mon, 2016-05-23 at 17:09 +0800, CK Hu wrote:
> Hi, YT:
> 
> Some comments below.
> 
> On Fri, 2016-05-20 at 23:05 +0800, yt.shen at mediatek.com wrote:
> > From: YT Shen <yt.shen@mediatek.com>
> > 
> > This patch add support for the Mediatek MT2701 DISP subsystem.
> > There is only one OVL engine in MT2701.
> > 
> > Signed-off-by: YT Shen <yt.shen@mediatek.com>
> >  
> > +static void mtk_ddp_mux_sel(void __iomem *config_regs,
> > +			    enum mtk_ddp_comp_id cur, enum mtk_ddp_comp_id next)
> > +{
> > +	if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0) {
> > +		writel_relaxed(BLS_TO_DSI_RDMA1_TO_DPI1,
> > +			       config_regs + DISP_REG_CONFIG_OUT_SEL);
> > +	}
> > +}
> > +
> 
> The function name 'mux' looks strange. The register written here
> controls the single output selection. I prefer to rename it as
> mtk_ddp_sout_sel().
OK, I will rename this function in the next version.
> 
> >  
> > -static const enum mtk_ddp_comp_id mtk_ddp_main[] = {
> > +static const enum mtk_ddp_comp_id mtk_ddp_main_2701[] = {
> > +	DDP_COMPONENT_OVL0,
> > +	DDP_COMPONENT_RDMA0,
> > +	DDP_COMPONENT_COLOR0,
> > +	DDP_COMPONENT_BLS,
> > +	DDP_COMPONENT_DSI0,
> > +};
> > +
> > +static const enum mtk_ddp_comp_id mtk_ddp_ext_2701[] = {
> > +	DDP_COMPONENT_OVL0,
> > +	DDP_COMPONENT_DSI0,
> > +};
> > +
> 
> These two pipelines has the same component such as OVL0 and DSI0. I
> think user program could not enable both crtc at the same time. Maybe
> MT2701 has only one crtc, so you should modify initial flow to create
> only one crtc for main display. Or it's typo for external display pipe,
> please correct it.
MT2701 hardware can support two output concurrently, but we haven't
implement DPI path yet.  We will change it like this:
static const enum mtk_ddp_comp_id mtk_ddp_ext_2701[] = {
	DDP_COMPONENT_RDMA1,
	DDP_COMPONENT_DPI0,
};

Thanks.
yt.shen
> 
> 
> Regards,
> CK
> 
