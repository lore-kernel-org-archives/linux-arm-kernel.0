From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 06 Jul 2016 22:04:42 +0200
Subject: [PATCH v3 0/2] [for arm-soc] mach-tango updates for v4.8
In-Reply-To: <20160706035730.GA23212@localhost>
References: <57726597.8030501@sigmadesigns.com> <577BA8DF.9080603@free.fr>
 <20160706035730.GA23212@localhost>
Message-ID: <12902449.rg2TfjcyfJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, July 5, 2016 8:57:30 PM CEST Olof Johansson wrote:
> On Tue, Jul 05, 2016 at 02:32:31PM +0200, Mason wrote:
> > On 28/06/2016 13:55, Marc Gonzalez wrote:
> > 
> > > Hello arm-soc maintainers,
> > > 
> > > Could you please merge the following patches?
> > > 
> > > Marc Gonzalez (2):
> > >   ARM: tango: add HOTPLUG_CPU support
> > >   Update ARM/TANGO section
> > 
> > Hello Olof,
> > 
> > I see you've just merged a large number of patches in the for-next branch.
> > https://git.kernel.org/cgit/linux/kernel/git/arm/arm-soc.git/log/?h=for-next
> > 
> > I think you overlooked the two patches in this thread:
> > 
> > [PATCH v4 1/2] ARM: tango: add HOTPLUG_CPU support
> > [PATCH v3 2/2] Update ARM/TANGO section
> > 
> > Could you merge these patches as well?
> 
> Yes, applied now. Thanks!

I ran into a build regression during randconfig testing, I think
we should apply the patch below on top of next/soc:

	Arnd

>From 3ea8aba06a2a99e40e145b90865e0635a56209c8 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 6 Jul 2016 21:59:55 +0200
Subject: [PATCH] ARM: tango: fix CONFIG_HOTPLUG_CPU=n build

Building with CONFIG_HOTPLUG_CPU disabled fails for mach-tango:

include/linux/stddef.h:7:14: error: excess elements in struct initializer [-Werror]
 #define NULL ((void *)0)
arch/arm/mach-tango/platsmp.c:48:15: note: in expansion of macro 'tango_cpu_kill'
  .cpu_kill  = tango_cpu_kill,

the problem as that the .cpu_kill and .cpu_die struct members are
unavailable and we must not try to assign them in this configuration.

Hiding the two (as all other platforms do too) lets us get rid of
the #else clause as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-tango/platsmp.c b/arch/arm/mach-tango/platsmp.c
index 8380699..98c62a4 100644
--- a/arch/arm/mach-tango/platsmp.c
+++ b/arch/arm/mach-tango/platsmp.c
@@ -38,15 +38,14 @@ static void tango_cpu_die(unsigned int cpu)
 
 	panic("cpu %d failed to die\n", cpu);
 }
-#else
-#define tango_cpu_kill	NULL
-#define tango_cpu_die	NULL
 #endif
 
 static const struct smp_operations tango_smp_ops __initconst = {
 	.smp_boot_secondary	= tango_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
 	.cpu_kill		= tango_cpu_kill,
 	.cpu_die		= tango_cpu_die,
+#endif
 };
 
 CPU_METHOD_OF_DECLARE(tango4_smp, "sigma,tango4-smp", &tango_smp_ops);
