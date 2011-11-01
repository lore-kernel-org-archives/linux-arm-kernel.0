From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 01 Nov 2011 16:09:08 +0000
Subject: [PATCH 3/5] ARM: restart: remove local_irq_disable() from within
	arch_reset()
In-Reply-To: <20111101160731.GQ19187@n2100.arm.linux.org.uk>
References: <20111101160731.GQ19187@n2100.arm.linux.org.uk>
Message-ID: <E1RLGtg-0005IV-TG@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IRQs are already disabled by the time arch_reset() is called, so these
calls to local_irq_disable() instead arch_reset() are redundant.  Remove
them.

The following spatch was used:
@ rule1 @ identifier fn; @@
arch_reset = fn;

@@ identifier rule1.fn, m, c; @@
void fn(char m, const char *c)
{
<... when != local_irq_enable
-local_irq_disable();
...>
}

@@ identifier m, c; @@
arch_reset(char m, const char *c)
{
<... when != local_irq_enable
-local_irq_disable();
...>
}

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-ep93xx/include/mach/system.h  |    2 --
 arch/arm/mach-iop32x/include/mach/system.h  |    2 --
 arch/arm/mach-ixp2000/include/mach/system.h |    2 --
 arch/arm/mach-lpc32xx/include/mach/system.h |    3 ---
 arch/arm/mach-shark/core.c                  |    1 -
 arch/arm/mach-u300/include/mach/system.h    |    1 -
 6 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-ep93xx/include/mach/system.h b/arch/arm/mach-ep93xx/include/mach/system.h
index 6d661fe..bdf6c4f 100644
--- a/arch/arm/mach-ep93xx/include/mach/system.h
+++ b/arch/arm/mach-ep93xx/include/mach/system.h
@@ -11,8 +11,6 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	local_irq_disable();
-
 	/*
 	 * Set then clear the SWRST bit to initiate a software reset
 	 */
diff --git a/arch/arm/mach-iop32x/include/mach/system.h b/arch/arm/mach-iop32x/include/mach/system.h
index a4b808f..5987196 100644
--- a/arch/arm/mach-iop32x/include/mach/system.h
+++ b/arch/arm/mach-iop32x/include/mach/system.h
@@ -18,8 +18,6 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	local_irq_disable();
-
 	if (machine_is_n2100()) {
 		gpio_line_set(N2100_HARDWARE_RESET, GPIO_LOW);
 		gpio_line_config(N2100_HARDWARE_RESET, GPIO_OUT);
diff --git a/arch/arm/mach-ixp2000/include/mach/system.h b/arch/arm/mach-ixp2000/include/mach/system.h
index de37099..810df7b 100644
--- a/arch/arm/mach-ixp2000/include/mach/system.h
+++ b/arch/arm/mach-ixp2000/include/mach/system.h
@@ -19,8 +19,6 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	local_irq_disable();
-
 	/*
 	 * Reset flash banking register so that we are pointing at
 	 * RedBoot bank.
diff --git a/arch/arm/mach-lpc32xx/include/mach/system.h b/arch/arm/mach-lpc32xx/include/mach/system.h
index df3b0de..d47f3b1 100644
--- a/arch/arm/mach-lpc32xx/include/mach/system.h
+++ b/arch/arm/mach-lpc32xx/include/mach/system.h
@@ -33,9 +33,6 @@ static inline void arch_reset(char mode, const char *cmd)
 	case 'h':
 		printk(KERN_CRIT "RESET: Rebooting system\n");
 
-		/* Disable interrupts */
-		local_irq_disable();
-
 		lpc32xx_watchdog_reset();
 		break;
 
diff --git a/arch/arm/mach-shark/core.c b/arch/arm/mach-shark/core.c
index ac2873c..be82b2a 100644
--- a/arch/arm/mach-shark/core.c
+++ b/arch/arm/mach-shark/core.c
@@ -29,7 +29,6 @@
 void arch_reset(char mode, const char *cmd)
 {
         short temp;
-        local_irq_disable();
         /* Reset the Machine via pc[3] of the sequoia chipset */
         outw(0x09,0x24);
         temp=inw(0x26);
diff --git a/arch/arm/mach-u300/include/mach/system.h b/arch/arm/mach-u300/include/mach/system.h
index 8daf136..a000c04 100644
--- a/arch/arm/mach-u300/include/mach/system.h
+++ b/arch/arm/mach-u300/include/mach/system.h
@@ -28,7 +28,6 @@ static void arch_reset(char mode, const char *cmd)
 	case 'h':
 		printk(KERN_CRIT "RESET: shutting down/rebooting system\n");
 		/* Disable interrupts */
-		local_irq_disable();
 #ifdef CONFIG_COH901327_WATCHDOG
 		coh901327_watchdog_reset();
 #endif
-- 
1.7.4.4
