From: agustinv@codeaurora.org (Agustin Vega-Frias)
Date: Thu,  5 Jul 2018 16:23:18 -0400
Subject: [RFC V4 1/4] ACPI: add support for sentinel-delimited probe tables
In-Reply-To: <1530822201-5890-1-git-send-email-agustinv@codeaurora.org>
References: <1530822201-5890-1-git-send-email-agustinv@codeaurora.org>
Message-ID: <1530822201-5890-2-git-send-email-agustinv@codeaurora.org>
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
index e373e2e..1ec0411 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -228,7 +228,8 @@
 	. = ALIGN(8);							\
 	__##name##_acpi_probe_table = .;				\
 	KEEP(*(__##name##_acpi_probe_table))				\
-	__##name##_acpi_probe_table_end = .;
+	__##name##_acpi_probe_table_end = .;				\
+	KEEP(*(__##name##_acpi_probe_table_end))
 #else
 #define ACPI_PROBE_TABLE(name)
 #endif
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
