From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Sep 2011 14:13:02 +0100
Subject: DT vs ARM static mappings
In-Reply-To: <1316696696.4611.844.camel@hornet.cambridge.arm.com>
References: <1316519479.4611.150.camel@hornet.cambridge.arm.com>
	<alpine.LFD.2.00.1109211320090.12663@xanadu.home>
	<1316696696.4611.844.camel@hornet.cambridge.arm.com>
Message-ID: <20110922131302.GO17169@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2011 at 02:04:56PM +0100, Pawel Moll wrote:
> > > ARM machine description contains a "map_io" method, which is used to
> > > create static memory mappings (using iotable_init() function) for things
> > > like peripherals or SRAMs. At least that's the theory, because most of
> > > the platforms are doing much more stuff there, like clocking/GPIOs/UARTs
> > > initialization, hardware probing etc.
> > 
> > No, most of them don't.  Maybe a few cases do for historical reasons, 
> > but there are other hooks now to link probing and initialization code 
> > to.
> 
> Ok, what I did was grepping for all .map_io-s. Then I sorted the list
> and had a look at first 100 and about 50% of them were doing more than
> just creating mappings.

The answer to that is: they shouldn't be now that we have the init_early
hook.  The only remainder for .map_io is where platforms make run-time
decisions about what to map based on some register value somewhere
(eg, Assabet vs Assabet+Neponset).

I do have a large patch series floating around in my git tree which tries
to clean up to all those map_io functions - the biggest stumbling block
to them is the Samsung stuff being indirected through its own tables.

Of course, with all the changes to .boot_params etc, the patches no longer
apply to current kernels.
