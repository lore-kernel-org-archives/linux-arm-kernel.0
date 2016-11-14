From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 14 Nov 2016 12:51:26 +0100
Subject: [PATCH RFC 1/7] dma: pl08x: Add support for the DMA slave map
In-Reply-To: <3693046.Gh6DJsekH3@wuerfel>
References: <1478276094-19135-1-git-send-email-s.nawrocki@samsung.com>
 <201611050026.49560.arnd@arndb.de>
 <3d10d013-b18c-e10e-b596-d4d0f8b6e973@samsung.com>
 <CGME20161107195651epcas4p4e5e949a772ce329b064ce9d791aeb5bd@epcas4p4.samsung.com>
 <3693046.Gh6DJsekH3@wuerfel>
Message-ID: <d6245c8d-d7a3-8f52-a32a-259e3791e513@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/2016 08:55 PM, Arnd Bergmann wrote:
>> diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
>> > index d5c75c8..0d1eb2e 100644
>> > --- a/drivers/dma/amba-pl08x.c
>> > +++ b/drivers/dma/amba-pl08x.c
>> > @@ -1793,6 +1793,23 @@ bool pl08x_filter_id(struct dma_chan *chan, void *chan_id)
>> >  }
[...]
>> > +static bool pl08x_filter_fn(struct dma_chan *chan, void *chan_id)
>> > +{
>> > +       struct pl08x_dma_chan *plchan;
[...]
>> > +       plchan = to_pl08x_chan(chan);
>> > +
>> > +       /* Check that the channel is not taken! */
>> > +       if (plchan->cd == chan_id)
>> > +               return true;
> 
> What I had in mind was a bit different: Instead of comparing the
> channel, I was thinking of modifying the channel itself, something
> like:
> 
> 	plchan->signal = chan_id->signal;
> 	plchan->periph_buses = chan_id->periph_buses;
> 
> after that, remove the plchan->cd data. Unfortunately, the muxing in
> arch/arm/mach-spear/ makes this a bit harder. I'd have to think
> about it some more. It may be easier to do this after moving
> spear and lpc32xx over to use dma_slave_map.

I've posted updated version of this patch, please let me know
if you have any further comments.

-- 
Thanks,
Sylwester
