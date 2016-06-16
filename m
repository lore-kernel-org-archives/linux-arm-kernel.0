From: geoff@infradead.org (Geoff Levand)
Date: Thu, 16 Jun 2016 23:48:28 +0000
Subject: [PATCH v19 10/13] arm64: kdump: add VMCOREINFO's for user-space
 coredump tools
In-Reply-To: <cover.1466120418.git.geoff@infradead.org>
References: <cover.1466120418.git.geoff@infradead.org>
Message-ID: <6e96110e85e7b1167043d789e85f9c916fdf281a.1466120418.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

For the current crash utility, we need to know, at least,
  - kimage_voffset
  - PHYS_OFFSET
to handle the contents of core dump file (/proc/vmcore) correctly due to
the introduction of KASLR (CONFIG_RANDOMIZE_BASE) in v4.6.
This patch puts them as VMCOREINFO's into the file.

  - VA_BITS
is also added for makedumpfile command.
More VMCOREINFO's may be added later.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/machine_kexec.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index f270967..57a30fb 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -18,6 +18,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
+#include <asm/memory.h>
 #include <asm/mmu_context.h>
 
 #include "cpu-reset.h"
@@ -278,3 +279,13 @@ void machine_crash_shutdown(struct pt_regs *regs)
 
 	pr_info("Starting crashdump kernel...\n");
 }
+
+void arch_crash_save_vmcoreinfo(void)
+{
+	VMCOREINFO_NUMBER(VA_BITS);
+	/* Please note VMCOREINFO_NUMBER() uses "%d", not "%x" */
+	vmcoreinfo_append_str("NUMBER(kimage_voffset)=0x%llx\n",
+						kimage_voffset);
+	vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",
+						PHYS_OFFSET);
+}
-- 
2.5.0
