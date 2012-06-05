From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 5 Jun 2012 13:24:44 +0100
Subject: Freescale fec.c driver breakage
In-Reply-To: <4FCDF8BE.6010509@snapgear.com>
References: <4FCC3CB4.5030107@snapgear.com>
 <20120604081937.GH30400@pengutronix.de>
 <20120604091616.GA3943@opensource.wolfsonmicro.com>
 <4FCDAD5B.8010106@snapgear.com>
 <20120605094141.GE23408@opensource.wolfsonmicro.com>
 <4FCDF8BE.6010509@snapgear.com>
Message-ID: <20120605122444.GS23408@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2012 at 10:17:02PM +1000, Greg Ungerer wrote:
> On 06/05/2012 07:41 PM, Mark Brown wrote:

> >Yes, if it's a reusable IP then it's going to have a fixed set of clocks
> >which go into it regardless of which platform it's hooked up to.

> I really don't think you can make that assumption here. Freescale have
> come up with a number of weird and slightly different permutations of
> this ethernet core.

That's just sounding like a standard "driver needs to take care of chip
revisions" thing though?

> >clkdev
> >provides an abstraction which can map these onto the platform, even if
> >you don't use the generic clk API clkdev is still very useful and will
> >help with a lot of these issues.

> In this specific case I don't know what the ipg or ahb clocks are on iMX
> (Sascha?), but there is nothing equivalent to them in the FEC cores used
> on existing ColdFire CPUs. They seem to be platform specific (iMX) more
> than FEC driver specific.

It's possible both are just always on in the ColdFire systems, at least
when Linux is running.  The AHB will be the I/O bus for the device (AHB
is a standard for interfacing between IPs) and I suspect IPG is the main
clock for the IP, both of which sound like they will always be there
even if there's no soft control of them.

FWIW I'm about to send a patch which will make devm_clk_get() available
with HAVE_CLK, though it would still be good to start looking at moving
ColdFire to the common clock infrastructure.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120605/4fe13afb/attachment.sig>
