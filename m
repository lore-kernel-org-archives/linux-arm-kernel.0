From: srivatsa.bhat@linux.vnet.ibm.com (Srivatsa S. Bhat)
Date: Mon, 18 Feb 2013 18:14:43 +0530
Subject: [PATCH v6 45/46] CPU hotplug,
 stop_machine: Decouple CPU hotplug from stop_machine() in Kconfig
In-Reply-To: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
Message-ID: <20130218124443.26245.34919.stgit@srivatsabhat.in.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simply dropping HOTPLUG_CPU from the dependency list of STOP_MACHINE will
lead to the following kconfig issue, reported by Fengguang Wu:

"warning: (HAVE_TEXT_POKE_SMP) selects STOP_MACHINE which has unmet direct
dependencies (SMP && MODULE_UNLOAD)"

So drop HOTPLUG_CPU and add HAVE_TEXT_POKE_SMP to the dependency list of
STOP_MACHINE.

And while at it, also cleanup a comment that refers to CPU hotplug being
dependent on stop_machine().

Cc: David Howells <dhowells@redhat.com>
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Suggested-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---

 include/linux/stop_machine.h |    2 +-
 init/Kconfig                 |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/stop_machine.h b/include/linux/stop_machine.h
index 3b5e910..ce2d3c4 100644
--- a/include/linux/stop_machine.h
+++ b/include/linux/stop_machine.h
@@ -120,7 +120,7 @@ int stop_machine(int (*fn)(void *), void *data, const struct cpumask *cpus);
  * @cpus: the cpus to run the @fn() on (NULL = any online cpu)
  *
  * Description: This is a special version of the above, which assumes cpus
- * won't come or go while it's being called.  Used by hotplug cpu.
+ * won't come or go while it's being called.
  */
 int __stop_machine(int (*fn)(void *), void *data, const struct cpumask *cpus);
 
diff --git a/init/Kconfig b/init/Kconfig
index be8b7f5..f4f79af 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1711,7 +1711,7 @@ config INIT_ALL_POSSIBLE
 config STOP_MACHINE
 	bool
 	default y
-	depends on (SMP && MODULE_UNLOAD) || HOTPLUG_CPU
+	depends on (SMP && (MODULE_UNLOAD || HAVE_TEXT_POKE_SMP))
 	help
 	  Need stop_machine() primitive.
 
