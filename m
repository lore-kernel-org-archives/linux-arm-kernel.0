From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 24 Nov 2016 18:58:06 +0900
Subject: [PATCH v28 5/9] arm64: kdump: add VMCOREINFO's for user-space tools
In-Reply-To: <20161124095523.6972-1-takahiro.akashi@linaro.org>
References: <20161124095523.6972-1-takahiro.akashi@linaro.org>
Message-ID: <20161124095809.7092-4-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In addition to common VMCOREINFO's defined in
crash_save_vmcoreinfo_init(), we need to know, for crash utility,
  - kimage_voffset
  - PHYS_OFFSET
to examine the contents of a dump file (/proc/vmcore) correctly
due to the introduction of KASLR (CONFIG_RANDOMIZE_BASE) in v4.6.

  - VA_BITS
is also required for makedumpfile command.

arch_crash_save_vmcoreinfo() appends them to the dump file.
More VMCOREINFO's may be added later.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: James Morse <james.morse@arm.com>
---
 arch/arm64/kernel/machine_kexec.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index c60346d..994fe0b 100644
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
2.10.0
