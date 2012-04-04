From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Apr 2012 14:04:01 +0100
Subject: [PATCH] ARM: fix __io macro for PCMCIA
In-Reply-To: <20120404125624.GT24211@n2100.arm.linux.org.uk>
References: <1333509112-1555-1-git-send-email-robherring2@gmail.com>
 <20120404090335.GQ24211@n2100.arm.linux.org.uk>
 <201204041027.30353.arnd@arndb.de>
 <20120404125624.GT24211@n2100.arm.linux.org.uk>
Message-ID: <20120404130401.GU24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 04, 2012 at 01:56:24PM +0100, Russell King - ARM Linux wrote:
> On Wed, Apr 04, 2012 at 10:27:30AM +0000, Arnd Bergmann wrote:
> > On Wednesday 04 April 2012, Russell King - ARM Linux wrote:
> > > On Tue, Apr 03, 2012 at 10:11:52PM -0500, Rob Herring wrote:
> > > > With commit c334bc1 (ARM: make mach/io.h include optional), PCMCIA was
> > > > broken as PCMCIA depends on __io() being just a cast. This needs a better
> > > > fix with a fixed i/o address mapping, but for now we just restore things
> > > > to the previous behavior.
> > > 
> > > And what about systems with PCI IO at non-zero offsets with cardbus/pcmcia?
> > > This is broken and your assumption above is wrong.
> > 
> > I would think they all still use their own mach/io.h. Which ones are you
> > thinking of?
> 
> But they don't need the IO_SPACE_LIMIT messed around with - it should
> remain at 64K not 4GB.

Actually, we've done the whole io.h removal in totally the wrong bloody
order - because in removing all these so-called unnecessary io.h headers,
we've removed all those IO_SPACE_LIMIT definitions which overrode the
generic ones.

What we should have done is sorted out the PCMCIA/PCI/ISA IO space _first_
before removing any mach/io.h headers.

The fix for this is to restore those io.h headers which defined
IO_SPACE_LIMIT to something else other than the asm/io.h default until
the proper process in the above paragraph has been followed, and not
to work around it by buggering with the generic - and correct -
definition.
