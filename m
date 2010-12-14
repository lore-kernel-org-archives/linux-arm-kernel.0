From: j.neuschaefer@gmx.net (Jonathan =?utf-8?Q?Neusch=C3=A4fer?=)
Date: Tue, 14 Dec 2010 23:48:48 +0100
Subject: [PATCH] arch/arm/kernel: use cpu_relax() in halt loops
Message-ID: <20101214224848.GA1706@debian.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looking throught arch/arm/kernel/ I found some halt loops.
I just thought we could save some power here using cpu_relax(),
or am I missing something?

Signed-off-by: Jonathan Neusch?fer <j.neuschaefer@gmx.net>
---
 arch/arm/kernel/process.c |    6 ++++--
 arch/arm/kernel/setup.c   |    7 +++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index e76fcaa..4a83fdf 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -124,7 +124,8 @@ void arm_machine_restart(char mode, const char *cmd)
 	 */
 	mdelay(1000);
 	printk("Reboot failed -- System halted\n");
-	while (1);
+	while (1)
+		cpu_relax();
 }
 
 /*
@@ -235,7 +236,8 @@ void machine_shutdown(void)
 void machine_halt(void)
 {
 	machine_shutdown();
-	while (1);
+	while (1)
+		cpu_relax();
 }
 
 void machine_power_off(void)
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 336f14e..0d77329 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -41,6 +41,7 @@
 #include <asm/cacheflush.h>
 #include <asm/cachetype.h>
 #include <asm/tlbflush.h>
+#include <asm/processor.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
@@ -337,7 +338,8 @@ static void __init setup_processor(void)
 	if (!list) {
 		printk("CPU configuration botched (ID %08x), unable "
 		       "to continue.\n", read_cpuid_id());
-		while (1);
+		while (1)
+			cpu_relax();
 	}
 
 	cpu_name = list->cpu_name;
@@ -434,7 +436,8 @@ static struct machine_desc * __init setup_machine(unsigned int nr)
 	if (!list) {
 		printk("Machine configuration botched (nr %d), unable "
 		       "to continue.\n", nr);
-		while (1);
+		while (1)
+			cpu_relax();
 	}
 
 	printk("Machine: %s\n", list->name);
-- 
1.7.2.3
