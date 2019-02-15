Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FA3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:26:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7BDD2192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nnJOfSkG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7BDD2192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J6j48HICLo+BVQAYodPG1/6EuJswVgmkGLntSQV9ikc=; b=nnJOfSkGLA7s5S
	6NvHdXdHWWRFfz1EFd+ZFxFTl1ac7XA/OOtaechj3R4i2AGDyKMB2vAEnb+iFAC9Ty7rz+p9e71Dc
	5PIMPZdvsT6ljjEbd+Tkhhu/cdMN0fsJTn96VCFVvKYuUSTMaIHk0m+rVFcM+UWgUJhD287A3g6Nv
	enUpeNv2BunzlhLKdKmps2z8N4FUPhdF++Z3tUbYM0YJcZkoLryIVbwmcXlnnlFW5purKDjdRJ51H
	LkzInyCUlt+PDuDikMdXtmVWrcVG8A4SD5BqSQQvuNotB6nuSippoNe9VbS3R+tzbY6CjlR4D1YM0
	Uc5uPMnNYqB0olsVgKYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gueRa-0003qn-QC; Fri, 15 Feb 2019 14:26:22 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gueRX-0003qS-SL
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 14:26:21 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A44BBA78;
 Fri, 15 Feb 2019 06:26:19 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7045B3F575;
 Fri, 15 Feb 2019 06:26:18 -0800 (PST)
Date: Fri, 15 Feb 2019 14:26:16 +0000
From: Will Deacon <will.deacon@arm.com>
To: Qian Cai <cai@lca.pw>
Subject: Re: livelock with KASAN_SW_TAGS
Message-ID: <20190215142616.GB6299@fuggles.cambridge.arm.com>
References: <7ec14ad5-8d64-b842-a819-9d57cc8495e2@lca.pw>
 <20190214163536.GB1825@fuggles.cambridge.arm.com>
 <50ef4f07-af09-5498-2bca-26ced76d9736@lca.pw>
 <20190214180125.GH2475@fuggles.cambridge.arm.com>
 <a31780dc-2fac-734e-61b8-8bdedaca2f05@lca.pw>
 <20190215142350.GA6299@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190215142350.GA6299@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_062619_922791_929F3764 
X-CRM114-Status: GOOD (  10.72  )
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
Cc: Andrey Konovalov <andreyknvl@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 kasan-dev <kasan-dev@googlegroups.com>, aryabinin@virtuozzo.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

[this time, with the diff]

On Fri, Feb 15, 2019 at 02:23:56PM +0000, Will Deacon wrote:
> One thing I did spot is that KASAN doesn't play nicely with page poisoning,
> because the pointer returned by kmap_atomic() which is used to poison and
> unpoison a page on free and alloc respectively is tagged. The simplest way
> to fix this was to disable KASAN around these operations (diff below).

Will

--->8

diff --git a/mm/page_poison.c b/mm/page_poison.c
index f0c15e9017c0..24aa8789971d 100644
--- a/mm/page_poison.c
+++ b/mm/page_poison.c
@@ -3,6 +3,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
+#include <linux/kasan.h>
 #include <linux/page_ext.h>
 #include <linux/poison.h>
 #include <linux/ratelimit.h>
@@ -116,10 +117,12 @@ void kernel_poison_pages(struct page *page, int numpages, int enable)
 	if (!page_poisoning_enabled())
 		return;
 
+	kasan_disable_current();
 	if (enable)
 		unpoison_pages(page, numpages);
 	else
 		poison_pages(page, numpages);
+	kasan_enable_current();
 }
 
 #ifndef CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
