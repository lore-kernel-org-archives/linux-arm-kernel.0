Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4022EC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:33:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E60DE20645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RodvOIxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E60DE20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Subject:To:From
	:Date:Message-Id:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=YxwFjllBsiwXunUyl0jeCLoPOUAtbJjbnh74jNyWY6Y=; b=RodvOIxmY7rXd7
	d6apIRyGLSVY9KWWmVPtoYtOLm9ZW86LD3Jwbw+zW3UQz75OQv0Y3hHjeRcRNUOI9Ey3m60pZ8kt2
	1yaxEsCpqqqPl5nVR9XOgBkAq862yuCqxEti+KxcpmnXll491p0nf/XS0Hl57ePB0E3gjAXXy+Y50
	wWXnZsqQHmDF0ev8pIhUmRv57XlE6w25YESH99R8xEavTOBQFD15XsjhbxWWGgJB+AHpyTpHReeC/
	25WEpV4xdXQ26y3HmyjAD2wUofovzA2W5bS11hZBZKvL9k2PVALliK14P1RqZgbV5L+V0Grg7dVGP
	VMJLA1cP/36nlDrJeGkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUbzE-0002vJ-QK; Wed, 05 Dec 2018 18:33:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUbz2-0002lR-R9
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 18:33:18 +0000
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com
 [66.24.56.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 097012133F;
 Wed,  5 Dec 2018 18:33:06 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
 (envelope-from <rostedt@goodmis.org>)
 id 1gUbyq-0007jt-2u; Wed, 05 Dec 2018 13:33:04 -0500
Message-Id: <20181205183304.000714627@goodmis.org>
User-Agent: quilt/0.65
Date: Wed, 05 Dec 2018 12:48:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: ftrace: Set FTRACE_SCHEDULABLE before
 ftrace_modify_all_code()
References: <20181205174852.435233070@goodmis.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_103316_915207_8343D1C3 
X-CRM114-Status: GOOD (  10.53  )
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

It has been reported that ftrace_replace_code() which is called by
ftrace_modify_all_code() can cause a soft lockup warning for an
allmodconfig kernel. This is because all the debug options enabled
causes the loop in ftrace_replace_code() (which loops over all the
functions being enabled where there can be 10s of thousands), is too
slow, and never schedules out.

To solve this, setting FTRACE_SCHEDULABLE to the command passed into
ftrace_replace_code() will make it call cond_resched() in the loop,
which prevents the soft lockup warning from triggering.

Link: http://lkml.kernel.org/r/20181204192903.8193-1-anders.roxell@linaro.org

Reported-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/arm64/kernel/ftrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 57e962290df3..9a8de0a79f97 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -193,6 +193,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 
 void arch_ftrace_update_code(int command)
 {
+	command |= FTRACE_SCHEDULABLE;
 	ftrace_modify_all_code(command);
 }
 
-- 
2.19.1



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
