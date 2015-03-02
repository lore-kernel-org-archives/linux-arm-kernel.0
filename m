From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 2 Mar 2015 22:24:46 +0800
Subject: [RFC PATCH v4 08/34] early kprobes: ARM: add definition for
 vmlinux.lds use.
In-Reply-To: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425306312-3437-9-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch defines MAX_OPTINSN_SIZE, MAX_INSN_SIZE and
KPROBE_OPCODE_SIZE for ARM for vmlinux.lds.S use. These macros are
originally defined in kprobes.h, which are unable to be used in
vmlinux.lds.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/arm/kernel/vmlinux.lds.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index b31aa73..09fcc20 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -45,6 +45,16 @@
 #define ARM_EXIT_DISCARD(x)	x
 #endif
 
+#ifdef CONFIG_EARLY_KPROBES
+# ifdef CONFIG_THUMB2_KERNEL
+#  define MAX_OPTINSN_SIZE 0
+# else
+#  define MAX_OPTINSN_SIZE (optprobe_template_end - optprobe_template_entry)
+# endif
+# define MAX_INSN_SIZE 2
+# define KPROBE_OPCODE_SIZE 4
+#endif
+
 OUTPUT_ARCH(arm)
 ENTRY(stext)
 
-- 
1.8.4
