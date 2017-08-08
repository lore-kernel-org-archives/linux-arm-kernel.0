From: phil@raspberrypi.org (Phil Elwell)
Date: Tue,  8 Aug 2017 12:04:55 +0100
Subject: [PATCH] ARM: bcm2836: Send event when onlining other cores
In-Reply-To: <1502190295-53391-1-git-send-email-phil@raspberrypi.org>
References: <1502190295-53391-1-git-send-email-phil@raspberrypi.org>
Message-ID: <1502190295-53391-2-git-send-email-phil@raspberrypi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Secondary cores should enter a low-power idle state when waiting to
be started. The "wfe" instruction causes a core to wait until an event
or interrupt arrives before continuing to the next instruction, and
the "sev" instruction sends a wakeup event to the other cores.

Add an "sev" (and a memory barrier) to bcm2836_boot_secondary, the
function that wakes the waiting cores during booting. This is required
if the secondary cores are sitting in "wfe", and harmless if not.

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
---
 arch/arm/mach-bcm/platsmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-bcm/platsmp.c b/arch/arm/mach-bcm/platsmp.c
index 3fa1a99..7811160 100644
--- a/arch/arm/mach-bcm/platsmp.c
+++ b/arch/arm/mach-bcm/platsmp.c
@@ -312,6 +312,9 @@ static int bcm2836_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	writel(virt_to_phys(secondary_startup),
 	       intc_base + LOCAL_MAILBOX3_SET0 + 16 * cpu);
 
+	dsb(sy);
+	sev();
+
 	iounmap(intc_base);
 
 	return 0;
-- 
1.9.1
