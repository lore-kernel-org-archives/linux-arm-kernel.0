From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 2 Mar 2015 22:24:48 +0800
Subject: [RFC PATCH v4 10/34] early kprobes: introduce early kprobes related
 code area.
In-Reply-To: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425306312-3437-11-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Append early kprobe related slots to KPROBES_TEXT. This is arch
independent part. Arch code should define MAX_OPTINSN_SIZE,
KPROBE_OPCODE_SIZE and MAX_INSN_SIZE for it.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 include/asm-generic/vmlinux.lds.h | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index ac78910..7cd1d21 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -424,11 +424,28 @@
 		*(.spinlock.text)					\
 		VMLINUX_SYMBOL(__lock_text_end) = .;
 
+#ifndef CONFIG_EARLY_KPROBES
+# define EARLY_KPROBES_TEXT
+#else
+# define EARLY_KPROBES_TEXT						\
+	. = ALIGN(8);							\
+	VMLINUX_SYMBOL(__early_kprobes_start) = .;			\
+	VMLINUX_SYMBOL(__early_kprobes_code_area_start) = .;		\
+	. = . + MAX_OPTINSN_SIZE * CONFIG_NR_EARLY_KPROBES_SLOTS;	\
+	VMLINUX_SYMBOL(__early_kprobes_code_area_end) = .;		\
+	. = ALIGN(8);							\
+	VMLINUX_SYMBOL(__early_kprobes_insn_slot_start) = .;		\
+	. = . + MAX_INSN_SIZE * KPROBE_OPCODE_SIZE * CONFIG_NR_EARLY_KPROBES_SLOTS;\
+	VMLINUX_SYMBOL(__early_kprobes_insn_slot_end) = .;		\
+	VMLINUX_SYMBOL(__early_kprobes_end) = .;
+#endif
+
 #define KPROBES_TEXT							\
 		ALIGN_FUNCTION();					\
 		VMLINUX_SYMBOL(__kprobes_text_start) = .;		\
 		*(.kprobes.text)					\
-		VMLINUX_SYMBOL(__kprobes_text_end) = .;
+		VMLINUX_SYMBOL(__kprobes_text_end) = .;			\
+		EARLY_KPROBES_TEXT
 
 #define ENTRY_TEXT							\
 		ALIGN_FUNCTION();					\
-- 
1.8.4
