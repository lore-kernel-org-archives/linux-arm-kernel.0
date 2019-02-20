Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33312C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:20:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8D2020838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j5ONYzsb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D2020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bNdzDNKMrECtJ5Yd64rZYhzpUnbfT6kUn/MQtmf/OFA=; b=j5ONYzsbfzFX03
	Mt95oZtden8wxr/QuQzHYULlldtpSxkFei7Ud2yfApuJBhOI9kMlqahhjhbVreQCkgXXswNg7n2MG
	v47kCNXBNnfAZPffrqNl7K5qVTdg4nrm+mimroF4shPHZX0clI7cZkykVZljVDOLq1jmaYyHcKO/3
	RP1AwRUPyOH6wa8Bifm/oY12P3hqIyOt8uP7a0tLOctxs18jOpbDpbJVaof64sNRI2mfhU8Wf92a6
	FVgcXycGQ5ilG+N2liJQpH3xpjgG2u5OEIpm6XQgyf1HK1EDQ51BXabw+hXeLPWEe8kMlVLg5kCPh
	ArED7H88hgVsaRYvafXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwWTO-0005SO-B9; Wed, 20 Feb 2019 18:19:58 +0000
Received: from anholt.net ([50.246.234.109])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwWTL-0005Re-AF; Wed, 20 Feb 2019 18:19:56 +0000
Received: from localhost (localhost [127.0.0.1])
 by anholt.net (Postfix) with ESMTP id 9C9DD10A2D1E;
 Wed, 20 Feb 2019 10:19:53 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
 by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id PO7RdZZsgT9d; Wed, 20 Feb 2019 10:19:51 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
 by anholt.net (Postfix) with ESMTP id DAB2610A2D1A;
 Wed, 20 Feb 2019 10:19:51 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
 id 610AD2FE464C; Wed, 20 Feb 2019 10:19:51 -0800 (PST)
From: Eric Anholt <eric@anholt.net>
To: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v2 1/2] soc: bcm: bcm2835-pm: Fix PM_IMAGE_PERI power domain
 support.
Date: Wed, 20 Feb 2019 10:19:50 -0800
Message-Id: <20190220181951.12670-1-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_101955_386833_EF9C3438 
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, linux-kernel@vger.kernel.org,
 Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

We don't have ASB master/slave regs for this domain, so just skip that
step.

Signed-off-by: Eric Anholt <eric@anholt.net>
Fixes: 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domains under a new binding.")
---
 drivers/soc/bcm/bcm2835-power.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/bcm/bcm2835-power.c b/drivers/soc/bcm/bcm2835-power.c
index 48412957ec7a..4a1b99b773c0 100644
--- a/drivers/soc/bcm/bcm2835-power.c
+++ b/drivers/soc/bcm/bcm2835-power.c
@@ -150,7 +150,12 @@ struct bcm2835_power {
 
 static int bcm2835_asb_enable(struct bcm2835_power *power, u32 reg)
 {
-	u64 start = ktime_get_ns();
+	u64 start;
+
+	if (!reg)
+		return 0;
+
+	start = ktime_get_ns();
 
 	/* Enable the module's async AXI bridges. */
 	ASB_WRITE(reg, ASB_READ(reg) & ~ASB_REQ_STOP);
@@ -165,7 +170,12 @@ static int bcm2835_asb_enable(struct bcm2835_power *power, u32 reg)
 
 static int bcm2835_asb_disable(struct bcm2835_power *power, u32 reg)
 {
-	u64 start = ktime_get_ns();
+	u64 start;
+
+	if (!reg)
+		return 0;
+
+	start = ktime_get_ns();
 
 	/* Enable the module's async AXI bridges. */
 	ASB_WRITE(reg, ASB_READ(reg) | ASB_REQ_STOP);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
