From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:50:09 +0000
Subject: [PATCH 30/41] ARM: restart: riscpc: use new restart hook
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6rB-0001Yd-G4@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook the RiscPC restart code into the new restart hook.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-rpc/include/mach/system.h |   10 ----------
 arch/arm/mach-rpc/riscpc.c              |   12 ++++++++++++
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-rpc/include/mach/system.h b/arch/arm/mach-rpc/include/mach/system.h
index a354f4d..e9fb593 100644
--- a/arch/arm/mach-rpc/include/mach/system.h
+++ b/arch/arm/mach-rpc/include/mach/system.h
@@ -7,10 +7,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include <linux/io.h>
-#include <mach/hardware.h>
-#include <asm/hardware/iomd.h>
-
 static inline void arch_idle(void)
 {
 	cpu_do_idle();
@@ -18,10 +14,4 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	iomd_writeb(0, IOMD_ROMCR0);
-
-	/*
-	 * Jump into the ROM
-	 */
-	soft_restart(0);
 }
diff --git a/arch/arm/mach-rpc/riscpc.c b/arch/arm/mach-rpc/riscpc.c
index 8559598..3d44a59 100644
--- a/arch/arm/mach-rpc/riscpc.c
+++ b/arch/arm/mach-rpc/riscpc.c
@@ -24,6 +24,7 @@
 #include <asm/elf.h>
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
+#include <asm/hardware/iomd.h>
 #include <asm/page.h>
 #include <asm/domain.h>
 #include <asm/setup.h>
@@ -214,6 +215,16 @@ static int __init rpc_init(void)
 
 arch_initcall(rpc_init);
 
+static void rpc_restart(char mode, const char *cmd)
+{
+	iomd_writeb(0, IOMD_ROMCR0);
+
+	/*
+	 * Jump into the ROM
+	 */
+	soft_restart(0);
+}
+
 extern struct sys_timer ioc_timer;
 
 MACHINE_START(RISCPC, "Acorn-RiscPC")
@@ -224,4 +235,5 @@ MACHINE_START(RISCPC, "Acorn-RiscPC")
 	.map_io		= rpc_map_io,
 	.init_irq	= rpc_init_irq,
 	.timer		= &ioc_timer,
+	.restart	= rpc_restart,
 MACHINE_END
-- 
1.7.4.4
