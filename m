From: tony@atomide.com (Tony Lindgren)
Date: Mon, 17 Sep 2012 10:22:09 -0700
Subject: linux-next: build failure after merge of the final tree
 (arm-soc tree related)
In-Reply-To: <201209171429.31794.arnd@arndb.de>
References: <20120917212615.91bc134d237dcd5968f9f549@canb.auug.org.au>
 <201209171429.31794.arnd@arndb.de>
Message-ID: <20120917172208.GN4521@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [120917 07:30]:
> On Monday 17 September 2012, Stephen Rothwell wrote:
> > After merging the final tree, today's linux-next build (powerpc
> > allyesconfig) failed like this:
> > 
> > drivers/mfd/twl-core.c:49:22: fatal error: plat/cpu.h: No such file or directory
> > 
> > Caused by commit 7d7e1eba7e92 ("ARM: OMAP2+: Prepare for irqs.h removal").

Oops, sorry I screwed up there. That used to get included indirectly
earlier if SPARSE_IRQ was not set.
 
> > I have added the following patch to restrict this driver to ARM until it
> > is fixed:
> > 
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Mon, 17 Sep 2012 21:18:21 +1000
> > Subject: [PATCH] ARM: retrict TWL4030_CORE to ARM while it is broken
> > 
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> Thanks!
> 
> If it requires plat/cpu.h, it should actually be limited to CONFIG_ARCH_OMAP,
> otherwise we will get the same problem on non-OMAP ARM builds. From what
> I can tell, the problem is the clocks_init function, which is the only
> part that is not completely generic.
> 
> The trivial workaround would be to enclose the "#include <plat/cpu.h>"
> statement in #ifdef CONFIG_ARCH_OMAP, but with the common clock code
> in place, we should probably be able to come up with a better solution
> that works independent of the omap platform.

There are patches coming to remove cpu_is_omap usage from drivers,
and until then we should just ifdef the plat/cpu.h include.

It is possible to use these kind of external PM chips with other
SoCs, they're just not omap related and that's why there drivers
have not had the Kconfig dependency. I'll post a patch for that.

Regards,

Tony
