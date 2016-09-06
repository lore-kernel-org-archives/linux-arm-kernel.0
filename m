From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Sep 2016 12:22:47 +0100
Subject: [PATCH 2/3] ARM: pxa: lubbock: add pcmcia clock
In-Reply-To: <87zinmi3jm.fsf@belgarion.home>
References: <1473015587-15589-1-git-send-email-robert.jarzmik@free.fr>
 <1473015587-15589-2-git-send-email-robert.jarzmik@free.fr>
 <20160904200827.GL1041@n2100.armlinux.org.uk>
 <877faqjtuk.fsf@belgarion.home>
 <20160905160420.GQ1041@n2100.armlinux.org.uk>
 <87zinmi3jm.fsf@belgarion.home>
Message-ID: <20160906112247.GU1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 05, 2016 at 08:50:53PM +0200, Robert Jarzmik wrote:
> Russell King - ARM Linux <linux@armlinux.org.uk> writes:
> 
> > On Mon, Sep 05, 2016 at 04:37:23PM +0200, Robert Jarzmik wrote:
> > From what I remember, the SA1111 takes the 3.6864MHz clock input as an
> > input to its own PLL to generate the clocks it needs internally.  All
> > the PCMCIA timing is handled by the SA1110 or PXA.
> >
> > The reason that we need to tell the SA1111 PCMCIA device about the PXA
> > clock is not because the SA1111 uses it, but because the driver needs it
> > to work out the correct timing information to program the SA1110 or PXA
> > access times.
> 
> I've been pondering that last sentence for a bit and what appeared to me
> is that between the PXA and the SA1111, as there is no clock from one to
> the other, ie. that the SA1111 clock for PCMCIA signals is independent
> from any PXA clock (well, excepting it's a PLL from a 3.6864MHz, but
> let's forget that), the contract binding the PXA and the SA1111 is a
> _timings_ one rather that a clock one.

It isn't.

The SA1110 and PXA already support PCMCIA/CF sockets, but need:
* external buffers to isolate the address/data buses from the sockets,
  and to provide level shifting for 5V setups.
* combinatorial logic to decode the socket control signals to route
  them to the appropriate socket and control the buffers.

The logic required for this is detailed in the SA1110 manual, and
probably the PXA manuals as well.

The SA1111 provides a single-chip solution to this, containing the
buffers and combinatorial logic.  The SA1111 provides a functional
description of this combinatorial logic.

The timing concerned here is the _access_ timing, and that is purely
controlled by the SA1110 or PXA.  The SA1111 plays no part in that,
apart from adding a little latency to the signals that flow through it,
in much the same way as the non-SA1111 solutions also add extra latency.

This is further evidenced by there being clock enable bits for everything
except the PCMCIA interface within the SA1111, and the fact that the
individual unit clocks must only be enabled once the internal clocks of
the SA1111 have been initialised by software.

> Or said differently, the 2 IPs must agree on timing values in order to
> inter-operate, and so should the device drivers.

There is no timing to program into the SA1111.

> I have not really looked into the PCMCIA structure, but I suppose it's clock
> based today.

PCMCIA doesn't have a clock.  It's an extension of buses like ISA, where
accesses are timed by the length of the memory/io read/write signals, and
an optional wait signal that is driven by the card.

If the card says "I want an access time of 300ns" then the SA1110 or PXA
must be programmed to achieve at least a 300ns access time to the card -
iow, the appropriate access enable signal must be asserted for at least
the specified time and data read after that period has elapsed.

As the SA1111 will be an implementation of the combinatorial logic shown
in the SA1110 manual, no clocks in the SA1111 come into play.

> Something like ?
> "The added clock doesn't actually exist, ie. there is no physical clock
> line from the PXA to the SA1111 on lubbock used by the PCMCIA block on
> the SA1111. The clocking information is only used to setup the memory
> bus timings."

Already committed with a modified commit message, thanks anyway. :)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
