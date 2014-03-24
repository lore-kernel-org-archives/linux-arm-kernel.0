From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Mar 2014 23:44:43 +0000
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <OF5A7B7FA4.2FEB0248-ON87257CA5.007AE2AE-87257CA5.007C44DB@grpleg.it>
References: <20140319225137.GM7528@n2100.arm.linux.org.uk>
 <20140321173252.GL7528@n2100.arm.linux.org.uk>
 <OF42C103CA.1A3B5524-ON87257CA5.005C7764-87257CA5.0062A13A@grpleg.it>
 <201403242121.58705.marex@denx.de>
 <OF5A7B7FA4.2FEB0248-ON87257CA5.007AE2AE-87257CA5.007C44DB@grpleg.it>
Message-ID: <20140324234443.GS7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 24, 2014 at 04:37:20PM -0600, robert.daniels at vantagecontrols.com wrote:
> Marek Vasut <marex@denx.de> wrote on 03/24/2014 02:21:58 PM:
> > I think the UDP test might be lossy, can you try with TCP test please ?
> >
> > Best regards,
> > Marek Vasut
> 
> Yes, I tried with TCP and there were no problems.
> I then tried my same test with a crossover cable: no problems.
> Then I started testing some different network configurations:
> 
> 1. Desktop & i.MX53 both connected to the same router: no problems.
> 2. Desktop & i.MX53 both connected to the same hub: packet loss but no tx
> timeout
> 3. Desktop connected to router, hub connected to router, i.MX53 connected
> to hub: packet loss + tx timeout
> 
> So, the packet loss is due to the hub, not the fec driver.
> I'm not sure why I'm getting the tx timeout.  My router is a Cisco
> ValetPlus and the hub is a Netgear DS108.
> The router and desktop are gigabit and the hub is 10/100.
> 
> I assumed that the tx timeout should not be happening - is this an
> incorrect assumption based on my setup?

The first point is that the timeout should not be happening, because
when the link is up and running, packets should be transmitted.

The second point is that I think you have a setup which tickles a bug
in the FEC hardware.  What I think is going on is that the driver is
filling the transmit ring correctly.  For some reason, the FEC is
either failing to update the header after transmission leaving the
buffer owned by the FEC (and therefore unable to be reaped), or the
FEC is skipping over a ring descriptor.

As I hinted in one of my previous replies, I think the only way we're
truely going to work out what's going on here is to come up with some
way to mark each packet that is transmitted with where it was in the
ring, so a tcpdump session on another machine can be used to inspect
which packets from the ring were actually transmitted on the wire.

Now, you mention packet loss above.  Even on half-duplex networks, I
would not expect there to be much packet loss because of the
retransmissions after a collision, and 100Mbit networks handle this
much better than 10Mbit.  It takes repeated collisions to cause a
packet to actually be dropped (and a packet being dropped because
of collisions should be logged by the transmitting host in its
interface statistics.)

Another possibility is that the FEC isn't properly negotiating with
the hub, and the two ends are ending up configured differently, or
that it is negotiating properly but the FEC isn't being configured
correctly.

Now that we know a little more about your setup, including that it
seems to be one specific setup which is causing the problems, I'll
do some more testing - I have an old Allied Telesys 10/100 hub here
which I'll try putting the iMX6 on and re-run your tests.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
