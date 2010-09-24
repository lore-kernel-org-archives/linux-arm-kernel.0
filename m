From: richardcochran@gmail.com (Richard Cochran)
Date: Fri, 24 Sep 2010 10:33:35 +0200
Subject: [PATCH v6 0/8] ptp: IEEE 1588 hardware clock support
In-Reply-To: <alpine.DEB.2.00.1009231238170.2962@router.home>
References: <cover.1285261533.git.richard.cochran@omicron.at>
	<alpine.DEB.2.00.1009231238170.2962@router.home>
Message-ID: <20100924083335.GA13272@riccoc20.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 23, 2010 at 12:53:20PM -0500, Christoph Lameter wrote:
> On Thu, 23 Sep 2010, Richard Cochran wrote:
> > 3.3 Synchronizing the Linux System Time
> > ========================================
> >
> >    One could offer a PHC as a combined clock source and clock event
> >    device. The advantage of this approach would be that it obviates
> >    the need for synchronization when the PHC is selected as the system
> >    timer. However, some PHCs, namely the PHY based clocks, cannot be
> >    used in this way.
> 
> Why not? Do PHY based clock not at least provide a counter that increments
> in synchronized intervals throughout the network?

The counter in the PHY is accessed via the MDIO bus. One 16 bit read
takes anywhere from 25 to 40 microseconds. Reading the 64 bit time
value requires four reads, so we're talking about 100 to 160
microseconds, just for a single time reading.

In addition to that, reading MDIO bus can sleep.  So, we can't (in
general) to offer PHCs as clock sources.

> >    Instead, the patch set provides a way to offer a Pulse Per Second
> >    (PPS) event from the PHC to the Linux PPS subsystem. A user space
> >    application can read the PPS events and tune the system clock, just
> >    like when using other external time sources like radio clocks or
> >    GPS.
> 
> User space is subject to various latencies created by the OS etc. I would
> that in order to have fine grained (read microsecond) accurary we would
> have to run the portions that are relevant to obtaining the desired
> accuracy in the kernel.

The time-critical operations are all performed in hardware (packet
timestamp), or in kernel space (input PPS timestamp). User space only
runs the servo (using hardware or kernel timestamps as input) and
performs the clock correction. With a sample rate of 1 PPS, the small
user space induced delay (a few dozen microseconds) between sample
time and clock correction is not an issue.

Thanks,
Richard
