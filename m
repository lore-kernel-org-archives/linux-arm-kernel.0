From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 04 Jul 2014 20:52:12 +0100
Subject: [PATCH 3/4] ARM: SWP emulation: only initialise on ARMv7 CPUs
In-Reply-To: <20140704195134.GJ21766@n2100.arm.linux.org.uk>
References: <20140704195134.GJ21766@n2100.arm.linux.org.uk>
Message-ID: <E1X39Wm-0000lu-O1@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previous CPUs do not have the ability to trap SWP instructions, so
it's pointless initialising this code there.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/swp_emulate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/kernel/swp_emulate.c b/arch/arm/kernel/swp_emulate.c
index b1b89882b113..67ca8578c6d8 100644
--- a/arch/arm/kernel/swp_emulate.c
+++ b/arch/arm/kernel/swp_emulate.c
@@ -27,6 +27,7 @@
 #include <linux/perf_event.h>
 
 #include <asm/opcodes.h>
+#include <asm/system_info.h>
 #include <asm/traps.h>
 #include <asm/uaccess.h>
 
@@ -266,6 +267,9 @@ static struct undef_hook swp_hook = {
  */
 static int __init swp_emulation_init(void)
 {
+	if (cpu_architecture() < CPU_ARCH_ARMv7)
+		return 0;
+
 #ifdef CONFIG_PROC_FS
 	if (!proc_create("cpu/swp_emulation", S_IRUGO, NULL, &proc_status_fops))
 		return -ENOMEM;
-- 
1.8.3.1
