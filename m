From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 27 Mar 2013 11:17:57 +0100
Subject: [PATCH v6 1/3] serial: sh-sci: Add OF support
In-Reply-To: <CABYn4sxAobmCZRfwdsbsrHqEqWFeW=+fFkPfZwCdvoDCN4sfAA@mail.gmail.com>
References: <1362569437-11133-1-git-send-email-hechtb+renesas@gmail.com>
 <1527167.zrgCvGiAzu@avalon>
 <CABYn4sxAobmCZRfwdsbsrHqEqWFeW=+fFkPfZwCdvoDCN4sfAA@mail.gmail.com>
Message-ID: <3396399.kGoqQHyR16@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bastian,

On Tuesday 19 March 2013 16:10:57 Bastian Hecht wrote:
> 2013/3/12 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
> > On Tuesday 12 March 2013 17:20:39 Paul Mundt wrote:
> >> On Mon, Mar 11, 2013 at 11:32:31PM +0100, Laurent Pinchart wrote:
> >> > On Thursday 07 March 2013 11:26:29 Bastian Hecht wrote:
> >> > > >> +- renesas,scscr : Should contain a bitfield used by the Serial
> >> > > >> Control
> >> > > >> Register.
> >> > > >> +  b7 = SCSCR_TIE
> >> > > >> +  b6 = SCSCR_RIE
> >> > > >> +  b5 = SCSCR_TE
> >> > > >> +  b4 = SCSCR_RE
> >> > > >> +  b3 = SCSCR_REIE
> >> > > >> +  b2 = SCSCR_TOIE
> >> > > >> +  b1 = SCSCR_CKE1
> >> > > >> +  b0 = SCSCR_CKE0
> >> > > > 
> >> > > > What is that for exactly ?
> >> > > 
> >> > > What I can see from 3 different datasheets (sh7372, sh73a0, r8a7740)
> >> > > the first 2 bits differ in meaning.
> >> > > 
> >> > > On r8a7740 it depends: In asynchronous mode the first 2 bits CKE0/1
> >> > > define whether you want to use an external clock to drive the baud
> >> > > generator or if you want to use the internal SUB clock. If you use
> >> > > the SUB clock you can further define if you want to use a subscaled
> >> > > SUB clock in the SCSMR register. In synchronous mode you must rely on
> >> > > the internal clock for the baud generator and can select if the SCK
> >> > > pin is used as clock input or output.
> >> > 
> >> > What about adding an optional source clock property to the bindings,
> >> > that would contain the phandle of the source clock ? If the property is
> >> > absent then the internal clock would be used.
> >> 
> >> We can't really use the internal oscillator at the moment, it's one of
> >> the things that is blocked on adoption of the common struct clk work. The
> >> baud rate generator algo will likewise differ depending on whether it's
> >> using an internally generated clock or not, which also makes a different
> >> set of baud rates available.
> >> 
> >> My plan originally was to wait until the common struct clk stuff came
> >> along well enough that we could provide a clock dynamically depending on
> >> the target baud (or for avoiding cpufreq pre/post-change notifier
> >> chains), but this obviously hasn't happened yet.
> >> 
> >> I think your idea for the abstraction with the phandle sounds like the
> >> right approach, but we aren't presently in a state where we can handle
> >> that.
> > 
> > Do the platforms that will be converted to DT currently need to make the
> > clock source configurable ? If not we could just leave it out of the DT
> > bindings until needed. Hopefully by then we'll have a common clock
> > framework implementation.
> 
> The r8a7779 does use the external clock (according to my r8a7740
> datasheet) while the other mainline SoCs use the internal one.
> 
> >> > > Bit 2 and 3 don't exist in my datasheets.
> >> > > 
> >> > > The other bits define under which conditions you receive interrupts
> >> > > (send FIFO empty, receive FIFO full) and which bits you need to start
> >> > > transfers (one bit to start sending, one receiving). The bits 8 to 31
> >> > > are used to set up DMA transfers and various interrupt events like
> >> > > error status and finish transfers. I haven't included them as they
> >> > > are not used in the driver.
> >> > 
> >> > If they're not used maybe we can drop them :-)
> >> 
> >> Obviously they're used, otherwise they wouldn't be defined in the common
> >> header. Whether they are used by these specific CPUs or not isn't
> >> relevant, as there are plenty of cases where they are. grep harder.
> > 
> > My point is that if they're only used by arm/sh/* SoCs we don't need to
> > support them in DT.
> 
> Assuming that SCSCR_TE and SCSCR_RE are always used and we could handle the
> clock flags with a phandle and the other flags are only used in the realtime
> domain (where we don't want DT support?), I suppose we could indeed drop the
> whole property - but we would have to wait. Otherwise it's not so shiny but
> we could get it merged now. I don't know how to proceed now, any decision
> makers here?

My main concern is that DT bindings are ABIs that need to be supported 
forever. This is why I'd rather not add those flags to the DT bindings now 
only to deprecate them in a couple of kernel versions.

-- 
Regards,

Laurent Pinchart
