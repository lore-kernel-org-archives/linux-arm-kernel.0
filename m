From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Jul 2018 15:02:04 +0100
Subject: [PATCH] arm: enable RapidIO config options in Kconfig
In-Reply-To: <20180724134122.86718-1-acolin@isi.edu>
References: <20180724134122.86718-1-acolin@isi.edu>
Message-ID: <20180724140203.GV17271@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2018 at 09:41:26AM -0400, Alexei Colin wrote:
> ARM SoCs with a PCI bus offer the RapiodIO config menu; SoCs with
> RapidIO IP blocks but without a PCI bus, need to add "select
> HAS_RAPIDIO" to the Kconfig entry for that SoC (e.g. ARCH_*).
> 
> HAS_RAPIDIO was chosen over HAVE_RAPIDIO to be consistent with
> other architectures which already define this flag (powerpc).

Is there any reason we can't have the RAPIDIO and HAS_RAPIDIO config
blocks in drivers/rapidio/Kconfig (maybe without the || PCI - see
below), and then have architecture Kconfig files do:

config (ARM or PPC)
	select HAS_RAPIDIO if PCI

or in the case of MIPS:

config MIPS
	...
	select HAS_RAPIDIO

That would avoid duplicating almost identical RAPIDIO and HAS_RAPIDIO
config blocks in architecture Kconfig files.

Why should rapidio be available just because we have PCI selected?  If
it behaves as a PCI add-in card, then why isn't this available for any
architecture with PCI?

What about build coverage - shouldn't RAPIDIO be selectable for (eg)
other architectures via COMPILE_TEST if it's supposed to be generic?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
