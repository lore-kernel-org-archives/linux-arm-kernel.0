Return-Path: <SRS0=5+Aw=QR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D67C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 05:28:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7757921736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 05:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lCNr0v/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7757921736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=QcznJXX8Kt81OhaSSsMfyOPZFmFs40YiDgVBliCt6FM=; b=lCNr0v/HqBdED2
	a17WPn2NFhFnAvEQ8+afA9dFwvWD8zR1P+HfYfw7j0dnYlsZmV7PIDgjvpF+0Kdrn4STflFdtWphD
	qN9d8DitewaqGMy2O8qxbGl5ZlZj+BzeBESd5C8mCj7J89uqoZ3UBfjitL65P7OOlhIO5Bsqq4HNM
	Gg1+CCzZdUVtrp8wEKeXAzCdI0bwzsdUUNdkMiCa4CEOfXpEnrDyGOet/da1vI/xy8kF8D852g3G1
	e0jRHgO6ExSWUxydfPM/jNY2fgISE5T3Ncc+JXkr9BP7IqKTrWPl65luIIu72yDjmqW/4qXHLA+AA
	5swoWrTf9OSsjwmtxAkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gshf8-0003EZ-9K; Sun, 10 Feb 2019 05:28:18 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gshey-00037Q-Ur
 for linux-arm-kernel@lists.infradead.org; Sun, 10 Feb 2019 05:28:11 +0000
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 7B19F9A484A186AA9593;
 Sun, 10 Feb 2019 13:27:55 +0800 (CST)
Received: from HGHY2Y004646261.china.huawei.com (10.184.12.158) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Sun, 10 Feb 2019 13:27:46 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
To: <tglx@linutronix.de>, <jason@lakedaemon.net>, <marc.zyngier@arm.com>
Subject: [PATCH] irqchip/gic-v3-its: Avoid parsing _indirect_ twice for Device
 table
Date: Sun, 10 Feb 2019 05:24:10 +0000
Message-ID: <1549776250-4464-1-git-send-email-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190209_212809_918579_56BB3F53 
X-CRM114-Status: UNSURE (   7.46  )
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
Cc: Zenghui Yu <yuzenghui@huawei.com>, wanghaibin.wang@huawei.com,
 linux-arm-kernel@lists.infradead.org, shankerd@codeaurora.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In current logic, its_parse_indirect_baser() will be invoked twice
when allocating Device tables. Add a *break* to omit the unnecessary
and annoying (might be ...) invoking.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index db20e99..9f529a6 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1946,6 +1946,8 @@ static int its_alloc_tables(struct its_node *its)
 			indirect = its_parse_indirect_baser(its, baser,
 							    psz, &order,
 							    its->device_ids);
+			break;
+
 		case GITS_BASER_TYPE_VCPU:
 			indirect = its_parse_indirect_baser(its, baser,
 							    psz, &order,
-- 
1.8.3.1



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
