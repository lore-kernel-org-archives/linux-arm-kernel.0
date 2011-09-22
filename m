From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 22 Sep 2011 14:04:56 +0100
Subject: DT vs ARM static mappings
In-Reply-To: <alpine.LFD.2.00.1109211320090.12663@xanadu.home>
References: <1316519479.4611.150.camel@hornet.cambridge.arm.com>
	<alpine.LFD.2.00.1109211320090.12663@xanadu.home>
Message-ID: <1316696696.4611.844.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > ARM machine description contains a "map_io" method, which is used to
> > create static memory mappings (using iotable_init() function) for things
> > like peripherals or SRAMs. At least that's the theory, because most of
> > the platforms are doing much more stuff there, like clocking/GPIOs/UARTs
> > initialization, hardware probing etc.
> 
> No, most of them don't.  Maybe a few cases do for historical reasons, 
> but there are other hooks now to link probing and initialization code 
> to.

Ok, what I did was grepping for all .map_io-s. Then I sorted the list
and had a look at first 100 and about 50% of them were doing more than
just creating mappings.

Never mind - I'll rephrase myself to "many" instead of "most" :-)

> The static mappings should be just that: static.  Most things should be 
> dynamically mapped instead.  With the series I'm working on, everybody 
> will get the benefit of a static mapping when one is available even if 
> the dynamic mapping interface like ioremap() is used.  So having a bunch 
> of static mappings is not bad, especially if they are easy.  But you 
> should defer as much hardware probing as possible after the memory is 
> initialized and the standard interfaces are available, keeping reliance 
> on direct access to static mappings as small as possible.

You won't get any argument from me here - my task would be easier
without the additional things happening in map_io...

> Your best bet would probably consist of keeping the virtual address 
> constant while the physical address is variable.  Adjusting the .pfn 
> field in the v2m_io_desc table right before calling iotable_init() 
> should be fine.  Alternatively you could have two such tables and select 
> the right one at run time.  The io_p2v macro doesn't make any sense 
> anymore in that context so it should be eliminated, and keeping only a 
> minimum set of fixed virtual addresses for the peripherals that can't 
> wait until ioremap is available should be fine.

Yep, that's (roughly) what my code is doing now. There is some hackery
involved (manual operations on pointers) that will disappear with your
changes.

And MMIO_P2V macro is dying - motherboard code is not using it any more,
the tile code will stop using it next week.

> And if static mappings are a problem, then try to live without them as 
> much as possible.  Again there is no reason you should be doing too much 
> hardware probing at .map_io time.

Current implementation is doing very little (just probing tile ID and
calling tile's private map_io) but it's enough to be a pain in the neck.

Anyway, patch (on top of Dave's initial support) to follow soon.

Cheers!

Pawe?
