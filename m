From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Dec 2011 04:47:48 -0500
Subject: [PATCH 19/20] ARM: substitute arch_idle()
In-Reply-To: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
Message-ID: <1324288069-21940-20-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that all implementations of arch_idle() are equivalent to cpu_do_idle()
we can just use the later directly and stop including mach/system.h.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/kernel/process.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index bf904624c5..4a04b2d661 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -61,8 +61,6 @@ extern void setup_mm_for_reboot(void);
 
 static volatile int hlt_counter;
 
-#include <mach/system.h>
-
 void disable_hlt(void)
 {
 	hlt_counter++;
@@ -161,7 +159,7 @@ static void default_idle(void)
 	if (arm_pm_idle)
 		arm_pm_idle();
 	else
-		arch_idle();
+		cpu_do_idle();
 	local_irq_enable();
 }
 
-- 
1.7.7.1.431.g10b2a
