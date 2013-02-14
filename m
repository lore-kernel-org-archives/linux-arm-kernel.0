From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Feb 2013 15:01:31 +0100
Subject: [PATCH] ARM: prima2: fix __init section for cpu hotplug
In-Reply-To: <1360850491-1463387-1-git-send-email-arnd@arndb.de>
References: <1360850491-1463387-1-git-send-email-arnd@arndb.de>
Message-ID: <1360850491-1463387-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code in arch/arm/mach-prima2/headsmp.S is used for
both boot time initialization and for cpu hotplug,
so it must not be discarded after the initial boot
is complete. This replaces the __INIT annotation
with __CPUINIT, and marks the sirfsoc_cpu_die as
__ref to annotate that it correctly uses the sections.

Without this patch, building prima2_defconfig results in:

WARNING: arch/arm/mach-prima2/built-in.o(.cpuinit.text+0x130): Section mismatch in reference from the function sirfsoc_boot_secondary() to the function .init.text:sirfsoc_secondary_startup()
The function __cpuinit sirfsoc_boot_secondary() references
a function __init sirfsoc_secondary_startup().
If sirfsoc_secondary_startup is only used by sirfsoc_boot_secondary then
annotate sirfsoc_secondary_startup with a matching annotation.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Barry Song <baohua.song@csr.com>
---
 arch/arm/mach-prima2/headsmp.S | 3 ++-
 arch/arm/mach-prima2/hotplug.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

I'm applying this as an obvious fix directly on the next/soc
branch that introduced the problem.

diff --git a/arch/arm/mach-prima2/headsmp.S b/arch/arm/mach-prima2/headsmp.S
index 6ec19d5..ada82d0 100644
--- a/arch/arm/mach-prima2/headsmp.S
+++ b/arch/arm/mach-prima2/headsmp.S
@@ -9,7 +9,8 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 
-	__INIT
+	__CPUINIT
+
 /*
  * Cold boot and hardware reset show different behaviour,
  * system will be always panic if we warm-reset the board
diff --git a/arch/arm/mach-prima2/hotplug.c b/arch/arm/mach-prima2/hotplug.c
index 97c1ee5..f4b17cb 100644
--- a/arch/arm/mach-prima2/hotplug.c
+++ b/arch/arm/mach-prima2/hotplug.c
@@ -35,7 +35,7 @@ static inline void platform_do_lowpower(unsigned int cpu)
  *
  * Called with IRQs disabled
  */
-void sirfsoc_cpu_die(unsigned int cpu)
+void __ref sirfsoc_cpu_die(unsigned int cpu)
 {
 	platform_do_lowpower(cpu);
 }
-- 
1.8.1.2
