From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Dec 2011 04:47:44 -0500
Subject: [PATCH 15/20] ARM: mach-shark: properly disable CPU idle call
In-Reply-To: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
Message-ID: <1324288069-21940-16-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-shark/core.c                |    6 ++++++
 arch/arm/mach-shark/include/mach/system.h |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shark/core.c b/arch/arm/mach-shark/core.c
index a851c254ad..487a12af8c 100644
--- a/arch/arm/mach-shark/core.c
+++ b/arch/arm/mach-shark/core.c
@@ -149,11 +149,17 @@ static struct sys_timer shark_timer = {
 	.init		= shark_timer_init,
 };
 
+static void shark_init_machine(void)
+{
+	disable_hlt();
+}
+
 MACHINE_START(SHARK, "Shark")
 	/* Maintainer: Alexander Schulz */
 	.atag_offset	= 0x3000,
 	.map_io		= shark_map_io,
 	.init_irq	= shark_init_irq,
+	.init_machine	= shark_init_machine,
 	.timer		= &shark_timer,
 	.dma_zone_size	= SZ_4M,
 	.restart	= shark_restart,
diff --git a/arch/arm/mach-shark/include/mach/system.h b/arch/arm/mach-shark/include/mach/system.h
index 1b2f2c5050..1ec8d6c383 100644
--- a/arch/arm/mach-shark/include/mach/system.h
+++ b/arch/arm/mach-shark/include/mach/system.h
@@ -8,6 +8,7 @@
 
 static inline void arch_idle(void)
 {
+	cpu_do_idle();
 }
 
 #endif
-- 
1.7.7.1.431.g10b2a
