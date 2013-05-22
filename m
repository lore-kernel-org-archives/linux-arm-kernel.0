From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 May 2013 15:17:51 +0100
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on
 Armada 370/XP
In-Reply-To: <20130522155218.1c2af492@skate>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130521193803.GA20882@1wt.eu> <519C9779.1040104@gmail.com>
 <20130522134336.GE18614@n2100.arm.linux.org.uk>
 <20130522155218.1c2af492@skate>
Message-ID: <20130522141751.GF18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 03:52:18PM +0200, Thomas Petazzoni wrote:
> Dear Russell King - ARM Linux,
> 
> On Wed, 22 May 2013 14:43:36 +0100, Russell King - ARM Linux wrote:
> > On Wed, May 22, 2013 at 12:01:29PM +0200, Sebastian Hesselbarth wrote:
> > > I tried the above on Dove which is possibly affected by the workaround
> > > as it is also ARMv7. In Dove you can access unmapped addresses without
> > > any problems, but as Thomas already stated Armada 370/XP just hang.
> > > Must be some default AHB slave in Dove, which Armada 370/XP is missing.
> > 
> > It may be some clock setting somewhere on the 370/XP.  The Dove will hang
> > as well if you prod at peripherals which you've turned their clocks off.
> 
> The register in question (offset 0x20080 from the base address of the
> internal register) is part of the "core" registers, so I clearly don't
> see how the system could even be booting if this clock was gated. No?

The question which was asked was:

	What happens if you access a register at 0xd0xxxxxx when the
	registers are remapped to 0xf1xxxxxx?

The answer which was given was:

	It hangs on XP / 370, but doesn't on Dove.

If the registers have been remapped, then 0xd0xxxxxx is _not_ going to
hit any of the "core" registers.  We're hitting "something else" and
what I'm saying is that Dove will also hang if you hit a peripheral with
its clocks turned off.  Now, it may not be a peripheral, but a bus
segment which is unclocked on those which hang.

As Dove only has clock gating in a few of its peripherals, it could be
that whatever you hit at 0xd0xxxxxx on Dove is allowed to succeed because
of this.  Is that also true on XP or 370?

What we need to know is: after the boot loader passes control to the
kernel, and before _we_ start fiddling around with any clocks, is the
region at 0xd0xxxxxx accessible without hanging the CPU?

That's the point at which we'd want to probe for the remapped registers,
so that's the point where the test access must be made - and with the
system clocks in whatever state was left by the reset+boot loader.
