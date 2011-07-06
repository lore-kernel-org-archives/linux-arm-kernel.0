From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jul 2011 15:51:11 +0100
Subject: [PATCH 1/3] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <201107061442.05182.arnd@arndb.de>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
	<1309945678-18813-2-git-send-email-bs14@csr.com>
	<20110706122501.GU8286@n2100.arm.linux.org.uk>
	<201107061442.05182.arnd@arndb.de>
Message-ID: <20110706145111.GD8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 02:42:04PM +0200, Arnd Bergmann wrote:
> Right now, the only platforms that use a value other than 0xffffffff
> are ones that actually have PCI and set it to 0xffff.

Note that those platforms using soc_common need to have their inb() et.al.
defined to be compatible with readb() et.al. as soc_common ioremaps the
IO resource and passes that into the PCMCIA layer as the per-socket IO
offset.

The alternative is to rip that out, and use fixed mappings and fixed
per-SoC IO offsets.

So, I think as part of this idea, we should - for the time being -
default IO_SPACE_LIMIT to 0xffffffff if PCMCIA_SOC_COMMON is enabled in
any way.  The plus side is that we get that condition documented, and
so can do something about it later.
