From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Mar 2010 20:54:53 +0000
Subject: [PATCH] ARM: Add Versatile Express CA9x4 processor support
In-Reply-To: <000201cabc81$ec481330$c4d83990$@tuckley@arm.com>
References: <git-1267729916-61c9b6ab773870de77ff9183b8bb055a03b19671@rmk-PC>
	<git-1267729916-8545dcd13a3ae6450278b076cb024d10d64ee785@rmk-PC>
	<000201cabc81$ec481330$c4d83990$@tuckley@arm.com>
Message-ID: <20100305205453.GC4885@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 05, 2010 at 04:35:53PM -0000, Colin Tuckley wrote:
> > -----Original Message-----
> > From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> > kernel-bounces at lists.infradead.org] On Behalf Of Russell King
> 
> > + * Versatile Express Core Tile Cortex A9x4 Support
> 
> Versatile Express daughter boards are *not* called "Core Tiles". They are
> both physically and electrically incompatible and so we have specifically
> avoided using the term.

I don't believe you.

DUI0448A contains these phrases:

CoreTile Express A9x4

Contents CoreTile Express A9x4 Technical Reference Manual
1.2 About the CoreTile Express A9x4 daughterboard
2.8 Overview of the CoreTile Express A9x4 daughterboard

There are 28 references in this document to 'CoreTile'.

> > +static struct clcd_panel xvga_panel = {
> 
> What happened to the support for vga and svga? These are needed when using
> the CLCD controller on the motherboard which doesn't support XVGA due to bus
> bandwidth limitations.

You may notice that this is supporting the Core Tile CLCD controller, not
the motherboard controller.  This file does not deal with *any* motherboard
stuff.

> This is not the preferred way to use the SRI (which I'm now told is
> officially called "The Serial Configuration Controller").
> 
> There is a documented data structure and set of routines which are used by
> the boot-monitor, self-test, bootloader and my kernel patch set for the
> Versatile Express. We would prefer that it be kept consistent across all
> software that needs to use the SCC.

So we should have some over complicated way to access what is a simple
protocol.  I'm sorry, in Linux land, we don't always follow manufacturers
recommendations to that level if there's a better way to do it - and
I believe that these interfaces are much better for what is actually
required.

Just because some other bits of software use some kind of software API
does not mean that the kernel should do - in fact, we've been down this
exact route with another manufacturer, who provided an "OS independent
library" for talking to their I2C based system controller which "every
OS must use" - the result was a very unstable kernel which kept provoking
the system to completely reboot.

Replacing that with a custom written implementation for Linux resolved
all the spontaneous reboot issues.

What I'm saying is that just because someone comes up with a super duper
all bells and whistles API and says that it should be implemented is not
a justification to implement it - in my experience it's better to stick
knives in the paper it's written on, stamp on it, and then burn it. ;)
