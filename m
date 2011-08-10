From: vkoul@infradead.org (Vinod Koul)
Date: Thu, 11 Aug 2011 02:28:03 +0530
Subject: [PATCH V2 6/6] spi/spi-pl022: Request/free DMA channels as and
	when required.
In-Reply-To: <CABb+yY2Usd5=RW6BV69UW=Tq0zQW6LCtT2GhfdHGA61ZU3aNcQ@mail.gmail.com>
References: <cover.1312965741.git.viresh.kumar@st.com>
	<566c0525199f498f04422d4c3b2ddd7466648c20.1312965742.git.viresh.kumar@st.com>
	<20110810090042.GE1831@n2100.arm.linux.org.uk>
	<4E424F7B.2000800@st.com>
	<438BB0150E931F4B9CE701519A4463010871804A15@bgsmsx502.gar.corp.intel.com>
	<CABb+yY3SnqKN78U7vLbom1i00m=ThnRVQDVM_iX1TPu=+XzSNQ@mail.gmail.com>
	<20110810104025.GK1831@n2100.arm.linux.org.uk>
	<CABb+yY3=q5Nq1wtM6Av2DrgUfjZR_Ao40QhBhv_ik9naAd5wRg@mail.gmail.com>
	<CACRpkdaCyUJ3A9VWfsVuwJj3DGVkvjc2_ZOD4yM4YX3NPxAAYQ@mail.gmail.com>
	<CABb+yY2Usd5=RW6BV69UW=Tq0zQW6LCtT2GhfdHGA61ZU3aNcQ@mail.gmail.com>
Message-ID: <1313009883.1603.25.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-08-10 at 18:46 +0530, Jassi Brar wrote:
> On Wed, Aug 10, 2011 at 5:24 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Wed, Aug 10, 2011 at 1:24 PM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
> >> On Wed, Aug 10, 2011 at 4:10 PM, Russell King - ARM Linux
> >>>
> >>> I discussed this with Linus on the bus back from Cambridge in the evening,
> >>> and it appears that the story you gave me was inaccurate - Linus had not
> >>> agreed to your proposal and saw more or less the same problems with it
> >>> which I've been on at you about via your other email alias/lkml.  So that's
> >>> essentially invalidated everything we discussed there as part of my thinking
> >>> was "if Linus is happy with it, then...".
> >>
> >> IIRC, Linus W mainly opined to involve device pointer during channel selection.
> >> Other than that I thought there was only ambiguity about implementation details.
> >
> > Bah now we have two "Linus oracles" in this world instead
> > of just one... haha :-)
> >
> 
> 
> >> Linus W, was there anything you said wouldn't work with the scheme ?
> >> Please tell now on the record.
> >
> > It would *work* but the current proposal is *not elegant* IMO.
> 
> would *work*  -> You could find no case that the scheme wouldn't support.
> *not elegant*  -> Your opinion. Let us see.
> 
> 
> > I think your scheme passing in a device ID and instance tuple
> > e.g. REQ(MMC,2) would *work*, but I don't think it is a proper
> > solution and I would never ACK it, as I said.
> As much as I would feel 'deprived' of your ACK, I am not yet changing
> the implementation for that part.
> 
> 
> > The lookup of a device DMA channel should follow the
> > design pattern set by regulators and clocks.
> Nopes. It depends upon the subsystem.
> We should strive towards making this scheme as 'standalone' as
> possible.
> Client having to specify the device it wants a channel for, is a
> waste - otherwise we don't fully get rid of platform assistance for
> channel selection!
On one of the platforms I work on we have 3 DMACs, peripheral 1, 2 and 3
can only use channels from controller 1, and the peripherals 4, 5 from
controller 2 and so on. They _absolutely_ need channel from specific
controller, so above suits it :).
Btw all three controllers _have_exactly_same_caps_ so dma engine will
not see any difference in channels. They don't know which peripherals
are connected to them, that's platform information which this scheme
seems to be suited to...
Can you tell me how your scheme will work in this case?

> Also that way, a client is actually asking for a 'channel' rather than
> only specifying its requirements to the API and the API has enough
> information to return the appropriate channel(which is what I propose).
> 
> > Which means
> > you use struct device * or alternatively a string (if the
> > instance is not available) to look it up, such that:
> >
> > struct dma_slave_map {
> >   char name[16];
> >   struct device *dev;
> >   char dev_name[16];
> >   struct devive *dma_dev;
> >   char dma_dev_name[16];
> > };
> >
> > struct dma_slave_map[] = {
> >  {
> >     .name = "MMC-RX",
> >     .dev_name = "mmc.0",
> >     .dma_dev_name = "pl08x.0",
> >  },
> >  {
> >     .name = "MMC-TX",
> >     .dev_name = "mmc.0",
> >     .dma_dev_name = "pl08x.0",
> >  },
> >  {
> >     .name = "SSP-RX",
> >     .dev_name = "pl022.0",
> >     .dma_dev_name = "pl08x.1",
> >  },
> 
> 1) This is implementation detail.
> 2) Not a very good one at that.
>      a) Just think how many bytes you take to specify a channel ?
>          Mine takes less than 4 bytes for equivalent information.
>      b) Think about the mess of string copy, compare etc, when we can
>          simply extract and manipulate bit-fields from, say, u32?
> 
> 
> >
> > The dmaengine core should take this mapping, and
> > the device driver would only have to:
> >
> > struct dma_chan *rxc;
> > struct dma_chan *txc;
> > struct device *dev;
> >
> > rxc = dma_request_slave_channel(dev, "MMC-RX");
> > txc = dma_request_slave_channel(dev, "MMC-TX");
> Absolutely "not-very-good" !
> We can do without the 'dev' argument.
> How does a client request duplex channel ?
>    MMC-RXTX or MMC-TXRX or TXRX-MMC ?
> Do you propose to implement a string parser in the core ?!
> Not to mention how limited requirements this scheme could
> express to the core.
> 
> 
> > I also recognized that you needed a priority scheme and
> > a few other bits for the above,
> You didn't recognize. I told you. IIRC you suggested I should actually
> sell that point!
> The priority is an additional feature that easily helps a situation when
> a peri could be reached from two different dmacs and the board can
> prioritize an already busy dmac over the one that would only serve
> this peripheral - to save power by keeping the idle dmac off.
> Your string manipulation would only get messier if it had to support
> that feature.
> 
> > If the majority is happy with this scheme I can even
> > try implementing it.
> Interesting! Only a few days ago you were seeing eternal sunshine in
> filter-functions... and now you plan to implement my proposal by
> replacing bit-fields with strings.
> Frankly, I don't care much who, if anybody, implements it anymore.
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
