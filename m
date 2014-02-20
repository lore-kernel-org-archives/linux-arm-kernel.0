From: ijc@hellion.org.uk (Ian Campbell)
Date: Thu, 20 Feb 2014 14:21:10 +0000
Subject: [PATCH 21/21] ARM: Kirkwood: Remove DT support
In-Reply-To: <2127012.W6WnQnXmRo@wuerfel>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <20140220121821.GO11878@lunn.ch>
 <1392900664.23342.60.camel@kazak.uk.xensource.com>
 <2127012.W6WnQnXmRo@wuerfel>
Message-ID: <1392906070.30563.11.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-02-20 at 14:53 +0100, Arnd Bergmann wrote:
> On Thursday 20 February 2014 12:51:04 Ian Campbell wrote:
> > On Thu, 2014-02-20 at 13:18 +0100, Andrew Lunn wrote:
> > > On Thu, Feb 20, 2014 at 11:34:36AM +0000, Ian Campbell wrote:
> > Debian has a single v7 flavour, armmp which uses the multi platform
> > stuff. (actually there is a second armmp-lpae, but lets ignore that)
> > 
> > I'm only really concerned about the v5 stuff here. Debian has multiple
> > v5 flavours: ixp4xx, kirkwood, mv78xx0, orion5x and versatile.
> 
> Unfortunately, this selection include multiple platforms that
> we don't plan to (ever) support in a multiplatform kernel, while
> a lot of platforms you don't currently support are already enabled
> or will be at some point.

That's ok, Debian is happy to stick with separate flavours for v5 if
necessary for the existing ones, although I think we'd prefer to avoid
adding any new ones.

(for v7 we have gone multiplatform only already)

> * ixp4xx is too different from the others and I don't think it's
>   possible to turn it over to multiplatform.
> * I see a iop32x_defconfig in svn that you didn't mention here,
>   but it's basically the same problem as ixp4xx.

This is only in Wheezy and not in trunk (which will become Jessie). AIUI
support for these has been dropped for the next version of Debian so
Wheezy is the last one and we don't need to worry about upgrade for
these.

TBH I'm not sure that ixp4xx isn't in the same boat, I suppose we'll
see.

> * kirkwood/mv78xx0/orion5x are essentially one platform and work
>   in progress.
> * versatile is easy to do as multiplatform, I just haven't gotten
>   around to do it.
> 
> ARMv5 platforms that are already working with ARCH_MULTIPLATFORM:
> * freescale mxc (i.mx21 and i.mx25)
> * freescale mxs (i.mx23 and i.mx28)
> * st-ericsson Nomadik
> * st-ericsson u300
> * st spear3xx
> * st spear6xx
> * TI NSpire
> * VIA/Wondermedia vt85xx/wm85xx/wm86xx
> 
> The embedded mxs family is probably most interesting among these,
> but there is also a community around the wondermedia stuff, which is
> used in cheap tablets and laptops.

Interesting. I don't know how many of these are supported by Debian --
mostly these things get added when someone acquires one and scratches
that itch.

I suppose if we could remove at least one existing flavour in favour of
a v5 multiplatform config then there probably wouldn't be many
objections to doing that.

> > > What this patchset does is also make mach-mvebu part of the multi v5
> > > kernel. So you just need one kernel for all ARM v5 machines which are
> > > part of multi v5. The long term goal is that you need just two 32 ARM
> > > kernels, multi v5 and multi v7. However orion5x and mv76xx0 are not
> > > yet part of theses, so we are not there yet.
> > 
> > So in answer to my question, on v5 ARCH_KIRKWOOD and ARCH_MVEBU *cannot*
> > coexist in the same binary?
> 
> That has been the plan for the kirkwood migration for the last few
> years, yes. The idea is that every kirkwood machine that anyone is
> interested in should be supported by ARCH_MVEBU, and we can keep
> ARCH_KIRKWOOD for the ones we don't care about until it is just
> dropped.
> 
> Same for orion5x, dove and mv78xx0, just a different schedule
> for moving them over.
> 
> Now in theory, we could have them supported in a multiplatform kernel,
> but that would mean extra work that we planned to avoid by converting
> them to DT first.
> 
> As I said, it may be useful to do multiplatform support for MACH_ORION5x,
> but for MACH_KIRKWOOD, we have come too far now to turn back.

Understood. It sounds like mach-kirkwood is very close to being
removable altogether though (by migrating the last few boards to
mach-mvebu), which would make distro upgrades much simpler, since we can
just do a straight swap rather than trying to figure out which one we
need.

Ian.
