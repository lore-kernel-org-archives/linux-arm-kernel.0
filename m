Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37F6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:21:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AC452087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WWPHhQXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC452087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Jw2638x9I9nFhh8bJ6jWbIWHJRNP1aFaKLn5k417Ips=; b=WWPHhQXvEAQcBw
	Q8V+U+3ygeAU4bR6Uc35QlblSU6q080GkBUq/z1gQ26uPU1MwSr7zIGY1weZ4WaEgiWSiSl0pFQF5
	66uHAomYwacVFOBTFoQk1Nztdn6i8knb6CJRWEUC3+I/3q1l//XECqMhOFyPdXQnhYoWHHUQmXl/o
	CsF0Ghd3BK+5smlbp5yR5AJ2seESTVsN3OJ2rZvA41K8NBspO3LzpF+KU7Z8UQbBLjJ3h7EoAQxqn
	x9Qrp3YS3I4uTs7weRzS68Kq0Wn+G2438ayfbTxx2QHpZfYrUkNtzIwzzntCcvyRfJuJZb4VqTDLk
	MO32zIjcRJXnTCIZsc8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggSyU-0000zY-Va; Mon, 07 Jan 2019 11:21:42 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggSyQ-0000yp-Sf; Mon, 07 Jan 2019 11:21:40 +0000
X-UUID: aaff68078e72464e99ab946cf71b1e84-20190107
X-UUID: aaff68078e72464e99ab946cf71b1e84-20190107
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <miles.chen@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 808047882; Mon, 07 Jan 2019 03:21:25 -0800
Received: from mtkmbs08n2.mediatek.inc (172.21.101.56) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 7 Jan 2019 03:21:24 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 7 Jan 2019 19:21:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Mon, 7 Jan 2019 19:21:22 +0800
From: Miles Chen <miles.chen@mediatek.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>
Subject: [PATCH] arm64: trap illegal translations in __virt_to_phys()
Date: Mon, 7 Jan 2019 19:21:20 +0800
Message-ID: <1546860080-13027-1-git-send-email-miles.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-TM-SNTS-SMTP: 234332DA94720DE407A4821BBD08A888B8AD06626A5B9BD0790A841A1B7E05452000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_032138_932719_698D9D3A 
X-CRM114-Status: UNSURE (   8.20  )
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
Cc: Miles Chen <miles.chen@mediatek.com>, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 wsd_upstream@mediatek.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Current __virt_to_phys() only print warning messages for non-linear
addresses. It's hard to catch all warnings by those messages. So add a
VIRTUAL_BUG_ON() to trap all non-linear and non-symbol addresses
(e.g., stack addresses)

Tested by pass stack addresses and symbol addresses to __pa(). Result:
stack addresses: kernel BUG()
symbol addresses: kernel warning message

Maybe we should trap all non-linear address translations in the future.

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 arch/arm64/mm/physaddr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/mm/physaddr.c b/arch/arm64/mm/physaddr.c
index 67a9ba9eaa96..f6b935dad19c 100644
--- a/arch/arm64/mm/physaddr.c
+++ b/arch/arm64/mm/physaddr.c
@@ -14,6 +14,11 @@ phys_addr_t __virt_to_phys(unsigned long x)
 	      (void *)x,
 	      (void *)x);
 
+	/* trap all non-linear and non-symbol addresses */
+	VIRTUAL_BUG_ON(!__is_lm_address(x) &&
+			(x < (unsigned long)KERNEL_START ||
+			 x > (unsigned long)KERNEL_END));
+
 	return __virt_to_phys_nodebug(x);
 }
 EXPORT_SYMBOL(__virt_to_phys);
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
