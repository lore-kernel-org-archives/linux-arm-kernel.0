Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D19C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:28:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1755520823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mQDAUbZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1755520823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=dnG9QEfz++GLJteLIqw6FPOBMF95y1sdowiCWl7dwTM=; b=mQDAUbZ6jxXWJp
	feV21eHBIC9A/OD9XvE3CCBanFiRsMpQFytgTONTY+MTN43MuxQOc3p1yANfQKaHu7uUL2mcFOrFt
	CvLI/aaq6ypRFEWlAG2Fxz9148R4yZ95ASF7uGmUNkf1r+R1Y55yXKE2jYu3ONjfa+4YwBPUWj9uP
	5JAV1fXHbh42NaJvf8LwPurM3cK9Z3d1MbtT1ncUb9uiUKIareCLskFvnFNiKsAjt/3+kvJdiI1wm
	Nht0MSbHJe7qMgdhrVrx9ZPCZcxxTwQsA4ZTGcYAlKfdzViqmb4moRPVsQnH5tYr1BMnQxQS8DVAt
	k26ssIjikylaqmOkaF9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmio2-0003q3-Dv; Thu, 24 Jan 2019 17:28:46 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gminz-0003pe-Nf
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 17:28:45 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3071FA78;
 Thu, 24 Jan 2019 09:28:43 -0800 (PST)
Received: from arrakis.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F09D83F5AF;
 Thu, 24 Jan 2019 09:28:41 -0800 (PST)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH] arm64: Do not issue IPIs for user executable ptes
Date: Thu, 24 Jan 2019 17:28:37 +0000
Message-Id: <20190124172837.10011-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_092843_828054_5BC858DB 
X-CRM114-Status: GOOD (  11.13  )
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
Cc: Shijith Thotton <sthotton@marvell.com>, stable@vger.kernel.org,
 Wandun Chen <chenwandun@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Commit 3b8c9f1cdfc5 ("arm64: IPI each CPU after invalidating the I-cache
for kernel mappings") was aimed at fixing the I-cache invalidation for
kernel mappings. However, it inadvertently caused all cache maintenance
for user mappings via set_pte_at() -> __sync_icache_dcache() ->
sync_icache_aliases() to call kick_all_cpus_sync().

Reported-by: Shijith Thotton <sthotton@marvell.com>
Tested-by: Shijith Thotton <sthotton@marvell.com>
Reported-by: Wandun Chen <chenwandun@huawei.com>
Fixes: 3b8c9f1cdfc5 ("arm64: IPI each CPU after invalidating the I-cache for kernel mappings")
Cc: <stable@vger.kernel.org> # 4.19.x-
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

Hi Will,

You acked the previous inlined patch but I think that's a better option
to revert the kernel behaviour w.r.t. user mapping to that prior to
commit 3b8c9f1cdfc5.

If you plan a pull request for 5.0-rc4, please pick this up as well.

Thanks.

 arch/arm64/mm/flush.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index 30695a868107..5c9073bace83 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -33,7 +33,11 @@ void sync_icache_aliases(void *kaddr, unsigned long len)
 		__clean_dcache_area_pou(kaddr, len);
 		__flush_icache_all();
 	} else {
-		flush_icache_range(addr, addr + len);
+		/*
+		 * Don't issue kick_all_cpus_sync() after I-cache invalidation
+		 * for user mappings.
+		 */
+		__flush_icache_range(addr, addr + len);
 	}
 }
 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
