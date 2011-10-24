From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 24 Oct 2011 05:49:57 -0400
Subject: [PATCH 08/12] ARM: mach-ixp4xx: properly disable CPU idle call
In-Reply-To: <1319449801-12367-1-git-send-email-nico@fluxnic.net>
References: <1319449801-12367-1-git-send-email-nico@fluxnic.net>
Message-ID: <1319449801-12367-9-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-ixp4xx/common.c              |    7 +++++++
 arch/arm/mach-ixp4xx/include/mach/system.h |    6 ------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 07772575d7..b787b81fd2 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -256,6 +256,13 @@ void __init ixp4xx_init_irq(void)
 					 handle_level_irq);
 		set_irq_flags(i, IRQF_VALID);
 	}
+
+	/*
+	 * ixp4xx does not implement the XScale PWRMODE register
+	 * ixp4xx does not implement the XScale PWRMODE registerso it must not
+	 * call cpu_do_idle().
+	 */
+	disable_hlt();
 }
 
 
diff --git a/arch/arm/mach-ixp4xx/include/mach/system.h b/arch/arm/mach-ixp4xx/include/mach/system.h
index 54c0af7fa2..ce7ff3941a 100644
--- a/arch/arm/mach-ixp4xx/include/mach/system.h
+++ b/arch/arm/mach-ixp4xx/include/mach/system.h
@@ -13,12 +13,6 @@
 
 static inline void arch_idle(void)
 {
-	/* ixp4xx does not implement the XScale PWRMODE register,
-	 * so it must not call cpu_do_idle() here.
-	 */
-#if 0
-	cpu_do_idle();
-#endif
 }
 
 
-- 
1.7.7.1.431.g10b2a
