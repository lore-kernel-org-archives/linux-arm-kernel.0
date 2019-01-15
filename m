Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D42C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 06:26:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87CDD20861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 06:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s1NjJKFq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiGtl9ju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CDD20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MBwmk1qG7tLa6ZLMbrs+4BSEjkQX1ZlWcYv1qb41Jrs=; b=s1NjJKFqYRVEC6
	gFSO0V7ZHvu+YrcEYjXAQsfwhGfPK7tqW23wTd5CpTiy5gdtQYqUt53/VYkadj/Z2yEGEZosS0MQf
	9WoGYe3+Hh4vly4z35Yaa8sxqoUZZuQhjsK7u9tZUSY/lHCjv1wf1ME4BJTkV6IlQVdir+QCDlsL/
	/lOx5CDFxtMuCl8rSyKrRx1t1R1cxPpZzzuF2hs2Ujsh2unl4uNbj8JoRHvoR1+OBpbnz4qHHwi5k
	n3qWQU+skb5Y8Yk1hejZlt5ufzV4jmt/+VVIu7Sjda1f0ptfliISqK1PAZAhMP9PqKvlksLyONk9y
	YmHUHPCW7AKyd9NxT9WQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjIAh-0007Ew-Um; Tue, 15 Jan 2019 06:25:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjIAf-0007EL-5t
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 06:25:58 +0000
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp
 [210.141.244.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A105220651;
 Tue, 15 Jan 2019 06:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547533556;
 bh=c3cvMz1HCpmGl/imOyH/ipMAfTvysPlZuDxCV5MItjo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jiGtl9juScFfW2sBrGxgUaVX/ak2eqEJp8+NKHvesiTC9yjB2ELFuuKgqG4lsoYTh
 cGr30LDQpxgCucetQyrsnaDUnv5BZ/AUv90BUwc9lmNJpne7BcQxTPUbisWM8GQfID
 rjaxLB8UaByVvSqLzsMv1A518K6PF1sT6KunuTfc=
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 4/4] arm64: kprobes: Use arch_populate_kprobe_blacklist()
Date: Tue, 15 Jan 2019 15:25:33 +0900
Message-Id: <154753353370.31541.14485875717131836689.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154753341900.31541.8135985235882849464.stgit@devbox>
References: <154753341900.31541.8135985235882849464.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_222557_248780_EBA71658 
X-CRM114-Status: GOOD (  12.32  )
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

Use arch_populate_kprobe_blacklist() instead of
arch_within_kprobe_blacklist() so that we can see the full
blacklisted symbols under the debugfs.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arm64/kernel/probes/kprobes.c |   42 ++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index b9e9758b6534..6c066c34c8a4 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -465,26 +465,30 @@ kprobe_breakpoint_handler(struct pt_regs *regs, unsigned int esr)
 	return DBG_HOOK_HANDLED;
 }
 
-bool arch_within_kprobe_blacklist(unsigned long addr)
+int __init arch_populate_kprobe_blacklist(void)
 {
-	if ((addr >= (unsigned long)__kprobes_text_start &&
-	    addr < (unsigned long)__kprobes_text_end) ||
-	    (addr >= (unsigned long)__entry_text_start &&
-	    addr < (unsigned long)__entry_text_end) ||
-	    (addr >= (unsigned long)__idmap_text_start &&
-	    addr < (unsigned long)__idmap_text_end) ||
-	    in_exception_text(addr))
-		return true;
-
-	if (!is_kernel_in_hyp_mode()) {
-		if ((addr >= (unsigned long)__hyp_text_start &&
-		    addr < (unsigned long)__hyp_text_end) ||
-		    (addr >= (unsigned long)__hyp_idmap_text_start &&
-		    addr < (unsigned long)__hyp_idmap_text_end))
-			return true;
-	}
-
-	return false;
+	int ret;
+
+	ret = kprobe_add_area_blacklist((unsigned long)__kprobes_text_start,
+					(unsigned long)__kprobes_text_end);
+	if (ret)
+		return ret;
+	ret = kprobe_add_area_blacklist((unsigned long)__entry_text_start,
+					(unsigned long)__entry_text_end);
+	if (ret)
+		return ret;
+	ret = kprobe_add_area_blacklist((unsigned long)__idmap_text_start,
+					(unsigned long)__idmap_text_end);
+	if (ret || is_kernel_in_hyp_mode())
+		return ret;
+
+	ret = kprobe_add_area_blacklist((unsigned long)__hyp_text_start,
+					(unsigned long)__hyp_text_end);
+	if (ret)
+		return ret;
+	ret = kprobe_add_area_blacklist((unsigned long)__hyp_idmap_text_start,
+					(unsigned long)__hyp_idmap_text_end);
+	return ret;
 }
 
 void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
