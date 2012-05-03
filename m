From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 3 May 2012 15:52:48 +0200
Subject: Making ARM multiplatform kernels DT-only?
In-Reply-To: <20120503140428.GB897@n2100.arm.linux.org.uk>
References: <201205031350.35476.arnd@arndb.de>
 <20120503140428.GB897@n2100.arm.linux.org.uk>
Message-ID: <20120503135248.GC7788@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:04 Thu 03 May     , Russell King - ARM Linux wrote:
> On Thu, May 03, 2012 at 01:50:35PM +0000, Arnd Bergmann wrote:
> > Hi everyone,
> > 
> > I've been discussing multiplatform kernels with a few people recently,
> > and we will have a lot of discussion sessions about this at Linaro
> > Connect in Hong Kong.
> > 
> > One question that came up repeatedly is whether we should support all
> > possible board files for each platform in a multiplatform kernel,
> > or just the ones that are already using DT probing. I would like
> > to get a quick poll of opinions on that and I've tried to put those
> > people on Cc that would be most impacted by this, i.e. the maintainers
> > for platforms that have both DT and non-DT board files at the moment.
> > 
> > My feeling is that we should just mandate DT booting for multiplatform
> > kernels, because it significantly reduces the combinatorial space
> > at compile time, avoids a lot of legacy board files that we cannot
> > test anyway, reduces the total kernel size and gives an incentive
> > for people to move forward to DT with their existing boards.
> > 
> > The counterargument is that we won't be able to support all the
> > boards we currently do when the user switches on multiplatform,
> > but I think that is acceptable.
> > Note that I would still want to allow users to build platforms
> > separately in order to enable the ATAG style board files, even
> > for platforms that are not multiplatform capable.
> 
> I'm basing my comments off mach-zynq.
> 
> How about we take the following steps towards it?
> 
> 1. create arch/arm/include/mach/ which contains standardized headers
>    for DT based implementations.  This must include all headers included
>    by asm/ or linux/ includes.  This will also be the only mach/ header
>    directory included for code outside of arch/arm/mach-*.  This also
>    acts as the 'default' set of mach/* includes for stuff like timex.h
>    and the empty hardware.h
> 
> 2. DT based mach-* directories do not have an include directory; their
>    include files must be located in the main include/ heirarchy if shared
>    with other parts of the kernel, otherwise they must be in the mach-*
>    directory.
on at91 I'm working to drop it

but will have to keep for old non DT board
> 
> 3. Allow build multiple mach-* directories (which we already do... see
>    the samsung stuff.)
> 
> We still have irqs.h being SoC dependent, and we still haven't taken
> debug-macros.S far enough along to get rid of that.  Then there's also
> the problem of uncompress.h.  The last piece of the puzzle is the common
> clock stuff.
on the decompressor I was thinking to use the DT to select it
by using a compatible string

if it's ok with you

Best Regards,
J.
