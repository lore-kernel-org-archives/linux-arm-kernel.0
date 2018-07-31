From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 Jul 2018 16:52:28 +0100
Subject: [PATCH 6/6] arm64: enable RapidIO menu in Kconfig
In-Reply-To: <d09cb4f5-768b-acd8-f9b1-d1d320a93564@gmail.com>
References: <20180730225035.28365-1-acolin@isi.edu>
 <20180730225035.28365-7-acolin@isi.edu>
 <20180731084143.GA4680@arm.com>
 <d09cb4f5-768b-acd8-f9b1-d1d320a93564@gmail.com>
Message-ID: <20180731155228.GN17271@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 08:54:14AM -0400, Alex Bounine wrote:
> On 2018-07-31 04:41 AM, Will Deacon wrote:
> >On Mon, Jul 30, 2018 at 06:50:34PM -0400, Alexei Colin wrote:
> >>Platforms with a PCI bus will be offered the RapidIO menu since they may
> >>be want support for a RapidIO PCI device. Platforms without a PCI bus
> >>that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
> >>in the platform-/machine-specific "config ARCH_*" Kconfig entry.
> >>
> >>Tested that kernel builds for arm64 with RapidIO subsystem and
> >>switch drivers enabled, also that the modules load successfully
> >>on a custom Aarch64 Qemu model.
> >>
> >>Cc: Andrew Morton <akpm@linux-foundation.org>
> >>Cc: Russell King <linux@armlinux.org.uk>
> >>Cc: John Paul Walters <jwalters@isi.edu>
> >>Cc: linux-arm-kernel at lists.infradead.org
> >>Cc: linux-kernel at vger.kernel.org,
> >>Signed-off-by: Alexei Colin <acolin@isi.edu>
> >>---
> >>  arch/arm64/Kconfig | 2 ++
> >>  1 file changed, 2 insertions(+)
> >
> >Thanks, this looks much cleaner than before:
> >
> >Acked-by: Will Deacon <will.deacon@arm.com>
> >
> >The only thing I'm not sure about is why we don't just select HAS_RAPIDIO
> >unconditionally in the arm64 Kconfig. Does selecting only that option
> >actually pull in new code to the build?
> >
> HAS_RAPIDIO option is intended for SOCs that have built in SRIO controllers,
> like TI KeyStoneII or FPGAs. Because RapidIO subsystem core is required
> during RapidIO port driver initialization, having separate option allows us
> to control available build options for RapidIO core and port driver (bool
> vs. tristate) and disable module option if port driver is configured as
> built-in.

Your explanation doesn't make much sense to me.

RAPIDIO is the bus-level support, right?  So drivers that depend on
the bus-level support should depend on RAPIDIO, and so, if RAPIDIO
is configured as a module, they will also be allowed to be disabled
or a module, but not built-in if tristate.  If it is boolean, and
causes the driver to be built-in to the kernel, then you need to use
"RAPIDIO=y" so that it's dependency is only satisfied when the core
is built-in.

HAS_RAPIDIO gives the impression that it defines whether or not
the rapidio core code is allowable or not - it doesn't suggest that
it has anything to do with drivers.  However, reading the PowerPC
Kconfig files, it seems to be used that way.  That's confusing, and
ought to be fixed.  From what I can tell, it's only used for FSL_RIO,
so I suggest that gets converted to:

config HAS_RAPIDIO
	bool PCI

config RAPIDIO
	tristate "RapidIO support"
	depends on HAS_RAPIDIO

config HAS_FSL_RIO
	bool
	select HAS_RAPIDIO

config FSL_RIO
	bool "Freescale Embedded SRIO Controller support"
	depends on RAPIDIO = y && HAS_FSL_RIO

This frees up HAS_RAPIDIO to operate as one would expect - to define
whether or not RAPIDIO should be offered.  This also allows:

config ARM
	select HAS_RAPIDIO if PCI

to be added to arch/arm/Kconfig if appropriate.  However, I'm not yet
convinced that _just because_ we have PCI does not mean that RAPIDIO
should be offered.  I stated a series of questions about that last
Tuesday in response to an individual patch adding rapidio to arch/arm,
and that email seems to have been ignored - at least as far as the
questions go.

Please ensure that you respond to your reviewers questions, otherwise
you will start receiving plain NAKs to your patches instead (since
it becomes a waste of time for reviewers to put any further effort
in to explain why they don't like the patch.)

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
