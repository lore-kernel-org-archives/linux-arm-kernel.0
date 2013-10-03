From: tipbot@zytor.com (tip-bot for Kevin Hilman)
Date: Thu, 3 Oct 2013 06:57:44 -0700
Subject: [tip:timers/core] vtime: Add HAVE_VIRT_CPU_ACCOUNTING_GEN Kconfig
Message-ID: <tip-554b0004d0ec4fbd11e08668dfc400f211e8d5c5@git.kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit-ID:  554b0004d0ec4fbd11e08668dfc400f211e8d5c5
Gitweb:     http://git.kernel.org/tip/554b0004d0ec4fbd11e08668dfc400f211e8d5c5
Author:     Kevin Hilman <khilman@linaro.org>
AuthorDate: Mon, 16 Sep 2013 15:28:21 -0700
Committer:  Frederic Weisbecker <fweisbec@gmail.com>
CommitDate: Mon, 30 Sep 2013 15:35:53 +0200

vtime: Add HAVE_VIRT_CPU_ACCOUNTING_GEN Kconfig

With VIRT_CPU_ACCOUNTING_GEN, cputime_t becomes 64-bit. In order
to use that feature, arch code should be audited to ensure there are no
races in concurrent read/write of cputime_t. For example,
reading/writing 64-bit cputime_t on some 32-bit arches may require
multiple accesses for low and high value parts, so proper locking
is needed to protect against concurrent accesses.

Therefore, add CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN which arches can
enable after they've been audited for potential races.

This option is automatically enabled on 64-bit platforms.

Feature requested by Frederic Weisbecker.

Signed-off-by: Kevin Hilman <khilman@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Russell King <rmk@arm.linux.org.uk>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Arm Linux <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
---
 arch/Kconfig        | 12 ++++++++++++
 init/Kconfig        |  1 +
 kernel/time/Kconfig |  1 +
 3 files changed, 14 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index af2cc6e..185f8b0 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -353,6 +353,18 @@ config HAVE_CONTEXT_TRACKING
 config HAVE_VIRT_CPU_ACCOUNTING
 	bool
 
+config HAVE_VIRT_CPU_ACCOUNTING_GEN
+	bool
+	default y if 64BIT
+	help
+	  With VIRT_CPU_ACCOUNTING_GEN, cputime_t becomes 64-bit.
+	  Before enabling this option, arch code must be audited
+	  to ensure there are no races in concurrent read/write of
+	  cputime_t. For example, reading/writing 64-bit cputime_t on
+	  some 32-bit arches may require multiple accesses, so proper
+	  locking is needed to protect against concurrent accesses.
+
+
 config HAVE_IRQ_TIME_ACCOUNTING
 	bool
 	help
diff --git a/init/Kconfig b/init/Kconfig
index 3ecd8a1..68c1a0e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -355,6 +355,7 @@ config VIRT_CPU_ACCOUNTING_NATIVE
 config VIRT_CPU_ACCOUNTING_GEN
 	bool "Full dynticks CPU time accounting"
 	depends on HAVE_CONTEXT_TRACKING && 64BIT
+	depends on HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select VIRT_CPU_ACCOUNTING
 	select CONTEXT_TRACKING
 	help
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 2b62fe8..f148475 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -101,6 +101,7 @@ config NO_HZ_FULL
 	depends on HAVE_CONTEXT_TRACKING
 	# VIRT_CPU_ACCOUNTING_GEN dependency
 	depends on 64BIT
+	depends on HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select NO_HZ_COMMON
 	select RCU_USER_QS
 	select RCU_NOCB_CPU
