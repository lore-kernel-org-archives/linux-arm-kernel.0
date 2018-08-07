From: ykaukab@suse.de (Mian Yousaf Kaukab)
Date: Tue,  7 Aug 2018 20:14:17 +0200
Subject: [PATCH 4/6] arm64: add sysfs vulnerability show for spectre v2
In-Reply-To: <20180807181419.15690-1-ykaukab@suse.de>
References: <20180807181419.15690-1-ykaukab@suse.de>
Message-ID: <20180807181419.15690-5-ykaukab@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only report mitigation present if hardening callback has been
successfully installed.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
---
 arch/arm64/kernel/cpu_errata.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 92616431ae4e..8469d3be7b15 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -481,7 +481,8 @@ multi_entry_cap_cpu_enable(const struct arm64_cpu_capabilities *entry)
 			caps->cpu_enable(caps);
 }
 
-#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+#if defined(CONFIG_HARDEN_BRANCH_PREDICTOR) || \
+	defined(CONFIG_GENERIC_CPU_VULNERABILITIES)
 
 /*
  * List of CPUs where we need to issue a psci call to
@@ -712,4 +713,35 @@ ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
 }
 
+ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	u64 pfr0;
+	struct bp_hardening_data *data;
+
+	pfr0 = read_cpuid(ID_AA64PFR0_EL1);
+	if (cpuid_feature_extract_unsigned_field(pfr0, ID_AA64PFR0_CSV2_SHIFT))
+		return sprintf(buf, "Not affected\n");
+
+	if (cpus_have_const_cap(ARM64_HARDEN_BRANCH_PREDICTOR)) {
+		/*
+		 * Hardware is vulnerable. Lets check if bp hardening callback
+		 * has been successfully installed
+		 */
+		data = arm64_get_bp_hardening_data();
+		if (data && data->fn)
+			return sprintf(buf,
+				"Mitigation: Branch predictor hardening");
+		else
+			/* For example SMCCC_VERSION_1_0 */
+			return sprintf(buf, "Vulnerable\n");
+	}
+
+	/* In case CONFIG_HARDEN_BRANCH_PREDICTOR is not enabled */
+	if (is_midr_in_range_list(read_cpuid_id(), arm64_bp_harden_smccc_cpus))
+		return sprintf(buf, "Vulnerable\n");
+
+	return sprintf(buf, "Not affected\n");
+}
+
 #endif
-- 
2.11.0
