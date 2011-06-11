From: mikpe@it.uu.se (Mikael Pettersson)
Date: Sat, 11 Jun 2011 13:22:18 +0200
Subject: [PATCH] arm: fix regression in ixp4xx clocksource
In-Reply-To: <20110611051510.GA3283@riccoc20.at.omicron.at>
References: <20110530084307.GA28953@riccoc20.at.omicron.at>
	<20110601225826.GR3660@n2100.arm.linux.org.uk>
	<20110611051510.GA3283@riccoc20.at.omicron.at>
Message-ID: <19955.20458.788309.51588@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Richard Cochran writes:
 > On Wed, Jun 01, 2011 at 11:58:26PM +0100, Russell King - ARM Linux wrote:
 > > On Mon, May 30, 2011 at 10:43:07AM +0200, Richard Cochran wrote:
 > > > Commit 234b6ceddb4fc2a4bc5b9a7670f070f6e69e0868
 > > > 
 > > >    clocksource: convert ARM 32-bit up counting clocksources
 > > > 
 > > > broke the build for ixp4xx and made big endian operation impossible.
 > > > This commit restores the original behaviour.
 > > 
 > > I'm really not happy about using the MMIO clocksource stuff with random
 > > other read functions like this - it defeats the entire purpose of the
 > > MMIO clocksource stuff.  Maybe we should just undo the change for IXP4xx
 > > and treat it as "special" for the time being.
 > 
 > I took another look at the whole MMIO clocksource implementation and
 > can't understand why all of the accessors use le_to_cpu. This seems to
 > imply that all peripheral buses are little endian (except for ixp,
 > which no one cares about, anyhow).

"no one"? ixp4xx is still being used.

 > I understand (or have been told) that almost all arm implementations
 > out there are little endian. Why not use use a normal load to read the
 > timer? Are there machines with LE peripheral buses but BE cores?

ARM cores often have software-controllable endianess (see the ARM ARM).
Off the top of my head:
- ixp4xx: natively BE core and peripherals, but some people like to
  switch the core to LE for user-space SW compatibility reasons
  (I run my ixp4xx in BE as intended though)
- Kirkwood: natively LE core and peripherals, but the core is switchable
  to BE, although driver support for that appears to be incomplete

And then there were the old chips where the integer core and the FPA
(ancient FPU) could run with different endianesses ... lots of software
had problems with that; I'm glad EABI and VFP put an end to that insanity.
