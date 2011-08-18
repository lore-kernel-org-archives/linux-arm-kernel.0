From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Aug 2011 17:14:47 +0200
Subject: [PATCH 00/10] Clean up some io.h and associated code
In-Reply-To: <20110817075104.GC1006@n2100.arm.linux.org.uk>
References: <20110817075104.GC1006@n2100.arm.linux.org.uk>
Message-ID: <201108181714.47464.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 August 2011, Russell King - ARM Linux wrote:
> This series does some cleanup of the mach/io.h header files and
> associated definitions, including getting rid of quite a lot of
> IO_SPACE_LIMIT definitions.

Hi Russell,

This looks very nice!

I did some research during the Cambourne meeting about of these
and found that the omap1 and a91 platforms also need the IO_SPACE_LIMIT
defined to 0xffffffff when CONFIG_AT91_CF or CONFIG_OMAP_CF are
set, so these fall into the same category as CONFIG_PCMCIA_SOC_COMMON.

How about a new Kconfig symbol for this special I/O mode that is
selected by the three drivers? That would take care of all remaning
PCCARD users and simplify the generic IO_SPACE_LIMIT definition to

#ifndef IO_SPACE_LIMIT
#if defined(CONFIG_IO_SPACE_VIRTUAL) /* maybe you have a better name */
#define IO_SPACE_LIMIT ((resource_size_t)0xffffffff)
#elif defined(CONFIG_PCI) || defined(CONFIG_ISA)
#define IO_SPACE_LIMIT ((resource_size_t)0xffff)
#else
#define IO_SPACE_LIMIT ((resource_size_t)0)
#endif
#endif

The platforms that currently use PCI or ISA in the same way can
then also set that symbol and get rid of their private definition, or
converted over to having a single 64k window.

	Arnd
