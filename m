Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7178FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:42:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DFD120675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ga+hUlqL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R78kjiVv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DFD120675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+wcReuDWDn/2mpbbzmd4P58IVVd67QHcl3VKMr3vkac=; b=ga+hUlqLq8m77J
	RxjebRV9Uvr1T3IZzbk6QiWJVM7EEJdPeLS7df+/7fUq1ln4IdseXO8SGgxvD//2aYWiw01R0XvxY
	AwKp95yaYRVLunHXypVl7t/pimxs5hhwN7Q/eOjofcwod72mnFIYv9rxDNiv8nGGLvfSemcy8JEBD
	09d+FMzE14K8ErF/jha6pDRIlmCb9aMCQtqaqGkP1XCDBeIab3pihqqN1Kd+/UMQruLlRgyXYh/aI
	tA0RDxHkpCUbFkQiRePjmmdQt+jjbEdQUNvomBYXetsWLItG62kHpbXes++2WM4wWkzv/BgzACJlI
	GYTTNOmMo8kwDU4bV8SQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYmbc-0002nD-45; Mon, 17 Dec 2018 06:42:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYmbZ-0002jK-B5
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 06:42:18 +0000
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp
 [210.141.244.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DC63320675;
 Mon, 17 Dec 2018 06:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545028927;
 bh=QM7XOsAU0i1KQFQo/n6k/OXJ89dL3NSEi3PjGHYFhXQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=R78kjiVvc77VsubODTNB185MrmewUu7OIUJ/TRBZIQbH4rKuixQLTrMi97hRKryph
 9FYcX/d7ivZ4tIchQjqNSJKbtEK986h3ON2A0u+nyUqbMycAZEAjvdC8X+5jMvrpMr
 FbacDQ9/ysMneVNvKeyBfiuQxkaSN8RCvsLIcPiU=
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH 3/3] arm64: kprobes: Move exception_text check in blacklist
Date: Mon, 17 Dec 2018 15:41:43 +0900
Message-Id: <154502890363.30629.6071608188122836265.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154502881646.30629.9938335052821665530.stgit@devbox>
References: <154502881646.30629.9938335052821665530.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_224217_404624_7762029A 
X-CRM114-Status: GOOD (  11.54  )
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
Cc: Pratyush Anand <panand@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-arm-kernel@lists.infradead.org,
 "David A . Long" <dave.long@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Move exception/irqentry text address check in blacklist,
since those are symbol based rejection.

If we prohibit probing on the symbols in exception_text,
those should be blacklisted.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arm64/kernel/probes/kprobes.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 1dae500d0a81..b9e9758b6534 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -98,9 +98,6 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	/* copy instruction */
 	p->opcode = le32_to_cpu(*p->addr);
 
-	if (in_exception_text(probe_addr))
-		return -EINVAL;
-
 	if (search_exception_tables(probe_addr))
 		return -EINVAL;
 
@@ -475,7 +472,8 @@ bool arch_within_kprobe_blacklist(unsigned long addr)
 	    (addr >= (unsigned long)__entry_text_start &&
 	    addr < (unsigned long)__entry_text_end) ||
 	    (addr >= (unsigned long)__idmap_text_start &&
-	    addr < (unsigned long)__idmap_text_end))
+	    addr < (unsigned long)__idmap_text_end) ||
+	    in_exception_text(addr))
 		return true;
 
 	if (!is_kernel_in_hyp_mode()) {


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
