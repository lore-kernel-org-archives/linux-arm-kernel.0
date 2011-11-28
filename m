From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Nov 2011 11:07:21 +0000
Subject: [03: PATCH 0/5] The remaining stuff
In-Reply-To: <CACRpkdb4ozt1S3CrEeWGY5zeeJ-=vi8Wh18jv9AONRAH+W1MxQ@mail.gmail.com>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <20111106173939.GJ12913@n2100.arm.linux.org.uk>
 <20111106175457.GK12913@n2100.arm.linux.org.uk>
 <20111111171650.GA4154@n2100.arm.linux.org.uk>
 <CACRpkdb4ozt1S3CrEeWGY5zeeJ-=vi8Wh18jv9AONRAH+W1MxQ@mail.gmail.com>
Message-ID: <20111128110721.GF9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2011 at 11:40:49AM +0100, Linus Walleij wrote:
> Is this about the problem of where to place the hook
> for restart as described in this message?
> http://marc.info/?l=linux-arm-kernel&m=132104005724249&w=2
> 
> If you apply that patch I think it's easy to fix that up,
> if you have some git branch I can base off I can fix
> it up too.
> 
> Or you can just throw it into -next so it breaks and I'll fix
> from there ASAP, no big deal.

This is about as far as I got with Nomadik.  The patch you point out above
does appear to fix the problem, and if you put it in the patch system, I'll
apply it to the restart-cleanup branch, and fix the patch below.

8<===
ARM: restart: nomadik: use new restart hook XXX WIP XXX WHY IS THERE NO LOCAL HEADERS XXX

Hook the Nomadik NHK platform restart code into the new restart hook.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-nomadik/board-nhk8815.c       |    1 +
 arch/arm/mach-nomadik/cpu-8815.c            |   11 +++++++++++
 arch/arm/mach-nomadik/include/mach/system.h |    9 ---------
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-nomadik/board-nhk8815.c b/arch/arm/mach-nomadik/board-nhk8815.c
index 0cbb74c..c559ed6 100644
--- a/arch/arm/mach-nomadik/board-nhk8815.c
+++ b/arch/arm/mach-nomadik/board-nhk8815.c
@@ -282,4 +282,5 @@ MACHINE_START(NOMADIK, "NHK8815")
 	.init_irq	= cpu8815_init_irq,
 	.timer		= &nomadik_timer,
 	.init_machine	= nhk8815_platform_init,
+	.restart	= cpu8815_restart,
 MACHINE_END
diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index dc67717..b4bbe51 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -21,6 +21,7 @@
 #include <linux/device.h>
 #include <linux/amba/bus.h>
 #include <linux/platform_device.h>
+#include <linux/io.h>
 
 #include <plat/gpio-nomadik.h>
 #include <mach/hardware.h>
@@ -164,3 +165,13 @@ void __init cpu8815_init_irq(void)
 #endif
 	 return;
 }
+
+void cpu8815_restart(char mode, const char *cmd)
+{
+	void __iomem *src_rstsr = io_p2v(NOMADIK_SRC_BASE + 0x18);
+
+	/* FIXME: use egpio when implemented */
+
+	/* Write anything to Reset status register */
+	writel(1, src_rstsr);
+}
diff --git a/arch/arm/mach-nomadik/include/mach/system.h b/arch/arm/mach-nomadik/include/mach/system.h
index 7119f68..16f59f6 100644
--- a/arch/arm/mach-nomadik/include/mach/system.h
+++ b/arch/arm/mach-nomadik/include/mach/system.h
@@ -20,9 +20,6 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H
 
-#include <linux/io.h>
-#include <mach/hardware.h>
-
 static inline void arch_idle(void)
 {
 	/*
@@ -34,12 +31,6 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	void __iomem *src_rstsr = io_p2v(NOMADIK_SRC_BASE + 0x18);
-
-	/* FIXME: use egpio when implemented */
-
-	/* Write anything to Reset status register */
-	writel(1, src_rstsr);
 }
 
 #endif
-- 
1.7.4.4
