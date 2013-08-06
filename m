From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 6 Aug 2013 18:08:14 +0100
Subject: [PATCH 0/3] ARM: vexpress: TC2 MCPM/SPC cleanups
In-Reply-To: <CAOesGMiTr1bTE_A=DGrgMQQd3sN9+E6HbahSHKJpOSfouLqHnQ@mail.gmail.com>
References: <1375675793-16492-1-git-send-email-olof@lixom.net>
 <20130805094709.GA29090@e102568-lin.cambridge.arm.com>
 <1375805993.12043.80.camel@hornet>
 <CAOesGMiTr1bTE_A=DGrgMQQd3sN9+E6HbahSHKJpOSfouLqHnQ@mail.gmail.com>
Message-ID: <20130806170813.GC28176@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 06, 2013 at 05:44:55PM +0100, Olof Johansson wrote:
> On Tue, Aug 6, 2013 at 9:19 AM, Pawel Moll <pawel.moll@arm.com> wrote:
> > On Mon, 2013-08-05 at 10:47 +0100, Lorenzo Pieralisi wrote:
> >> For the bindings, you are right, how about this (commit log written just
> >> for the sake of it, it should be squashed in Nico's original series) ?
> >
> > So I finally sat down and did what I should have done long time ago...
> > Read the spec ;-)
> 
> Uh... Ok. Biting my tongue. :)
> 
> Is the spec public, per chance?

I will check.

> > SCC is (was?) mainly used to set initial conditions for the cores,
> > interconnect and all the other bits and pieces inside the test chip. It
> > could be considered an equivalent of the classic "boot mode" pins, but
> > as test chips have many more of them comparing to the normal SOCs, the
> > data is being "injected" to the chip in a serial fashion *before* the
> > main reset is being de-asserted. This is done by an external entity,
> > namely the DCC (daughterboard configuration controller, so simply a
> > microcontroller living next to the test chip). Why is this detail
> > important at all? Because traditionally the SCC was *not* available in
> > the normal memory map, otherwise it would be a perfect candidate for
> > the . In order to change anything one had to go through the usual
> > Versatile Express config infrastructure. Fortunately there was no need
> > to do this at all...
> 
> Vexpress is such a hack. :) It's unfortunate that it ends up being the
> lead platform on these kind of technologies, in some ways.
> 
> I think it makes sense to hide some of this ick in mach-vexpress, I
> don't think we should ever aim to empty it out. Not based on how messy
> the platform architecture is. I'd rather hide it in there than pollute
> other parts of the kernel. Or at least, we should keep it as an option
> in some cases such as these -- there might be other parts that do make
> sense to move out to generic kernel.
> 
> > And here comes the V2P-CA15_A7, also known as TC2 ;-) where the
> > interface was re-(or ab-?)used as a "convenient" communication channel
> > between the test chip and the microcontroller. And the SPC is even
> > described as "being merged" with the SCC. Uh...
> >
> > Now, the bottom line. How about keeping the driver look for
> > "arm,vexpress-spc,v2p-ca15_a7" because it's a driver for the SPC bit
> > after all and doing the following in the tree:
> >
> > scc at 7fff0000 {
> >         compatible = "arm,vexpress-scc,v2p-ca15_a7", "arm,vexpress-scc";
> >         reg = <0x7fff0000 0x1000>;
> >         interrupts = <0 95 4>;
> >
> >         spc at b00 {
> >                 compatible = "arm,vexpress-spc,v2p-ca15_a7", "arm,vexpress-spc";
> >                 reg = <0xb00 0x100>;
> >         };
> > };
> >
> > This, I believe, would represent the actual situation, require no change
> > in the driver (except for the retirement of SPC_BASE which is good :-)
> > and allowed as, if and when necessary, to drive the SCC as a MFD/syscon
> > device.
> >
> > Does it make some sense?
> 
> It does, but you need to setup the scc as a bus (with ranges, etc) for
> that binding to work.
> 
> I pushed the fixed-up set of patches to the branch in arm-soc, so you
> can find them there (olof/vexpress). Sounds like this isn't quite
> ready to merge if these things still need to be worked out. So feel
> free to take my patches, change them up as needed and send a fresh
> copy.

No, please, no. By no means MCPM for TC2 should be delayed for longer by a
piece of HW that is giving me (and unfortunately you too) the time of my
life. We moved code to mach-vexpress, trimmed it to just a bunch of regs
reads and writes, and put it where it belongs, in platform specific code.

There is still room for making the SCC a proper MFD/syscon device, but not now,
it makes no sense to delay this code for something that we might not even
come to implement.

Let's get it through as it is, please.

Lorenzo
