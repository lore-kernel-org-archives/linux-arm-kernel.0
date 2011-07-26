From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 26 Jul 2011 09:02:33 +0100
Subject: [PATCH V4 06/14] ARM: SAMSUNG: Add common DMA operations
In-Reply-To: <CABb+yY0nWLpdVGqTJPO2YwkGWiDw5tRjC2xn7Le0bO0ZNFHC_g@mail.gmail.com>
References: <1311557312-26107-1-git-send-email-boojin.kim@samsung.com>
	<1311557312-26107-7-git-send-email-boojin.kim@samsung.com>
	<CABb+yY0nWLpdVGqTJPO2YwkGWiDw5tRjC2xn7Le0bO0ZNFHC_g@mail.gmail.com>
Message-ID: <20110726080233.GN9653@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2011 at 05:21:44PM +0530, Jassi Brar wrote:
> On Mon, Jul 25, 2011 at 6:58 AM, Boojin Kim <boojin.kim@samsung.com> wrote:
> 
> > +
> > +static bool pl330_filter(struct dma_chan *chan, void *param)
> > +{
> > + ? ? ? struct dma_pl330_peri *peri = (struct dma_pl330_peri *)chan->private;
> > + ? ? ? unsigned dma_ch = (unsigned)param;
> > +
> > + ? ? ? if (peri->peri_id != dma_ch)
> > + ? ? ? ? ? ? ? return false;
> > +
> > + ? ? ? return true;
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

So what if you have a PL080 and PL330 drivers registered with the DMA
engine code, and you need to match a specific PL330 channel?
