Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66E8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:56:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A74B20651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ibJQw3zp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A74B20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Wwh2KMHT8Rnq5z4ztXoOXDVZ9byFjaGmrFl+bv8XJM0=; b=ibJQw3zpxGTziyQT0KOurPpClf
	En6EozAgoKOxe+mxydHcrWDhIb6/0awBakM6cpl/ltncusnyyR3qsn0KjgLhcmhoHW7zvSJjoanex
	tLHNaIut1do3Jxdq6AWn0fbngu6scvLucKdFcbXnnWUnm0jtTTewOC4oIaA51lL2ksrlkx2rvrRjb
	f40gOFuwWmNw+LPSeOJUPjYXmUqAOxPVzkYbZ6uaFyXOIDZs0nWZ0+H0ZhZWkw+24BCzvD4wBVlrR
	KHrtwmQ5RfWruNWZwppidTwRVKIYc8/KeXkC2i4UIcW7+4Ly5kgQbjc8G3mMM7N4PGoJ55ZgO/152
	sWy/fJ3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjwut-0007oy-2C; Thu, 17 Jan 2019 01:56:23 +0000
Received: from inva021.nxp.com ([92.121.34.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjwth-0006Sh-C3
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 01:55:11 +0000
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0A1882003BD;
 Thu, 17 Jan 2019 02:55:08 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 248602001FD;
 Thu, 17 Jan 2019 02:55:04 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 044DA402E5;
 Thu, 17 Jan 2019 09:54:58 +0800 (SGT)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [v2, 5/5] ptp_qoriq: add fiper pulse loopback support
Date: Thu, 17 Jan 2019 09:49:36 +0800
Message-Id: <20190117014936.48117-6-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190117014936.48117-1-yangbo.lu@nxp.com>
References: <20190117014936.48117-1-yangbo.lu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_175509_638751_5462AA2E 
X-CRM114-Status: UNSURE (   9.37  )
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
Cc: Richard Cochran <richardcochran@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Yangbo Lu <yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch is to add Kconfig options to support fiper
pulse loopback mode. This is very useful for validating
hardware and driver without external hardware.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- None.
---
 drivers/ptp/Kconfig     |   18 ++++++++++++++++++
 drivers/ptp/ptp_qoriq.c |    7 ++++++-
 2 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index d137c48..561d797 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -55,6 +55,24 @@ config PTP_1588_CLOCK_QORIQ
 	  To compile this driver as a module, choose M here: the module
 	  will be called ptp_qoriq.
 
+config PTP_1588_CLOCK_QORIQ_FIPER1_LOOPBACK
+	bool "Fiper1 pulse loopback"
+	depends on PTP_1588_CLOCK_QORIQ
+	default n
+	help
+	  Enable fiper1 pulse loopback mode. If choose y, fiper1 pulse is
+	  looped back into trigger1 input. In default, trigger1 input is
+	  based upon normal external trigger input.
+
+config PTP_1588_CLOCK_QORIQ_FIPER2_LOOPBACK
+	bool "Fiper2 pulse loopback"
+	depends on PTP_1588_CLOCK_QORIQ
+	default n
+	help
+	  Enable fiper2 pulse loopback mode. If choose y, fiper2 pulse is
+	  looped back into trigger2 input. In default, trigger2 input is
+	  based upon normal external trigger input.
+
 config PTP_1588_CLOCK_IXP46X
 	tristate "Intel IXP46x as PTP clock"
 	depends on IXP4XX_ETH
diff --git a/drivers/ptp/ptp_qoriq.c b/drivers/ptp/ptp_qoriq.c
index a2e7702..5294475 100644
--- a/drivers/ptp/ptp_qoriq.c
+++ b/drivers/ptp/ptp_qoriq.c
@@ -551,7 +551,12 @@ static int qoriq_ptp_probe(struct platform_device *dev)
 	tmr_ctrl =
 	  (qoriq_ptp->tclk_period & TCLK_PERIOD_MASK) << TCLK_PERIOD_SHIFT |
 	  (qoriq_ptp->cksel & CKSEL_MASK) << CKSEL_SHIFT;
-
+#ifdef CONFIG_PTP_1588_CLOCK_QORIQ_FIPER1_LOOPBACK
+	tmr_ctrl |= PP1L;
+#endif
+#ifdef CONFIG_PTP_1588_CLOCK_QORIQ_FIPER2_LOOPBACK
+	tmr_ctrl |= PP2L;
+#endif
 	spin_lock_irqsave(&qoriq_ptp->lock, flags);
 
 	regs = &qoriq_ptp->regs;
-- 
1.7.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
