From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 14 Nov 2016 10:24:48 +0530
Subject: [PATCH 01/14] dma: sun6i-dma: Add burst case of 4
In-Reply-To: <CAGb2v65yR9NOff+VDA0cBj3UenGpdYUfnYfesnmzP8AN4uw4Tw@mail.gmail.com>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
 <3a2404510b5f8b16ae3bb193982d70f158700b2b.1475571575.git.mylene.josserand@free-electrons.com>
 <20161004124011.d7f5754a082d5f17d5185fc4@free.fr>
 <20161004165553.GS5228@lukather>
 <20161023183107.5b75b6aad62853378713299f@free.fr>
 <20161027175154.v4kuhyvm3r5n6tdo@lukather>
 <CAGb2v67SSZF6XL-HXv83nuwTKpJc53h8gsrb2r2V98LNZBzqEA@mail.gmail.com>
 <1477922460.2837.5.camel@intel.com>
 <CAGb2v65yR9NOff+VDA0cBj3UenGpdYUfnYfesnmzP8AN4uw4Tw@mail.gmail.com>
Message-ID: <20161114045448.GQ3000@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 01, 2016 at 10:55:13PM +0800, Chen-Yu Tsai wrote:

> >>  * @src_maxburst: the maximum number of words (note: words, as in
> >>  * units of the src_addr_width member, not bytes) that can be sent
> >>  * in one burst to the device. Typically something like half the
> >>  * FIFO depth on I/O peripherals so you don't overflow it. This
> >>  * may or may not be applicable on memory sources.
> >>  * @dst_maxburst: same as src_maxburst but for destination target
> >>  * mutatis mutandis.
> >>
> >> The DMA engine driver should be free to select whatever burst size
> >> that doesn't exceed this. So for max_burst = 4, the driver can select
> >> burst = 4 for controllers that do support it, or burst = 1 for those
> >> that don't, and do more bursts.
> >
> > Nope, the client configures these parameters and dmaengine driver
> > validates and programs
> 
> Shouldn't we just name it "burst_size" then if it's meant to be what
> the client specifically asks for?

Well if for some reason we program lesser than than max it would work
technically. But a larger burst wont work at all, so thats why maxburst is
significant.

> My understanding is that the client configures its own parameters,
> such as the trigger level for the DRQ, like raise DRQ when level < 1/4
> FIFO depth, request maxburst = 1/4 or 1/2 FIFO depth, so as not to
> overrun the FIFO. When the DRQ is raised, the DMA engine will do a
> burst, and after the burst the DRQ would be low again, so the DMA
> engine will wait. So the DMA engine driver should be free to
> program the actual burst size to something less than maxburst, shouldn't
> it?

Yup but not more that max..

> >> This also means we can increase max_burst for the audio codec, as
> >> the FIFO is 64 samples deep for stereo, or 128 samples for mono.
> >
> > Beware that higher bursts means chance of underrun of FIFO. This value
> > is selected with consideration of power and performance required. Lazy
> > allocation would be half of FIFO size..
> 
> You mean underrun if its the source right? So the client setting maxburst
> should take the DRQ trigger level into account for this.

Yes

-- 
~Vinod
