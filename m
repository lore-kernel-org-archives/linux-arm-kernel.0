From: ulrich.hecht@gmail.com (Ulrich Hecht)
Date: Sat,  5 Jan 2013 14:05:23 +0100
Subject: [PATCH] ARM: smp: return from ipi_cpu_stop()
Message-ID: <1357391123-759-1-git-send-email-ulrich.hecht@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ipi_cpu_stop() is supposed to mark a CPU offline, but it's the job of the
idle thread to actually shut it down. It seems, however, that the idle
thread doesn't get a chance to run because ipi_cpu_stop() disables all
interrupts and does not return.  This keeps the platform-specific shutdown
code from being executed, which causes big trouble when kexec'ing an SMP
kernel.

This patch fixes the issue by removing the endless loop. Tested on a KZM9G
board.

Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
---
 arch/arm/kernel/smp.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 84f4cbf..e72b025 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -571,9 +571,6 @@ static void ipi_cpu_stop(unsigned int cpu)
 
 	local_fiq_disable();
 	local_irq_disable();
-
-	while (1)
-		cpu_relax();
 }
 
 /*
-- 
1.7.7
