Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13049C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:41:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D06EF21720
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HISKIHE9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D06EF21720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=HPyln+/4e3+6EGKhngD/+S8tD+g3mBBtwEQ1aBBEYs4=; b=HISKIHE92ppKZZ
	VWf0yeg1NGbAhioI/qwQJjtRRS29Z8gt0fzjGXFwOgQC5tXO/4/Zv+GwasJWgj8JsA3+k3pN85alP
	+io3MOPwRP6neD+mC0raT46aaWYm9mO+aCER4gcQzwH4n6RbGP583lLf6YGoybmz2W2jpGzey5cBz
	L9DN8IfHEuseSz4MGG93ajBnpCKZG6nAo7vHK2cqyAlVboFkXYF3NNgI8rMHV6PbB1rJoIyN7ZEHD
	m980ZAAXRwem0VHIeGPDO1merrp9tTquAKd15v3qeVavxqGp/OwHvqiOFEpsQQmm9LPkmbLZmzKH8
	Q+VKzpn5OntcFc7pKNIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZttV-0005qD-OV; Thu, 20 Dec 2018 08:41:25 +0000
Received: from [38.106.11.25] (helo=barracuda02.hxt-semitech.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZttR-0005ow-8J
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 08:41:23 +0000
X-ASG-Debug-ID: 1545294088-107606139f1f160001-tbGyMd
Received: from HXTBJIDCEMVIW02.hxtcorp.net (localhost [10.128.0.15]) by
 barracuda02.hxt-semitech.com with ESMTP id FQI9Q7vkbjbmcYWu (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
 Thu, 20 Dec 2018 16:21:28 +0800 (CST)
X-Barracuda-Envelope-From: yuanyuan.zhao@hxt-semitech.com
Received: from localhost.localdomain.localdomain (10.64.5.29) by
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 20 Dec 2018 16:20:30 +0800
From: Zhao Yuanyuan <yuanyuan.zhao@hxt-semitech.com>
To: <marc.zyngier@arm.com>
Subject: [PATCH 1/1] gic: its: Make sure a LPI is discarded before free.
Date: Thu, 20 Dec 2018 16:20:23 +0800
X-ASG-Orig-Subj: [PATCH 1/1] gic: its: Make sure a LPI is discarded before
 free.
Message-ID: <e37e3f5e0146be65c60092a457ca5c82e25581a0.1545292748.git.yuanyuan.zhao@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.64.5.29]
X-ClientProxiedBy: HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) To
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15)
X-Barracuda-Connect: localhost[10.128.0.15]
X-Barracuda-Start-Time: 1545294088
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.102:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 1504
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5002 1.0000 0.7500
X-Barracuda-Spam-Score: 1.35
X-Barracuda-Spam-Status: No, SCORE=1.35 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=MARKETING_SUBJECT
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.64134
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
 0.60 MARKETING_SUBJECT      Subject contains popular marketing words
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_004121_505979_2CB5B8CD 
X-CRM114-Status: UNSURE (   5.11  )
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
Cc: dongsheng.wang@hxt-semitech.com, jason@lakedaemon.net,
 linux-kernel@vger.kernel.org, Zhao Yuanyuan <yuanyuan.zhao@hxt-semitech.com>,
 tglx@linutronix.de, yu.zheng@hxt-semitech.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Its device will be removed after all events be freed.
Undisarded events can lead to unpredictable behaviar.

Signed-off-by: Zhao Yuanyuan <yuanyuan.zhao@hxt-semitech.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index db20e99..4fee008 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2572,6 +2572,10 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
                                                                virq + i);
                u32 event = its_get_event_id(data);

+               /* Discard irq before free */
+               if (irqd_is_activated(d))
+                       its_send_discard(its_dev, event);
+
                /* Mark interrupt index as unused */
                clear_bit(event, its_dev->event_map.lpi_map);

--
1.8.3.1




This email is intended only for the named addressee. It may contain information that is confidential/private, legally privileged, or copyright-protected, and you should handle it accordingly. If you are not the intended recipient, you do not have legal rights to retain, copy, or distribute this email or its contents, and should promptly delete the email and all electronic copies in your system; do not retain copies in any media. If you have received this email in error, please notify the sender promptly. Thank you.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
