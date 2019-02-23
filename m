Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF624C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:48:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F6E5206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O7ZTixRW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6E5206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=LtkEmnPgQxoHeJTbJ6Z9vH+K4JY+kfHOi1o61koV/gg=; b=O7ZTixRWThfYYP
	GhTQE3xRJrvgdMxiFiLbI54Uv43SBMxHWi4oeRdrky7OulaWKgqPLKbA27g7eVVPJ70T6x104vfLd
	qCxqi+JavQp09oYm+/R1kmQnICDo0WKaWIgL7mi30LFe/SY8/alxHm6xwar9oernuyk+qUHSI87XB
	gAqDBqZZybIejzUUW/WMiksqdNrybYCJdUs6ffDj0VaSIA3Nmo0AnzyRf4OrymzE8WyfciUTxg5jo
	/VcUbnoHBpPcCbNi+zOm5I3dAAiRJRrJRSySLmENo3ZpolGR/Z/XR2J4AJKBw/7OzBJkZ7fkDWMMK
	EpfZ6j4HRRcRfj2+/npg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxR6w-0006ox-He; Sat, 23 Feb 2019 06:48:34 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxR6s-0006oE-Sw
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 06:48:32 +0000
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id A4F7CDC8D62B86813F93;
 Sat, 23 Feb 2019 14:48:16 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.408.0; Sat, 23 Feb 2019 14:48:05 +0800
From: Xuefeng Wang <wxf.wang@hisilicon.com>
To: <catalin.marinas@arm.com>, <will.deacon@arm.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] Use flush tlb last level when change protection
Date: Sat, 23 Feb 2019 14:47:27 +0800
Message-ID: <1550904447-45567-1-git-send-email-wxf.wang@hisilicon.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_224831_097500_86E0CBB3 
X-CRM114-Status: UNSURE (   9.11  )
X-CRM114-Notice: Please train this message.
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
Cc: guohanjun@huawei.com, wxf.wang@hisilicon.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The protection attributes are only kept in last level tlb, so
protection changing only need invalidate last level tlb, exclude
the PWC entries.

Signed-off-by: Xuefeng Wang <wxf.wang@hisilicon.com>
---
 mm/mprotect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 36cb358..0c4303d 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -287,7 +287,7 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 
 	/* Only flush the TLB if we actually modified any entries: */
 	if (pages)
-		flush_tlb_range(vma, start, end);
+		__flush_tlb_range(vma, start, end, PAGE_SIZE, true);
 	dec_tlb_flush_pending(mm);
 
 	return pages;
-- 
1.7.12.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
