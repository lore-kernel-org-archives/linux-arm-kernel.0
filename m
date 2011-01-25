From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 25 Jan 2011 23:53:35 +0530
Subject: [PATCH 4/5] ARM: scu: Move register defines to header file
In-Reply-To: <20110125130611.GA15663@n2100.arm.linux.org.uk>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
	<1295859080-15259-5-git-send-email-santosh.shilimkar@ti.com>
	<20110125114635.GB13300@n2100.arm.linux.org.uk>
	<236d45e400a960cc3b32db538b3a79ae@mail.gmail.com>
	<20110125121655.GD13300@n2100.arm.linux.org.uk>
	<4534e82bf14eeea9f96769df760df5ae@mail.gmail.com>
	<20110125125656.GG13300@n2100.arm.linux.org.uk>
	<20110125130422.GH13300@n2100.arm.linux.org.uk>
	<20110125130611.GA15663@n2100.arm.linux.org.uk>
Message-ID: <627ff975140c8e4afbad281105b29d35@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Tuesday, January 25, 2011 6:36 PM
> To: Santosh Shilimkar
> Cc: catalin.marinas at arm.com; linus.ml.walleij at gmail.com; linux-
> omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> ccross at android.com
> Subject: Re: [PATCH 4/5] ARM: scu: Move register defines to header
> file
>
> On Tue, Jan 25, 2011 at 01:04:22PM +0000, Russell King - ARM Linux
> wrote:
> > Actually, we can do this safely - byte stores are permitted to SCU
> > registers probably for this very reason.
>
> 3rd revision of the patch:

After fixing the 3rd version for base address break, I was able to
use this patch and test it. Seems to work. SMC related stuff can
be ignored because OMAP4 ES1.0 doesn't have functional PM hardware
support.

Here is the updated patch which will be 4th revision...

4th revision
---
 arch/arm/include/asm/smp_scu.h |    5 +++++
 arch/arm/kernel/smp_scu.c      |   23 +++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/smp_scu.h
b/arch/arm/include/asm/smp_scu.h
index b6f42c9..676bc43 100644
--- a/arch/arm/include/asm/smp_scu.h
+++ b/arch/arm/include/asm/smp_scu.h
@@ -7,7 +7,12 @@
 #define SCU_INVALIDATE		0x0c
 #define SCU_FPGA_REVISION	0x10

+#define SCU_PM_NORMAL	0
+#define SCU_PM_DORMANT	2
+#define SCU_PM_POWEROFF	3
+
 unsigned int scu_get_core_count(void __iomem *);
 void scu_enable(void __iomem *);
+int scu_power_mode(unsigned int);

 #endif
diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
index ee7bf47..aec7c5d 100644
--- a/arch/arm/kernel/smp_scu.c
+++ b/arch/arm/kernel/smp_scu.c
@@ -14,6 +14,8 @@
 #include <asm/smp_scu.h>
 #include <asm/cacheflush.h>

+static void __iomem *base;
+
 /*
  * Get the number of CPU cores from the SCU configuration
  */
@@ -29,14 +31,15 @@ unsigned int __init scu_get_core_count(void __iomem
*scu_base)
 void __init scu_enable(void __iomem *scu_base)
 {
 	u32 scu_ctrl;
+	base = scu_base;

-	scu_ctrl = __raw_readl(scu_base + SCU_CTRL);
+	scu_ctrl = __raw_readl(base + SCU_CTRL);
 	/* already enabled? */
 	if (scu_ctrl & 1)
 		return;

 	scu_ctrl |= 1;
-	__raw_writel(scu_ctrl, scu_base + SCU_CTRL);
+	__raw_writel(scu_ctrl, base + SCU_CTRL);

 	/*
 	 * Ensure that the data accessed by CPU0 before the SCU was
@@ -44,3 +47,19 @@ void __init scu_enable(void __iomem *scu_base)
 	 */
 	flush_cache_all();
 }
+
+int scu_power_mode(unsigned int mode)
+{
+	unsigned int val;
+	int cpu = smp_processor_id();
+	int shift;
+
+	if (mode > 3 || mode == 1 || cpu > 3)
+		return -EINVAL;
+
+	val = __raw_readb(base + SCU_CPU_STATUS + cpu) & ~0x03;
+	val |= mode;
+	__raw_writeb(val, base + SCU_CPU_STATUS + cpu);
+
+	return 0;
+}
-- 
1.6.0.4
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-4th-revision.patch
Type: application/octet-stream
Size: 1898 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110125/21404ae7/attachment.obj>
