From: agustinv@codeaurora.org (Agustin Vega-Frias)
Date: Fri, 22 Jun 2018 15:49:06 -0400
Subject: [RFC V3 1/3] ACPI: add support for sentinel-delimited probe tables
Message-ID: <1529696948-16991-1-git-send-email-agustinv@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tables declared with the ACPI_PROBE_TABLE linker macro are typically
traversed by using the start and end symbols created by the linker
script. However, there are some APIs that use sentinel-delimited
tables (e.g. acpi_match_device). To better support these APIs an
additional section is added at the end of the probe table. This
section can be used to add a sentinel for tables that require it.

Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
---
 include/asm-generic/vmlinux.lds.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index af24057..5894049 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -219,7 +219,8 @@
 	. = ALIGN(8);							\
 	VMLINUX_SYMBOL(__##name##_acpi_probe_table) = .;		\
 	KEEP(*(__##name##_acpi_probe_table))				\
-	VMLINUX_SYMBOL(__##name##_acpi_probe_table_end) = .;
+	VMLINUX_SYMBOL(__##name##_acpi_probe_table_end) = .;		\
+	KEEP(*(__##name##_acpi_probe_table_end))
 #else
 #define ACPI_PROBE_TABLE(name)
 #endif
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
