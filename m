From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Jan 2013 16:12:11 +0000
Subject: OMAP4 randconfig failure: Zynq
In-Reply-To: <20130124160609.GW23505@n2100.arm.linux.org.uk>
References: <20130124111117.GU23505@n2100.arm.linux.org.uk>
 <20130124155704.GJ11970@beefymiracle.amer.corp.natinst.com>
 <20130124160609.GW23505@n2100.arm.linux.org.uk>
Message-ID: <20130124161211.GX23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 04:06:09PM +0000, Russell King - ARM Linux wrote:
> On Thu, Jan 24, 2013 at 09:57:04AM -0600, Josh Cartwright wrote:
> > On Thu, Jan 24, 2013 at 11:11:17AM +0000, Russell King - ARM Linux wrote:
> > > The OMAP4 randconfig build last night failed with this error:
> > > 
> > > arch/arm/mach-zynq/common.c:99:14: error: 'irqchip_init' undeclared here (not in a function)
> > > 
> > > Full details at the usual place - 
> > > http://www.arm.linux.org.uk/developer/build/
> > 
> > Curious.  This doesn't look like a valid config to me.
> 
> I think you're wrong.
> 
> > In particular, both ARCH_MULTIPLATFORM and ARCH_OMAP are selected, even
> > though those selections should be mutually exclusive, since they fall
> > under the same:
> > 
> >     choice
> >     	prompt "ARM system type"
> >     	default ARCH_MULTIPLATFORM
> > 
> > Perhaps it's because CONFIG_ARCH_OMAP=y was setup in the seed?
> 
> ARCH_OMAP2PLUS selects ARCH_OMAP, and ARCH_OMAP2PLUS must be enabled
> to produce a configuration including any OMAP code.
> 
> > oldconfig seems to complain, too:
> > 
> >       .config:340:warning: override: ARCH_OMAP changes choice state
> 
> Err, nope, don't get that warning.
> 
> $ mkdir /tmp/build
> $ wget -O /tmp/build/.config 'http://www.arm.linux.org.uk/developer/build/file.php?type=config&idx=3562'
> $ emake -j2 O=/tmp/build/ oldconfig
>   GEN     /tmp/build/Makefile
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/kconfig/conf.o
>   SHIPPED scripts/kconfig/zconf.tab.c
>   SHIPPED scripts/kconfig/zconf.lex.c
>   SHIPPED scripts/kconfig/zconf.hash.c
>   HOSTCC  scripts/kconfig/zconf.tab.o
>   HOSTLD  scripts/kconfig/conf
> scripts/kconfig/conf --oldconfig Kconfig
> #
> # configuration written to .config
> #
> 
> So, the config system produced this configuration, and the config system
> believes it to be correct.  The problem lies elsewhere.
> 
> Clearly from the error, for a configuration for an OMAP platform to be
> errored out by a Zynq error, that means there's something that Zynq is
> missing.

And what's missing is _specific_ to Zynq.  Let's look at the error again:

arch/arm/mach-zynq/common.c:99:14: error: 'irqchip_init' undeclared here (not in a function)

What it means is that the "irqchip_init" identifier was not declared by
anything before it has been used.  That means arch/arm/mach-zynq/common.c
is missing a required #include statement.

irqchip_init can be found in linux/irqchip.h.  Does arch/arm/mach-zynq/common.c
include this required include?  No.  Therefore, the build fails with the
above error.

You need to add this include file...
