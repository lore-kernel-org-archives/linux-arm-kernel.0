From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 19 Oct 2010 16:38:57 +0200
Subject: [PATCH 02/12] ARM: smp: Convert stop_lock to raw_spinlock
In-Reply-To: <20101019143717.GH11713@pengutronix.de>
References: <20101019143717.GH11713@pengutronix.de>
Message-ID: <1287499147-13846-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Gleixner <tglx@linutronix.de>

stop_lock needs to be a real spinlock on preempt-rt. Convert it to
a raw_spinlock. No change for !RT kernels.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/kernel/smp.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 40dc74f2..8b242af 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -464,7 +464,7 @@ void __cpuinit percpu_timer_setup(void)
 	local_timer_setup(evt);
 }
 
-static DEFINE_SPINLOCK(stop_lock);
+static DEFINE_RAW_SPINLOCK(stop_lock);
 
 /*
  * ipi_cpu_stop - handle IPI from smp_send_stop()
@@ -473,10 +473,10 @@ static void ipi_cpu_stop(unsigned int cpu)
 {
 	if (system_state == SYSTEM_BOOTING ||
 	    system_state == SYSTEM_RUNNING) {
-		spin_lock(&stop_lock);
+		raw_spin_lock(&stop_lock);
 		printk(KERN_CRIT "CPU%u: stopping\n", cpu);
 		dump_stack();
-		spin_unlock(&stop_lock);
+		raw_spin_unlock(&stop_lock);
 	}
 
 	set_cpu_online(cpu, false);
-- 
1.7.2.3
