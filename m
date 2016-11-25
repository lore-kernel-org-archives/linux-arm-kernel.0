From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 25 Nov 2016 19:39:04 +0000
Subject: [RFC PATCH 16/29] arm64/sve: signal: Add SVE state record to
 sigcontext
In-Reply-To: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
References: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1480102762-23647-17-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a record to sigcontext that will contain the SVE
state.

Subsequent patches will implement the actual register dumping.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/uapi/asm/sigcontext.h | 86 ++++++++++++++++++++++++++++++++
 arch/arm64/kernel/signal.c               | 62 +++++++++++++++++++++++
 2 files changed, 148 insertions(+)

diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
index 1af8437..11c915d 100644
--- a/arch/arm64/include/uapi/asm/sigcontext.h
+++ b/arch/arm64/include/uapi/asm/sigcontext.h
@@ -88,4 +88,90 @@ struct extra_context {
 	__u32 size;	/* size in bytes of the extra space */
 };
 
+#define SVE_MAGIC	0x53564501
+
+struct sve_context {
+	struct _aarch64_ctx head;
+	__u16 vl;
+	__u16 __reserved[3];
+};
+
+/*
+ * The SVE architecture leaves space for future expansion of the
+ * vector length beyond its initial architectural limit of 2048 bits
+ * (16 quadwords).
+ */
+#define SVE_VQ_MIN		1
+#define SVE_VQ_MAX		0x200
+
+#define SVE_VL_MIN		(SVE_VQ_MIN * 0x10)
+#define SVE_VL_MAX		(SVE_VQ_MAX * 0x10)
+
+#define SVE_NUM_ZREGS		32
+#define SVE_NUM_PREGS		16
+
+#define sve_vl_valid(vl) \
+	((vl) % 0x10 == 0 && (vl) >= SVE_VL_MIN && (vl) <= SVE_VL_MAX)
+#define sve_vq_from_vl(vl)	((vl) / 0x10)
+
+/*
+ * The total size of meaningful data in the SVE context in bytes,
+ * including the header, is given by SVE_SIG_CONTEXT_SIZE(vq).
+ *
+ * Note: for all these macros, the "vq" argument denotes the SVE
+ * vector length in quadwords (i.e., units of 128 bits).
+ *
+ * The correct way to obtain vq is to use sve_vq_from_vl(vl).  The
+ * result is valid if and only if sve_vl_valid(vl) is true.  This is
+ * guaranteed for a struct sve_context written by the kernel.
+ *
+ *
+ * Additional macros describe the contents and layout of the payload.
+ * For each, SVE_SIG_x_OFFSET(args) is the start offset relative to
+ * the start of struct sve_context, and SVE_SIG_x_SIZE(args) is the
+ * size in bytes:
+ *
+ *	x	type				description
+ *	-	----				-----------
+ *	REGS					the entire SVE context
+ *
+ *	ZREGS	__uint128_t[SVE_NUM_ZREGS][vq]	all Z-registers
+ *	ZREG	__uint128_t[vq]			individual Z-register Zn
+ *
+ *	PREGS	uint16_t[SVE_NUM_PREGS][vq]	all P-registers
+ *	PREG	uint16_t[vq]			individual P-register Pn
+ *
+ *	FFR	uint16_t[vq]			first-fault status register
+ *
+ * Additional data might be appended in the future.
+ */
+
+#define SVE_SIG_ZREG_SIZE(vq)	((__u32)(vq) * 16)
+#define SVE_SIG_PREG_SIZE(vq)	((__u32)(vq) * 2)
+#define SVE_SIG_FFR_SIZE(vq)	SVE_SIG_PREG_SIZE(vq)
+
+#define SVE_SIG_REGS_OFFSET	((sizeof(struct sve_context) + 15) / 16 * 16)
+
+#define SVE_SIG_ZREGS_OFFSET	SVE_SIG_REGS_OFFSET
+#define SVE_SIG_ZREG_OFFSET(vq, n) \
+	(SVE_SIG_ZREGS_OFFSET + SVE_SIG_ZREG_SIZE(vq) * (n))
+#define SVE_SIG_ZREGS_SIZE(vq) \
+	(SVE_SIG_ZREG_OFFSET(vq, SVE_NUM_ZREGS) - SVE_SIG_ZREGS_OFFSET)
+
+#define SVE_SIG_PREGS_OFFSET(vq) \
+	(SVE_SIG_ZREGS_OFFSET + SVE_SIG_ZREGS_SIZE(vq))
+#define SVE_SIG_PREG_OFFSET(vq, n) \
+	(SVE_SIG_PREGS_OFFSET(vq) + SVE_SIG_PREG_SIZE(vq) * (n))
+#define SVE_SIG_PREGS_SIZE(vq) \
+	(SVE_SIG_PREG_OFFSET(vq, SVE_NUM_PREGS) - SVE_SIG_PREGS_OFFSET(vq))
+
+#define SVE_SIG_FFR_OFFSET(vq) \
+	(SVE_SIG_PREGS_OFFSET(vq) + SVE_SIG_PREGS_SIZE(vq))
+
+#define SVE_SIG_REGS_SIZE(vq) \
+	(SVE_SIG_FFR_OFFSET(vq) + SVE_SIG_FFR_SIZE(vq) - SVE_SIG_REGS_OFFSET)
+
+#define SVE_SIG_CONTEXT_SIZE(vq) (SVE_SIG_REGS_OFFSET + SVE_SIG_REGS_SIZE(vq))
+
+
 #endif /* _UAPI__ASM_SIGCONTEXT_H */
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 1e430b4..7418237 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -57,6 +57,7 @@ struct rt_sigframe_user_layout {
 
 	unsigned long fpsimd_offset;
 	unsigned long esr_offset;
+	unsigned long sve_offset;
 	unsigned long extra_offset;
 	unsigned long end_offset;
 };
@@ -209,8 +210,39 @@ static int restore_fpsimd_context(struct fpsimd_context __user *ctx)
 	return err ? -EFAULT : 0;
 }
 
+
+#ifdef CONFIG_ARM64_SVE
+
+static int preserve_sve_context(struct sve_context __user *ctx)
+{
+	int err = 0;
+	u16 reserved[ARRAY_SIZE(ctx->__reserved)];
+	unsigned int vl = sve_get_vl();
+	unsigned int vq = sve_vq_from_vl(vl);
+
+	memset(reserved, 0, sizeof(reserved));
+
+	__put_user_error(SVE_MAGIC, &ctx->head.magic, err);
+	__put_user_error(round_up(SVE_SIG_CONTEXT_SIZE(vq), 16),
+			 &ctx->head.size, err);
+	__put_user_error(vl, &ctx->vl, err);
+	BUILD_BUG_ON(sizeof(ctx->__reserved) != sizeof(reserved));
+	err |= copy_to_user(&ctx->__reserved, reserved, sizeof(reserved));
+
+	return err ? -EFAULT : 0;
+}
+
+#else /* ! CONFIG_ARM64_SVE */
+
+/* Turn any non-optimised out attempt to use this into a link error: */
+extern int preserve_sve_context(void __user *ctx);
+
+#endif /* ! CONFIG_ARM64_SVE */
+
+
 struct user_ctxs {
 	struct fpsimd_context __user *fpsimd;
+	struct sve_context __user *sve;
 };
 
 static int parse_user_sigframe(struct user_ctxs *user,
@@ -224,6 +256,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 	bool have_extra_context = false;
 
 	user->fpsimd = NULL;
+	user->sve = NULL;
 
 	if (!IS_ALIGNED((unsigned long)base, 16))
 		goto invalid;
@@ -271,6 +304,19 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			/* ignore */
 			break;
 
+		case SVE_MAGIC:
+			if (!IS_ENABLED(CONFIG_ARM64_SVE))
+				goto invalid;
+
+			if (user->sve)
+				goto invalid;
+
+			if (size < sizeof(*user->sve))
+				goto invalid;
+
+			user->sve = (struct sve_context __user *)head;
+			break;
+
 		case EXTRA_MAGIC:
 			if (have_extra_context)
 				goto invalid;
@@ -417,6 +463,15 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user)
 			return err;
 	}
 
+	if (IS_ENABLED(CONFIG_ARM64_SVE) && (elf_hwcap & HWCAP_SVE)) {
+		unsigned int vq = sve_vq_from_vl(sve_get_vl());
+
+		err = sigframe_alloc(user, &user->sve_offset,
+				     SVE_SIG_CONTEXT_SIZE(vq));
+		if (err)
+			return err;
+	}
+
 	return sigframe_alloc_end(user);
 }
 
@@ -458,6 +513,13 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
 		__put_user_error(current->thread.fault_code, &esr_ctx->esr, err);
 	}
 
+	/* Scalable Vector Extension state, if present */
+	if (IS_ENABLED(CONFIG_ARM64_SVE) && err == 0 && user->sve_offset) {
+		struct sve_context __user *sve_ctx =
+			apply_user_offset(user, user->sve_offset);
+		err |= preserve_sve_context(sve_ctx);
+	}
+
 	if (err == 0 && user->extra_offset) {
 		struct extra_context __user *extra =
 			apply_user_offset(user, user->extra_offset);
-- 
2.1.4
