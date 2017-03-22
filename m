From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 22 Mar 2017 14:50:34 +0000
Subject: [RFC PATCH v2 04/41] arm64: signal: Allocate extra sigcontext space
 as needed
In-Reply-To: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1490194274-30569-5-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies the context block allocator to create an
extra_context expansion block as necessary, and adds the necessary
code to populate, parse and decode this block.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/uapi/asm/sigcontext.h |  27 ++++++++
 arch/arm64/kernel/signal.c               | 112 +++++++++++++++++++++++++------
 2 files changed, 120 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
index ee469be..1af8437 100644
--- a/arch/arm64/include/uapi/asm/sigcontext.h
+++ b/arch/arm64/include/uapi/asm/sigcontext.h
@@ -61,4 +61,31 @@ struct esr_context {
 	__u64 esr;
 };
 
+/*
+ * Pointer to extra space for additional structures that don't fit in
+ * sigcontext.__reserved[].  Note:
+ *
+ * 1) fpsimd_context, esr_context and extra_context must be placed in
+ * sigcontext.__reserved[] if present.  They cannot be placed in the
+ * extra space.  Any other record can be placed either in the extra
+ * space or in sigcontext.__reserved[].
+ *
+ * 2) There must not be more than one extra_context.
+ *
+ * 3) If extra_context is present, it must be followed immediately in
+ * sigcontext.__reserved[] by the terminating null _aarch64_ctx (i.e.,
+ * extra_context must be the last record in sigcontext.__reserved[]
+ * except for the terminator).
+ *
+ * 4) The extra space must itself be terminated with a null
+ * _aarch64_ctx.
+ */
+#define EXTRA_MAGIC	0x45585401
+
+struct extra_context {
+	struct _aarch64_ctx head;
+	void *data;	/* 16-byte aligned pointer to the extra space */
+	__u32 size;	/* size in bytes of the extra space */
+};
+
 #endif /* _UAPI__ASM_SIGCONTEXT_H */
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 411a42d..223bd52 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -25,6 +25,7 @@
 #include <linux/freezer.h>
 #include <linux/stddef.h>
 #include <linux/uaccess.h>
+#include <linux/sizes.h>
 #include <linux/string.h>
 #include <linux/tracehook.h>
 #include <linux/ratelimit.h>
@@ -56,18 +57,22 @@ struct rt_sigframe_user_layout {
 
 	unsigned long fpsimd_offset;
 	unsigned long esr_offset;
+	unsigned long extra_offset;
 	unsigned long end_offset;
 };
 
 static void init_user_layout(struct rt_sigframe_user_layout *user)
 {
+	const size_t __reserved_size =
+		sizeof(user->sigframe->uc.uc_mcontext.__reserved);
+	const size_t terminator_size =
+		round_up(sizeof(struct _aarch64_ctx), 16);
+
 	memset(user, 0, sizeof(*user));
 	user->size = offsetof(struct rt_sigframe, uc.uc_mcontext.__reserved);
-
-	user->limit = user->size +
-		sizeof(user->sigframe->uc.uc_mcontext.__reserved) -
-		round_up(sizeof(struct _aarch64_ctx), 16);
-		/* ^ reserve space for terminator */
+	user->limit = user->size + (__reserved_size - terminator_size -
+				    sizeof(struct extra_context));
+	/* Reserve space for extension and terminator ^ */
 }
 
 static size_t sigframe_size(struct rt_sigframe_user_layout const *user)
@@ -75,6 +80,49 @@ static size_t sigframe_size(struct rt_sigframe_user_layout const *user)
 	return round_up(max(user->size, sizeof(struct rt_sigframe)), 16);
 }
 
+/* Sanity limit on the maximum size of signal frame we'll try to generate. */
+/* This is NOT ABI. */
+#define SIGFRAME_MAXSZ SZ_64K
+
+static int __sigframe_alloc(struct rt_sigframe_user_layout *user,
+			    unsigned long *offset, size_t size, bool extend)
+{
+	size_t padded_size = round_up(size, 16);
+
+	if (padded_size > user->limit - user->size &&
+	    !user->extra_offset &&
+	    extend) {
+		int ret;
+
+		ret = __sigframe_alloc(user, &user->extra_offset,
+				       sizeof(struct extra_context), false);
+		if (ret)
+			return ret;
+
+		/*
+		 * Further allocations must go after the fixed-size
+		 * part of the signal frame:
+		 */
+		user->size = round_up(sizeof(struct rt_sigframe), 16);
+
+		/*
+		 * Allow expansion up to SIGFRAME_MAXSZ, ensuring space for
+		 * the terminator:
+		 */
+		user->limit = SIGFRAME_MAXSZ -
+			round_up(sizeof(struct _aarch64_ctx), 16);
+	}
+
+	/* Still not enough space?  Bad luck! */
+	if (padded_size > user->limit - user->size)
+		return -ENOMEM;
+
+	*offset = user->size;
+	user->size += padded_size;
+
+	return 0;
+}
+
 /*
  * Allocate space for an optional record of <size> bytes in the user
  * signal frame.  The offset from the signal frame base address to the
@@ -83,11 +131,26 @@ static size_t sigframe_size(struct rt_sigframe_user_layout const *user)
 static int sigframe_alloc(struct rt_sigframe_user_layout *user,
 			  unsigned long *offset, size_t size)
 {
-	size_t padded_size = round_up(size, 16);
+	return __sigframe_alloc(user, offset, size, true);
+}
 
-	*offset = user->size;
-	user->size += padded_size;
+/* Allocate the null terminator record and prevent further allocations */
+static int sigframe_alloc_end(struct rt_sigframe_user_layout *user)
+{
+	int ret;
+	const size_t terminator_size =
+		round_up(sizeof(struct _aarch64_ctx), 16);
+
+	/* Un-reserve the space reserved for the terminator: */
+	user->limit += terminator_size;
+
+	ret = sigframe_alloc(user, &user->end_offset,
+			     sizeof(struct _aarch64_ctx));
+	if (ret)
+		return ret;
 
+	/* Prevent further allocation: */
+	user->limit = user->size;
 	return 0;
 }
 
@@ -314,17 +377,7 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user)
 			return err;
 	}
 
-	/*
-	 * Allocate space for the terminator record.
-	 * HACK: here we undo the reservation of space for the end record.
-	 * This bodge should be replaced with a cleaner approach later on.
-	 */
-	user->limit = offsetof(struct rt_sigframe, uc.uc_mcontext.__reserved) +
-		sizeof(user->sigframe->uc.uc_mcontext.__reserved);
-
-	err = sigframe_alloc(user, &user->end_offset,
-			     sizeof(struct _aarch64_ctx));
-	return err;
+	return sigframe_alloc_end(user);
 }
 
 
@@ -365,6 +418,27 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
 		__put_user_error(current->thread.fault_code, &esr_ctx->esr, err);
 	}
 
+	if (err == 0 && user->extra_offset) {
+		struct extra_context __user *extra =
+			apply_user_offset(user, user->extra_offset);
+		struct _aarch64_ctx __user *end =
+			(struct _aarch64_ctx __user *)((char __user *)extra +
+				round_up(sizeof(*extra), 16));
+		void __user *extra_data = apply_user_offset(user,
+			round_up(sizeof(struct rt_sigframe), 16));
+		u32 extra_size = round_up(user->size, 16) -
+			round_up(sizeof(struct rt_sigframe), 16);
+
+		__put_user_error(EXTRA_MAGIC, &extra->head.magic, err);
+		__put_user_error(sizeof(*extra), &extra->head.size, err);
+		__put_user_error(extra_data, &extra->data, err);
+		__put_user_error(extra_size, &extra->size, err);
+
+		/* Add the terminator */
+		__put_user_error(0, &end->magic, err);
+		__put_user_error(0, &end->size, err);
+	}
+
 	/* set the "end" magic */
 	if (err == 0) {
 		struct _aarch64_ctx __user *end =
-- 
2.1.4
