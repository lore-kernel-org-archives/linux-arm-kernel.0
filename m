From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Apr 2012 15:16:04 +0100
Subject: [PATCH] ARM: fix __io macro for PCMCIA
In-Reply-To: <4F7C50D8.6060102@gmail.com>
References: <1333509112-1555-1-git-send-email-robherring2@gmail.com>
 <20120404090335.GQ24211@n2100.arm.linux.org.uk>
 <201204041027.30353.arnd@arndb.de>
 <20120404125624.GT24211@n2100.arm.linux.org.uk>
 <20120404130401.GU24211@n2100.arm.linux.org.uk> <4F7C50D8.6060102@gmail.com>
Message-ID: <20120404141604.GW24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 04, 2012 at 08:47:04AM -0500, Rob Herring wrote:
> On 04/04/2012 08:04 AM, Russell King - ARM Linux wrote:
> > On Wed, Apr 04, 2012 at 01:56:24PM +0100, Russell King - ARM Linux wrote:
> >> On Wed, Apr 04, 2012 at 10:27:30AM +0000, Arnd Bergmann wrote:
> >>> On Wednesday 04 April 2012, Russell King - ARM Linux wrote:
> >>>> On Tue, Apr 03, 2012 at 10:11:52PM -0500, Rob Herring wrote:
> >>>>> With commit c334bc1 (ARM: make mach/io.h include optional), PCMCIA was
> >>>>> broken as PCMCIA depends on __io() being just a cast. This needs a better
> >>>>> fix with a fixed i/o address mapping, but for now we just restore things
> >>>>> to the previous behavior.
> >>>>
> >>>> And what about systems with PCI IO at non-zero offsets with cardbus/pcmcia?
> >>>> This is broken and your assumption above is wrong.
> >>>
> >>> I would think they all still use their own mach/io.h. Which ones are you
> >>> thinking of?
> >>
> >> But they don't need the IO_SPACE_LIMIT messed around with - it should
> >> remain at 64K not 4GB.
> > 
> > Actually, we've done the whole io.h removal in totally the wrong bloody
> > order - because in removing all these so-called unnecessary io.h headers,
> > we've removed all those IO_SPACE_LIMIT definitions which overrode the
> > generic ones.
> > 
> > What we should have done is sorted out the PCMCIA/PCI/ISA IO space _first_
> > before removing any mach/io.h headers.
> > 
> > The fix for this is to restore those io.h headers which defined
> > IO_SPACE_LIMIT to something else other than the asm/io.h default until
> > the proper process in the above paragraph has been followed, and not
> > to work around it by buggering with the generic - and correct -
> > definition.
> > 
> 
> If you look at who defined IO_SPACE_LIMIT, you'll see most were just
> wrong (i.e. 0xffffffff and no PCMCIA/ISA/PCI). Is there any PCMCIA
> enabled ARM platform that doesn't require IO_SPACE_LIMIT to be 0xffffffff?

I thought I'd pointed that out already and why you're wrong above.
Think: what if you have PCI IO space at 0x7c000000 and you have a cardbus
bridge on your PCI bus.  Hint: ARM platforms have exactly this.

You're going to end up setting their IO_SPACE_LIMIT to 4GB instead of
the _correct_ 64K which they've had for _years_.

You're not making this better with this stuff, you're making things worse
in the name of 'less files, oh that must be good'.  No, it isn't good
if you end up breaking stuff in the process.

> CONFIG_PCMCIA_SOC_COMMON is pretty much specific to PXA and SA11xx and
> we already have a special case for it in asm/io.h. I'm simply extending
> that to the few other platforms using PCMCIA. So it's not really any
> more buggered than it already was.

Which is wrong, as I've already pointed out in this thread.

The generic definitions in asm/io.h are _correct_.  PCMCIA without
soc-common is standard PCMCIA, which has a single 64K IO window
unless the platform is using some special code.

PCMCIA with soc-common is indeterminant, and we default to a 4GB
_until_ the platforms are all fixed to use proper IO windows.

> Also, with this patch, building a PCMCIA enabled platform and non-PCMCIA
> platform together are compatible. Adding io.h will mean any PCMCIA
> platform could not be part of a single kernel build (other issues aside).

Look, it's pretty simple.  The kernel was working just fine before your
conversion.  Your conversion happened.  The kernel stops working on certain
platforms.  That means your conversion to remove mach/io.h was incorrect
and your analysis of what was required was wrong.

If that wasn't the case, there wouldn't be this fundamental issue that's
caused this breakage.
