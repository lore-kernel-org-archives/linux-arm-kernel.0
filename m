Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CC5C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:43:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEE1521773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ywsh+5bZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGOU+vqF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE1521773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v0BiUjqS9UKwGGRnRVjRzRGw7rjzoFnOZcvR88CBgLE=; b=Ywsh+5bZaNYfRU
	rP3dkSqeM0ofJ+12lBKvk3x2iTDsaQKbz/TNhK1PKgtgN1bFNExd3eieFXoQwaWWWE8taigQOPAlK
	3qGC9KqoPqzY0drE3/iYfD9hcJNjZzLp7roYwR1mpb4FWv81CC+hCo1+KKvaaLvVTi5gN5LJQZrN/
	XGp+xOfLvIac/cCY5tLoxpd5nAkD0ZsxArC6hs3iNP/N+YWjtEFbdiDfM/U19FRgHvsXeEvuSet5v
	dJMm0wLk1AGu7kCQZV4TIFOfv0Du5cZ7vTs+ZDJFZY19fDo50zle215ZZpuH08qwwDC1blT9PEu+9
	UuB8zQN6FhPEddGo/3Sg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtaDt-0006Ec-TU; Tue, 12 Feb 2019 15:43:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtaDq-0006Cg-2i
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 15:43:47 +0000
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp
 [210.141.244.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7CA0C21773;
 Tue, 12 Feb 2019 15:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549986225;
 bh=0W/75YHGlmESdSfdJlB9JnspyeIkW8XqMvb/1p+GSmE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aGOU+vqFPOKSbJWqILXjb50J6gHsBXFUaB73jmnJfUhp4jq3igTdXIR3oFnC0etsJ
 lsFAFUcA/cdHEaCRnsl7i6s/99+6kpvsxr36mkxk7O0hm/PSG+ENQDeI7W8FXuIBwq
 VOKx0jiDt2wUvr8dlAs/WJNpOt2xZwbmHq+UdaOU=
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH v3 1/4] arm64: kprobes: Move extable address check into
 arch_prepare_kprobe()
Date: Wed, 13 Feb 2019 00:43:22 +0900
Message-Id: <154998620258.21869.8971320076728831126.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154998617300.21869.11457765723750331236.stgit@devbox>
References: <154998617300.21869.11457765723750331236.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_074346_238379_EA0838C8 
X-CRM114-Status: GOOD (  11.72  )
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
index f17afb99890c..9989ec9baa11 100644
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
@@ -479,8 +483,7 @@ bool arch_within_kprobe_blacklist(unsigned long addr)
 	    (addr >= (unsigned long)__idmap_text_start &&
 	    addr < (unsigned long)__idmap_text_end) ||
 	    (addr >= (unsigned long)__hyp_text_start &&
-	    addr < (unsigned long)__hyp_text_end) ||
-	    !!search_exception_tables(addr))
+	    addr < (unsigned long)__hyp_text_end))
 		return true;
 
 	if (!is_kernel_in_hyp_mode()) {


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
