From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 9 Apr 2013 12:34:25 -0400 (EDT)
Subject: [PATCH v4 15/15] ARM: vexpress: Select multi-cluster SMP operation
 if required
In-Reply-To: <1365487246.3292.3.camel@computer5.home>
References: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
 <1360041732-17936-16-git-send-email-nicolas.pitre@linaro.org>
 <20130405224819.GB14308@quad.lixom.net>
 <alpine.LFD.2.03.1304060943370.1171@syhkavp.arg>
 <1365412211.3384.16.camel@linaro1.home>
 <alpine.LFD.2.03.1304090135590.1171@syhkavp.arg>
 <1365487246.3292.3.camel@computer5.home>
Message-ID: <alpine.LFD.2.03.1304090829590.1171@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 9 Apr 2013, Jon Medhurst (Tixy) wrote:

> On Tue, 2013-04-09 at 01:41 -0400, Nicolas Pitre wrote:
> > > Do the changes to the above mcpm files want to be in a separate patch as
> > > it's generic ARM code, not vexpress specific?
> > 
> > Well, since it was so trivial I didn't do it, but the split might be a 
> > good idea nevertheless.  So I inserted the following patch in the 
> > series, and corresponding changes are now removed from the patch above.  
> > What do you think?
> 
> Looks fine. 

May I add your ACK?

> Did you miss my other comment about smp_ops not looking like they were 
> getting set in the case of mcpm_smp_set_ops not getting called?

You are right.  See my change to #14/15 to fix that.

The VExpress patch now becomes this (only change is the return value):

Author: Jon Medhurst <tixy@linaro.org>
Date:   Wed Jan 30 09:12:55 2013 +0000

    ARM: vexpress: Select multi-cluster SMP operation if required
    
    Signed-off-by: Jon Medhurst <tixy@linaro.org>
    Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
    Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
    Acked-by: Pawel Moll <pawel.moll@arm.com>

diff --git a/arch/arm/mach-vexpress/core.h b/arch/arm/mach-vexpress/core.h
index f134cd4a85..bde4374ab6 100644
--- a/arch/arm/mach-vexpress/core.h
+++ b/arch/arm/mach-vexpress/core.h
@@ -6,6 +6,8 @@
 
 void vexpress_dt_smp_map_io(void);
 
+bool vexpress_smp_init_ops(void);
+
 extern struct smp_operations	vexpress_smp_ops;
 
 extern void vexpress_cpu_die(unsigned int cpu);
diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index dc1ace55d5..f31a7af712 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -12,9 +12,11 @@
 #include <linux/errno.h>
 #include <linux/smp.h>
 #include <linux/io.h>
+#include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/vexpress.h>
 
+#include <asm/mcpm_entry.h>
 #include <asm/smp_scu.h>
 #include <asm/mach/map.h>
 
@@ -203,3 +205,21 @@ struct smp_operations __initdata vexpress_smp_ops = {
 	.cpu_die		= vexpress_cpu_die,
 #endif
 };
+
+bool __init vexpress_smp_init_ops(void)
+{
+#ifdef CONFIG_MCPM
+	/*
+	 * The best way to detect a multi-cluster configuration at the moment
+	 * is to look for the presence of a CCI in the system.
+	 * Override the default vexpress_smp_ops if so.
+	 */
+	struct device_node *node;
+	node = of_find_compatible_node(NULL, NULL, "arm,cci");
+	if (node && of_device_is_available(node)) {
+		mcpm_smp_set_ops();
+		return true;
+	}
+#endif
+	return false;
+}
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 915683cb67..16b42c10e0 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -476,6 +476,7 @@ static const char * const v2m_dt_match[] __initconst = {
 DT_MACHINE_START(VEXPRESS_DT, "ARM-Versatile Express")
 	.dt_compat	= v2m_dt_match,
 	.smp		= smp_ops(vexpress_smp_ops),
+	.smp_init	= smp_init_ops(vexpress_smp_init_ops),
 	.map_io		= v2m_dt_map_io,
 	.init_early	= v2m_dt_init_early,
 	.init_irq	= irqchip_init,
