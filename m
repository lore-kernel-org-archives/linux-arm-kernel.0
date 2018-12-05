Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A1CC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:33:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4DC720645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="He2AbyIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4DC720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Subject:To:From
	:Date:Message-Id:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=ZZg7dFClWaiZKKx6A7Pdum+KKzBx/hg1s8dY7Ck+PLY=; b=He2AbyIo0HBlg7
	53oRbdNt8EXg787qW3+vp2zX1RSXz+Mq6cmtdCNPCzjgJq9PRHfJrrbshL+3EkrNdZDUyRI47l1U5
	6yCiqfVoztIYqWMAljD78P1ODJjo9Bqv6OO60kWF0WYX2EdO2qt0+LfbIHOH2CKX0xptLU7y5LL2W
	nnIv5K9YR6kp4ZvOMLZnHSYKDRiVgluTe3ciLMR1Q2T9Om0lK5AxljHJhtE344gKeWdjC8/3/n3Kr
	j3e2gSJ2V/ZajGrXrDIv0Vj59OkEJ510WRlwd/hvbLp9yvCSIOy2aczMQWiP45kaO56P1AGH9s6K0
	0zI8sdX0TL7z5R6myFuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUbzY-0003Ij-9c; Wed, 05 Dec 2018 18:33:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUbz2-0002lP-R7
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 18:33:19 +0000
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com
 [66.24.56.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 00BEA20892;
 Wed,  5 Dec 2018 18:33:06 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
 (envelope-from <rostedt@goodmis.org>)
 id 1gUbyp-0007jB-U9; Wed, 05 Dec 2018 13:33:03 -0500
Message-Id: <20181205183303.828422192@goodmis.org>
User-Agent: quilt/0.65
Date: Wed, 05 Dec 2018 12:48:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ftrace: Allow ftrace_replace_code() to be schedulable
References: <20181205174852.435233070@goodmis.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_103316_928768_1F4D8716 
X-CRM114-Status: GOOD (  14.99  )
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
Cc: Anders Roxell <anders.roxell@linaro.org>, keescook@chromium.org,
 arnd@arndb.de, catalin.marinas@arm.com, will.deacon@arm.com,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The function ftrace_replace_code() is the ftrace engine that does the
work to modify all the nops into the calls to the function callback in
all the functions being traced.

The generic version which is normally called from stop machine, but an
architecture can implement a non stop machine version and still use the
generic ftrace_replace_code(). When an architecture does this,
ftrace_replace_code() may be called from a schedulable context, where
it can allow the code to be preemptible, and schedule out.

In order to allow an architecture to make ftrace_replace_code()
schedulable, a new command flag is added called:

 FTRACE_SCHEDULABLE

Which can be or'd to the command that is passed to
ftrace_modify_all_code() that calls ftrace_replace_code() and will have
it call cond_resched() in the loop that modifies the nops into the
calls to the ftrace trampolines.

Link: http://lkml.kernel.org/r/20181204192903.8193-1-anders.roxell@linaro.org

Reported-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h |  1 +
 kernel/trace/ftrace.c  | 19 ++++++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index dd16e8218db3..c281b16baef9 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -389,6 +389,7 @@ enum {
 	FTRACE_UPDATE_TRACE_FUNC	= (1 << 2),
 	FTRACE_START_FUNC_RET		= (1 << 3),
 	FTRACE_STOP_FUNC_RET		= (1 << 4),
+	FTRACE_SCHEDULABLE		= (1 << 5),
 };
 
 /*
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 77734451cb05..74fdcacba514 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -77,6 +77,11 @@
 #define ASSIGN_OPS_HASH(opsname, val)
 #endif
 
+enum {
+	FTRACE_MODIFY_ENABLE_FL		= (1 << 0),
+	FTRACE_MODIFY_SCHEDULABLE_FL	= (1 << 1),
+};
+
 static struct ftrace_ops ftrace_list_end __read_mostly = {
 	.func		= ftrace_stub,
 	.flags		= FTRACE_OPS_FL_RECURSION_SAFE | FTRACE_OPS_FL_STUB,
@@ -2415,10 +2420,12 @@ __ftrace_replace_code(struct dyn_ftrace *rec, int enable)
 	return -1; /* unknow ftrace bug */
 }
 
-void __weak ftrace_replace_code(int enable)
+void __weak ftrace_replace_code(int mod_flags)
 {
 	struct dyn_ftrace *rec;
 	struct ftrace_page *pg;
+	int enable = mod_flags & FTRACE_MODIFY_ENABLE_FL;
+	int schedulable = mod_flags & FTRACE_MODIFY_SCHEDULABLE_FL;
 	int failed;
 
 	if (unlikely(ftrace_disabled))
@@ -2435,6 +2442,8 @@ void __weak ftrace_replace_code(int enable)
 			/* Stop processing */
 			return;
 		}
+		if (schedulable)
+			cond_resched();
 	} while_for_each_ftrace_rec();
 }
 
@@ -2548,8 +2557,12 @@ int __weak ftrace_arch_code_modify_post_process(void)
 void ftrace_modify_all_code(int command)
 {
 	int update = command & FTRACE_UPDATE_TRACE_FUNC;
+	int mod_flags = 0;
 	int err = 0;
 
+	if (command & FTRACE_SCHEDULABLE)
+		mod_flags = FTRACE_MODIFY_SCHEDULABLE_FL;
+
 	/*
 	 * If the ftrace_caller calls a ftrace_ops func directly,
 	 * we need to make sure that it only traces functions it
@@ -2567,9 +2580,9 @@ void ftrace_modify_all_code(int command)
 	}
 
 	if (command & FTRACE_UPDATE_CALLS)
-		ftrace_replace_code(1);
+		ftrace_replace_code(mod_flags | FTRACE_MODIFY_ENABLE_FL);
 	else if (command & FTRACE_DISABLE_CALLS)
-		ftrace_replace_code(0);
+		ftrace_replace_code(mod_flags);
 
 	if (update && ftrace_trace_function != ftrace_ops_list_func) {
 		function_trace_op = set_function_trace_op;
-- 
2.19.1



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
