From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 24 Oct 2011 05:49:56 -0400
Subject: [PATCH 07/12] ARM: mach-ixp23xx: properly disable CPU idle call
In-Reply-To: <1319449801-12367-1-git-send-email-nico@fluxnic.net>
References: <1319449801-12367-1-git-send-email-nico@fluxnic.net>
Message-ID: <1319449801-12367-8-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-ixp23xx/core.c                |    3 +++
 arch/arm/mach-ixp23xx/include/mach/system.h |    4 ----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-ixp23xx/core.c b/arch/arm/mach-ixp23xx/core.c
index a1bee33d18..3fd8da956b 100644
--- a/arch/arm/mach-ixp23xx/core.c
+++ b/arch/arm/mach-ixp23xx/core.c
@@ -443,4 +443,7 @@ void __init ixp23xx_sys_init(void)
 {
 	*IXP23XX_EXP_UNIT_FUSE |= 0xf;
 	platform_add_devices(ixp23xx_devices, ARRAY_SIZE(ixp23xx_devices));
+
+	/* by default, the idle code is disabled */
+	disable_hlt();
 }
diff --git a/arch/arm/mach-ixp23xx/include/mach/system.h b/arch/arm/mach-ixp23xx/include/mach/system.h
index 8920ff2dff..0d239f2a1c 100644
--- a/arch/arm/mach-ixp23xx/include/mach/system.h
+++ b/arch/arm/mach-ixp23xx/include/mach/system.h
@@ -13,10 +13,6 @@
 
 static inline void arch_idle(void)
 {
-#if 0
-	if (!hlt_counter)
-		cpu_do_idle();
-#endif
 }
 
 static inline void arch_reset(char mode, const char *cmd)
-- 
1.7.7.1.431.g10b2a
