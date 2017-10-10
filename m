From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 10 Oct 2017 19:38:32 +0100
Subject: [PATCH v3 15/28] arm64: cpufeature: Move sys_caps_initialised
 declarations
In-Reply-To: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
References: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1507660725-7986-16-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

update_cpu_features() currently cannot tell whether it is being
called during early or late secondary boot.  This doesn't
desperately matter for anything it currently does.

However, SVE will need to know here whether the set of available
vector lengths is fixed of still to be determined when booting a
CPU so that it can be updated appropriately.

This patch simply moves the sys_caps_initialised stuff to the top
of the file so that it can be more widely.  There doesn't seem to
be a more obvious place to put it.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 21e2c95..92a9502 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -51,6 +51,21 @@ unsigned int compat_elf_hwcap2 __read_mostly;
 DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 EXPORT_SYMBOL(cpu_hwcaps);
 
+/*
+ * Flag to indicate if we have computed the system wide
+ * capabilities based on the boot time active CPUs. This
+ * will be used to determine if a new booting CPU should
+ * go through the verification process to make sure that it
+ * supports the system capabilities, without using a hotplug
+ * notifier.
+ */
+static bool sys_caps_initialised;
+
+static inline void set_sys_caps_initialised(void)
+{
+	sys_caps_initialised = true;
+}
+
 static int dump_cpu_hwcaps(struct notifier_block *self, unsigned long v, void *p)
 {
 	/* file-wide pr_fmt adds "CPU features: " prefix */
@@ -1041,21 +1056,6 @@ void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
 }
 
 /*
- * Flag to indicate if we have computed the system wide
- * capabilities based on the boot time active CPUs. This
- * will be used to determine if a new booting CPU should
- * go through the verification process to make sure that it
- * supports the system capabilities, without using a hotplug
- * notifier.
- */
-static bool sys_caps_initialised;
-
-static inline void set_sys_caps_initialised(void)
-{
-	sys_caps_initialised = true;
-}
-
-/*
  * Check for CPU features that are used in early boot
  * based on the Boot CPU value.
  */
-- 
2.1.4
