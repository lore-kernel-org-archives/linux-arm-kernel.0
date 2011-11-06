From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:41:38 +0000
Subject: [PATCH 05/41] ARM: restart: clps711x: use new restart hook
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6iw-0001Wt-M3@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook these platforms restart code into the new restart hook rather
than using arch_reset().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-clps711x/autcpu12.c            |    1 +
 arch/arm/mach-clps711x/cdb89712.c            |    1 +
 arch/arm/mach-clps711x/ceiva.c               |    1 +
 arch/arm/mach-clps711x/clep7312.c            |    1 +
 arch/arm/mach-clps711x/common.c              |    5 +++++
 arch/arm/mach-clps711x/edb7211-arch.c        |    1 +
 arch/arm/mach-clps711x/fortunet.c            |    1 +
 arch/arm/mach-clps711x/include/mach/system.h |    1 -
 arch/arm/mach-clps711x/p720t.c               |    1 +
 9 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-clps711x/autcpu12.c b/arch/arm/mach-clps711x/autcpu12.c
index 0276091..3fb79a1 100644
--- a/arch/arm/mach-clps711x/autcpu12.c
+++ b/arch/arm/mach-clps711x/autcpu12.c
@@ -68,5 +68,6 @@ MACHINE_START(AUTCPU12, "autronix autcpu12")
 	.map_io		= autcpu12_map_io,
 	.init_irq	= clps711x_init_irq,
 	.timer		= &clps711x_timer,
+	.restart	= clps711x_restart,
 MACHINE_END
 
diff --git a/arch/arm/mach-clps711x/cdb89712.c b/arch/arm/mach-clps711x/cdb89712.c
index 25b3bfd..c314f49 100644
--- a/arch/arm/mach-clps711x/cdb89712.c
+++ b/arch/arm/mach-clps711x/cdb89712.c
@@ -59,4 +59,5 @@ MACHINE_START(CDB89712, "Cirrus-CDB89712")
 	.map_io		= cdb89712_map_io,
 	.init_irq	= clps711x_init_irq,
 	.timer		= &clps711x_timer,
+	.restart	= clps711x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-clps711x/ceiva.c b/arch/arm/mach-clps711x/ceiva.c
index 1df9ec6..a70147e 100644
--- a/arch/arm/mach-clps711x/ceiva.c
+++ b/arch/arm/mach-clps711x/ceiva.c
@@ -60,4 +60,5 @@ MACHINE_START(CEIVA, "CEIVA/Polaroid Photo MAX Digital Picture Frame")
 	.map_io		= ceiva_map_io,
 	.init_irq	= clps711x_init_irq,
 	.timer		= &clps711x_timer,
+	.restart	= clps711x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-clps711x/clep7312.c b/arch/arm/mach-clps711x/clep7312.c
index 80496c0..dbc7842 100644
--- a/arch/arm/mach-clps711x/clep7312.c
+++ b/arch/arm/mach-clps711x/clep7312.c
@@ -41,5 +41,6 @@ MACHINE_START(CLEP7212, "Cirrus Logic 7212/7312")
 	.map_io		= clps711x_map_io,
 	.init_irq	= clps711x_init_irq,
 	.timer		= &clps711x_timer,
+	.restart	= clps711x_restart,
 MACHINE_END
 
diff --git a/arch/arm/mach-clps711x/common.c b/arch/arm/mach-clps711x/common.c
index aa273e7..fedf0e3 100644
--- a/arch/arm/mach-clps711x/common.c
+++ b/arch/arm/mach-clps711x/common.c
@@ -220,3 +220,8 @@ struct sys_timer clps711x_timer = {
 	.init		= clps711x_timer_init,
 	.offset		= clps711x_gettimeoffset,
 };
+
+void clps711x_restart(char mode, const char *cmd)
+{
+	soft_restart(0);
+}
diff --git a/arch/arm/mach-clps711x/edb7211-arch.c b/arch/arm/mach-clps711x/edb7211-arch.c
index 9721f61..5fad0b4 100644
--- a/arch/arm/mach-clps711x/edb7211-arch.c
+++ b/arch/arm/mach-clps711x/edb7211-arch.c
@@ -62,4 +62,5 @@ MACHINE_START(EDB7211, "CL-EDB7211 (EP7211 eval board)")
 	.reserve	= edb7211_reserve,
 	.init_irq	= clps711x_init_irq,
 	.timer		= &clps711x_timer,
+	.restart	= clps711x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-clps711x/fortunet.c b/arch/arm/mach-clps711x/fortunet.c
index d992566..3a3f0b7 100644
--- a/arch/arm/mach-clps711x/fortunet.c
+++ b/arch/arm/mach-clps711x/fortunet.c
@@ -78,4 +78,5 @@ MACHINE_START(FORTUNET, "ARM-FortuNet")
 	.map_io		= clps711x_map_io,
 	.init_irq	= clps711x_init_irq,
 	.timer		= &clps711x_timer,
+	.restart	= clps711x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-clps711x/include/mach/system.h b/arch/arm/mach-clps711x/include/mach/system.h
index 6c11993..9982deb 100644
--- a/arch/arm/mach-clps711x/include/mach/system.h
+++ b/arch/arm/mach-clps711x/include/mach/system.h
@@ -34,7 +34,6 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	soft_restart(0);
 }
 
 #endif
diff --git a/arch/arm/mach-clps711x/p720t.c b/arch/arm/mach-clps711x/p720t.c
index 6ecea95..42ee8f3 100644
--- a/arch/arm/mach-clps711x/p720t.c
+++ b/arch/arm/mach-clps711x/p720t.c
@@ -93,6 +93,7 @@ MACHINE_START(P720T, "ARM-Prospector720T")
 	.map_io		= p720t_map_io,
 	.init_irq	= clps711x_init_irq,
 	.timer		= &clps711x_timer,
+	.restart	= clps711x_restart,
 MACHINE_END
 
 static int p720t_hw_init(void)
-- 
1.7.4.4
