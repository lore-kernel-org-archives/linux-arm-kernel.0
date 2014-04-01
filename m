From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Apr 2014 23:51:49 +0100
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <OF15BAA4F9.E675BBEF-ON87257CAD.006812E9-87257CAD.006BE81E@grpleg.it>
References: <20140319225137.GM7528@n2100.arm.linux.org.uk>
 <20140321173252.GL7528@n2100.arm.linux.org.uk>
 <OF42C103CA.1A3B5524-ON87257CA5.005C7764-87257CA5.0062A13A@grpleg.it>
 <201403242121.58705.marex@denx.de>
 <OF5A7B7FA4.2FEB0248-ON87257CA5.007AE2AE-87257CA5.007C44DB@grpleg.it>
 <20140324234443.GS7528@n2100.arm.linux.org.uk>
 <20140326001135.GV7528@n2100.arm.linux.org.uk>
 <20140401092638.GA10224@n2100.arm.linux.org.uk>
 <OF15BAA4F9.E675BBEF-ON87257CAD.006812E9-87257CAD.006BE81E@grpleg.it>
Message-ID: <20140401225149.GC7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 01, 2014 at 01:38:37PM -0600, robert.daniels at vantagecontrols.com wrote:
> I'm not sure where this factors in, but I originally saw this problem using
> the Freescale 2.6.35 kernel.  The driver there exhibits this problem
> differently, although it could very well be a different problem. What
> I observed was that when the FEC got into this bad state the driver would
> attempt to transmit a socket buffer but for some reason the buffer would
> not actually get transmitted.
>
> The driver would continue transmitting packets until it got all the way
> around in the ring buffer to the buffer descriptor right before the one
> that was never transmitted.  When this buffer descriptor was set to
> transmit you'd get a double transmit - the new packet and the previously
> untransmitted buffer.
>
> This results in out-of-order packets being sent directly from the i.MX53.

At initial glance, this is coherent with my idea of the FEC skipping a
ring entry on the initial pass around.  Then when a new entry is loaded,

Let's say that the problem entry is number 12 that has been skipped.
When we get back around to entry 11, the FEC will transmit entries 11
and 12, as you rightly point out, and it will then look at entry 13
for the next packet.

However, the driver loads the next packet into entry 12, and hits the
FEC to transmit it.  The FEC re-reads entry 13, finds no packet, so
does nothing.

Then the next packet is submitted to the driver, and it enters it into
entry 13, again hitting the FEC.  The FEC now sees the entry at 13,
meanwhile the entry at 12 is still pending.

> I hope this additional information is useful, I don't know enough
> about these low-level networking details to contribute much but
> it's possible that what I've seen in the 2.6.35 kernel is actually
> the same issue that I'm seeing in the 3.14 kernel but handled
> better.

It confirms the theory, but doesn't really provide much clues for a
solution at the moment.

However, I've had something of a breakthrough with iMX6 and half-duplex.
I think much of the problem comes down to this ERR006358 workaround
implemented in the driver (this apparantly doesn't affect your device.)
The delayed work implementation, and my delayed timer implementation of
the same are fundamentally wrong to the erratum documentation - as is
the version implemented in the Freescale BSP.

Implementing what the erratum says as an acceptable workaround improves
things tremendously - I see iperf on a 10Mbit hub go from 1-2Mbps up to
8Mbps, though still with loads of collisions.  That said, I'm not that
trusting of the error bits indicated from the FEC.

The reason I mention it here is that I wonder if less wacking of the
FEC_X_DES_ACTIVE register may help your problem.

In 3.14, in the fec_enet_start_xmit function, find the
"writel(0, fep->hwp + FEC_X_DES_ACTIVE);" and change it to:

	wmb();

        /* Trigger transmission start */
        if (readl(fep->hwp + FEC_X_DES_ACTIVE) == 0)
                writel(0, fep->hwp + FEC_X_DES_ACTIVE);

and see whether that helps your problem(s).

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
