From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Mar 2014 17:24:21 +0100
Subject: [PATCH 61/62] ARM: sunxi: fix build for THUMB2_KERNEL
In-Reply-To: <4626847.CFbp3XOTnf@wuerfel>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <CAL_JsqL_XkF6VRAJdgRmZvX6uud3S8OqvzoTqc9hy2PNDUv5kw@mail.gmail.com>
 <4626847.CFbp3XOTnf@wuerfel>
Message-ID: <6006528.k1jnepzDNv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 March 2014 17:05:09 Arnd Bergmann wrote:
> On Friday 21 March 2014 10:54:49 Rob Herring wrote:
> > The first things secondary_startup do are:
> > 
> > -set BE mode
> > -if in HYP mode, install hyp vectors and drop to SVC
> > -set the CPSR to a know value (safe_svcmode_maskall r9)
> > 
> > So this code is completely redundant and unnecessary. If there were
> > some reason for it, then it should be in secondary_startup.
> 
> Ah, thanks for the clarification. Shall we just delete the file then
> and jump straight to secondary_startup?

Maxime, can you test the new version?

>From 2f6220cee15e45446c43e5c43affa85a6c407b31 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Sun, 16 Mar 2014 18:04:54 +0100
Subject: [PATCH] ARM: sunxi: fix build for THUMB2_KERNEL

Building an SMP kernel for the sunxi platform with THUMB2 instructions
fails with this error at the moment:

headsmp.S:7: Error: Thumb encoding does not support an immediate here -- `msr cpsr_fsxc,#0xd3'

Since the generic secondary_startup function already does
the same thing in a safe way, we can just drop the private
sunxi implementation and jump straight to secondary_startup.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>

diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
index d939720..27b168f 100644
--- a/arch/arm/mach-sunxi/Makefile
+++ b/arch/arm/mach-sunxi/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_ARCH_SUNXI) += sunxi.o
-obj-$(CONFIG_SMP) += platsmp.o headsmp.o
+obj-$(CONFIG_SMP) += platsmp.o
diff --git a/arch/arm/mach-sunxi/common.h b/arch/arm/mach-sunxi/common.h
index 9e5ac47..08deb30 100644
--- a/arch/arm/mach-sunxi/common.h
+++ b/arch/arm/mach-sunxi/common.h
@@ -13,7 +13,6 @@
 #ifndef __ARCH_SUNXI_COMMON_H_
 #define __ARCH_SUNXI_COMMON_H_
 
-void sun6i_secondary_startup(void);
 extern struct smp_operations sun6i_smp_ops;
 
 #endif /* __ARCH_SUNXI_COMMON_H_ */
diff --git a/arch/arm/mach-sunxi/headsmp.S b/arch/arm/mach-sunxi/headsmp.S
deleted file mode 100644
index a10d494..0000000
--- a/arch/arm/mach-sunxi/headsmp.S
+++ /dev/null
@@ -1,9 +0,0 @@
-#include <linux/linkage.h>
-#include <linux/init.h>
-
-        .section ".text.head", "ax"
-
-ENTRY(sun6i_secondary_startup)
-	msr	cpsr_fsxc, #0xd3
-	b	secondary_startup
-ENDPROC(sun6i_secondary_startup)
diff --git a/arch/arm/mach-sunxi/platsmp.c b/arch/arm/mach-sunxi/platsmp.c
index 7b141d8..3f9b889 100644
--- a/arch/arm/mach-sunxi/platsmp.c
+++ b/arch/arm/mach-sunxi/platsmp.c
@@ -82,7 +82,7 @@ static int sun6i_smp_boot_secondary(unsigned int cpu,
 	spin_lock(&cpu_lock);
 
 	/* Set CPU boot address */
-	writel(virt_to_phys(sun6i_secondary_startup),
+	writel(virt_to_phys(secondary_startup),
 	       cpucfg_membase + CPUCFG_PRIVATE0_REG);
 
 	/* Assert the CPU core in reset */
@@ -120,5 +120,5 @@ static int sun6i_smp_boot_secondary(unsigned int cpu,
 
 struct smp_operations sun6i_smp_ops __initdata = {
 	.smp_prepare_cpus	= sun6i_smp_prepare_cpus,
-	.smp_boot_secondary	= sun6i_smp_boot_secondary,
+	.smp_boot_secondary	= sun6i_smp_secondary_startup,
 };
