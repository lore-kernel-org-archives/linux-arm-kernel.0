Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F589C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:48:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D362C20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CUc9Uosk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D362C20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=kcC7ZgYPHJJt7/whp8Cx+WWtIj77rVhJvH8LFgUmccI=; b=CUc9UoskEv9HtCt0qMxX4Ur8h6
	7DSfeYIz5zdbmUGnnbiyIJVw10isLviFO6M97+rlLAHdN1yiaSBXxdAS2fShQaInOFtalwVE1sAnE
	5LHRIOErmtlRACIg1YHwsnoUNjNzj0Nw1DZeZnYNALAMh9QW/ozuqcUWChj6bVzKuYuqxovXoMbjB
	NEJgksWC23CDN5GoJwsDLivLid/SY+JvvKnGSlJkdIACUKNv6h3bSxlTJjp8wEBNqA9/S64OHuxq3
	/QtS1d22dEwL4e7c8xHpm3xfpPUKQ770ex+T6NQfJ7wlFXfxCKIX2hjYzS4BDuzI9WCZnGaQFhSg2
	kFVoq6iw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXJw-0001Mv-0r; Fri, 18 Jan 2019 16:48:40 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXID-0008BZ-7i
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:47:03 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7E00168F;
 Fri, 18 Jan 2019 08:46:52 -0800 (PST)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com
 [10.1.196.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2762F3F7BE;
 Fri, 18 Jan 2019 08:46:51 -0800 (PST)
From: Julien Grall <julien.grall@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 8/8] arm64/sve: Rework SVE trap access to use
 TIF_SVE_NEEDS_FLUSH
Date: Fri, 18 Jan 2019 16:46:10 +0000
Message-Id: <20190118164610.8123-9-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190118164610.8123-1-julien.grall@arm.com>
References: <20190118164610.8123-1-julien.grall@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_084653_902306_155A55EC 
X-CRM114-Status: GOOD (  18.94  )
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

SVE state will be flushed on the first SVE access trap. At the moment,
the SVE state will be generated from the FPSIMD state in software and
then loaded in memory.

It is possible to use the newly introduce flag TIF_SVE_NEEDS_FLUSH to
avoid a lot of memory access.

If the FPSIMD state is in memory, the SVE state will be loaded on return
to userspace from the FPSIMD state.

If the FPSIMD state is loaded, then we need to the vector-length before
relying on return to userspace to flush the SVE registers. This is
because the vector-length is only set when loading from memory.

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 arch/arm64/include/asm/fpsimd.h  |  2 ++
 arch/arm64/kernel/entry-fpsimd.S |  5 +++++
 arch/arm64/kernel/fpsimd.c       | 30 ++++++++++++++++++------------
 3 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 859c2c108f92..8a53c46adfa3 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -87,6 +87,8 @@ extern void sve_load_from_fpsimd_state(struct user_fpsimd_state const *state,
 
 extern unsigned int sve_get_vl(void);
 
+extern void sve_set_vq(unsigned long vq_minus_1);
+
 struct arm64_cpu_capabilities;
 extern void sve_kernel_enable(const struct arm64_cpu_capabilities *__unused);
 
diff --git a/arch/arm64/kernel/entry-fpsimd.S b/arch/arm64/kernel/entry-fpsimd.S
index 35c21a707730..e3ec566d7335 100644
--- a/arch/arm64/kernel/entry-fpsimd.S
+++ b/arch/arm64/kernel/entry-fpsimd.S
@@ -58,6 +58,11 @@ ENTRY(sve_get_vl)
 	ret
 ENDPROC(sve_get_vl)
 
+ENTRY(sve_set_vq)
+	sve_load_vq x0, x1, x2
+	ret
+ENDPROC(sve_set_vq)
+
 /*
  * Load SVE state from FPSIMD state.
  *
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index ff76e7cc358d..d6a61828ccd6 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -815,10 +815,8 @@ void fpsimd_release_task(struct task_struct *dead_task)
 /*
  * Trapped SVE access
  *
- * Storage is allocated for the full SVE state, the current FPSIMD
- * register contents are migrated across, and TIF_SVE is set so that
- * the SVE access trap will be disabled the next time this task
- * reaches ret_to_user.
+ * Storage is allocated for the full SVE state and rely on the return
+ * code to actually convert the FPSIMD state to SVE state.
  *
  * TIF_SVE should be clear on entry: otherwise, fpsimd_restore_current_state()
  * would have disabled the SVE access trap for userspace during
@@ -836,15 +834,20 @@ asmlinkage void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 
 	local_bh_disable();
 
-	fpsimd_save();
-	fpsimd_to_sve(current);
-
-	/* Force ret_to_user to reload the registers: */
-	fpsimd_flush_task_state(current);
-	set_thread_flag(TIF_FOREIGN_FPSTATE);
+	set_thread_flag(TIF_SVE_NEEDS_FLUSH);
+	/*
+	 * We should not be here with SVE enabled. TIF_SVE will be set
+	 * before returning to userspace by fpsimd_restore_current_state().
+	 */
+	WARN_ON(test_thread_flag(TIF_SVE));
 
-	if (test_and_set_thread_flag(TIF_SVE))
-		WARN_ON(1); /* SVE access shouldn't have trapped */
+	/*
+	 * The return path (see fpsimd_restore_current_state) requires the
+	 * Vector-Length to be loaded beforehand when the FPSIMD state is
+	 * loaded.
+	 */
+	if (!test_thread_flag(TIF_FOREIGN_FPSTATE))
+		sve_set_vq(sve_vq_from_vl(current->thread.sve_vl) - 1);
 
 	local_bh_enable();
 }
@@ -1040,6 +1043,9 @@ void fpsimd_restore_current_state(void)
 		/*
 		 * The userspace had SVE enabled on entry to the kernel
 		 * and requires the state to be flushed.
+		 *
+		 * We rely on the Vector-Length to be set correctly before-hand
+		 * when converting a loaded FPSIMD state to SVE state.
 		 */
 		sve_flush_live();
 		sve_user_enable();
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
