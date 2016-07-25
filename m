From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Mon, 25 Jul 2016 14:15:35 +0800
Subject: [PATCH 2/4] drm/mediatek: enhance the HDMI driving current
In-Reply-To: <1468998902.11841.54.camel@mtksdaap41>
References: <1468987385-37353-1-git-send-email-bibby.hsieh@mediatek.com>
 <1468987385-37353-3-git-send-email-bibby.hsieh@mediatek.com>
 <1468998902.11841.54.camel@mtksdaap41>
Message-ID: <1469427335.26205.12.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, CK,

I'm appreciate your comment.

On Wed, 2016-07-20 at 15:15 +0800, CK Hu wrote:
> Hi, Bibby:
> 
> One comment inline.
> 
> On Wed, 2016-07-20 at 12:03 +0800, Bibby Hsieh wrote:
> > From: Junzhi Zhao <junzhi.zhao@mediatek.com>
> > 
> > In order to improve 4K resolution performance,
> > we have to enhance the HDMI driving currend
> > when clock rate is greater than 165MHz.
> > 
> > Signed-off-by: Junzhi Zhao <junzhi.zhao@mediatek.com>
> > Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c |   89 +++++++++++++++++-------
> >  1 file changed, 63 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> > index 8a24754..a871c14 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> > @@ -298,32 +298,69 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> >  			  (0x1 << PLL_BR_SHIFT),
> >  			  RG_HDMITX_PLL_BP | RG_HDMITX_PLL_BC |
> >  			  RG_HDMITX_PLL_BR);
> > -	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON3, RG_HDMITX_PRD_IMP_EN);
> > -	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON4,
> > -			  (0x3 << PRD_IBIAS_CLK_SHIFT) |
> > -			  (0x3 << PRD_IBIAS_D2_SHIFT) |
> > -			  (0x3 << PRD_IBIAS_D1_SHIFT) |
> > -			  (0x3 << PRD_IBIAS_D0_SHIFT),
> > -			  RG_HDMITX_PRD_IBIAS_CLK |
> > -			  RG_HDMITX_PRD_IBIAS_D2 |
> > -			  RG_HDMITX_PRD_IBIAS_D1 |
> > -			  RG_HDMITX_PRD_IBIAS_D0);
> > -	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON3,
> > -			  (0x0 << DRV_IMP_EN_SHIFT), RG_HDMITX_DRV_IMP_EN);
> > -	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON6,
> > -			  (hdmi_phy->drv_imp_clk << DRV_IMP_CLK_SHIFT) |
> > -			  (hdmi_phy->drv_imp_d2 << DRV_IMP_D2_SHIFT) |
> > -			  (hdmi_phy->drv_imp_d1 << DRV_IMP_D1_SHIFT) |
> > -			  (hdmi_phy->drv_imp_d0 << DRV_IMP_D0_SHIFT),
> > -			  RG_HDMITX_DRV_IMP_CLK | RG_HDMITX_DRV_IMP_D2 |
> > -			  RG_HDMITX_DRV_IMP_D1 | RG_HDMITX_DRV_IMP_D0);
> > -	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON5,
> > -			  (hdmi_phy->ibias << DRV_IBIAS_CLK_SHIFT) |
> > -			  (hdmi_phy->ibias << DRV_IBIAS_D2_SHIFT) |
> > -			  (hdmi_phy->ibias << DRV_IBIAS_D1_SHIFT) |
> > -			  (hdmi_phy->ibias << DRV_IBIAS_D0_SHIFT),
> > -			  RG_HDMITX_DRV_IBIAS_CLK | RG_HDMITX_DRV_IBIAS_D2 |
> > -			  RG_HDMITX_DRV_IBIAS_D1 | RG_HDMITX_DRV_IBIAS_D0);
> > +	if (rate < 165000000) {
> > +		mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON3,
> > +					RG_HDMITX_PRD_IMP_EN);
> > +		mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON4,
> > +				  (0x3 << PRD_IBIAS_CLK_SHIFT) |
> > +				  (0x3 << PRD_IBIAS_D2_SHIFT) |
> > +				  (0x3 << PRD_IBIAS_D1_SHIFT) |
> > +				  (0x3 << PRD_IBIAS_D0_SHIFT),
> > +				  RG_HDMITX_PRD_IBIAS_CLK |
> > +				  RG_HDMITX_PRD_IBIAS_D2 |
> > +				  RG_HDMITX_PRD_IBIAS_D1 |
> > +				  RG_HDMITX_PRD_IBIAS_D0);
> > +		mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON3,
> > +				  (0x0 << DRV_IMP_EN_SHIFT),
> > +				  RG_HDMITX_DRV_IMP_EN);
> > +		mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON6,
> > +				  (hdmi_phy->drv_imp_clk << DRV_IMP_CLK_SHIFT) |
> > +				  (hdmi_phy->drv_imp_d2 << DRV_IMP_D2_SHIFT) |
> > +				  (hdmi_phy->drv_imp_d1 << DRV_IMP_D1_SHIFT) |
> > +				  (hdmi_phy->drv_imp_d0 << DRV_IMP_D0_SHIFT),
> > +				  RG_HDMITX_DRV_IMP_CLK | RG_HDMITX_DRV_IMP_D2 |
> > +				  RG_HDMITX_DRV_IMP_D1 | RG_HDMITX_DRV_IMP_D0);
> > +		mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON5,
> > +				  (hdmi_phy->ibias << DRV_IBIAS_CLK_SHIFT) |
> > +				  (hdmi_phy->ibias << DRV_IBIAS_D2_SHIFT) |
> > +				  (hdmi_phy->ibias << DRV_IBIAS_D1_SHIFT) |
> > +				  (hdmi_phy->ibias << DRV_IBIAS_D0_SHIFT),
> > +				  RG_HDMITX_DRV_IBIAS_CLK |
> > +				  RG_HDMITX_DRV_IBIAS_D2 |
> > +				  RG_HDMITX_DRV_IBIAS_D1 |
> > +				  RG_HDMITX_DRV_IBIAS_D0);
> > +	} else {
> > +		mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON3,
> > +				      RG_HDMITX_PRD_IMP_EN);
> > +		mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON4,
> > +				  (0x6 << PRD_IBIAS_CLK_SHIFT) |
> > +				  (0x6 << PRD_IBIAS_D2_SHIFT) |
> > +				  (0x6 << PRD_IBIAS_D1_SHIFT) |
> > +				  (0x6 << PRD_IBIAS_D0_SHIFT),
> > +				  RG_HDMITX_PRD_IBIAS_CLK |
> > +				  RG_HDMITX_PRD_IBIAS_D2 |
> > +				  RG_HDMITX_PRD_IBIAS_D1 |
> > +				  RG_HDMITX_PRD_IBIAS_D0);
> > +		mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON3,
> > +				  (0xf << DRV_IMP_EN_SHIFT),
> > +				  RG_HDMITX_DRV_IMP_EN);
> > +		mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON6,
> > +				  (hdmi_phy->drv_imp_clk << DRV_IMP_CLK_SHIFT) |
> > +				  (hdmi_phy->drv_imp_d2 << DRV_IMP_D2_SHIFT) |
> > +				  (hdmi_phy->drv_imp_d1 << DRV_IMP_D1_SHIFT) |
> > +				  (hdmi_phy->drv_imp_d0 << DRV_IMP_D0_SHIFT),
> > +				  RG_HDMITX_DRV_IMP_CLK | RG_HDMITX_DRV_IMP_D2 |
> > +				  RG_HDMITX_DRV_IMP_D1 | RG_HDMITX_DRV_IMP_D0);
> > +		mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON5,
> > +				  (hdmi_phy->ibias_up << DRV_IBIAS_CLK_SHIFT) |
> > +				  (hdmi_phy->ibias_up << DRV_IBIAS_D2_SHIFT) |
> > +				  (hdmi_phy->ibias_up << DRV_IBIAS_D1_SHIFT) |
> > +				  (hdmi_phy->ibias_up << DRV_IBIAS_D0_SHIFT),
> > +				  RG_HDMITX_DRV_IBIAS_CLK |
> > +				  RG_HDMITX_DRV_IBIAS_D2 |
> > +				  RG_HDMITX_DRV_IBIAS_D1 |
> > +				  RG_HDMITX_DRV_IBIAS_D0);
> > +	}
> 
> 'if' part and 'else' part looks almost the same. Use variable for
> difference and merge these two part. For example:
> 
> if (rate < 165000000)
> 	prd_ibias = 0x3;
> else
> 	prd_ibias = 0x6;
> 
> mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON4,
> 		  (prd_ibias << PRD_IBIAS_CLK_SHIFT) |
> 		  (prd_ibias << PRD_IBIAS_D2_SHIFT) |
> 		  (prd_ibias << PRD_IBIAS_D1_SHIFT) |
> 		  (prd_ibias << PRD_IBIAS_D0_SHIFT),
> 		  RG_HDMITX_PRD_IBIAS_CLK |
> 		  RG_HDMITX_PRD_IBIAS_D2 |
> 		  RG_HDMITX_PRD_IBIAS_D1 |
> 		  RG_HDMITX_PRD_IBIAS_D0);
> 
> >  	return 0;
> >  }
> >  
Ok, I will use variable instead of that.
> 
> Regards,
> CK
> 
