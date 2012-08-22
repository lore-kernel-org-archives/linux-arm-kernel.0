From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Aug 2012 09:32:23 +0100
Subject: [PATCH 2/2] ARM: imx6q: replace clk_register_clkdev with clock
 DT lookup
In-Reply-To: <5033891D.90509@calxeda.com>
References: <1345104526-14797-1-git-send-email-shawn.guo@linaro.org>
 <1345104526-14797-3-git-send-email-shawn.guo@linaro.org>
 <503232E0.3000007@gmail.com>
 <CAKGA1bn2uCWE8YkGR4EzTxZ_bXJ_ov2diq63uxQ=dT7b6Fu9GQ@mail.gmail.com>
 <20120820151609.GN24242@S2101-09.ap.freescale.net>
 <CAKGA1bnfhMC8QG9OqBbpy5iq6ZAfEgrYMg_LVd50U7yikLhDAg@mail.gmail.com>
 <20120821122753.GU18957@n2100.arm.linux.org.uk> <5033891D.90509@calxeda.com>
Message-ID: <20120822083223.GW18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2012 at 08:11:57AM -0500, Rob Herring wrote:
> On 08/21/2012 07:27 AM, Russell King - ARM Linux wrote:
> > So now, you're not dealing with inventing a whole load of names for clocks
> > on a platform, instead what you're doing is describing _where_ the clock
> > comes from in the system for a particular device by device node and index
> > into it - just like we do for interrupts.
> 
> That is what we're doing. The names are optional for DT, but happen to
> be required for struct clk now. If we don't put something in DT, then
> the clock names will have to be something generic like ccm-1..ccm-185.

And that's what's wrong.  Clocks themselves should _not_ be required to
be named.

If you use purely "producer node + index" then you don't need to name a
whole bunch of clocks, and you don't need to have an array of clock names
in the DT file.  This also gets rid of the time consuming strcmp against
every clock, which has already been raised as a problem with the existing
clk_get().

And, like it or not, the way they're being describing them in the DT file
at the top of this sub-thread, the matching _is_ done only by producer
name, which is TOTALLY the wrong way to go about this (that's how folk
tried to use the connection ID in the clk API and IT DOESN'T WORK for
reusable drivers.)
