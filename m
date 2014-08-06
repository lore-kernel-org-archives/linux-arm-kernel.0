From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Aug 2014 13:04:40 +0200
Subject: DMA engine API issue (was: [PATCH/RFC 0/5] R-Car Gen2 DMAC
 hardware descriptor list support)
In-Reply-To: <CAMuHMdVz8hNus5x1hn0feqb1SYsUuhA4QHHfPGyebiKLZJwfEQ@mail.gmail.com>
References: <1406032431-3807-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1877927.dGcJCfKbeH@avalon>
 <CAMuHMdVz8hNus5x1hn0feqb1SYsUuhA4QHHfPGyebiKLZJwfEQ@mail.gmail.com>
Message-ID: <201408061304.41105.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 August 2014, Geert Uytterhoeven wrote:
> > I actually have the opposite problem, in my case channels of physically
> > separate DMA engines can be used interchangeably to serve the system's slaves.
> > Using the DMA engine DT bindings, DT nodes of the slaves currently reference a
> > specific DMA engine, even if they can be served by both. This leads to limited
> > dynamic channel allocation capabilities (especially when taking into account
> > lazy channel allocation as mentioned in another mail in this thread).
> 
> What about adding a property to the first one, referencing the second
> (or the other way around, don't know what's the easiest to implement)?
> 
>         dmac0: dma-controller at e6700000 {
>                 ...
>                 renesas,alternative = <&dmac1>;
>                 ...
>         };
> 
>         dmac1: dma-controller at e6720000 {
>                 ...
>         };
> 
> That would avoid having to bind a slave device explicitly to a single
> dmac, or having to bind all slave devices to all dmacs.

We have a perfectly fine way to express this with the existing binding
already: you just list channels for both (or more) controllers for each
slave, and let the dma subsystem pick one. This was a compromise we
reached when we initially introduced the dma slave binding, the downside
being that we have to name every reference from a slave to a controller,
even though almost all of them are "rx", "tx" or "data".

I believe what happened though is that the initial implementation in the
kernel was to just pick the first channel for a given name and try that
but give up if it fails. This works for the majority of users and I had
expected someone to implement a smarter strategy as needed.

The easiest way would be to just randomize the order of the channels
during lookup and then try them all, but there is a potential problem
with this failing sometimes in nondeterministic ways.
Another alternative would be for the dma controller to report back
some form of "utilization" number to the dma subsystem and have the
common code pick the least utilized engine that is connected to that
slave.

	Arnd
