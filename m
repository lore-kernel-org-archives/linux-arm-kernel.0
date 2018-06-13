From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Wed, 13 Jun 2018 16:58:11 +0800
Subject: [PATCH 19/28] drm/mediatek: add connection from RDMA2 to DPI1
In-Reply-To: <1528877675.30263.27.camel@mtksdaap41>
References: <1528687580-549-1-git-send-email-stu.hsieh@mediatek.com>
 <1528687580-549-20-git-send-email-stu.hsieh@mediatek.com>
 <1528874037.30263.6.camel@mtksdaap41>
 <1528876862.11190.35.camel@mtksdccf07>
 <1528877675.30263.27.camel@mtksdaap41>
Message-ID: <1528880291.11190.45.camel@mtksdccf07>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, CK:

On Wed, 2018-06-13 at 16:14 +0800, CK Hu wrote:
> Hi, Stu:
> 
> On Wed, 2018-06-13 at 16:01 +0800, Stu Hsieh wrote:
> > Hi, CK:
> > 
> > 
> > On Wed, 2018-06-13 at 15:13 +0800, CK Hu wrote:
> > > Hi, Stu:
> > > 
> > > On Mon, 2018-06-11 at 11:26 +0800, Stu Hsieh wrote:
> > > > This patch add the connection from RDMA2 to DPI1
> > > > 
> > > > Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> > > > ---
> > > >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > > > index 31a0832ef9ec..2d883815d79c 100644
> > > > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > > > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > > > @@ -93,9 +93,11 @@
> > > >  #define RDMA1_MOUT_DPI0			0x2
> > > >  #define RDMA1_MOUT_DPI1			0x3
> > > >  #define RDMA2_MOUT_DPI0			0x2
> > > > +#define RDMA2_MOUT_DPI1			0x3
> > > 
> > > Usually, each bit of a mout register represent a output enable. Is this
> > > value 0x3 a correct value?
> > > 
> > > Regards,
> > > CK
> > > 
> > In HW CONFIG SPEC or MT2712_E2_MMSYS_Change_note show as following:
> > 
> > Bit(s)	Name			Description
> > 2:0	DISP_RDMA2_SOUT_SEL_IN	0: output to dsi0
> > 				1: outptu to dsi1
> > 				2: output to dpi0
> > 				3: output to dpi1
> > 				4: output to dsi2
> > 				5: output to dsi3
> > 
> > So, 0x3 is correct value.
> 
> The data sheet use the term SOUT match its function, so I think driver
> have better change the naming to SOUT.
> 
> Regards,
> CK
> 

The definition DISP_REG_CONFIG_DISP_RDMA2_SOUT is use term SOUT in this
patch.

Regard,
Stu

> > 
> > Regard,
> > Stu
> > 
> > > >  #define DPI0_SEL_IN_RDMA1		0x1
> > > >  #define DPI0_SEL_IN_RDMA2		0x3
> > > >  #define DPI1_SEL_IN_RDMA1		(0x1 << 8)
> > > > +#define DPI1_SEL_IN_RDMA2		(0x3 << 8)
> > > >  #define DSI1_SEL_IN_RDMA1		0x1
> > > >  #define DSI2_SEL_IN_RDMA1		(0x1 << 16)
> > > >  #define DSI3_SEL_IN_RDMA1		(0x1 << 16)
> > > > @@ -199,6 +201,9 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
> > > >  	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DPI0) {
> > > >  		*addr = DISP_REG_CONFIG_DISP_RDMA2_SOUT;
> > > >  		value = RDMA2_MOUT_DPI0;
> > > > +	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DPI1) {
> > > > +		*addr = DISP_REG_CONFIG_DISP_RDMA2_SOUT;
> > > > +		value = RDMA2_MOUT_DPI1;
> > > >  	} else {
> > > >  		value = 0;
> > > >  	}
> > > > @@ -233,6 +238,9 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
> > > >  	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DPI0) {
> > > >  		*addr = DISP_REG_CONFIG_DPI_SEL_IN;
> > > >  		value = DPI0_SEL_IN_RDMA2;
> > > > +	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DPI1) {
> > > > +		*addr = DISP_REG_CONFIG_DPI_SEL_IN;
> > > > +		value = DPI1_SEL_IN_RDMA2;
> > > >  	} else if (cur == DDP_COMPONENT_OVL1 && next == DDP_COMPONENT_COLOR1) {
> > > >  		*addr = DISP_REG_CONFIG_DISP_COLOR1_SEL_IN;
> > > >  		value = COLOR1_SEL_IN_OVL1;
> > > 
> > > 
> > 
> > 
> 
> 
