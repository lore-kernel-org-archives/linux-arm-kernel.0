From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:44:07 +0100
Subject: [PATCH 39/51] ARM: mach-shark: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-40-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-shark to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-shark/core.c                |    5 ++++-
 arch/arm/mach-shark/include/mach/system.h |    5 +++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shark/core.c b/arch/arm/mach-shark/core.c
index ac2873c..bbe4fc5 100644
--- a/arch/arm/mach-shark/core.c
+++ b/arch/arm/mach-shark/core.c
@@ -26,7 +26,7 @@
 #define ROMCARD_SIZE            0x08000000
 #define ROMCARD_START           0x10000000
 
-void arch_reset(char mode, const char *cmd)
+static void shark_arch_reset(char mode, const char *cmd)
 {
         short temp;
         local_irq_disable();
@@ -97,6 +97,9 @@ static int __init shark_init(void)
 		ret = platform_device_register(&serial_device);
 		if (ret) printk(KERN_ERR "Unable to register Serial device: %d\n", ret);
 	}
+
+	arm_arch_reset = shark_arch_reset;
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-shark/include/mach/system.h b/arch/arm/mach-shark/include/mach/system.h
index 21c373b..2cc363a 100644
--- a/arch/arm/mach-shark/include/mach/system.h
+++ b/arch/arm/mach-shark/include/mach/system.h
@@ -6,8 +6,9 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H
 
-/* Found in arch/mach-shark/core.c */
-extern void arch_reset(char mode, const char *cmd);
+static inline void arch_reset(char mode, const char *cmd)
+{
+}
 
 static inline void arch_idle(void)
 {
-- 
1.7.4.1
