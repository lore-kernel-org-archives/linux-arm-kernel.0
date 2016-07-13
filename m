From: tiffany.lin@mediatek.com (tiffany lin)
Date: Wed, 13 Jul 2016 21:55:21 +0800
Subject: [PATCH] [media] mtk-vcodec: fix type mismatches
In-Reply-To: <4915511.9pXBipIRF8@wuerfel>
References: <20160711213959.2481081-1-arnd@arndb.de>
 <1468403786.32454.16.camel@mtksdaap41> <4915511.9pXBipIRF8@wuerfel>
Message-ID: <1468418121.32454.19.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, 2016-07-13 at 15:08 +0200, Arnd Bergmann wrote:
> On Wednesday, July 13, 2016 5:56:26 PM CEST tiffany lin wrote:
> > > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> > > index 6dcae0a0a1f2..0b25a8700877 100644
> > > --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> > > +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> > > @@ -1028,15 +1028,15 @@ static void mtk_venc_worker(struct work_struct *work)
> > >       bs_buf.size = (size_t)dst_buf->planes[0].length;
> > >  
> > >       mtk_v4l2_debug(2,
> > > -                     "Framebuf VA=%p PA=%llx Size=0x%lx;VA=%p PA=0x%llx Size=0x%lx;VA=%p PA=0x%llx Size=%zu",
> > > +                     "Framebuf VA=%p PA=%pad Size=0x%zx;VA=%p PA=%pad Size=0x%zx;VA=%p PA=%pad Size=0x%zx",
> > >                       frm_buf.fb_addr[0].va,
> > > -                     (u64)frm_buf.fb_addr[0].dma_addr,
> > > +                     &frm_buf.fb_addr[0].dma_addr,
> > >                       frm_buf.fb_addr[0].size,
> > >                       frm_buf.fb_addr[1].va,
> > > -                     (u64)frm_buf.fb_addr[1].dma_addr,
> > > +                     &frm_buf.fb_addr[1].dma_addr,
> > >                       frm_buf.fb_addr[1].size,
> > >                       frm_buf.fb_addr[2].va,
> > > -                     (u64)frm_buf.fb_addr[2].dma_addr,
> > > +                     &frm_buf.fb_addr[2].dma_addr,
> > >                       frm_buf.fb_addr[2].size);
> > This change will make debug message dump address of dma_addr field but
> > not the value of the dma_addr we want.
> > How about change it from
> > PA=%llx -> PA=%u
> > (u64)frm_buf.fb_addr[0].dma_addr -> (u32)frm_buf.fb_addr[0].dma_addr,
> > 
> 
> The %llx works fine with the cast to u64, the change above is mainly for the "%lx"
> on a size_t causing a warning.
> 
> The change to %pad is done in order to use a consistent output for the
> dma_addr_t, which had a leading "0x" in two cases but not in the first
> one.
> 
> printk interprets %pad as a pointer to a dma_addr_t and prints the
> address, not the pointer to it, see Documentation/printk-formats.txt,
> which lets you avoid the type cast as well as the 0x.
> 
I understood now, I will check Documentation/printk-formats.txt.
Thanks for your explanation.


best regards,
Tiffany

> 	Arnd
