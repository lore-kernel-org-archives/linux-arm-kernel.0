From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 22 Mar 2017 14:50:35 +0000
Subject: [RFC PATCH v2 05/41] arm64: signal: Parse extra_context during
 sigreturn
In-Reply-To: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1490194274-30569-6-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If extra_context is present, parse it.

To avoid abuse by userspace, this patch attempts to ensure that:
 * that no more than one extra_context is accepted;
 * that the extra_context is a sensible size;
 * that the extra context data is properly aligned.

This patch relies on the user accessors in order to ensure that the
user-supplied extra context data pointer is an honest userspace
address.

Other than that, the kernel doesn't care specially whether the
pointer supplied is sensible (e.g., not garbage, doesn't overlap
sigcontext.__reserved[], etc.) since this cannot harm the kernel.

More checks may be added later in order to aid debugging of
botched sigreturns from userspace.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/signal.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 223bd52..49c30df 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -221,6 +221,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 	char __user *base = (char __user *)&sc->__reserved;
 	size_t offset = 0;
 	size_t limit = sizeof(sc->__reserved);
+	bool have_extra_context = false;
 
 	user->fpsimd = NULL;
 
@@ -230,6 +231,9 @@ static int parse_user_sigframe(struct user_ctxs *user,
 	while (1) {
 		int err = 0;
 		u32 magic, size;
+		struct extra_context const __user *extra;
+		void __user *extra_data;
+		u32 extra_size;
 
 		if (limit - offset < sizeof(*head))
 			goto invalid;
@@ -267,6 +271,42 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			/* ignore */
 			break;
 
+		case EXTRA_MAGIC:
+			if (have_extra_context)
+				goto invalid;
+
+			if (size < sizeof(*extra))
+				goto invalid;
+
+			extra = (struct extra_context const __user *)head;
+			__get_user_error(extra_data, &extra->data, err);
+			__get_user_error(extra_size, &extra->size, err);
+			if (err)
+				return err;
+
+			/* Prevent looping/repeated parsing of extra_conext */
+			have_extra_context = true;
+
+			/*
+			 * Rely on the __user accessors to reject bogus
+			 * pointers.
+			 */
+			base = extra_data;
+			if (!IS_ALIGNED((unsigned long)base, 16))
+				goto invalid;
+
+			/* Reject "unreasonably large" frames: */
+			limit = extra_size;
+			if (limit > SIGFRAME_MAXSZ - sizeof(sc->__reserved))
+				goto invalid;
+
+			/*
+			 * Ignore trailing terminator in __reserved[]
+			 * and start parsing extra_data:
+			 */
+			offset = 0;
+			continue;
+
 		default:
 			goto invalid;
 		}
-- 
2.1.4
