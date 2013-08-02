From: will.deacon@arm.com (Will Deacon)
Date: Fri, 2 Aug 2013 17:45:30 +0100
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Describing complex,
 non-probable system topologies
In-Reply-To: <20130802152648.GD2361@localhost.localdomain>
References: <20130801183531.GB29831@mudshark.cambridge.arm.com>
 <20130801192730.GC9174@kroah.com>
 <20130802090355.GF7656@atomide.com>
 <20130802093222.GA8982@kroah.com>
 <20130802123445.GG7656@atomide.com>
 <20130802141449.GA7533@kroah.com>
 <20130802152648.GD2361@localhost.localdomain>
Message-ID: <20130802164530.GH5292@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 02, 2013 at 04:26:48PM +0100, Dave Martin wrote:
> On Fri, Aug 02, 2013 at 10:14:49PM +0800, Greg KH wrote:
> > It should be easy to just abstract out your "this is how I write a byte
> > to the hardware" logic to handle the different bus types, if you really
> > are using the same chip/core.  Lots of drivers do this today just fine,
> > it isn't a big deal.
> 
> I think the focus here is on high-performance memory-mapped buses, since
> that's where a lot of the complexity lies in a SoC.  Once the bus is
> configured, all buses look much the same at the "how to write a byte"
> level.
> 
> The pain points are how the buses are configured, what their capabilities
> are, and how the view of the system (coherency, and addressing and visibility
> of slaves) varies between different bus masters.  These are key things which
> may vary per bus.  DT at least has no real way of describing such things
> right now.

And a simple, concrete example of this is the CCI (Cache Coherent
Interconnect) bus driver that was merged recently (drivers/bus/arm-cci.c).

The CCI supports device-coherency, which the driver exposes via a global
__cci_control_port_by_device symbol. Guess how many callers we have of that
function? Anyway, even if we did have a caller, that function then relies on
CCI-specific properties on the device being made coherent to figure out what
to do, so there's no new bus_type at all -- the linkages are all implicit in
the device-tree binding.

The CCI also has QoS and performance monitoring capabilities exposed in
memory-mapped registers, which aren't touched by the driver (although I have
seen patches for the latter).

Will
