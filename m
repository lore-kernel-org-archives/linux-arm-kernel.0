From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 22 Aug 2017 18:50:33 +0200 (CEST)
Subject: [GIT PULL 1/6] Broadcom soc changes for 4.14
In-Reply-To: <cc4d171e-47cf-3045-738c-929807454297@gmail.com>
References: <20170817183748.1450-1-f.fainelli@gmail.com>
 <20170817183748.1450-2-f.fainelli@gmail.com>
 <cc4d171e-47cf-3045-738c-929807454297@gmail.com>
Message-ID: <843914385.20451.1503420633158@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> Florian Fainelli <f.fainelli@gmail.com> hat am 22. August 2017 um 00:16 geschrieben:
> 
> 
> On 08/17/2017 11:37 AM, Florian Fainelli wrote:
> 
> Copying what Arnd was writing on IRC this morning, Eric, Stefan, can you
> implement what Arnd recommends and I will pull again or cherry-pick
> (whatever you prefer) thanks! Arnd, how quickly should we give you a new
> PR with those changes?
> 
> 10:07 < arnd> [florian], anholt, maz: I looked at the
> arm-soc/for-4.14/soc pull request again now, and wonder if we can do a
> little better than  that
> 
> 10:08 < arnd> it seems you have pulled in the DT branch before the move
> of the bcm2836_smp_ops from drivers/irqchip to arch/arm/mach-bcm, to
> hide an incompatible DT binding change: in the old code, no
>  enable-method was needed, but now it is
> 
> 10:09 < arnd> clearly we want the enable-method to be there, but it
> would be good if old dts files could keep working, in particular as
> there are probably lots of people that hack their dts files to add
>   random peripherals, and we don't want to force them to update their
> dtb with every kernel change
> 
> 10:11 < arnd> how about we add a .smp_init handler to
> DT_MACHINE_START(BCM2835, ...) to keep it working with the old DT?
> 
> 10:12 < arnd> that would also get rid of the branch dependency as an
> added bonus, but avoiding the boot breakage is more important of course

i already had a discussion with Eric about the case the dts changes are missing and i wasn't able see a boot breakage ("only" a SMP breakage which is still a regression).

> 
> 10:13 < arnd> Stefan Wahren did the patch, but he's either not on this
> channel, or I don't know his nick
> 
> 10:30 < arnd> on a related note, I see that the match table for the
> machine descriptor doesn't list bcm2837, and the bcm2837.dtsi file
> doesn't list itself as compatible with bcm2836, so that would have to be
>    added too to make it actually work
> 

sorry i don't have much time today and i'm not sure how to implement the smp_init.

Here is my draft (untested) which has a linker error (arch/arm/mach-bcm/board_bcm2835.o:(.arch.info.init+0x34): Undefined reference on `bcm2836_smp_ops). Does it goes in the right direction?

diff --git a/arch/arm/mach-bcm/board_bcm2835.c b/arch/arm/mach-bcm/board_bcm2835.c
index 24af33f..4f90f1f 100644
--- a/arch/arm/mach-bcm/board_bcm2835.c
+++ b/arch/arm/mach-bcm/board_bcm2835.c
@@ -19,16 +19,21 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
+#include "platsmp.h"
+
 static const char * const bcm2835_compat[] = {
 #ifdef CONFIG_ARCH_MULTI_V6
 	"brcm,bcm2835",
 #endif
 #ifdef CONFIG_ARCH_MULTI_V7
 	"brcm,bcm2836",
+	"brcm,bcm2837",
 #endif
 	NULL
 };
 
 DT_MACHINE_START(BCM2835, "BCM2835")
-	.dt_compat = bcm2835_compat
+	.dt_compat = bcm2835_compat,
+	.smp = smp_ops(bcm2836_smp_ops),
+	.smp_init = smp_init_ops(bcm2836_smp_init_ops),
 MACHINE_END
diff --git a/arch/arm/mach-bcm/platsmp.c b/arch/arm/mach-bcm/platsmp.c
index 7811160..c47c79a 100644
--- a/arch/arm/mach-bcm/platsmp.c
+++ b/arch/arm/mach-bcm/platsmp.c
@@ -343,3 +343,8 @@ static const struct smp_operations bcm2836_smp_ops __initconst = {
 	.smp_boot_secondary	= bcm2836_boot_secondary,
 };
 CPU_METHOD_OF_DECLARE(bcm_smp_bcm2836, "brcm,bcm2836-smp", &bcm2836_smp_ops);
+
+bool __init bcm2836_smp_init_ops(void) {
+	smp_set_ops(&bcm2836_smp_ops);
+	return true;
+}
diff --git a/arch/arm/mach-bcm/platsmp.h b/arch/arm/mach-bcm/platsmp.h
new file mode 100644
index 0000000..50c0ad3
--- /dev/null
+++ b/arch/arm/mach-bcm/platsmp.h
@@ -0,0 +1,4 @@
+
+bool bcm2836_smp_init_ops(void);
+
+extern const struct smp_operations bcm2836_smp_ops;

> -- 
> Florian
