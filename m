From: gerg@snapgear.com (Greg Ungerer)
Date: Tue, 5 Jun 2012 22:36:30 +1000
Subject: Freescale fec.c driver breakage
In-Reply-To: <20120605122444.GS23408@opensource.wolfsonmicro.com>
References: <4FCC3CB4.5030107@snapgear.com>
 <20120604081937.GH30400@pengutronix.de>
 <20120604091616.GA3943@opensource.wolfsonmicro.com>
 <4FCDAD5B.8010106@snapgear.com>
 <20120605094141.GE23408@opensource.wolfsonmicro.com>
 <4FCDF8BE.6010509@snapgear.com>
 <20120605122444.GS23408@opensource.wolfsonmicro.com>
Message-ID: <4FCDFD4E.1000906@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2012 10:24 PM, Mark Brown wrote:
> On Tue, Jun 05, 2012 at 10:17:02PM +1000, Greg Ungerer wrote:
>> On 06/05/2012 07:41 PM, Mark Brown wrote:
>
>>> Yes, if it's a reusable IP then it's going to have a fixed set of clocks
>>> which go into it regardless of which platform it's hooked up to.
>
>> I really don't think you can make that assumption here. Freescale have
>> come up with a number of weird and slightly different permutations of
>> this ethernet core.
>
> That's just sounding like a standard "driver needs to take care of chip
> revisions" thing though?
 >
>>> clkdev
>>> provides an abstraction which can map these onto the platform, even if
>>> you don't use the generic clk API clkdev is still very useful and will
>>> help with a lot of these issues.
>
>> In this specific case I don't know what the ipg or ahb clocks are on iMX
>> (Sascha?), but there is nothing equivalent to them in the FEC cores used
>> on existing ColdFire CPUs. They seem to be platform specific (iMX) more
>> than FEC driver specific.
>
> It's possible both are just always on in the ColdFire systems, at least
> when Linux is running.  The AHB will be the I/O bus for the device (AHB
> is a standard for interfacing between IPs) and I suspect IPG is the main
> clock for the IP, both of which sound like they will always be there
> even if there's no soft control of them.

I am pretty sure AHB was bolted on later. This FEC core has progressed
from very old Motorola PowerPC platforms to ColdFire/M68k to ARM, over
something coming close to a 20 year period. In the earlier uses of it
there is quite a few differences (including some quite odd register
layout differences).

There may be other things that are somewhat like an ahb clock and ipg
clock, but really these are things that have come along later with a
specific platform implementation.


> FWIW I'm about to send a patch which will make devm_clk_get() available
> with HAVE_CLK, though it would still be good to start looking at moving
> ColdFire to the common clock infrastructure.

Sure, agreed.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close,                            FAX:         +61 7 3891 3630
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
