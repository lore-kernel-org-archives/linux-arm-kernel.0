From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:44:04 +0100
Subject: [PATCH 36/51] ARM: mach-rpc: use arm_arch_reset instead of arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-37-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-rpc to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-rpc/include/mach/system.h |   10 ----------
 arch/arm/mach-rpc/riscpc.c              |   14 ++++++++++++++
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-rpc/include/mach/system.h b/arch/arm/mach-rpc/include/mach/system.h
index 45c7b93..e9fb593 100644
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
-	cpu_reset(0);
 }
diff --git a/arch/arm/mach-rpc/riscpc.c b/arch/arm/mach-rpc/riscpc.c
index 580b3c7..2d9ac6e 100644
--- a/arch/arm/mach-rpc/riscpc.c
+++ b/arch/arm/mach-rpc/riscpc.c
@@ -25,9 +25,12 @@
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 #include <asm/page.h>
+#include <asm/proc-fns.h>
 #include <asm/domain.h>
 #include <asm/setup.h>
 
+#include <asm/hardware/iomd.h>
+
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -206,9 +209,20 @@ static struct i2c_board_info i2c_rtc = {
 	I2C_BOARD_INFO("pcf8583", 0x50)
 };
 
+static void rpc_arch_reset(char mode, const char *cmd)
+{
+	iomd_writeb(0, IOMD_ROMCR0);
+
+	/*
+	 * Jump into the ROM
+	 */
+	cpu_reset(0);
+}
+
 static int __init rpc_init(void)
 {
 	i2c_register_board_info(0, &i2c_rtc, 1);
+	arm_arch_reset = rpc_arch_reset;
 	return platform_add_devices(devs, ARRAY_SIZE(devs));
 }
 
-- 
1.7.4.1
