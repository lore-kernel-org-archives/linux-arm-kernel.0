From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 24 Apr 2013 17:19:13 -0700
Subject: [PATCH] idle: fix hlt/nohlt command-line handling in new generic idle
Message-ID: <1366849153-25564-1-git-send-email-khilman@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit d1669912 (idle: Implement generic idle function) added a new
generic idle along with support for hlt/nohlt command line options to
override default idle loop behavior.  However, the command-line
processing is never compiled.

The command-line handling is wrapped by CONFIG_GENERIC_IDLE_POLL_SETUP
and arches that use this feature select it in their Kconfigs.
However, no Kconfig definition was created for this option, so it is
never enabled, and therefore command-line override of the idle-loop
behavior is broken after migrating to the generic idle loop.

To fix, add a Kconfig definition for GENERIC_IDLE_POLL_SETUP.

Tested on ARM (OMAP4/Panda) which enables the command-line overrides
by default.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
Applies on tip/smp/hotplug where generic idle feature is added

 arch/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 1455579..e0ef57b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -216,6 +216,9 @@ config USE_GENERIC_SMP_HELPERS
 config GENERIC_SMP_IDLE_THREAD
        bool
 
+config GENERIC_IDLE_POLL_SETUP
+       bool
+
 # Select if arch init_task initializer is different to init/init_task.c
 config ARCH_INIT_TASK
        bool
-- 
1.8.2
