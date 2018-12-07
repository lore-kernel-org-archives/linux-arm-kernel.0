Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2747CC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:47:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E62EC20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gQ4ZVYmT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62EC20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=ubx8BF4DGjx/AmumvAn7xg+FkDzNwMFyprfkP49cZUs=; b=gQ4
	ZVYmTqo1G39eZ/2BKUs1gUwBURmgl3ptNuuuEjmEG5hVe2M8C4BUpkdj5J4ON9tN+u+BRNRyDnfRR
	tFW7xLiu9itgj4r9/eqYeHif20POUfhWUoHS0qnSB5KMAO60m+XEMexBEIO6V1p0S+kOonAvXNamB
	RirsYQhZAn65p7i/OKbdnmaUbQCAlFUIhdgJ2FEYCgNIwMmYcv7VgIquIMrGc7sJd+Ne+KpXoNVtM
	ILhJgyVTk1E5HVN3bhjcXQSm8uDbukOK8VhswNOpMzAgKyvnSYHcgM3bDaSDNxO3YDG0eJ6drhOwS
	SgT9qLigcOhe2oZV/he3bjSHgyPfGvA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVFX7-0003Dd-Dt; Fri, 07 Dec 2018 12:47:05 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVFX3-0003Cn-Ei
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 12:47:02 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABD79EBD;
 Fri,  7 Dec 2018 04:46:50 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7C2B43F5AF;
 Fri,  7 Dec 2018 04:46:50 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id DE4821AE0C03; Fri,  7 Dec 2018 12:47:11 +0000 (GMT)
From: Will Deacon <will.deacon@arm.com>
To: catalin.marinas@arm.com
Subject: [PATCH] arm64: hibernate: Avoid sending cross-calling with interrupts
 disabled
Date: Fri,  7 Dec 2018 12:47:10 +0000
Message-Id: <1544186830-27934-1-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_044701_498163_88803F1E 
X-CRM114-Status: GOOD (  11.95  )
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
Cc: Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org,
 james.morse@arm.com, hayashi.kunihiko@socionext.com,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Since commit 3b8c9f1cdfc50 ("arm64: IPI each CPU after invalidating the
I-cache for kernel mappings"), a call to flush_icache_range() will use
an IPI to cross-call other online CPUs so that any stale instructions
are flushed from their pipelines. This triggers a WARN during the
hibernation resume path, where flush_icache_range() is called with
interrupts disabled and is therefore prone to deadlock:

  | Disabling non-boot CPUs ...
  | CPU1: shutdown
  | psci: CPU1 killed.
  | CPU2: shutdown
  | psci: CPU2 killed.
  | CPU3: shutdown
  | psci: CPU3 killed.
  | WARNING: CPU: 0 PID: 1 at ../kernel/smp.c:416 smp_call_function_many+0xd4/0x350
  | Modules linked in:
  | CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.20.0-rc4 #1

Since all secondary CPUs have been taken offline prior to invalidating
the I-cache, there's actually no need for an IPI and we can simply call
__flush_icache_range() instead.

Cc: <stable@vger.kernel.org>
Fixes: 3b8c9f1cdfc50 ("arm64: IPI each CPU after invalidating the I-cache for kernel mappings")
Reported-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Tested-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Tested-by: James Morse <james.morse@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/hibernate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 6b2686d54411..29cdc99688f3 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -214,7 +214,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	}
 
 	memcpy((void *)dst, src_start, length);
-	flush_icache_range(dst, dst + length);
+	__flush_icache_range(dst, dst + length);
 
 	pgdp = pgd_offset_raw(allocator(mask), dst_addr);
 	if (pgd_none(READ_ONCE(*pgdp))) {
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
