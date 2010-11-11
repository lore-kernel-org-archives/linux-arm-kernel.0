From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 11 Nov 2010 23:29:54 +0000
Subject: arm smp support patch
In-Reply-To: <20101111230652.GC23785@n2100.arm.linux.org.uk>
References: <73a3b42c84eb2bfde0f861d1e53042cd.squirrel@www.concentris-systems.com>
	<20101111044125.GA5850@mvista.com>
	<52622063180ba1627bf98811e4f56a05.squirrel@www.concentris-systems.com>
	<4CDC63A9.9090606@codeaurora.org>
	<20101111230652.GC23785@n2100.arm.linux.org.uk>
Message-ID: <20101111232954.GD23785@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 11, 2010 at 11:06:52PM +0000, Russell King - ARM Linux wrote:
> It seems that we have one of the first implementations which has enable
> register bits provided for the SGIs.  As the enable register bits are
> banked on a per-CPU basis, there's nothing that the boot CPU can do to
> set those enable bits - the only thing that can enable those is the
> pre-kernel boot software.

Reading a bit deeper, not only are the enable registers banked, but also
the priority registers.  So let's do this properly and move the code
accessing these banked registers to the per-CPU initialization function.

I've also decided that we should explicitly enable all the SGI interrupts
so that we're compatible with what happens on the previous GICs if these
enable bits are programmable.

Note that as gic_cpu_init() now accesses distributor registers, it
requires that gic_dist_init() has already been called - which appears
to be the case already by everyone using the GIC code.

From: Russell King - ARM Linux <linux@arm.linux.org.uk>

ARM: GIC: don't disable software generated interrupts

Software generated interrupts (SGI) are used for IPIs by the kernel.
While previous revisions of the GIC hardware were specified not to
implement enable bits for SGIs, more recent hardware is now permitted
to implement these bits in a per-CPU banked register.

The priority registers for the PPI and SGIs are also per-CPU banked
registers, so ensure that these are also appropriately initialized.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/gic.c |   28 ++++++++++++++++++++++++----
 1 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index ada6359..772f95f 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -251,15 +251,16 @@ void __init gic_dist_init(unsigned int gic_nr, void __iomem *base,
 		writel(cpumask, base + GIC_DIST_TARGET + i * 4 / 4);
 
 	/*
-	 * Set priority on all interrupts.
+	 * Set priority on all global interrupts.
 	 */
-	for (i = 0; i < max_irq; i += 4)
+	for (i = 32; i < max_irq; i += 4)
 		writel(0xa0a0a0a0, base + GIC_DIST_PRI + i * 4 / 4);
 
 	/*
-	 * Disable all interrupts.
+	 * Disable all interrupts.  Leave the PPI and SGIs alone
+	 * as these enables are banked registers.
 	 */
-	for (i = 0; i < max_irq; i += 32)
+	for (i = 32; i < max_irq; i += 32)
 		writel(0xffffffff, base + GIC_DIST_ENABLE_CLEAR + i * 4 / 32);
 
 	/*
@@ -277,11 +278,30 @@ void __init gic_dist_init(unsigned int gic_nr, void __iomem *base,
 
 void __cpuinit gic_cpu_init(unsigned int gic_nr, void __iomem *base)
 {
+	void __iomem *dist_base;
+	int i;
+
 	if (gic_nr >= MAX_GIC_NR)
 		BUG();
 
+	dist_base = gic_data[gic_nr].dist_base;
+	BUG_ON(!dist_base);
+
 	gic_data[gic_nr].cpu_base = base;
 
+	/*
+	 * Deal with the banked PPI and SGI interrupts - disable all
+	 * PPI interrupts, ensure all SGI interrupts are enabled.
+	 */
+	writel(0xffff0000, dist_base + GIC_DIST_ENABLE_CLEAR);
+	writel(0x0000ffff, dist_base + GIC_DIST_ENABLE_SET);
+
+	/*
+	 * Set priority on PPI and SGI interrupts
+	 */
+	for (i = 0; i < 32; i += 4)
+		writel(0xa0a0a0a0, dist_base + GIC_DIST_PRI + i * 4 / 4);
+
 	writel(0xf0, base + GIC_CPU_PRIMASK);
 	writel(1, base + GIC_CPU_CTRL);
 }
-- 
1.6.2.5
