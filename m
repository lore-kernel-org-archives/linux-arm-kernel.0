From: boojin.kim@samsung.com (Boojin Kim)
Date: Tue, 26 Jul 2011 18:35:12 +0900
Subject: [PATCH V4 06/14] ARM: SAMSUNG: Add common DMA operations
In-Reply-To: <CABb+yY0nWLpdVGqTJPO2YwkGWiDw5tRjC2xn7Le0bO0ZNFHC_g@mail.gmail.com>
References: <1311557312-26107-1-git-send-email-boojin.kim@samsung.com>
	<1311557312-26107-7-git-send-email-boojin.kim@samsung.com>
	<CABb+yY0nWLpdVGqTJPO2YwkGWiDw5tRjC2xn7Le0bO0ZNFHC_g@mail.gmail.com>
Message-ID: <003801cc4b77$51e9f3e0$f5bddba0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jassi Brar Wrote:
> Sent: Monday, July 25, 2011 8:52 PM
> To: Boojin Kim
> Cc: linux-arm-kernel at lists.infradead.org; linux-samsung-
> soc at vger.kernel.org; Vinod Koul; Dan Williams; Kukjin Kim; Grant
> Likely; Mark Brown
> Subject: Re: [PATCH V4 06/14] ARM: SAMSUNG: Add common DMA operations
>
> On Mon, Jul 25, 2011 at 6:58 AM, Boojin Kim <boojin.kim@samsung.com>
> wrote:
>
> > +
> > +static bool pl330_filter(struct dma_chan *chan, void *param)
> > +{
> > +       struct dma_pl330_peri *peri = (struct dma_pl330_peri *)chan-
> >private;
> > +       unsigned dma_ch = (unsigned)param;
> > +
> > +       if (peri->peri_id != dma_ch)
> > +               return false;
> > +
> > +       return true;
> > +}
> This is what I meant... if we keep chan_id for paltform assigned IDs,
> these filter functions could simply become
>
> static bool pl330_filter(struct dma_chan *chan, void *param)
> {
>         return chan->chan_id == param
> }
>
> And ideally in the long run, we could just drop the filter callback
> and add expected channel ID to the request_channel call.
The chan_id is set by dmaengine. So, We don't use it to hold the user specific 
Id.

>
>
>
> > +
> > +static inline int s3c_dma_trigger(unsigned ch)
> > +{
> > +       return s3c2410_dma_ctrl(ch, S3C2410_DMAOP_START);
> > +}
> > +
> > +static inline int s3c_dma_started(unsigned ch)
> > +{
> > +       return s3c2410_dma_ctrl(ch, S3C2410_DMAOP_STARTED);
> > +}
> > +
> > +static inline int s3c_dma_flush(unsigned ch)
> > +{
> > +       return s3c2410_dma_ctrl(ch, S3C2410_DMAOP_FLUSH);
> > +}
> > +
> > +static inline int s3c_dma_stop(unsigned ch)
> > +{
> > +       return s3c2410_dma_ctrl(ch, S3C2410_DMAOP_STOP);
> > +}
> > +
> > +static struct samsung_dma_ops s3c_dma_ops = {
> > +       .request        = s3c_dma_request,
> > +       .release        = s3c_dma_release,
> > +       .prepare        = s3c_dma_prepare,
> > +       .trigger        = s3c_dma_trigger,
> > +       .started        = s3c_dma_started,
> > +       .flush          = s3c_dma_flush,
> > +       .stop           = s3c_dma_stop,
>
> These last 4 should be gnereallized into one callback with OP argument.
I don't have any idea about it. Can you explain it in more detail?
