From: nbowler@elliptictech.com (Nick Bowler)
Date: Mon, 22 Aug 2011 09:54:19 -0400
Subject: [PATCH v2] ARM: vexpress: Use wfi macro in platform_do_lowpower.
In-Reply-To: <CAHkRjk6Fq+1b_uM+DFACS1QVd7B6_1XhqRw-27i88U1VyvLk+Q@mail.gmail.com>
References: <CAHkRjk6Fq+1b_uM+DFACS1QVd7B6_1XhqRw-27i88U1VyvLk+Q@mail.gmail.com>
Message-ID: <1314021259-31710-1-git-send-email-nbowler@elliptictech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current Versatile Express CPU hotplug code includes a hardcoded WFI
instruction, in ARM encoding.  When the kernel is compiled in Thumb-2
mode, this is invalid and causes the machine to hang hard when a CPU
is offlined.

Using the wfi macro (which uses the appropriate assembler mnemonic)
causes the correct instruction to be emitted in either case.  As a
consequence of this change, an apparently vestigial "cc" clobber is
dropped from the asm (the macro uses "memory" only).

Signed-off-by: Nick Bowler <nbowler@elliptictech.com>
---
 arch/arm/mach-vexpress/hotplug.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

OK.  If this version is acceptable, I'll follow up with patches for the
other platforms.

diff --git a/arch/arm/mach-vexpress/hotplug.c b/arch/arm/mach-vexpress/hotplug.c
index ea4cbfb..3668cf9 100644
--- a/arch/arm/mach-vexpress/hotplug.c
+++ b/arch/arm/mach-vexpress/hotplug.c
@@ -13,6 +13,7 @@
 #include <linux/smp.h>
 
 #include <asm/cacheflush.h>
+#include <asm/system.h>
 
 extern volatile int pen_release;
 
@@ -62,13 +63,7 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 	 * code will have already disabled interrupts
 	 */
 	for (;;) {
-		/*
-		 * here's the WFI
-		 */
-		asm(".word	0xe320f003\n"
-		    :
-		    :
-		    : "memory", "cc");
+		wfi();
 
 		if (pen_release == cpu) {
 			/*
-- 
1.7.3.4
