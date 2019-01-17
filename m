Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3505CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:55:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE0820651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NJzulz0V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE0820651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=TNXZ03294Wyp48Nr05NfknVDCamz9cf2XdPV/lzhql4=; b=NJzulz0VtM8yxqBF99YgS5WXFq
	CE9xuKDyc5WeWLOFViFnrffmeri16o50PgPhQrUIenbXvBSaZV4T7uk2AgmWXaWF4ULTaRdno76yO
	lli3nIs59+en2KAInqcVBKLfcT1d3U4ZpoUAN+2xxZtb/d6pcxmculgVWVUh1Yk8TUi+TTL7h9igm
	E78bdFpXh/ESt+mLX5Bj/PFLMxBpX8heZVF2Jv9+wM8iDPsQn1phmwLzxD8ENW9hCPyjlfCVRT87m
	EDPGEb4u5GVgNCwiCwFJ25Rad35Ci42F5uTWqP45H4P6uIiWxnXhF51QmiKPKEWtBXB4qGJjpo+DS
	RbEoiGXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjwuN-0007MV-Bx; Thu, 17 Jan 2019 01:55:51 +0000
Received: from inva020.nxp.com ([92.121.34.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjwth-0006La-0c
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 01:55:10 +0000
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3EA181A0174;
 Thu, 17 Jan 2019 02:55:04 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 265891A0160;
 Thu, 17 Jan 2019 02:55:00 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 02BEA402E8;
 Thu, 17 Jan 2019 09:54:54 +0800 (SGT)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [v2, 1/5] ptp_qoriq: fix interrupt enabling and handling
Date: Thu, 17 Jan 2019 09:49:32 +0800
Message-Id: <20190117014936.48117-2-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190117014936.48117-1-yangbo.lu@nxp.com>
References: <20190117014936.48117-1-yangbo.lu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_175509_454975_9AEA8C25 
X-CRM114-Status: GOOD (  10.93  )
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
Cc: Richard Cochran <richardcochran@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Yangbo Lu <yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The tmr_tevent register would update event bits
no matter tmr_temask bits were set or not. So we
should get interrupts by tmr_tevent & tmr_temask,
and clean up interrupts in tmr_tevent before
enabling them.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- Remove useless lock/register operations.
---
 drivers/ptp/ptp_qoriq.c |   62 +++++++++++++++++++++++-----------------------
 1 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/ptp/ptp_qoriq.c b/drivers/ptp/ptp_qoriq.c
index fdd49c2..2743214 100644
--- a/drivers/ptp/ptp_qoriq.c
+++ b/drivers/ptp/ptp_qoriq.c
@@ -98,11 +98,18 @@ static irqreturn_t isr(int irq, void *priv)
 	struct qoriq_ptp_registers *regs = &qoriq_ptp->regs;
 	struct ptp_clock_event event;
 	u64 ns;
-	u32 ack = 0, lo, hi, mask, val;
+	u32 ack = 0, lo, hi, mask, val, irqs;
+
+	spin_lock(&qoriq_ptp->lock);
 
 	val = qoriq_read(&regs->ctrl_regs->tmr_tevent);
+	mask = qoriq_read(&regs->ctrl_regs->tmr_temask);
+
+	spin_unlock(&qoriq_ptp->lock);
+
+	irqs = val & mask;
 
-	if (val & ETS1) {
+	if (irqs & ETS1) {
 		ack |= ETS1;
 		hi = qoriq_read(&regs->etts_regs->tmr_etts1_h);
 		lo = qoriq_read(&regs->etts_regs->tmr_etts1_l);
@@ -113,7 +120,7 @@ static irqreturn_t isr(int irq, void *priv)
 		ptp_clock_event(qoriq_ptp->clock, &event);
 	}
 
-	if (val & ETS2) {
+	if (irqs & ETS2) {
 		ack |= ETS2;
 		hi = qoriq_read(&regs->etts_regs->tmr_etts2_h);
 		lo = qoriq_read(&regs->etts_regs->tmr_etts2_l);
@@ -124,7 +131,7 @@ static irqreturn_t isr(int irq, void *priv)
 		ptp_clock_event(qoriq_ptp->clock, &event);
 	}
 
-	if (val & ALM2) {
+	if (irqs & ALM2) {
 		ack |= ALM2;
 		if (qoriq_ptp->alarm_value) {
 			event.type = PTP_CLOCK_ALARM;
@@ -136,13 +143,10 @@ static irqreturn_t isr(int irq, void *priv)
 			ns = qoriq_ptp->alarm_value + qoriq_ptp->alarm_interval;
 			hi = ns >> 32;
 			lo = ns & 0xffffffff;
-			spin_lock(&qoriq_ptp->lock);
 			qoriq_write(&regs->alarm_regs->tmr_alarm2_l, lo);
 			qoriq_write(&regs->alarm_regs->tmr_alarm2_h, hi);
-			spin_unlock(&qoriq_ptp->lock);
 			qoriq_ptp->alarm_value = ns;
 		} else {
-			qoriq_write(&regs->ctrl_regs->tmr_tevent, ALM2);
 			spin_lock(&qoriq_ptp->lock);
 			mask = qoriq_read(&regs->ctrl_regs->tmr_temask);
 			mask &= ~ALM2EN;
@@ -153,7 +157,7 @@ static irqreturn_t isr(int irq, void *priv)
 		}
 	}
 
-	if (val & PP1) {
+	if (irqs & PP1) {
 		ack |= PP1;
 		event.type = PTP_CLOCK_PPS;
 		ptp_clock_event(qoriq_ptp->clock, &event);
@@ -260,7 +264,7 @@ static int ptp_qoriq_enable(struct ptp_clock_info *ptp,
 	struct qoriq_ptp *qoriq_ptp = container_of(ptp, struct qoriq_ptp, caps);
 	struct qoriq_ptp_registers *regs = &qoriq_ptp->regs;
 	unsigned long flags;
-	u32 bit, mask;
+	u32 bit, mask = 0;
 
 	switch (rq->type) {
 	case PTP_CLK_REQ_EXTTS:
@@ -274,32 +278,28 @@ static int ptp_qoriq_enable(struct ptp_clock_info *ptp,
 		default:
 			return -EINVAL;
 		}
-		spin_lock_irqsave(&qoriq_ptp->lock, flags);
-		mask = qoriq_read(&regs->ctrl_regs->tmr_temask);
-		if (on)
-			mask |= bit;
-		else
-			mask &= ~bit;
-		qoriq_write(&regs->ctrl_regs->tmr_temask, mask);
-		spin_unlock_irqrestore(&qoriq_ptp->lock, flags);
-		return 0;
-
+		break;
 	case PTP_CLK_REQ_PPS:
-		spin_lock_irqsave(&qoriq_ptp->lock, flags);
-		mask = qoriq_read(&regs->ctrl_regs->tmr_temask);
-		if (on)
-			mask |= PP1EN;
-		else
-			mask &= ~PP1EN;
-		qoriq_write(&regs->ctrl_regs->tmr_temask, mask);
-		spin_unlock_irqrestore(&qoriq_ptp->lock, flags);
-		return 0;
-
-	default:
+		bit = PP1EN;
 		break;
+	default:
+		return -EOPNOTSUPP;
 	}
 
-	return -EOPNOTSUPP;
+	spin_lock_irqsave(&qoriq_ptp->lock, flags);
+
+	mask = qoriq_read(&regs->ctrl_regs->tmr_temask);
+	if (on) {
+		mask |= bit;
+		qoriq_write(&regs->ctrl_regs->tmr_tevent, bit);
+	} else {
+		mask &= ~bit;
+	}
+
+	qoriq_write(&regs->ctrl_regs->tmr_temask, mask);
+
+	spin_unlock_irqrestore(&qoriq_ptp->lock, flags);
+	return 0;
 }
 
 static const struct ptp_clock_info ptp_qoriq_caps = {
-- 
1.7.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
