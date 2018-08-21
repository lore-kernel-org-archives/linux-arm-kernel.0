From: nhillery@codeaurora.org (Nathan Hillery)
Date: Tue, 21 Aug 2018 17:44:58 -0400
Subject: [RFC,V5,1/4] ACPI: Add support for sentinel-delimited probe tables
In-Reply-To: <1534887901-24734-1-git-send-email-nhillery@codeaurora.org>
References: <1534887901-24734-1-git-send-email-nhillery@codeaurora.org>
Message-ID: <1534887901-24734-2-git-send-email-nhillery@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tables declared with the ACPI_PROBE_TABLE linker macro are typically
traversed by using the start and end symbols created by the linker
script. However, there are some APIs that use sentinel-delimited
tables (e.g. acpi_match_device). To better support these APIs, this
patch adds a section at the end of the probe table. This section can
be used to add a sentinel for tables that require it.

Signed-off-by: Nathan Hillery <nhillery@codeaurora.org>
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
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
