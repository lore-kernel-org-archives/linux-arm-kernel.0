From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Jul 2015 16:37:55 +0200
Subject: [PATCH] ARM: BCM: Restrict Broadcom BCM470X / BCM5301X to non-LPAE
In-Reply-To: <20150715210044.GH7557@n2100.arm.linux.org.uk>
References: <1436897535-3782-1-git-send-email-f.fainelli@gmail.com>
 <5941809.XWvPzT6esn@wuerfel> <20150715210044.GH7557@n2100.arm.linux.org.uk>
Message-ID: <1747823.jKCu0PvllP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 July 2015 22:00:44 Russell King - ARM Linux wrote:
> On Wed, Jul 15, 2015 at 10:41:51PM +0200, Arnd Bergmann wrote:
> > On Wednesday 15 July 2015 09:38:52 Florian Fainelli wrote:
> > > 
> > > I like the idea in general, but I think this is going to be a very
> > > tedious job to collect every single CR values for ARMv7 processors to
> > > determine whether they are pure v7 or v7e... Maybe we could use
> > > kernelci.org to start extracting the relevant lines in bootlogs and
> > > people can start adding their own chips one by one?
> > 
> > No, we know most of them:
> > 
> > Cortex-A5, A8, A9: ARMv7, no LPAE, no IDIV
> > Cortex-A7, A15, A12, A17: ARMv7VE, no LPAE, no IDIV
> > 
> > 
> > Almost everyone uses the above cores unmodified.
> > 
> > The ones I'm not 100% sure about are:
> > 
> > Marvell PJ4 (almost certainly ARMv7)
> > Marvell PJ4B (probably ARMv7 plus IDIV without LPAE)
> 
> Dove (PJ4B iirc):
> 
> Features        : half thumb fastmult vfp edsp iwmmxt thumbee vfpv3
> 		  vfpv3d16 tls idivt
> 
> So, thumb-only idiv, no LPAE.

Oh, so potentially another level.

> > If my list above is correct, there are no CPUs that have
> > LPAE but don't have IDIV, and we just need to decide how
> > to represent that.
> 
> GCC ARMv7VE selects ARM idiv and Thumb idiv support, so you need to
> check for idiva and idivt support from the CPU, otherwise we're into
> even more Kconfig dependency hell trying to work out the dependencies
> for T2 kernel builds vs ARM kernel builds.

An easy way out of course would be to ignore the idivt capability of
PJ4B and always treat it as ARMv7 even when building a thumb2 based
kernel.

The ARCH_MULTI_V* cpu level configuration we currently have is
indeed too complicated already, and I've tried to come up with
a way to simplify it.

The best idea I've had so far is to just use the global setting
for picking the minimum level, and working out the supported platforms
and features from there. Something along the lines of

choice
	prompt "Minimum CPU Architecture level"

config ARM_MIN_V4
	bool "ARMv4 based platforms (FA526)"
	select ARCH_MULTI_V4
	select ARCH_MULTI_V4T
	select ARCH_MULTI_V5

...

config ARM_MIN_V6
	bool "ARMv6 based platforms (ARM1136r0)"
	select ARCH_MULTI_V6
	select ARCH_MULTI_V6K
	select ARCH_MULTI_V7
	select ARCH_MULTI_V7_IDIVT
	select ARCH_MULTI_V7_IDIV
	select ARCH_MULTI_V7VE # for lpae
	select ARCH_MULTI_V8 # for crypto, maybe same as v7ve?

...

config ARM_MIN_V7_IDIV
	bool "ARMv7 based platforms with integer divide"
	select ARCH_MULTI_V7_IDIV
	select ARCH_MULTI_V7VE
	select ARCH_MULTI_V8
...

endchoice

I think this would be able to cover all cases we are
interested in, including future extensions. The main problem
I couldn't solve is how to convert existing defconfigs and
user configuration files without relying on users to pick
the right option.

	Arnd
