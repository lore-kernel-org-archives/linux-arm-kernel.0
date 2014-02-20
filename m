From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Feb 2014 14:53:02 +0100
Subject: [PATCH 21/21] ARM: Kirkwood: Remove DT support
In-Reply-To: <1392900664.23342.60.camel@kazak.uk.xensource.com>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <20140220121821.GO11878@lunn.ch>
 <1392900664.23342.60.camel@kazak.uk.xensource.com>
Message-ID: <2127012.W6WnQnXmRo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 February 2014 12:51:04 Ian Campbell wrote:
> On Thu, 2014-02-20 at 13:18 +0100, Andrew Lunn wrote:
> > On Thu, Feb 20, 2014 at 11:34:36AM +0000, Ian Campbell wrote:
> Debian has a single v7 flavour, armmp which uses the multi platform
> stuff. (actually there is a second armmp-lpae, but lets ignore that)
> 
> I'm only really concerned about the v5 stuff here. Debian has multiple
> v5 flavours: ixp4xx, kirkwood, mv78xx0, orion5x and versatile.

Unfortunately, this selection include multiple platforms that
we don't plan to (ever) support in a multiplatform kernel, while
a lot of platforms you don't currently support are already enabled
or will be at some point.

* ixp4xx is too different from the others and I don't think it's
  possible to turn it over to multiplatform.
* I see a iop32x_defconfig in svn that you didn't mention here,
  but it's basically the same problem as ixp4xx.
* kirkwood/mv78xx0/orion5x are essentially one platform and work
  in progress.
* versatile is easy to do as multiplatform, I just haven't gotten
  around to do it.

ARMv5 platforms that are already working with ARCH_MULTIPLATFORM:
* freescale mxc (i.mx21 and i.mx25)
* freescale mxs (i.mx23 and i.mx28)
* st-ericsson Nomadik
* st-ericsson u300
* st spear3xx
* st spear6xx
* TI NSpire
* VIA/Wondermedia vt85xx/wm85xx/wm86xx

The embedded mxs family is probably most interesting among these,
but there is also a community around the wondermedia stuff, which is
used in cheap tablets and laptops.

> > What this patchset does is also make mach-mvebu part of the multi v5
> > kernel. So you just need one kernel for all ARM v5 machines which are
> > part of multi v5. The long term goal is that you need just two 32 ARM
> > kernels, multi v5 and multi v7. However orion5x and mv76xx0 are not
> > yet part of theses, so we are not there yet.
> 
> So in answer to my question, on v5 ARCH_KIRKWOOD and ARCH_MVEBU *cannot*
> coexist in the same binary?

That has been the plan for the kirkwood migration for the last few
years, yes. The idea is that every kirkwood machine that anyone is
interested in should be supported by ARCH_MVEBU, and we can keep
ARCH_KIRKWOOD for the ones we don't care about until it is just
dropped.

Same for orion5x, dove and mv78xx0, just a different schedule
for moving them over.

Now in theory, we could have them supported in a multiplatform kernel,
but that would mean extra work that we planned to avoid by converting
them to DT first.

As I said, it may be useful to do multiplatform support for MACH_ORION5x,
but for MACH_KIRKWOOD, we have come too far now to turn back.

	Arnd
