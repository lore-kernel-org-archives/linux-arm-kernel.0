Return-Path: <SRS0=YQjL=OY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3864C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 03:01:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B930C2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 03:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KR1OJlbd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B930C2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uI1STDYJvteZ2WozIdv0nx8uifus835sJrXNu+2H1Os=; b=KR1OJlbdPdiEUI
	hn2JabsvwxKKKrRB/2kD4RNQujDdHtjUGxiLRuU5905HmU90BHksJP39ePd9Qm385preshO7SylX7
	v+0QlAFApjK9RttYLew/2OPK000nINgOs4siRX/NOv5GArJWCu/FMA7Db0HnxCucsp6vdfOfGe2kv
	iQhqH3Y0ayA3nWaSWFD6PyU5xKDGZpjaN7fA3Gho4DrpVGTLG3WP7NQuxZhvwQpYoZIyXC3u1V6Xl
	/ecHrlCUVBmwMe2W5KhDImCejSX06FoLC2DlbuHgOVEiD04KgGvkWaPHDR8x2wyOs92mjWH6YMnGc
	cN8RAApA9QE8c9zDL28Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gY0CV-0001gG-ND; Sat, 15 Dec 2018 03:01:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gY0CS-0001f6-Oy
 for linux-arm-kernel@lists.infradead.org; Sat, 15 Dec 2018 03:01:10 +0000
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com
 [66.24.56.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BB3AD2086D;
 Sat, 15 Dec 2018 03:00:56 +0000 (UTC)
Date: Fri, 14 Dec 2018 22:00:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH 6/6] arm64: Use ftrace_graph_get_ret_stack() instead of
 curr_ret_stack
Message-ID: <20181214220054.101f9e4c@vmware.local.home>
In-Reply-To: <f0613902-80ac-5865-26ee-f0aac4d3b906@arm.com>
References: <20181210193007.655970639@goodmis.org>
 <20181210193335.417173167@goodmis.org>
 <f0613902-80ac-5865-26ee-f0aac4d3b906@arm.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_190108_833050_B79DAB6E 
X-CRM114-Status: GOOD (  12.01  )
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
Cc: linux-arch@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 13 Dec 2018 17:09:35 +0000
James Morse <james.morse@arm.com> wrote:

> Hi Steven,
> 

> I gave this branch a spin, but I hit the WARN_ON() fairly easily:

Thanks for testing!

Can you see if this patch fixes it for you?

-- Steve

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index d4f04f0ca646..8dfd5021b933 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -246,10 +246,10 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 struct ftrace_ret_stack *
 ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
 {
-	idx = current->curr_ret_stack - idx;
+	idx = task->curr_ret_stack - idx;
 
 	if (idx >= 0 && idx <= task->curr_ret_stack)
-		return &current->ret_stack[idx];
+		return &task->ret_stack[idx];
 
 	return NULL;
 }


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
