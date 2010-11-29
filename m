From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Nov 2010 16:50:30 +0100
Subject: [PATCH] ARM: Gemini: Add support for PCI Bus
In-Reply-To: <20101129142200.GA14941@n2100.arm.linux.org.uk>
References: <1290263224-16965-1-git-send-email-ulli.kroll@googlemail.com>
	<201011271639.21694.arnd@arndb.de>
	<20101129142200.GA14941@n2100.arm.linux.org.uk>
Message-ID: <201011291650.30982.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 November 2010, Russell King - ARM Linux wrote:
> On Sat, Nov 27, 2010 at 04:39:21PM +0100, Arnd Bergmann wrote:
> > On Saturday 27 November 2010 14:01:20 Micha? Miros?aw wrote:
>
> Be careful.  There are two things going on here:
> 
> 1. those which PCI support is configurable
> 2. those which always have PCI support
> 
> Making PCI "depend on HAVE_PCI" is wrong, and will throw up lots of
> Kconfig warnings, as those platforms which always have PCI support
> won't select HAVE_PCI - and making them do so such that "PCI support"
> gets offered to them - with the only possible value being 'Y' is
> silly.

We definitely need to be careful with combinations of select and
depends. The obvious danger is enabling two boards, one of which
requires PCI while the other one cannot deal with CONFIG_PCI=y.
As we get to more multiplatform builds, we have to eventually
solve this, along with the problem that certain PCI implementations
are currently mutually exclusive.

What behaviour do you want to see in a multiplatform build where
one board is known to have PCI, one may have it and a third
one cannot have PCI? Should it be enabled, disabled or
user-selected.

> So, rather than HAVE_PCI, it should be MIGHT_HAVE_PCI, and that
> symbol needs to control whether the "PCI support" prompt is offered
> to the user, not whether PCI is available or not.

Most architectures make PCI optional even though it is a bit silly
to disable it like on x86. There are a lot of other useful configuration
options that end up always enabled in practice.

The easiest way would be to always select HAVE_PCI (or MIGHT_HAVE_PCI
if you prefer the term) and make the default CONFIG_PCI default to
yes.

Or you could go fancy and have both HAVE_PCI and MIGHT_HAVE_PCI, with
each platform selecting at most one of the two and this

config PCI
	bool "PCI support"
	depends on MIGHT_HAVE_PCI && !HAVE_PCI
	default HAVE_PCI

This way it will be silently turned on if one of the machines requires
PCI, but stay visible if the machines might want to disable PCI.

	Arnd
