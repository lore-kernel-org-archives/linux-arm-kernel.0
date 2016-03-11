From: anna-maria@linutronix.de (Anna-Maria Gleixner)
Date: Fri, 11 Mar 2016 10:19:55 +0100
Subject: [PATCH] arm/bL_switcher: Use global define for masking hotplug
 transition switch action argument
Message-ID: <1457687995-40417-1-git-send-email-anna-maria@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The action argument of the hotplug transition switch case is masked
with '0xf' to map CPU_XXX_FROZEN hotplug transition on corresponding
non frozen hotplug transitions. There is a global define
CPU_TASKS_FROZEN used as mask for frozen hotplug transitions.

Use '~CPU_TASKS_FROZEN' instead of '0xf'.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 arch/arm/common/bL_switcher.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -762,7 +762,7 @@ static int bL_switcher_hotplug_callback(
 {
 	if (bL_switcher_active) {
 		int pairing = bL_switcher_cpu_pairing[(unsigned long)hcpu];
-		switch (action & 0xf) {
+		switch (action & ~CPU_TASKS_FROZEN) {
 		case CPU_UP_PREPARE:
 		case CPU_DOWN_PREPARE:
 			if (pairing == -1)
