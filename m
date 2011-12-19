From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Dec 2011 04:47:42 -0500
Subject: [PATCH 13/20] ARM: mach-ixp23xx: properly disable CPU idle call
In-Reply-To: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
Message-ID: <1324288069-21940-14-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-ixp23xx/core.c                |    3 +++
 arch/arm/mach-ixp23xx/include/mach/system.h |    5 +----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-ixp23xx/core.c b/arch/arm/mach-ixp23xx/core.c
index 0923bb905c..7c1495e4fe 100644
--- a/arch/arm/mach-ixp23xx/core.c
+++ b/arch/arm/mach-ixp23xx/core.c
@@ -441,6 +441,9 @@ static struct platform_device *ixp23xx_devices[] __initdata = {
 
 void __init ixp23xx_sys_init(void)
 {
+	/* by default, the idle code is disabled */
+	disable_hlt();
+
 	*IXP23XX_EXP_UNIT_FUSE |= 0xf;
 	platform_add_devices(ixp23xx_devices, ARRAY_SIZE(ixp23xx_devices));
 }
diff --git a/arch/arm/mach-ixp23xx/include/mach/system.h b/arch/arm/mach-ixp23xx/include/mach/system.h
index 277dda7334..69f80006fc 100644
--- a/arch/arm/mach-ixp23xx/include/mach/system.h
+++ b/arch/arm/mach-ixp23xx/include/mach/system.h
@@ -9,8 +9,5 @@
  */
 static inline void arch_idle(void)
 {
-#if 0
-	if (!hlt_counter)
-		cpu_do_idle();
-#endif
+	cpu_do_idle();
 }
-- 
1.7.7.1.431.g10b2a
