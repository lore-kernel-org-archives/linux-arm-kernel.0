Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67080C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:09:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 358012184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b33d7jB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358012184A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=/Loq7eJAbXt9s64witBAzH5T6Jcuq0yAd1QecymbSGg=; b=b33d7jB/pZ/+xa
	yRbxajPnCKalSeiYzecNWnFqw1kdKUvt7bJEYj4Be1nHCimXEWL1GCaopymR7LX1gNUjwsM09i99x
	zx9LlUtXTdKfIu9WXh/iSnWp5ix75lC7cM0t06sE1Jzz0Ay5jVwZnY8LKXPzd/7Xp/3BA75MT43Hy
	4sCYtiW4HBDOqd02Y/SYEeoYuMaW2zx1D7OIW+P4KgDC3hV+bpAnoGvg92ojco8BaVx8CvvCtMP2c
	QhUZZ5dqntslOIhDnd6cL2/3DjBKuIHE0Asy6R/NVbFmwCzIQmRjFDy6X38yRgKvSL1Z612aSJf6X
	Vmxawtds9zss501cAO/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVwg-00017d-1z; Tue, 12 Feb 2019 11:09:46 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVwd-00016f-LT; Tue, 12 Feb 2019 11:09:44 +0000
X-UUID: b83173e9b6614893a3d75ade8eb4228f-20190212
X-UUID: b83173e9b6614893a3d75ade8eb4228f-20190212
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <mars.cheng@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1852666723; Tue, 12 Feb 2019 03:09:33 -0800
Received: from mtkmbs08n2.mediatek.inc (172.21.101.56) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Feb 2019 03:09:31 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Feb 2019 19:09:28 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Tue, 12 Feb 2019 19:09:29 +0800
From: Mars Cheng <mars.cheng@mediatek.com>
To: Will Deacon <will.deacon@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, "Paul
 E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH 1/1] arm64: Use _rcuidle for smp_cross_call() tracepoints
Date: Tue, 12 Feb 2019 19:09:25 +0800
Message-ID: <1549969765-3707-1-git-send-email-mars.cheng@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-TM-SNTS-SMTP: 1731896514CCA5E36CA281726A01A3970BA1EDC218C2A61281BD864EDE78E57F2000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_030943_710875_610E3B4A 
X-CRM114-Status: UNSURE (   9.69  )
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
Cc: CC Hwang <cc.hwang@mediatek.com>, wsd_upstream@mediatek.com,
 Loda Chou <loda.chou@mediatek.com>, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Mars
 Cheng <mars.cheng@mediatek.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

fix similar issue for aarch64 as the commit 7c64cc0531fa
("arm: Use _rcuidle for smp_cross_call() tracepoints") fixed
in aarch32

Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
---
 arch/arm64/kernel/smp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 1598d6f..c1cf8f9 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -758,7 +758,7 @@ void __init set_smp_cross_call(void (*fn)(const struct cpumask *, unsigned int))
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 {
-	trace_ipi_raise(target, ipi_types[ipinr]);
+	trace_ipi_raise_rcuidle(target, ipi_types[ipinr]);
 	__smp_cross_call(target, ipinr);
 }
 
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
