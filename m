From: Marc.Zyngier@arm.com (Marc Zyngier)
Date: Wed, 25 May 2011 19:04:05 +0100
Subject: [PATCH] ARM: exynos4: fix secondary CPU boot
In-Reply-To: <4DDD3C57.6020705@samsung.com>
References: <1305899190-16732-1-git-send-email-marc.zyngier@arm.com>
	<4DDD3C57.6020705@samsung.com>
Message-ID: <1306346645.27474.182.camel@e102391-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-05-25 at 10:28 -0700, Kukjin Kim wrote:
> On 05/20/11 06:46, Marc Zyngier wrote:
> > Patch 7d30e8b38 (ARM: EXYNOS4: Add EXYNOS4 CPU initialization support)
> > renamed the s5pv310 to exynos4, and also changed the value of
> > EXYNOS4_PA_SYSRAM, which is used to release the secondary CPU from
> > spinning in BL0. As a result, CPU1 can't be brought up anymore.
> >
> > This patch simply reverts EXYNOS4_PA_SYSRAM to its original value,
> > which results in a working CPU1.
> >
> > Tested on an SMDK-v310.
> >
> > Cc: Kukjin Kim<kgene.kim@samsung.com>
> > Signed-off-by: Marc Zyngier<marc.zyngier@arm.com>
> > ---
> >   arch/arm/mach-exynos4/include/mach/map.h |    2 +-
> >   1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-exynos4/include/mach/map.h b/arch/arm/mach-exynos4/include/mach/map.h
> > index 6330b73..862967f 100644
> > --- a/arch/arm/mach-exynos4/include/mach/map.h
> > +++ b/arch/arm/mach-exynos4/include/mach/map.h
> > @@ -23,7 +23,7 @@
> >
> >   #include<plat/map-s5p.h>
> >
> > -#define EXYNOS4_PA_SYSRAM		0x02020000
> > +#define EXYNOS4_PA_SYSRAM		0x02025000
> >
> Hi Marc,
> 
> Hmm...the value, 0x02020000 is correct on Exynos4210 now.
> 
> So can't apply this but I know, you're right on old version of 
> Exynos4210...let's think again about this.

So that address has changed between two SoC revisions? That's
unfortunate, to say the least. I'm most probably using an early revision
of the hardware (EVT0?), as it doesn't even support MCT.

What about the following patch?

	M.

>From c27e75b86e1ee181987a9364286a888421e76205 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <marc.zyngier@arm.com>
Date: Fri, 20 May 2011 14:38:25 +0100
Subject: [PATCH] ARM: exynos4: fix secondary CPU boot on early SoC revisions

It appears that the system-wide flags register that used to be at
0x02025000 on the first revision of Exynos4 has moved to 0x02020000.

The kernel has been updated accordingly, but this unfortunately leaves
early boards without SMP support (the secondary CPU spins endlessly
in BL0 waiting for an address to be written at that memory location).

Try to solve the problem by poking both locations. This should be
safe as this is done early enough in the kernel boot process, and nobody
should be using the SRAM yet.

Tested on a vintage SMDK-v310.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-exynos4/include/mach/map.h |    1 +
 arch/arm/mach-exynos4/platsmp.c          |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/include/mach/map.h b/arch/arm/mach-exynos4/include/mach/map.h
index 0009e77..781e149 100644
--- a/arch/arm/mach-exynos4/include/mach/map.h
+++ b/arch/arm/mach-exynos4/include/mach/map.h
@@ -24,6 +24,7 @@
 #include <plat/map-s5p.h>
 
 #define EXYNOS4_PA_SYSRAM		0x02020000
+#define EXYNOS4_PA_SYSRAM_EVT0		0x02025000
 
 #define EXYNOS4_PA_FIMC0		0x11800000
 #define EXYNOS4_PA_FIMC1		0x11810000
diff --git a/arch/arm/mach-exynos4/platsmp.c b/arch/arm/mach-exynos4/platsmp.c
index c5e65a0..f261c34 100644
--- a/arch/arm/mach-exynos4/platsmp.c
+++ b/arch/arm/mach-exynos4/platsmp.c
@@ -155,6 +155,7 @@ void __init smp_init_cpus(void)
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 {
 	int i;
+	void __iomem *sysram_evt0;
 
 	/*
 	 * Initialise the present map, which describes the set of CPUs
@@ -172,4 +173,17 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 	 * secondary CPU branches to this address.
 	 */
 	__raw_writel(BSYM(virt_to_phys(exynos4_secondary_startup)), S5P_VA_SYSRAM);
+
+	/*
+	 * EVT0 has the system-wide flags register at a different address.
+	 * Poke it as well, in case we're running on an old SoC revision.
+	 */
+	sysram_evt0 = ioremap(EXYNOS4_PA_SYSRAM_EVT0, SZ_4K);
+	if (!sysram_evt0) {
+		pr_err("Unable to remap EXYNOS4_PA_SYSRAM_EVT0\n");
+		return;
+	}
+
+	__raw_writel(BSYM(virt_to_phys(exynos4_secondary_startup)), sysram_evt0);
+	iounmap(sysram_evt0);
 }
-- 
1.7.0.4



-- 
Reality is an implementation detail.
