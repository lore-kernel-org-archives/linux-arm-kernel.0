From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 04 Apr 2011 13:50:35 +0530
Subject: RFC, GIC based smp_cross_call cleanup suggestion
In-Reply-To: <20110403134837.GE4213@n2100.arm.linux.org.uk>
References: <10921831-0170-4106-bb3a-a52515a32c3e@VA3EHSMHS002.ehs.local>
	<BANLkTimY+mRXqT7NwUQ86SxnfKw0HX-pTQ@mail.gmail.com>
	<20110402085133.GE8482@n2100.arm.linux.org.uk>
	<BANLkTim+bco_90iPLrc1ioV4bdSw+LRzQQ@mail.gmail.com>
	<BANLkTimjyBzh3Kc+1njcBBYCouKdSWhgng@mail.gmail.com>
	<20110403103730.GB4213@n2100.arm.linux.org.uk>
	<4D9851B5.20100@ti.com>
	<20110403134837.GE4213@n2100.arm.linux.org.uk>
Message-ID: <4D997F53.5010409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/3/2011 7:18 PM, Russell King - ARM Linux wrote:
> On Sun, Apr 03, 2011 at 04:23:41PM +0530, Santosh Shilimkar wrote:
>> If you plan to commit this change then I can move these to
>> other OMAP4 header file.
>
> Can you send me a patch to do that please?
>
Here it is.. Generated against latest mainline.
Also attached just in case for any mailer issues.

 From 62563f7687d8b19f1c9c3966105d141d91e69b55 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Mon, 4 Apr 2011 12:48:37 +0530
Subject: [PATCH] OMAP4: Move the privately used SMP boot functions to 
OMAP specific header.

Header files in arch/arm/*/include/mach included from
arch/arm/include/asm/*.h are there to provide necessary definitions for
either the rest of the kernel or the ARM specific parts.  They shouldn't
be polluted with *any* platform private stuff which is not absolutely
necessary to satisfy the rest of the kernel.

Hence move the OMAP specific SMP boot functions to different header
instead of keeping them in 'plat/smp.h' which gets included indirectly
by linux/smp.h

The patch is outcome of the discussion in below thread:
	http://www.spinics.net/lists/arm-kernel/msg120363.html

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
  arch/arm/mach-omap2/include/mach/omap4-common.h |    7 +++++++
  arch/arm/plat-omap/include/plat/smp.h           |    6 ------
  2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h 
b/arch/arm/mach-omap2/include/mach/omap4-common.h
index de441c0..e4bd876 100644
--- a/arch/arm/mach-omap2/include/mach/omap4-common.h
+++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
@@ -33,4 +33,11 @@ extern void __iomem *gic_dist_base_addr;
  extern void __init gic_init_irq(void);
  extern void omap_smc1(u32 fn, u32 arg);

+#ifdef CONFIG_SMP
+/* Needed for secondary core boot */
+extern void omap_secondary_startup(void);
+extern u32 omap_modify_auxcoreboot0(u32 set_mask, u32 clear_mask);
+extern void omap_auxcoreboot_addr(u32 cpu_addr);
+extern u32 omap_read_auxcoreboot0(void);
+#endif
  #endif
diff --git a/arch/arm/plat-omap/include/plat/smp.h 
b/arch/arm/plat-omap/include/plat/smp.h
index 7a10257..416e9d5 100644
--- a/arch/arm/plat-omap/include/plat/smp.h
+++ b/arch/arm/plat-omap/include/plat/smp.h
@@ -19,12 +19,6 @@

  #include <asm/hardware/gic.h>

-/* Needed for secondary core boot */
-extern void omap_secondary_startup(void);
-extern u32 omap_modify_auxcoreboot0(u32 set_mask, u32 clear_mask);
-extern void omap_auxcoreboot_addr(u32 cpu_addr);
-extern u32 omap_read_auxcoreboot0(void);
-
  /*
   * We use Soft IRQ1 as the IPI
   */
-- 
1.6.0.4

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: 0001-OMAP4-Move-the-privately-used-SMP-boot-functions-to.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110404/77a8888d/attachment.ksh>
