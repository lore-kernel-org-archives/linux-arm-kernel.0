From: boojin.kim@samsung.com (Boojin Kim)
Date: Thu, 28 Jul 2011 09:38:45 +0900
Subject: [PATCH V4 06/14] ARM: SAMSUNG: Add common DMA operations
In-Reply-To: <CABb+yY2i1rnvqWTFQUnMSrX7_h9KHnNL9xPZ2aHv8hO5Y7j+uA@mail.gmail.com>
References: <1311557312-26107-1-git-send-email-boojin.kim@samsung.com>
	<1311557312-26107-7-git-send-email-boojin.kim@samsung.com>
	<CABb+yY0nWLpdVGqTJPO2YwkGWiDw5tRjC2xn7Le0bO0ZNFHC_g@mail.gmail.com>
	<003801cc4b77$51e9f3e0$f5bddba0$%kim@samsung.com>
	<CABb+yY3shX+myCgO++rUQrFuT81cdhhf18398Wa-S=88UK3rkg@mail.gmail.com>
	<000401cc4c1c$71d63240$558296c0$%kim@samsung.com>
	<CABb+yY2i1rnvqWTFQUnMSrX7_h9KHnNL9xPZ2aHv8hO5Y7j+uA@mail.gmail.com>
Message-ID: <001201cc4cbe$b5fe9780$21fbc680$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jassi Brar wrote:
> Sent: Wednesday, July 27, 2011 4:58 PM
> To: Boojin Kim
> Cc: Kukjin Kim; Vinod Koul; Mark Brown; Grant Likely; linux-samsung-
> soc at vger.kernel.org; Dan Williams; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH V4 06/14] ARM: SAMSUNG: Add common DMA operations
>
> On Wed, Jul 27, 2011 at 10:47 AM, Boojin Kim <boojin.kim@samsung.com>
> wrote:
> > Jassi Brar wrote:
> >> Sent: Wednesday, July 27, 2011 10:34 AM
> >> To: Boojin Kim
> >> Cc: linux-arm-kernel at lists.infradead.org; linux-samsung-
> >> soc at vger.kernel.org; Vinod Koul; Dan Williams; Kukjin Kim; Grant
> >> Likely; Mark Brown
> >> Subject: Re: [PATCH V4 06/14] ARM: SAMSUNG: Add common DMA
> operations
> >>
> >> On Tue, Jul 26, 2011 at 3:05 PM, Boojin Kim
> <boojin.kim@samsung.com>
> >> wrote:
> >> > Jassi Brar Wrote:
> >> >> Sent: Monday, July 25, 2011 8:52 PM
> >> >> To: Boojin Kim
> >> >> Cc: linux-arm-kernel at lists.infradead.org; linux-samsung-
> >> >> soc at vger.kernel.org; Vinod Koul; Dan Williams; Kukjin Kim; Grant
> >> >> Likely; Mark Brown
> >> >> Subject: Re: [PATCH V4 06/14] ARM: SAMSUNG: Add common DMA
> >> operations
> >> >>
> >> >> On Mon, Jul 25, 2011 at 6:58 AM, Boojin Kim
> >> <boojin.kim@samsung.com>
> >> >> wrote:
> >> >>
> >> >> > +
> >> >> > +static bool pl330_filter(struct dma_chan *chan, void *param)
> >> >> > +{
> >> >> > +       struct dma_pl330_peri *peri = (struct dma_pl330_peri
> >> *)chan-
> >> >> >private;
> >> >> > +       unsigned dma_ch = (unsigned)param;
> >> >> > +
> >> >> > +       if (peri->peri_id != dma_ch)
> >> >> > +               return false;
> >> >> > +
> >> >> > +       return true;
> >> >> > +}
> >> >> This is what I meant... if we keep chan_id for paltform assigned
> >> IDs,
> >> >> these filter functions could simply become
> >> >>
> >> >> static bool pl330_filter(struct dma_chan *chan, void *param)
> >> >> {
> >> >>         return chan->chan_id == param
> >> >> }
> >> >>
> >> >> And ideally in the long run, we could just drop the filter
> callback
> >> >> and add expected channel ID to the request_channel call.
> >> > The chan_id is set by dmaengine. So, We don't use it to hold the
> >> user specific
> >> > Id.
> >> Not for long.
> >> See  https://lkml.org/lkml/2011/7/26/245
> >>
> >>
> >> >> > +
> >> >> > +static inline int s3c_dma_trigger(unsigned ch)
> >> >> > +{
> >> >> > +       return s3c2410_dma_ctrl(ch, S3C2410_DMAOP_START);
> >> >> > +}
> >> >> > +
> >> >> > +static inline int s3c_dma_started(unsigned ch)
> >> >> > +{
> >> >> > +       return s3c2410_dma_ctrl(ch, S3C2410_DMAOP_STARTED);
> >> >> > +}
> >> >> > +
> >> >> > +static inline int s3c_dma_flush(unsigned ch)
> >> >> > +{
> >> >> > +       return s3c2410_dma_ctrl(ch, S3C2410_DMAOP_FLUSH);
> >> >> > +}
> >> >> > +
> >> >> > +static inline int s3c_dma_stop(unsigned ch)
> >> >> > +{
> >> >> > +       return s3c2410_dma_ctrl(ch, S3C2410_DMAOP_STOP);
> >> >> > +}
> >> >> > +
> >> >> > +static struct samsung_dma_ops s3c_dma_ops = {
> >> >> > +       .request        = s3c_dma_request,
> >> >> > +       .release        = s3c_dma_release,
> >> >> > +       .prepare        = s3c_dma_prepare,
> >> >> > +       .trigger        = s3c_dma_trigger,
> >> >> > +       .started        = s3c_dma_started,
> >> >> > +       .flush          = s3c_dma_flush,
> >> >> > +       .stop           = s3c_dma_stop,
> >> >>
> >> >> These last 4 should be gnereallized into one callback with OP
> >> argument.
> >> > I don't have any idea about it. Can you explain it in more detail?
> >>
> >> static int s3c_dma_control(unsigned ch, enum s3c2410_chan_op/*or
> >> similar*/ op)
> >>  {
> >>         return s3c2410_dma_ctrl(ch, op);
> >>  }
> >>
> >> static struct samsung_dma_ops s3c_dma_ops = {
> >>         .request        = s3c_dma_request,
> >>         .release        = s3c_dma_release,
> >>         .prepare        = s3c_dma_prepare,
> >>         .control        = s3c_dma_control,
> > 'Struct samsung_dma_ops' is used for both 'S3C-DMA-OPS' for 's3c
> dma' and
> > 'DMA-OPS' for 'dmaengine'.
> > If I modify "Struct samsung_dma_ops" as your guide, It gives un-
> expectable
> > effect to DMA-OPS.
> > Actually, We don't want the client with 'DMA-OPS' uses 'enum
> s3c2410_chan_op'
> > operation anymore.
>
> " enum s3c2410_chan_op /* or similar */ "  <<<<  note 'or similar'
>
> Defining a callback for each value of the argument doesn't make sense.
Yes, The command may not be 'enum s3c2410_chan_op'. But it's very similar with 
'enum s3c2410_chan_op'.
So, It brings same result that I sad.
Actually, I quietly agree with your comment. If the 'struct samsung_dma_ops' 
is only used for 's3c-dma-ops', I would address your comment. But, 'struct 
samsung_dma_ops' is used for all Samsung dma clients. I aim that 'struct 
samsung_dma_ops' provide the DMA clients with 'dmaengine' friendly DMA 
interface without any other command.
