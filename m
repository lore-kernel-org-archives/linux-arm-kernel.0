From: ykaukab@suse.de (Mian Yousaf Kaukab)
Date: Tue,  7 Aug 2018 20:14:18 +0200
Subject: [PATCH 5/6] arm64: add sysfs vulnerability show for speculative store
 bypass
In-Reply-To: <20180807181419.15690-1-ykaukab@suse.de>
References: <20180807181419.15690-1-ykaukab@suse.de>
Message-ID: <20180807181419.15690-6-ykaukab@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Return status based no ssbd_state. Return string "Unknown" in case
CONFIG_ARM64_SSBD is disabled or arch workaround2 is not available
in the firmware.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
---
 arch/arm64/kernel/cpu_errata.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 8469d3be7b15..8b60aa30a3fa 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -744,4 +744,24 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "Not affected\n");
 }
 
+ssize_t cpu_show_spec_store_bypass(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	switch (arm64_get_ssbd_state()) {
+	case ARM64_SSBD_MITIGATED:
+		return sprintf(buf, "Not affected\n");
+
+	case ARM64_SSBD_KERNEL:
+	case ARM64_SSBD_FORCE_ENABLE:
+		return sprintf(buf,
+			"Mitigation: Speculative Store Bypass disabled");
+
+	case ARM64_SSBD_FORCE_DISABLE:
+		return sprintf(buf, "Vulnerable\n");
+
+	default: /* ARM64_SSBD_UNKNOWN*/
+		return sprintf(buf, "Unknown\n");
+	}
+}
+
 #endif
-- 
2.11.0
