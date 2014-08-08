From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Aug 2014 15:30:08 +0100
Subject: [BUG]: imx6q (wandboard): Very unstable ethernet since kernel 3.16
In-Reply-To: <1407507023.19455.3.camel@sharkbay.at>
References: <1407503758.19455.1.camel@sharkbay.at>
 <20140808132754.GC30282@n2100.arm.linux.org.uk>
 <1407507023.19455.3.camel@sharkbay.at>
Message-ID: <20140808143008.GD30282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 08, 2014 at 04:10:23PM +0200, Thomas Scheiblauer wrote:
> On Fre, 2014-08-08 at 14:27 +0100, Russell King - ARM Linux wrote:
> > On Fri, Aug 08, 2014 at 03:15:58PM +0200, Thomas Scheiblauer wrote:
> > > Since Kernel 3.16 (running on 3.16.0) the ethernet (fec) connection
> > > stops working after exchanging very little data. Sometimes it comes back
> > > again for some seconds and drops again. No clues in dmesg.
> > > 
> > > After increasing TX_RING_SIZE in "drivers/net/ethernet/freescale/fec.h"
> > > from 512 to 1024 the connection seems to stay stable (judging after
> > > about half an hour of testing) but I really don't have experience with
> > > kernel driver hacking, so I'm not sure what I'm doing here.
> > 
> > Interesting.  There have been some other reports of instability in a
> > similar manner to that which you report, and, like the wanboard, they
> > too have this:
> > 
> >         interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_HIGH>,
> >                               <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
> > 
> > Could it be that gpio1 6 doesn't actually work very well?  What happens
> > if you comment out the above property in
> > arch/arm/boot/dts/imx6qdl-wandboard.dtsi so you're using the standard
> > interrupt on GIC 150?
> > 
> 
> These lines in arch/arm/boot/dts/imx6qdl-wandboard.dtsi already seem to
> be a workaround for some hardware errata:
> ERR006687 ?ENET: Only the ENET wake-up interrupt request can wake the
> system from Wait mode?

Correct.  That's a workaround for wakeup.  That's not a workaround for
normal operation.

Two people (including yourself) have reported ethernet stability problems
with recent kernels.  Both reporters show that their platforms are using
GPIO1 6 being for the ethernet IRQ.

Meanwhile, I (and others) have the standard IRQ being used for it, and we
have yet to have any reports or see any instability resulting from that.

So, what I'm asking is to try without this workaround in case there is
some interaction there, thus testing the same interrupt configuration
that I've had here for the last 10 months without the kind of issues
you're reporting.  Sometimes, workarounds for one problem end up causing
other problem elsewhere.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
