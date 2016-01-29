From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Jan 2016 15:06:31 +0100
Subject: [PATCH 7/9] ARM: pxa: fix building without IWMMXT
In-Reply-To: <1454076396-3563101-1-git-send-email-arnd@arndb.de>
References: <1454076396-3563101-1-git-send-email-arnd@arndb.de>
Message-ID: <1454076396-3563101-8-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_IWMMXT, the pxa3xx and pxa27x suspend/resume code
emits some xscale specific instructions, which are rejected
by the assembler, because gcc is built with -march=armv5
-mtune=xscale and passes that option to the assembler:

/tmp/cciHumzr.s:553: Error: selected processor does not support ARM mode `mra r2,r3,acc0'
/tmp/cciHumzr.s:605: Error: selected processor does not support ARM mode `mar acc0,r2,r3'
make[3]: *** [arch/arm/mach-pxa/pxa3xx.o] Error 1
/tmp/cci5MUNu.s:326: Error: selected processor does not support ARM mode `mra r2,r3,acc0'
/tmp/cci5MUNu.s:367: Error: selected processor does not support ARM mode `mar acc0,r2,r3'
make[3]: *** [arch/arm/mach-pxa/pxa27x.o] Error 1

Overriding with -Wa,-march=xscale no longer works, so instead
I'm adding an explict ".arch_extension" directive in all four inline
assembly statements, which should work even if they end up in a different
order in the assembly output.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/pxa27x.c | 6 ++++--
 arch/arm/mach-pxa/pxa3xx.c | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 8dfd1755c659..49c735962148 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -132,7 +132,8 @@ void pxa27x_cpu_pm_enter(suspend_state_t state)
 #ifndef CONFIG_IWMMXT
 	u64 acc0;
 
-	asm volatile("mra %Q0, %R0, acc0" : "=r" (acc0));
+	asm volatile(".arch_extension xscale\n\t"
+		     "mra %Q0, %R0, acc0" : "=r" (acc0));
 #endif
 
 	/* ensure voltage-change sequencer not initiated, which hangs */
@@ -151,7 +152,8 @@ void pxa27x_cpu_pm_enter(suspend_state_t state)
 	case PM_SUSPEND_MEM:
 		cpu_suspend(pwrmode, pxa27x_finish_suspend);
 #ifndef CONFIG_IWMMXT
-		asm volatile("mar acc0, %Q0, %R0" : "=r" (acc0));
+		asm volatile(".arch_extension xscale\n\t"
+			     "mar acc0, %Q0, %R0" : "=r" (acc0));
 #endif
 		break;
 	}
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 1ba62be65f7c..126c265691f5 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -102,7 +102,8 @@ static void pxa3xx_cpu_pm_suspend(void)
 #ifndef CONFIG_IWMMXT
 	u64 acc0;
 
-	asm volatile("mra %Q0, %R0, acc0" : "=r" (acc0));
+	asm volatile(".arch_extension xscale\n\t"
+		     "mra %Q0, %R0, acc0" : "=r" (acc0));
 #endif
 
 	/* resuming from D2 requires the HSIO2/BOOT/TPM clocks enabled */
@@ -130,7 +131,8 @@ static void pxa3xx_cpu_pm_suspend(void)
 	AD3ER = 0;
 
 #ifndef CONFIG_IWMMXT
-	asm volatile("mar acc0, %Q0, %R0" : "=r" (acc0));
+	asm volatile(".arch_extension xscale\n\t"
+		     "mar acc0, %Q0, %R0" : "=r" (acc0));
 #endif
 }
 
-- 
2.7.0
