From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 05 Sep 2014 16:04:06 +0200
Subject: [PATCH v2 1/4] arm64,
 thunder: Add Kconfig option for Cavium Thunder SoC Family
In-Reply-To: <20140905125147.GC20164@leverpostej>
References: <1409903205-2762-1-git-send-email-rric@kernel.org>
 <20140905110552.GH30401@n2100.arm.linux.org.uk>
 <20140905125147.GC20164@leverpostej>
Message-ID: <7863371.EMkUuntQWU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 September 2014 13:51:47 Mark Rutland wrote:
> On Fri, Sep 05, 2014 at 12:05:52PM +0100, Russell King - ARM Linux wrote:
> > On Fri, Sep 05, 2014 at 12:45:47PM +0200, Robert Richter wrote:
> > > On 05.09.14 10:32:40, Russell King - ARM Linux wrote:
> > > No, we need it just to enable all our drivers on the SoC. We want to
> > > enable the SoC by using defconfig + ARCH_THUNDER. As said in my other
> > > mail, I put it here to be able to base all other thunder driver patch
> > > sets on this initial base patch set. Otherwise this particular patch
> > > and also the dtb patch need to be shipped with all other driver patch
> > > sets. This might lead to duplicate submissions of the same patch.
> > > 
> > > With doing defconfig + ARCH_THUNDER we also want to enable the max
> > > number of cpus that is currently supported. I only enable 32 cpus
> > > since booting more cpus is untested. There might be problems at the 32
> > > cpu boundary. Just setting it to 64 does not mean a kernel will
> > > actually boot more than 32 cpus. But if it will be ack'ed, I would be
> > > fine to set NR_CPUS to 32 or 64 in general and independent from
> > > ARCH_THUNDER.
> > > 
> > > For simplicity I better drop setting NR_CPUS in this patch.
> > 
> > So, ARM64 will get a big long list of "config ARCH_foo" options just
> > to stuff lots of broken select statements into the configuration.  Yes,
> > this may have been the norm with ARM, but it's turned out to be more
> > of a problem than a solution, especially as it keeps causing Kconfig
> > warnings when things change in the rest of the kernel tree.
> 
> Agreed; this seems more pain than it is worth.

Lots of select statements indeed would be a problem, but I don't think
that is what Robert was suggesting.

> > The same is true with defconfigs - Linus threatened to delete all ARM
> > defconfigs except one at one point.
> 
> IMO we should continue doing what we've done so far and make the ARM64
> defconfig work on everything it can by default, no ARCH_* necessary.
> That's what most people will build and test and we shouldn't get
> platform-specific code (well, drivers) breaking the single image.

Right.

> For the extreme configurations (really tiny or really big) custom
> configuration being necessary is fine. That doesn't have to involve
> ARCH_* config options.
> 
> If you want to build a custom config then you should have an idea of
> what you need. ARCH_* options are only necessary if someone wants a
> kernel tuned for a specific SoC but doesn't know anything about that
> SoC.

A common pattern these days is to do dependencies like

arch/*/Kconfig:
	config ARCH_FOO
	bool "Enable support for Foo platform"
	help
	  ...


drivers/*/Kconfig
	config SUBSYS_FOO
	bool "SUBSYS driver for Foo"
	depends on ARCH_FOO || COMPILE_TEST
	depends on OF && REGULATOR && GENERIC_PHY # or whatever

That way we can enable everything in the defconfig, but someone
who likes to build a more specialized kernel can disable the
other platforms and won't get the drivers that are specific to
those.

I personally think this is a bit more verbose than what we need, but
I don't strongly object doing it that way.

The code size really should not matter much on ARM64 though: it's
unlikely we will see a lot of systems with less than a few gigabytes
of memory, and I expect that a generic kernel would be e.g. 6 MB
instead of 4 MB for a platform specific kernel.

	Arnd
