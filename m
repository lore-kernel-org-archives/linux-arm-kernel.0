From: srivatsa.bhat@linux.vnet.ibm.com (Srivatsa S. Bhat)
Date: Mon, 18 Feb 2013 18:14:49 +0530
Subject: [PATCH v6 46/46] Documentation/cpu-hotplug: Remove references to
 stop_machine()
In-Reply-To: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
Message-ID: <20130218124448.26245.60959.stgit@srivatsabhat.in.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since stop_machine() is no longer used in the CPU offline path, we cannot
disable CPU hotplug using preempt_disable()/local_irq_disable() etc. We
need to use the newly introduced get/put_online_cpus_atomic() APIs.
Reflect this in the documentation.

Cc: Rob Landley <rob@landley.net>
Cc: linux-doc at vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---

 Documentation/cpu-hotplug.txt |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/cpu-hotplug.txt b/Documentation/cpu-hotplug.txt
index 9f40135..7f907ec 100644
--- a/Documentation/cpu-hotplug.txt
+++ b/Documentation/cpu-hotplug.txt
@@ -113,13 +113,15 @@ Never use anything other than cpumask_t to represent bitmap of CPUs.
 	#include <linux/cpu.h>
 	get_online_cpus() and put_online_cpus():
 
-The above calls are used to inhibit cpu hotplug operations. While the
+The above calls are used to inhibit cpu hotplug operations, when invoked from
+non-atomic context (because the above functions can sleep). While the
 cpu_hotplug.refcount is non zero, the cpu_online_mask will not change.
-If you merely need to avoid cpus going away, you could also use
-preempt_disable() and preempt_enable() for those sections.
-Just remember the critical section cannot call any
-function that can sleep or schedule this process away. The preempt_disable()
-will work as long as stop_machine_run() is used to take a cpu down.
+
+However, if you are executing in atomic context (ie., you can't afford to
+sleep), and you merely need to avoid cpus going offline, you can use
+get_online_cpus_atomic() and put_online_cpus_atomic() for those sections.
+Just remember the critical section cannot call any function that can sleep or
+schedule this process away.
 
 CPU Hotplug - Frequently Asked Questions.
 
@@ -360,6 +362,9 @@ A: There are two ways.  If your code can be run in interrupt context, use
 		return err;
 	}
 
+   If my_func_on_cpu() itself cannot block, use get/put_online_cpus_atomic()
+   instead of get/put_online_cpus() to prevent CPUs from going offline.
+
 Q: How do we determine how many CPUs are available for hotplug.
 A: There is no clear spec defined way from ACPI that can give us that
    information today. Based on some input from Natalie of Unisys,
