From: dave.long@linaro.org (David Long)
Date: Tue, 15 Oct 2013 17:04:25 -0400
Subject: [PATCH v2 10/13] kprobes: Remove uneeded kernel dependency on struct
 arch_specific_insn
In-Reply-To: <1381871068-27660-1-git-send-email-dave.long@linaro.org>
References: <1381871068-27660-1-git-send-email-dave.long@linaro.org>
Message-ID: <1381871068-27660-11-git-send-email-dave.long@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "David A. Long" <dave.long@linaro.org>

Instead of depending on include/asm/kprobes.h to provide a dummy definition
for struct arch_specific_insn, do so in include/linux/kprobes.h.

Signed-off-by: David A. Long <dave.long@linaro.org>
---
 include/linux/kprobes.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 925eaf2..4b5a74d 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -52,9 +52,6 @@
 
 #else /* CONFIG_KPROBES */
 typedef int kprobe_opcode_t;
-struct arch_specific_insn {
-	int dummy;
-};
 #endif /* CONFIG_KPROBES */
 
 struct kprobe;
@@ -110,7 +107,11 @@ struct kprobe {
 	kprobe_opcode_t opcode;
 
 	/* copy of the original instruction */
+#ifdef CONFIG_KPROBES
 	struct arch_specific_insn ainsn;
+#else
+	int ainsn;
+#endif
 
 	/*
 	 * Indicates various status flags.
-- 
1.8.1.2
