From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Thu, 22 Jun 2017 10:21:04 +0800
Subject: [PATCH v2] drm: mediatek: change the variable type of rdma
 threshold
In-Reply-To: <1495431964.20811.8.camel@mtksdaap41>
References: <1495187843-6882-1-git-send-email-bibby.hsieh@mediatek.com>
 <1495431964.20811.8.camel@mtksdaap41>
Message-ID: <1498098064.717.12.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, CK,

Thanks for your review and comment.

On Mon, 2017-05-22 at 13:46 +0800, CK Hu wrote:
> Hi, Bibby:
> 
> One comment inline.
> 
> On Fri, 2017-05-19 at 17:57 +0800, Bibby Hsieh wrote:
> > For some greater resolution, the rdma threshold
> > variable will overflow.
> > 
> > Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> > index 0df05f9..9afdcd7 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> > @@ -37,7 +37,7 @@
> >  #define DISP_REG_RDMA_FIFO_CON			0x0040
> >  #define RDMA_FIFO_UNDERFLOW_EN				BIT(31)
> >  #define RDMA_FIFO_PSEUDO_SIZE(bytes)			(((bytes) / 16) << 16)
> > -#define RDMA_OUTPUT_VALID_FIFO_THRESHOLD(bytes)		((bytes) / 16)
> > +#define RDMA_OUTPUT_VALID_FIFO_THRESHOLD(bytes) (((bytes) / 16) & 0x3ff)
> 
> I think it's not necessary to do this mask operation. Before calling
> RDMA_OUTPUT_VALID_FIFO_THRESHOLD(), you should make sure that width,
> height, and vrefresh matches the HW spec, so the result of threshold
> likely does not exceed 0x3ff. If width, height, and vrefresh matches the
> HW spec but threshold exceed 0x3ff, maybe you should limited it to 0x3ff
> rather than truncating it.
> 

Ok, It seems to me that I will refer Guenter's comment, add clamp_val()
to avoid unexpected value. Thanks.


Bibby

> Regards,
> CK
> 
> >  
> >  /**
> >   * struct mtk_disp_rdma - DISP_RDMA driver structure
> > @@ -109,7 +109,7 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
> >  			    unsigned int height, unsigned int vrefresh,
> >  			    unsigned int bpc)
> >  {
> > -	unsigned int threshold;
> > +	unsigned long long threshold;
> >  	unsigned int reg;
> >  
> >  	rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_0, 0xfff, width);
> > @@ -121,7 +121,8 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
> >  	 * output threshold to 6 microseconds with 7/6 overhead to
> >  	 * account for blanking, and with a pixel depth of 4 bytes:
> >  	 */
> > -	threshold = width * height * vrefresh * 4 * 7 / 1000000;
> > +	threshold = (unsigned long long)width * height * vrefresh *
> > +		    4 * 7 / 1000000;
> >  	reg = RDMA_FIFO_UNDERFLOW_EN |
> >  	      RDMA_FIFO_PSEUDO_SIZE(SZ_8K) |
> >  	      RDMA_OUTPUT_VALID_FIFO_THRESHOLD(threshold);
> 
> 

-- 
Bibby
