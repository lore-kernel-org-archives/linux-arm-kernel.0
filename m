From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 30 Aug 2016 15:53:07 +0900
Subject: [PATCH v25] 6/9] arm64: kdump: add VMCOREINFO's for user-space
 coredump tools
In-Reply-To: <20160830064941.19452-2-takahiro.akashi@linaro.org>
References: <20160830064941.19452-2-takahiro.akashi@linaro.org>
Message-ID: <20160830065309.19604-4-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
index 8ac9dba8..38b4411 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -17,6 +17,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
+#include <asm/memory.h>
 #include <asm/mmu_context.h>
 
 #include "cpu-reset.h"
@@ -260,3 +261,13 @@ void machine_crash_shutdown(struct pt_regs *regs)
 
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
2.9.0
