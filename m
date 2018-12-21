Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3A2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:42:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D0E821917
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ONmoUv5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0E821917
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:Reply-To:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Message-Id:Date:Subject:To:From:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=bIXhDVTcYZnPyQoPwoTZc0ieG+k8386Cuz2qPxhZ4G4=; b=ONm
	oUv5cMnxUdl0L3Rk/3dZJKrEfTjrj+9oDtrsdpcxAEULd+YufNnaAXXOAkmS8Ro1xcq7KKefRJcUe
	4B5/m6G9S401fJLLGojhjBIFBPqCLMop7a9/Gn/ZW+e/c3oglq9XsGp5J12mjLeUfMMgo/9JQMMEt
	0ZMasoKFAQSGouo7J7DKDPctTpwkBRdGFThsjpQAG1fl4B3406xu7j2QLVWqOAPfW5olQt4UD6R0t
	lFJL+q1BZGCMcVm+htEZSqeTEQZr/w1FN9Du+8pHJDGE+pKYjj/fwpEi0cA0PBG+swDAHUUBjuG3i
	zSkPkCnxeg94tYUAiesTc8DGacNViJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaM03-0000wo-Nl; Fri, 21 Dec 2018 14:42:03 +0000
Received: from inva021.nxp.com ([92.121.34.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaLzz-0000vr-8v
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 14:42:00 +0000
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 469862004DE;
 Fri, 21 Dec 2018 15:41:45 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3A353200023;
 Fri, 21 Dec 2018 15:41:45 +0100 (CET)
Received: from fsr-fed2164-101.ea.freescale.net
 (fsr-fed2164-101.ea.freescale.net [10.171.82.91])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id D0D50205E9;
 Fri, 21 Dec 2018 15:41:44 +0100 (CET)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: leoyang.li@nxp.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] soc: fsl: qbman: avoid race in clearing QMan interrupt
Date: Fri, 21 Dec 2018 16:41:42 +0200
Message-Id: <1545403302-22475-1-git-send-email-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.1.0
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_064159_449498_F38633DE 
X-CRM114-Status: UNSURE (   8.26  )
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
Reply-To: madalin.bucur@nxp.com
Cc: Madalin Bucur <madalin.bucur@nxp.com>, netdev@vger.kernel.org,
 roy.pledge@nxp.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

By clearing all interrupt sources, not only those that
already occurred, the existing code may acknowledge by
mistake interrupts that occurred after the code checks
for them.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/qman.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 52c153cd795a..636f83f781f5 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -1143,18 +1143,19 @@ static void qm_mr_process_task(struct work_struct *work);
 static irqreturn_t portal_isr(int irq, void *ptr)
 {
 	struct qman_portal *p = ptr;
-
-	u32 clear = QM_DQAVAIL_MASK | p->irq_sources;
 	u32 is = qm_in(&p->p, QM_REG_ISR) & p->irq_sources;
+	u32 clear = 0;
 
 	if (unlikely(!is))
 		return IRQ_NONE;
 
 	/* DQRR-handling if it's interrupt-driven */
-	if (is & QM_PIRQ_DQRI)
+	if (is & QM_PIRQ_DQRI) {
 		__poll_portal_fast(p, QMAN_POLL_LIMIT);
+		clear = QM_DQAVAIL_MASK | QM_PIRQ_DQRI;
+	}
 	/* Handling of anything else that's interrupt-driven */
-	clear |= __poll_portal_slow(p, is);
+	clear |= __poll_portal_slow(p, is) & QM_PIRQ_SLOW;
 	qm_out(&p->p, QM_REG_ISR, clear);
 	return IRQ_HANDLED;
 }
-- 
2.1.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
