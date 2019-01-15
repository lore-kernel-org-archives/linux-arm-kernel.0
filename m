Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6E1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 06:24:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B8C220651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 06:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nkKZm1EL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0d+QhrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8C220651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DiaKGFWla+k91KJJ+CNJAOusha0CwACeXtunORlnmPA=; b=nkKZm1EL/x67Nu
	wgMFivOVu8itKrKQhkitJ0RA7r5a8AN0Q7Hgkyg9dUF++pvKqYN200A3ECd2A1VFTH1bF1OUww4+3
	83DzIz2TJFKGJEXDtD5SsHV0K+gMLR2eBOUbv8AnYL95K+L/su/SNrLZ2ZrZFv95XJMFj1MK/lETH
	zGsxqGSrt5rEKVgRSIgBsRjtBsgHlx8SwejS09TFuB6yd7lgk6GgyxbcKlv5fsCZTqT8vIdhzMqh0
	V8BiN9huY3UJJFfqevbavlHGh7ymXtpd2As/A1DSSkUE0EHiSFGaAoemyi7n/D/Yh4MP+PzAVBYl9
	w56kIuwlzhpzuuTIQiyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjI9M-00059H-Bi; Tue, 15 Jan 2019 06:24:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjI9H-00058V-Jx
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 06:24:34 +0000
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp
 [210.141.244.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 20C9A20651;
 Tue, 15 Jan 2019 06:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547533471;
 bh=JMPzgJxn71Oh3CSPLMfjWsZVP7P3WH3Nj9DBNFncCNU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=L0d+QhrAA1raIo2uM8j525TaubAY8kIQauQJKDLhiGMRqVv7wWbq6kWjXGfmxsoX9
 NjbiDm+VqVFOQBA/Se3Wa+5BmE7KTsDD9dVaH/aQqtk8TKSR5vxfNesLDdvR8F+PSC
 IxwCzpAMu2a6FILbySzAk35WBJrHPMaoiYx+jvqM=
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 1/4] arm64: kprobes: Move extable address check into
 arch_prepare_kprobe()
Date: Tue, 15 Jan 2019 15:24:08 +0900
Message-Id: <154753344814.31541.1870614689774287684.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154753341900.31541.8135985235882849464.stgit@devbox>
References: <154753341900.31541.8135985235882849464.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_222431_783453_FC14C8C1 
X-CRM114-Status: GOOD (  12.13  )
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
 linux-kernel <linux-kernel@vger.kernel.org>, James Morse <james.morse@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-arm-kernel@lists.infradead.org,
 "David A . Long" <dave.long@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Move extable address check into arch_prepare_kprobe() from
arch_within_kprobe_blacklist().
The blacklist is exposed via debugfs as a list of symbols.
The extable entries are smaller, so must be filtered out
by arch_prepare_kprobe().

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: James Morse <james.morse@arm.com>
---
 Update in v2:
  - Update commit message.
  - Add Reviewed-by from James.
---
 arch/arm64/kernel/probes/kprobes.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 2a5b338b2542..b2d4b7428ebc 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -102,6 +102,10 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 
 	if (in_exception_text(probe_addr))
 		return -EINVAL;
+
+	if (search_exception_tables(probe_addr))
+		return -EINVAL;
+
 	if (probe_addr >= (unsigned long) __start_rodata &&
 	    probe_addr <= (unsigned long) __end_rodata)
 		return -EINVAL;
@@ -477,8 +481,7 @@ bool arch_within_kprobe_blacklist(unsigned long addr)
 	    (addr >= (unsigned long)__entry_text_start &&
 	    addr < (unsigned long)__entry_text_end) ||
 	    (addr >= (unsigned long)__idmap_text_start &&
-	    addr < (unsigned long)__idmap_text_end) ||
-	    !!search_exception_tables(addr))
+	    addr < (unsigned long)__idmap_text_end))
 		return true;
 
 	if (!is_kernel_in_hyp_mode()) {


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
