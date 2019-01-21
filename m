Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD16C31680
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:05:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07C7E2089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RRt9qJyE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C7E2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xb4rsqqSuTiIRtabk1JzRPa7DL0IDOn3kxVFePYtczU=; b=RRt9qJyEE5k7wT
	Mg9a9VnFq0fljsBLVw/Kdg0UEp7dsYmkYUWItGu/COEX9oyVa9ThZJb0cy+N0j9F9LCeOqb0h6pmT
	MzSxWaLR3mCbAftKbLlxyKMHR3ouTGZGQpXZg7X6dj0Lzu3O9xzWIo4hNSkxnJ8PJ2z5xGWkwl/Es
	MwG1x4jiVNB20WaZEqI+na4vWWkWWEaR4mhLXCdhphhpk/lBHjdUMcoFmMKdejI39UGnNKcZXsEyS
	3BY/4YtcAiDcdsQiMBQq/HOGJzcoi45ooLuERG8iI/9/2V1+XE6aWAs79oNM5t4OI8xBpYfIsqYFK
	m91dCzyNLndFAH6O4TiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gld1E-0005EO-LH; Mon, 21 Jan 2019 17:05:52 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glczo-0002pp-Kf
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 17:04:30 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 518781650;
 Mon, 21 Jan 2019 09:04:24 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC4E13F614;
 Mon, 21 Jan 2019 09:04:22 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] arm64: hibernate: Clean the __hyp_text to PoC after resume
Date: Mon, 21 Jan 2019 17:04:04 +0000
Message-Id: <20190121170404.142966-5-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121170404.142966-1-james.morse@arm.com>
References: <20190121170404.142966-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_090425_121560_5D794855 
X-CRM114-Status: GOOD (  13.79  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, james.morse@arm.com,
 Masami Hiramatsu <mhiramat@kernel.org>, kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

During resume hibernate restores all physical memory. Any memory
that is accessed with the MMU disabled needs to be cleaned to the
PoC.

KVMs __hyp_text was previously ommited as it runs with the MMU
enabled, but now that the hyp-stub is located in this section,
we must clean __hyp_text too.

This ensures secondary CPUs that come online after hibernate
has finished resuming, and load KVM via the freshly written
hyp-stub see the correct instructions.

Signed-off-by: James Morse <james.morse@arm.com>
Cc: stable@vger.kernel.org
---
 arch/arm64/kernel/hibernate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 29cdc99688f3..9859e1178e6b 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -299,8 +299,10 @@ int swsusp_arch_suspend(void)
 		dcache_clean_range(__idmap_text_start, __idmap_text_end);
 
 		/* Clean kvm setup code to PoC? */
-		if (el2_reset_needed())
+		if (el2_reset_needed()) {
 			dcache_clean_range(__hyp_idmap_text_start, __hyp_idmap_text_end);
+			dcache_clean_range(__hyp_text_start, __hyp_text_end);
+		}
 
 		/* make the crash dump kernel image protected again */
 		crash_post_resume();
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
