From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Dec 2011 04:47:43 -0500
Subject: [PATCH 14/20] ARM: mach-ixp4xx: properly disable CPU idle call
In-Reply-To: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
Message-ID: <1324288069-21940-15-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-ixp4xx/common.c              |    6 ++++++
 arch/arm/mach-ixp4xx/include/mach/system.h |    5 -----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 04aa12103b..ef39c02f43 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -237,6 +237,12 @@ void __init ixp4xx_init_irq(void)
 {
 	int i = 0;
 
+	/*
+	 * ixp4xx does not implement the XScale PWRMODE register
+	 * so it must not call cpu_do_idle().
+	 */
+	disable_hlt();
+
 	/* Route all sources to IRQ instead of FIQ */
 	*IXP4XX_ICLR = 0x0;
 
diff --git a/arch/arm/mach-ixp4xx/include/mach/system.h b/arch/arm/mach-ixp4xx/include/mach/system.h
index 140a9bef44..768ac09d0f 100644
--- a/arch/arm/mach-ixp4xx/include/mach/system.h
+++ b/arch/arm/mach-ixp4xx/include/mach/system.h
@@ -10,10 +10,5 @@
  */
 static inline void arch_idle(void)
 {
-	/* ixp4xx does not implement the XScale PWRMODE register,
-	 * so it must not call cpu_do_idle() here.
-	 */
-#if 0
 	cpu_do_idle();
-#endif
 }
-- 
1.7.7.1.431.g10b2a
