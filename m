From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:53:10 +0000
Subject: [PATCH 39/41] ARM: restart: lpc32xx & u300: remove unnecessary printk
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6u6-0001ZD-Ll@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the:
	KERN_CRIT "RESET: Rebooting system\n" (lpc32xx)
	KERN_CRIT "RESET: shutting down/rebooting system\n" (u300)

printk from the restart handler; we already print such a message from
kernel_restart() in kernel/sys.c:

	KERN_EMERG "Restarting system.\n"

so this is unnecessary.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-lpc32xx/common.c |    2 --
 arch/arm/mach-u300/core.c      |    1 -
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/common.c b/arch/arm/mach-lpc32xx/common.c
index b049fd1..369b152 100644
--- a/arch/arm/mach-lpc32xx/common.c
+++ b/arch/arm/mach-lpc32xx/common.c
@@ -317,8 +317,6 @@ void lpc23xx_restart(char mode, const char *cmd)
 	switch (mode) {
 	case 's':
 	case 'h':
-		printk(KERN_CRIT "RESET: Rebooting system\n");
-
 		lpc32xx_watchdog_reset();
 		break;
 
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 27be5a7..6979307 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -1897,7 +1897,6 @@ void u300_restart(char mode, const char *cmd)
 	switch (mode) {
 	case 's':
 	case 'h':
-		printk(KERN_CRIT "RESET: shutting down/rebooting system\n");
 #ifdef CONFIG_COH901327_WATCHDOG
 		coh901327_watchdog_reset();
 #endif
-- 
1.7.4.4
