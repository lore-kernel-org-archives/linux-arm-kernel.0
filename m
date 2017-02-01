From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed,  1 Feb 2017 21:46:27 +0900
Subject: [PATCH v31 08/12] arm64: kdump: add VMCOREINFO's for user-space tools
In-Reply-To: <20170201124218.5823-1-takahiro.akashi@linaro.org>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
Message-ID: <20170201124630.6016-7-takahiro.akashi@linaro.org>
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
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/machine_kexec.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index c61dd7b7dca0..1fcd5483c1bb 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -17,6 +17,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
+#include <asm/memory.h>
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
 
@@ -280,3 +281,13 @@ void arch_kexec_unprotect_crashkres(void)
 
 	flush_tlb_all();
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
2.11.0
