From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Jan 2016 15:06:30 +0100
Subject: [PATCH 6/9] ARM: pxa: move extern declarations to pm.h
In-Reply-To: <1454076396-3563101-1-git-send-email-arnd@arndb.de>
References: <1454076396-3563101-1-git-send-email-arnd@arndb.de>
Message-ID: <1454076396-3563101-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_IWMMXT is disabled, we get a warning in pxa3xx.c:

arch/arm/mach-pxa/pxa3xx.c: In function 'pxa3xx_cpu_pm_suspend':
arch/arm/mach-pxa/pxa3xx.c:109:2: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]

It turns out that there is an 'extern' declaration in the
middle of a function.

For consistency, this moves the declaration and two others from
the same file into pm.h.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/pm.h     | 3 +++
 arch/arm/mach-pxa/pxa3xx.c | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/pm.h b/arch/arm/mach-pxa/pm.h
index 51558bcee999..3aab90d8d2b7 100644
--- a/arch/arm/mach-pxa/pm.h
+++ b/arch/arm/mach-pxa/pm.h
@@ -29,6 +29,9 @@ extern int pxa_pm_enter(suspend_state_t state);
 extern int pxa_pm_prepare(void);
 extern void pxa_pm_finish(void);
 
+extern const char pm_enter_standby_start[], pm_enter_standby_end[];
+extern int pxa3xx_finish_suspend(unsigned long);
+
 /* NOTE: this is for PM debugging on Lubbock,  it's really a big
  * ugly, but let's keep the crap minimum here, instead of direct
  * accessing the LUBBOCK CPLD registers in arch/arm/mach-pxa/pm.c
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index a1c4c888f246..1ba62be65f7c 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -68,7 +68,6 @@ static unsigned long wakeup_src;
  */
 static void pxa3xx_cpu_standby(unsigned int pwrmode)
 {
-	extern const char pm_enter_standby_start[], pm_enter_standby_end[];
 	void (*fn)(unsigned int) = (void __force *)(sram + 0x8000);
 
 	memcpy_toio(sram + 0x8000, pm_enter_standby_start,
@@ -106,8 +105,6 @@ static void pxa3xx_cpu_pm_suspend(void)
 	asm volatile("mra %Q0, %R0, acc0" : "=r" (acc0));
 #endif
 
-	extern int pxa3xx_finish_suspend(unsigned long);
-
 	/* resuming from D2 requires the HSIO2/BOOT/TPM clocks enabled */
 	CKENA |= (1 << CKEN_BOOT) | (1 << CKEN_TPM);
 	CKENB |= 1 << (CKEN_HSIO2 & 0x1f);
-- 
2.7.0
