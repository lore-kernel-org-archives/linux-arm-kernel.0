From: geoff@infradead.org (Geoff Levand)
Date: Thu, 09 Jun 2016 20:08:45 +0000
Subject: [PATCH v18 10/13] arm64: kdump: add VMCOREINFO for user-space
 coredump tools
In-Reply-To: <cover.1465502767.git.geoff@infradead.org>
References: <cover.1465502767.git.geoff@infradead.org>
Message-ID: <c6b63471f98726a04fd740a27640212490d4efa0.1465502767.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

For the current crash utility, we need to know, at least, a value of
"kimage_voffset" to handle the contents of core dump file (/proc/vmcore)
correctly due to the introduction of KASLR (CONFIG_RANDOMIZE_BASE) in v4.6.

More VMCOREINFO may be added later for makedumpfile command.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/machine_kexec.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 93588b2..91b0f8c 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -22,6 +22,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
+#include <asm/memory.h>
 #include <asm/mmu_context.h>
 #include <asm/system_misc.h>
 
@@ -296,3 +297,10 @@ void machine_crash_shutdown(struct pt_regs *regs)
 
 	pr_info("Starting crashdump kernel...\n");
 }
+
+void arch_crash_save_vmcoreinfo(void)
+{
+	/* Please note VMCOREINFO_NUMBER() uses "%d", not "%x" */
+	vmcoreinfo_append_str("NUMBER(kimage_voffset)=0x%llx\n",
+						kimage_voffset);
+}
-- 
2.5.0
