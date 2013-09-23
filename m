From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 23 Sep 2013 19:17:56 -0400
Subject: [PATCH 13/13] ARM: bL_switcher: Add query interface to discover CPU
 affinities
In-Reply-To: <1379978276-31241-1-git-send-email-nicolas.pitre@linaro.org>
References: <1379978276-31241-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1379978276-31241-14-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Martin <dave.martin@linaro.org>

When the switcher is active, there is no straightforward way to
figure out which logical CPU a given physical CPU maps to.

This patch provides a function
bL_switcher_get_logical_index(mpidr), which is analogous to
get_logical_index().

This function returns the logical CPU on which the specified
physical CPU is grouped (or -EINVAL if unknown).
If the switcher is inactive or not present, -EUNATCH is returned instead.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/common/bL_switcher.c      | 20 ++++++++++++++++++++
 arch/arm/include/asm/bL_switcher.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
index f4878a3604..63bbc4f705 100644
--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -532,6 +532,26 @@ static int bL_switcher_halve_cpus(void)
 	return 0;
 }
 
+/* Determine the logical CPU a given physical CPU is grouped on. */
+int bL_switcher_get_logical_index(u32 mpidr)
+{
+	int cpu;
+
+	if (!bL_switcher_active)
+		return -EUNATCH;
+
+	mpidr &= MPIDR_HWID_BITMASK;
+	for_each_online_cpu(cpu) {
+		int pairing = bL_switcher_cpu_pairing[cpu];
+		if (pairing == -1)
+			continue;
+		if ((mpidr == cpu_logical_map(cpu)) ||
+		    (mpidr == cpu_logical_map(pairing)))
+			return cpu;
+	}
+	return -EINVAL;
+}
+
 static void bL_switcher_trace_trigger_cpu(void *__always_unused info)
 {
 	trace_cpu_migrate_current(get_ns(), read_mpidr());
diff --git a/arch/arm/include/asm/bL_switcher.h b/arch/arm/include/asm/bL_switcher.h
index 8ada5a885c..1714800fa1 100644
--- a/arch/arm/include/asm/bL_switcher.h
+++ b/arch/arm/include/asm/bL_switcher.h
@@ -55,6 +55,7 @@ bool bL_switcher_get_enabled(void);
 void bL_switcher_put_enabled(void);
 
 int bL_switcher_trace_trigger(void);
+int bL_switcher_get_logical_index(u32 mpidr);
 
 #else
 static inline int bL_switcher_register_notifier(struct notifier_block *nb)
@@ -70,6 +71,7 @@ static inline int bL_switcher_unregister_notifier(struct notifier_block *nb)
 static inline bool bL_switcher_get_enabled(void) { return false; }
 static inline void bL_switcher_put_enabled(void) { }
 static inline int bL_switcher_trace_trigger(void) { return 0; }
+static inline int bL_switcher_get_logical_index(u32 mpidr) { return -EUNATCH; }
 #endif /* CONFIG_BL_SWITCHER */
 
 #endif
-- 
1.8.4.98.gb022869
