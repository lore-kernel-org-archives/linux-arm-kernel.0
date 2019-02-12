Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E371C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:45:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F144121773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X4HgW4CB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zef25u1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F144121773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PBKwINnPP4OamF1fJUO6rm1pnxC0cvP1YRc96YNK0Ww=; b=X4HgW4CB/uI0mx
	lzy3/SNfE9k9bAZRDDIUeGr5GBmkfJ3QQJP6LDipHlM0eKFk09q6nhkeq030idyPX1lKYsKXoP1gb
	ElL+weMXCsFiQTVnoeTdg9XkL+ThkOaBKjKBLggkc38IZg7mRSdfq4ED8ioBM0zULKnhlfYAYonEt
	LfXiQJ7JKxSjftAs4Tw5K5JNwbkVQfEjmc1JKf9zur45Fo1PkDv8iX4E7EZWMq1ow33OKT2b8jtsG
	BJtHjRa0jr5/wG1u9tj0JEgrRbbDJf0caxZx1Y/hEU36XK0EViw/0/HsQRKb2xby43D/8M6rrVK8V
	k6scgZ2zFLmZGbRleARA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtaFG-0008JE-NN; Tue, 12 Feb 2019 15:45:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtaFD-00081M-Eo
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 15:45:13 +0000
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp
 [210.141.244.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F39F121773;
 Tue, 12 Feb 2019 15:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549986311;
 bh=uyCwuVK7m1EdKUW1jMDgbNHxoIArsqofJ5gDugVV8so=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Zef25u1hDtnYTLdkMiNpVudl6DEgCBtDSb4Dc9n7UyMXLYUng/E7V9lbZx8aud2gY
 Z5yKina+DtMLWT/B3TuRIbF3FG/ndbReqhtIhl4JTqybDngkMEZ6A3DpXAbhbipCRa
 J1UGfkVzOfqfZM6H+wGNuDF7f/TLuqkeIB0uRhFw=
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH v3 4/4] arm64: kprobes: Use arch_populate_kprobe_blacklist()
Date: Wed, 13 Feb 2019 00:44:48 +0900
Message-Id: <154998628802.21869.4041705065539411318.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154998617300.21869.11457765723750331236.stgit@devbox>
References: <154998617300.21869.11457765723750331236.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_074511_539528_D41FC8CC 
X-CRM114-Status: GOOD (  13.31  )
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
  Changes in v3
   - Do not populate blacklist in __kprobe_text in
     arch_populate_kprobe_blacklist(), since it is already
     populated in populate_kprobe_blacklist().
   - Add exception entry text blacklist since those are rejected
     by in_exception_text().
---
 arch/arm64/kernel/probes/kprobes.c |   45 +++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 194262fca5cd..37d913f33a89 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -465,26 +465,33 @@ kprobe_breakpoint_handler(struct pt_regs *regs, unsigned int esr)
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
-	    (addr >= (unsigned long)__hyp_text_start &&
-	    addr < (unsigned long)__hyp_text_end) ||
-	    in_exception_text(addr))
-		return true;
-
-	if (!is_kernel_in_hyp_mode()) {
-		if ((addr >= (unsigned long)__hyp_idmap_text_start &&
-		    addr < (unsigned long)__hyp_idmap_text_end))
-			return true;
-	}
-
-	return false;
+	int ret;
+
+	ret = kprobe_add_area_blacklist((unsigned long)__entry_text_start,
+					(unsigned long)__entry_text_end);
+	if (ret)
+		return ret;
+	ret = kprobe_add_area_blacklist((unsigned long)__irqentry_text_start,
+					(unsigned long)__irqentry_text_end);
+	if (ret)
+		return ret;
+	ret = kprobe_add_area_blacklist((unsigned long)__exception_text_start,
+					(unsigned long)__exception_text_end);
+	if (ret)
+		return ret;
+	ret = kprobe_add_area_blacklist((unsigned long)__idmap_text_start,
+					(unsigned long)__idmap_text_end);
+	if (ret)
+		return ret;
+	ret = kprobe_add_area_blacklist((unsigned long)__hyp_text_start,
+					(unsigned long)__hyp_text_end);
+	if (ret || is_kernel_in_hyp_mode())
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
