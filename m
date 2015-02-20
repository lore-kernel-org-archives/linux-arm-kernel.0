From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 20 Feb 2015 14:53:46 +0000
Subject: [PATCH] genirq: better describe IRQF_NO_SUSPEND semantics
Message-ID: <1424444026-31231-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IRQF_NO_SUSPEND flag is intended to be used for interrupts required
to be enabled during the suspend-resume cycle. This mostly consists of
IPIs and timer interrupts, potentially including chained irqchip
interrupts if these are necessary to handle timers or IPIs. If an
interrupt does not fall into one of the aforementioned categories,
requesting it with IRQF_NO_SUSPEND is likely incorrect.

Using IRQF_NO_SUSPEND does not guarantee that the interrupt can wake the
system from a suspended state. For an interrupt to be able to trigger a
wakeup, it may be necessary to program various components of the system.
In these cases it is necessary to use {enable,disabled}_irq_wake.

Unfortunately, several drivers assume that IRQF_NO_SUSPEND ensures that
an IRQ can wake up the system, and the documentation can be read
ambiguously w.r.t. this property.

This patch updates the documentation regarding IRQF_NO_SUSPEND to make
this caveat explicit, hopefully making future misuse rarer. Cleanup of
existing misuse will occur as part of later patch series.

Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Ian Campbell <ian.campbell@citrix.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/power/suspend-and-interrupts.txt | 6 ++++--
 include/linux/interrupt.h                      | 4 +++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/power/suspend-and-interrupts.txt b/Documentation/power/suspend-and-interrupts.txt
index 2f9c5a5..50493c9 100644
--- a/Documentation/power/suspend-and-interrupts.txt
+++ b/Documentation/power/suspend-and-interrupts.txt
@@ -40,8 +40,10 @@ but also to IPIs and to some other special-purpose interrupts.
 
 The IRQF_NO_SUSPEND flag is used to indicate that to the IRQ subsystem when
 requesting a special-purpose interrupt.  It causes suspend_device_irqs() to
-leave the corresponding IRQ enabled so as to allow the interrupt to work all
-the time as expected.
+leave the corresponding IRQ enabled so as to allow the interrupt to work as
+expected during the suspend-resume cycle, but does not guarantee that the
+interrupt will wake the system from a suspended state -- for such cases it is
+necessary to use enable_irq_wake().
 
 Note that the IRQF_NO_SUSPEND flag affects the entire IRQ and not just one
 user of it.  Thus, if the IRQ is shared, all of the interrupt handlers installed
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index d9b05b5..606771c 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -52,7 +52,9 @@
  * IRQF_ONESHOT - Interrupt is not reenabled after the hardirq handler finished.
  *                Used by threaded interrupts which need to keep the
  *                irq line disabled until the threaded handler has been run.
- * IRQF_NO_SUSPEND - Do not disable this IRQ during suspend
+ * IRQF_NO_SUSPEND - Do not disable this IRQ during suspend.  Does not guarantee
+ *                   that this interrupt will wake the system from a suspended
+ *                   state.  See Documentation/power/suspend-and-interrupts.txt
  * IRQF_FORCE_RESUME - Force enable it on resume even if IRQF_NO_SUSPEND is set
  * IRQF_NO_THREAD - Interrupt cannot be threaded
  * IRQF_EARLY_RESUME - Resume IRQ early during syscore instead of at device
-- 
1.9.1
