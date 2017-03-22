From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 22 Mar 2017 14:50:33 +0000
Subject: [RFC PATCH v2 03/41] arm64: signal: factor out signal frame record
 allocation
In-Reply-To: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1490194274-30569-4-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Factor out the allocator for signal frame optional records into a
separate function, to ensure consistency and facilitate later
expansion of the signal frame.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/signal.c | 43 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index e2fe34b..411a42d 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -75,6 +75,22 @@ static size_t sigframe_size(struct rt_sigframe_user_layout const *user)
 	return round_up(max(user->size, sizeof(struct rt_sigframe)), 16);
 }
 
+/*
+ * Allocate space for an optional record of <size> bytes in the user
+ * signal frame.  The offset from the signal frame base address to the
+ * allocated block is assigned to *offset.
+ */
+static int sigframe_alloc(struct rt_sigframe_user_layout *user,
+			  unsigned long *offset, size_t size)
+{
+	size_t padded_size = round_up(size, 16);
+
+	*offset = user->size;
+	user->size += padded_size;
+
+	return 0;
+}
+
 static void __user *apply_user_offset(
 	struct rt_sigframe_user_layout const *user, unsigned long offset)
 {
@@ -283,19 +299,32 @@ asmlinkage long sys_rt_sigreturn(struct pt_regs *regs)
 /* Determine the layout of optional records in the signal frame */
 static int setup_sigframe_layout(struct rt_sigframe_user_layout *user)
 {
-	user->fpsimd_offset = user->size;
-	user->size += round_up(sizeof(struct fpsimd_context), 16);
+	int err;
+
+	err = sigframe_alloc(user, &user->fpsimd_offset,
+			     sizeof(struct fpsimd_context));
+	if (err)
+		return err;
 
 	/* fault information, if valid */
 	if (current->thread.fault_code) {
-		user->esr_offset = user->size;
-		user->size += round_up(sizeof(struct esr_context), 16);
+		err = sigframe_alloc(user, &user->esr_offset,
+				     sizeof(struct esr_context));
+		if (err)
+			return err;
 	}
 
-	/* set the "end" magic */
-	user->end_offset = user->size;
+	/*
+	 * Allocate space for the terminator record.
+	 * HACK: here we undo the reservation of space for the end record.
+	 * This bodge should be replaced with a cleaner approach later on.
+	 */
+	user->limit = offsetof(struct rt_sigframe, uc.uc_mcontext.__reserved) +
+		sizeof(user->sigframe->uc.uc_mcontext.__reserved);
 
-	return 0;
+	err = sigframe_alloc(user, &user->end_offset,
+			     sizeof(struct _aarch64_ctx));
+	return err;
 }
 
 
-- 
2.1.4
