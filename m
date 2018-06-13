From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Wed, 13 Jun 2018 16:52:08 +0800
Subject: [PATCH 13/28] drm/mediatek: add connection from RDMA0 to DSI3
In-Reply-To: <1528877112.30263.24.camel@mtksdaap41>
References: <1528687580-549-1-git-send-email-stu.hsieh@mediatek.com>
 <1528687580-549-14-git-send-email-stu.hsieh@mediatek.com>
 <1528868751.15127.10.camel@mtksdaap41>
 <1528875983.11190.29.camel@mtksdccf07>
 <1528877112.30263.24.camel@mtksdaap41>
Message-ID: <1528879928.11190.39.camel@mtksdccf07>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, CK:

On Wed, 2018-06-13 at 16:05 +0800, CK Hu wrote:
> Hi, Stu:
> 
> On Wed, 2018-06-13 at 15:46 +0800, Stu Hsieh wrote:
> > Hi, CK:
> > 
> > On Wed, 2018-06-13 at 13:45 +0800, CK Hu wrote:
> > > Hi, Stu:
> > > 
> > > Two inline comment.
> > > 
> > > On Mon, 2018-06-11 at 11:26 +0800, Stu Hsieh wrote:
> > > > This patch add the connection from RDMA0 to DSI3
> > > > 
> > > > Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> > > > ---
> > > >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c      | 4 ++++
> > > >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 2 +-
> > > >  2 files changed, 5 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > > > index c08aed8dae44..fed1b5704355 100644
> > > > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > > > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > > > @@ -83,6 +83,7 @@
> > > >  #define GAMMA_MOUT_EN_RDMA1		0x1
> > > >  #define RDMA0_MOUT_DPI0			0x2
> > > >  #define RDMA0_MOUT_DSI2			0x4
> > > > +#define RDMA0_MOUT_DSI3			0x5
> > > 
> > > Usually, each bit of a mout register represent a output enable. Is this
> > > value 0x5 is a correct value?
> > 
> > In hw CONFIG SPEC show as following:
> > Bit(s)	Name			Description
> > 2:0	DISP_PATH0_SOUT_SEL_IN	0 : Output to DSI0
> > 				1:  Ooutput to DSI1
> > 				2:  Ooutput to DPI
> > 				3:  Ooutput to DPI1
> > 				4:  Ooutput to DSI2
> > 				5:  Ooutput to DSI3
> > 				6 : reserved
> > 				7:  Ooutput to DISP_UFOE
> > So, the value 0x5 is correct value.
> > 
> 
> From the definition, it looks like that RDMA0 could only single output
> (output to only one destination at one moment). The register naming
> 'DISP_REG_CONFIG_DISP_RDMA0_MOUT_EN' (MOUT means output to multiple
> destination simultaneously) would confuse me. If the data sheet use the
> confused naming, I think I could just accept it.
> 
> Regards,
> CK
> 
OK, I would change the definition name from
DISP_REG_CONFIG_DISP_RDMA0_MOUT_EN to DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN

> > Regard,
> > Stu
> > 
> > > 
> > > >  #define RDMA1_MOUT_DPI0			0x2
> > > >  #define DPI0_SEL_IN_RDMA1		0x1
> > > >  #define COLOR1_SEL_IN_OVL1		0x1
> > > > @@ -164,6 +165,9 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
> > > >  	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DSI2) {
> > > >  		*addr = DISP_REG_CONFIG_DISP_RDMA0_MOUT_EN;
> > > >  		value = RDMA0_MOUT_DSI2;
> > > > +	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DSI3) {
> > > > +		*addr = DISP_REG_CONFIG_DISP_RDMA0_MOUT_EN;
> > > > +		value = RDMA0_MOUT_DSI3;
> > > >  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
> > > >  		*addr = DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN;
> > > >  		value = RDMA1_MOUT_DPI0;
> > > > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > > > index fe6fdc021fc7..22f4c72fa785 100644
> > > > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > > > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > > > @@ -228,7 +228,7 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
> > > >  	[DDP_COMPONENT_DSI0]	= { MTK_DSI,		0, NULL },
> > > >  	[DDP_COMPONENT_DSI1]	= { MTK_DSI,		1, NULL },
> > > >  	[DDP_COMPONENT_DSI2]	= { MTK_DSI,		2, NULL },
> > > > -	[DDP_COMPONENT_DSI2]	= { MTK_DSI,		3, NULL },
> > > > +	[DDP_COMPONENT_DSI3]	= { MTK_DSI,		3, NULL },
> > > 
> > > I think this is not related to this patch.
> > OK
> > 
> > > 
> > > Regards,
> > > CK
> > > 
> > > >  	[DDP_COMPONENT_GAMMA]	= { MTK_DISP_GAMMA,	0, &ddp_gamma },
> > > >  	[DDP_COMPONENT_OD0]	= { MTK_DISP_OD,	0, &ddp_od },
> > > >  	[DDP_COMPONENT_OD1]	= { MTK_DISP_OD,	1, &ddp_od },
> > > 
> > > 
> > 
> > 
> 
> 
