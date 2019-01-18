Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B0BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:49:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE62920823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rceKOCrl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE62920823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=KzcFsn1zLvC6H6Yco5qQReHj5e1/NsBdzzbM3C26Y4k=; b=rceKOCrlld2i//tXNR0nmJed6o
	wc/Vev0D/SyI1Nj1sEPl4oGchgU0BWdYt0M7VLihTysAXoXlgY6g+K/pNGxX2rSp17CBX/U+7HUA4
	3fYocvSZor/xM/8I3J2tqTo/1Zuth3UX8OClC7wWA3koXBYpTUpr8F5Hhl0pVgwsnsutqdomMWysl
	BL3Zg7HbxFFgBhIZvN/ITEaeW5FYA9KbRfQ1ZBUehWJxnG0/fbnfDjLInPSgOG63wwIdgsvzWvNf7
	3JLJlbW7iRZ443Dp+TbNpgdDtfbFGHRYFnNInjPIAADOa7Me35HOsl2NdyLn6eYh6PtUDy6r0y64t
	hYA4uRAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXKC-0001cN-Ci; Fri, 18 Jan 2019 16:48:56 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXIB-00089X-51
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:47:04 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCF7C1650;
 Fri, 18 Jan 2019 08:46:50 -0800 (PST)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com
 [10.1.196.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C84F3F7BE;
 Fri, 18 Jan 2019 08:46:48 -0800 (PST)
From: Julien Grall <julien.grall@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 7/8] arm64/sve: Don't disable SVE on syscalls return
Date: Fri, 18 Jan 2019 16:46:09 +0000
Message-Id: <20190118164610.8123-8-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190118164610.8123-1-julien.grall@arm.com>
References: <20190118164610.8123-1-julien.grall@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_084651_895236_1306845A 
X-CRM114-Status: GOOD (  22.76  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: tokamoto@jp.fujitsu.com, Anton.Kirilov@arm.com, catalin.marinas@arm.com,
 will.deacon@arm.com, oleg@redhat.com, Julien Grall <julien.grall@arm.com>,
 alex.bennee@linaro.org, Dave.Martin@arm.com, Daniel.Kiss@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Per the syscalls ABI, SVE registers will be unknown after a syscalls. In
practice the kernel will disable SVE and zero all the registers but the
first 128-bits of the vector on the next SVE instructions. In workload
mixing SVE and syscall, this will result of 2 entry/exit to the kernel
per exit.

To avoid the second entry/exit, a new flag TIF_SVE_NEEDS_FLUSH is
introduced to mark a task that needs to flush the SVE context on
return to userspace.

On entry to a syscall, the flag TIF_SVE will still be cleared. It will
be restored on return to userspace once the SVE state has been flushed.
This means that if a task requires to synchronize the FP state during a
syscall (e.g context switch, signal), only the FPSIMD registers will be
saved. When the task is rescheduled, the SVE state will be loaded from
FPSIMD state.

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 arch/arm64/include/asm/thread_info.h |  5 ++++-
 arch/arm64/kernel/fpsimd.c           | 32 ++++++++++++++++++++++++++++++++
 arch/arm64/kernel/process.c          |  1 +
 arch/arm64/kernel/ptrace.c           |  7 +++++++
 arch/arm64/kernel/signal.c           | 14 +++++++++++++-
 arch/arm64/kernel/syscall.c          | 13 +++++--------
 6 files changed, 62 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index bbca68b54732..78a836d61dc1 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -87,6 +87,7 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define TIF_FOREIGN_FPSTATE	3	/* CPU's FP state is not current's */
 #define TIF_UPROBE		4	/* uprobe breakpoint or singlestep */
 #define TIF_FSCHECK		5	/* Check FS is USER_DS on return */
+#define TIF_SVE_NEEDS_FLUSH	6	/* Flush SVE registers on return */
 #define TIF_NOHZ		7
 #define TIF_SYSCALL_TRACE	8
 #define TIF_SYSCALL_AUDIT	9
@@ -114,10 +115,12 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define _TIF_FSCHECK		(1 << TIF_FSCHECK)
 #define _TIF_32BIT		(1 << TIF_32BIT)
 #define _TIF_SVE		(1 << TIF_SVE)
+#define _TIF_SVE_NEEDS_FLUSH	(1 << TIF_SVE_NEEDS_FLUSH)
 
 #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
 				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
-				 _TIF_UPROBE | _TIF_FSCHECK)
+				 _TIF_UPROBE | _TIF_FSCHECK | \
+				 _TIF_SVE_NEEDS_FLUSH)
 
 #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index b3870905a492..ff76e7cc358d 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -148,6 +148,8 @@ extern void __percpu *efi_sve_state;
  */
 static void __sve_free(struct task_struct *task)
 {
+	/* SVE context will be zeroed when allocated. */
+	clear_tsk_thread_flag(task, TIF_SVE_NEEDS_FLUSH);
 	kfree(task->thread.sve_state);
 	task->thread.sve_state = NULL;
 }
@@ -204,6 +206,11 @@ static void sve_free(struct task_struct *task)
  *  * FPSR and FPCR are always stored in task->thread.uw.fpsimd_state
  *    irrespective of whether TIF_SVE is clear or set, since these are
  *    not vector length dependent.
+ *
+ *  * When TIF_SVE_NEEDS_FLUSH is set, all the SVE registers but the first
+ *    128-bits of the Z-registers are logically zero but not stored anywhere.
+ *    Saving logically zero bits across context switches is therefore
+ *    pointless, although they must be zeroed before re-entering userspace.
  */
 
 /*
@@ -213,6 +220,14 @@ static void sve_free(struct task_struct *task)
  * thread_struct is known to be up to date, when preparing to enter
  * userspace.
  *
+ * When TIF_SVE_NEEDS_FLUSH is set, the SVE state will be restored from the
+ * FPSIMD state.
+ *
+ * TIF_SVE_NEEDS_FLUSH and TIF_SVE set at the same time should never happen.
+ * In the unlikely case it happens, the code is able to cope with it. I will
+ * first restore the SVE registers and then flush them in
+ * fpsimd_restore_current_state.
+ *
  * Softirqs (and preemption) must be disabled.
  */
 static void task_fpsimd_load(void)
@@ -223,6 +238,12 @@ static void task_fpsimd_load(void)
 		sve_load_state(sve_pffr(&current->thread),
 			       &current->thread.uw.fpsimd_state.fpsr,
 			       sve_vq_from_vl(current->thread.sve_vl) - 1);
+	else if (system_supports_sve() &&
+		 test_and_clear_thread_flag(TIF_SVE_NEEDS_FLUSH)) {
+		sve_load_from_fpsimd_state(&current->thread.uw.fpsimd_state,
+					   sve_vq_from_vl(current->thread.sve_vl) - 1);
+		set_thread_flag(TIF_SVE);
+	}
 	else
 		fpsimd_load_state(&current->thread.uw.fpsimd_state);
 }
@@ -1014,6 +1035,17 @@ void fpsimd_restore_current_state(void)
 		fpsimd_bind_task_to_cpu();
 	}
 
+	if (system_supports_sve() &&
+	    test_and_clear_thread_flag(TIF_SVE_NEEDS_FLUSH)) {
+		/*
+		 * The userspace had SVE enabled on entry to the kernel
+		 * and requires the state to be flushed.
+		 */
+		sve_flush_live();
+		sve_user_enable();
+		set_thread_flag(TIF_SVE);
+	}
+
 	local_bh_enable();
 }
 
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index a0f985a6ac50..52e27d18cb8f 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -319,6 +319,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 	 * and disable discard SVE state for p:
 	 */
 	clear_tsk_thread_flag(p, TIF_SVE);
+	clear_tsk_thread_flag(p, TIF_SVE_NEEDS_FLUSH);
 	p->thread.sve_state = NULL;
 
 	/*
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 9dce33b0e260..20099c0604be 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -899,6 +899,11 @@ static int sve_set(struct task_struct *target,
 		ret = __fpr_set(target, regset, pos, count, kbuf, ubuf,
 				SVE_PT_FPSIMD_OFFSET);
 		clear_tsk_thread_flag(target, TIF_SVE);
+		/*
+		 * If ptrace requested to use FPSIMD, then don't try to
+		 * re-enable SVE when the task is running again.
+		 */
+		clear_tsk_thread_flag(target, TIF_SVE_NEEDS_FLUSH);
 		goto out;
 	}
 
@@ -923,6 +928,8 @@ static int sve_set(struct task_struct *target,
 	 */
 	fpsimd_sync_to_sve(target);
 	set_tsk_thread_flag(target, TIF_SVE);
+	/* Don't flush SVE registers on return as ptrace will update them. */
+	clear_tsk_thread_flag(target, TIF_SVE_NEEDS_FLUSH);
 
 	BUILD_BUG_ON(SVE_PT_SVE_OFFSET != sizeof(header));
 	start = SVE_PT_SVE_OFFSET;
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 11e335f489b0..cf70b196fc82 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -535,6 +535,17 @@ static int restore_sigframe(struct pt_regs *regs,
 		} else {
 			err = restore_fpsimd_context(user.fpsimd);
 		}
+
+		/*
+		 * When successfully restoring the:
+		 *	- FPSIMD context, we don't want to re-enable SVE
+		 *	- SVE context, we don't want to override what was
+		 *	restored
+		 */
+		if (err == 0)
+			clear_thread_flag(TIF_SVE_NEEDS_FLUSH);
+
+
 	}
 
 	return err;
@@ -947,7 +958,8 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
 				rseq_handle_notify_resume(NULL, regs);
 			}
 
-			if (thread_flags & _TIF_FOREIGN_FPSTATE)
+			if (thread_flags & (_TIF_FOREIGN_FPSTATE |
+					    _TIF_SVE_NEEDS_FLUSH))
 				fpsimd_restore_current_state();
 		}
 
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 5610ac01c1ec..5ae2100fc5e8 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -111,16 +111,13 @@ static inline void sve_user_discard(void)
 	if (!system_supports_sve())
 		return;
 
-	clear_thread_flag(TIF_SVE);
-
 	/*
-	 * task_fpsimd_load() won't be called to update CPACR_EL1 in
-	 * ret_to_user unless TIF_FOREIGN_FPSTATE is still set, which only
-	 * happens if a context switch or kernel_neon_begin() or context
-	 * modification (sigreturn, ptrace) intervenes.
-	 * So, ensure that CPACR_EL1 is already correct for the fast-path case.
+	 * TIF_SVE is cleared to save the FPSIMD state rather than the SVE
+	 * state on context switch. The bit will be set again while
+	 * restoring/zeroing the registers.
 	 */
-	sve_user_disable();
+	if (test_and_clear_thread_flag(TIF_SVE))
+		set_thread_flag(TIF_SVE_NEEDS_FLUSH);
 }
 
 asmlinkage void el0_svc_handler(struct pt_regs *regs)
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
