From: will.deacon@arm.com (Will Deacon)
Date: Fri, 9 Jul 2010 13:22:48 +0100
Subject: [PATCH] Versatile Express: add support for local timers on	CA9X4
	daughterboard
In-Reply-To: <20100709101657.GB22845@n2100.arm.linux.org.uk>
References: <1275904430-15995-1-git-send-email-will.deacon@arm.com>
	<20100709101657.GB22845@n2100.arm.linux.org.uk>
Message-ID: <005201cb1f61$7162f2f0$5428d8d0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

> On Mon, Jun 07, 2010 at 10:53:50AM +0100, Will Deacon wrote:
> > This patch adds support for the Cortex-A9 local timers available when
> > using the CA9X4 daughterboard with the Versatile Express.
> 
> I'd rather we didn't change the timer stuff like this - all that you
> seem to want is some way to setup the twd base address.  Can this be
> done via .map_io method instead?

That's a lot tidier, how about something like this?:

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 98922f7..7b117b1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1172,9 +1172,10 @@ config HOTPLUG_CPU
 config LOCAL_TIMERS
        bool "Use local timer interrupts"
        depends on SMP && (REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || \
-               REALVIEW_EB_A9MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || ARCH_U8500)
+               REALVIEW_EB_A9MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || \
+               ARCH_U8500 || ARCH_VEXPRESS_CA9X4)
        default y
-       select HAVE_ARM_TWD if (ARCH_REALVIEW || ARCH_OMAP4 || ARCH_U8500)
+       select HAVE_ARM_TWD if (ARCH_REALVIEW || ARCH_VEXPRESS || ARCH_OMAP4 || ARCH_U8500)
        help
          Enable support for local timers on SMP platforms, rather then the
          legacy IPI broadcast method.  Local timers allows the system
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 6353459..577df6c 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -16,6 +16,7 @@
 #include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 #include <asm/pmu.h>
+#include <asm/smp_twd.h>
 
 #include <mach/clkdev.h>
 #include <mach/ct-ca9x4.h>
@@ -53,6 +54,7 @@ static struct map_desc ct_ca9x4_io_desc[] __initdata = {
 
 static void __init ct_ca9x4_map_io(void)
 {
+       twd_base = MMIO_P2V(A9_MPCORE_TWD);
        v2m_map_io(ct_ca9x4_io_desc, ARRAY_SIZE(ct_ca9x4_io_desc));
 }
 
diff --git a/arch/arm/mach-vexpress/include/mach/ct-ca9x4.h b/arch/arm/mach-vexpress/include/mach/ct-ca9x4.h
index 8650f04..f9e2f8d 100644
--- a/arch/arm/mach-vexpress/include/mach/ct-ca9x4.h
+++ b/arch/arm/mach-vexpress/include/mach/ct-ca9x4.h
@@ -28,6 +28,7 @@
 #define A9_MPCORE_SCU          (CT_CA9X4_MPIC + 0x0000)
 #define A9_MPCORE_GIC_CPU      (CT_CA9X4_MPIC + 0x0100)
 #define A9_MPCORE_GIT          (CT_CA9X4_MPIC + 0x0200)
+#define A9_MPCORE_TWD          (CT_CA9X4_MPIC + 0x0600)
 #define A9_MPCORE_GIC_DIST     (CT_CA9X4_MPIC + 0x1000)
 
 /*


My only question is; what is the commented-out timer code for in
ct-ca9x4.c? It would be nice to get rid of it if it's not useful.

Cheers,

Will
