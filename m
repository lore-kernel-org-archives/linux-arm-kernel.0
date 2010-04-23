From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Fri, 23 Apr 2010 07:53:13 +0300
Subject: [PATCH 0/8] Initial implementation of kdump for ARM
In-Reply-To: <20100423042626.GA2997@localhost.localdomain>
References: <cover.1271752135.git.ext-mika.1.westerberg@nokia.com>
	<20100422120308.GD26418@gw.healthdatacare.com>
	<20100423030556.GA8012@localhost.localdomain>
	<20100423041106.GG3028@esdhcp04058.research.nokia.com>
	<20100423042626.GA2997@localhost.localdomain>
Message-ID: <20100423045313.GH3028@esdhcp04058.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 23, 2010 at 06:26:26AM +0200, ext Janboe Ye wrote:
> These are some other hard code address in some boards.
> 
> For example, beagle board boot_params is 0x80000100.
> 
> I guest nokia's Nseris does not use atags for transfering params.
> 
> When I test my relocated kernel, it blocks at machinee initialization.
> 
> Maybe there is other address mapping issue. I will look it tomorrow.

Yes, we use atags.

I have following changes on top of these patches. Note that you should also
change beagles board file so that it works with different PHYS_OFFSET (if you
are going to pass initrd, then that will need to be changed also).

I actually have beagleboard in home and I can try it there as well but I'll be
away weekend so it is going to happen earliest on monday.

Thanks,
MW

diff --git a/arch/arm/mach-omap2/Makefile.boot b/arch/arm/mach-omap2/Makefile.boot
index 565aff7..b958007 100644
--- a/arch/arm/mach-omap2/Makefile.boot
+++ b/arch/arm/mach-omap2/Makefile.boot
@@ -1,3 +1,8 @@
-  zreladdr-y		:= 0x80008000
+ifeq ($(CONFIG_CRASH_DUMP),y)
+zreladdr-y		:= 0x84008000
+params_phys-y		:= 0x84000100
+else
+zreladdr-y		:= 0x80008000
 params_phys-y		:= 0x80000100
+endif
 initrd_phys-y		:= 0x80800000
diff --git a/arch/arm/plat-omap/include/plat/memory.h b/arch/arm/plat-omap/include/plat/memory.h
index 9ad41dc..596a130 100644
--- a/arch/arm/plat-omap/include/plat/memory.h
+++ b/arch/arm/plat-omap/include/plat/memory.h
@@ -40,7 +40,15 @@
 #define PHYS_OFFSET		UL(0x10000000)
 #elif defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
 			defined(CONFIG_ARCH_OMAP4)
+/*
+ * We want crashdump kernels to be in different physical address than
+ * the primary kernel.
+ */
+#ifdef CONFIG_CRASH_DUMP
+#define PHYS_OFFSET		UL(0x84000000)
+#else
 #define PHYS_OFFSET		UL(0x80000000)
+#endif /* CONFIG_CRASH_DUMP */
 #endif
 
 /*

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index df5c918..a023f62 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -459,7 +459,7 @@ MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
 	/* Maintainer: Syed Mohammed Khasim - http://beagleboard.org */
 	.phys_io	= 0x48000000,
 	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
-	.boot_params	= 0x80000100,
+	.boot_params	= PHYS_OFFSET + 0x100,
 	.map_io		= omap3_beagle_map_io,
 	.init_irq	= omap3_beagle_init_irq,
 	.init_machine	= omap3_beagle_init,
