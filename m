Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B18C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:48:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2462820859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aSNxx6ia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2462820859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=2VG+D9XkUVQATQZ3azpIMSF1X3s6eHSW3BaDokCoQJI=; b=aSNxx6iaNdPHYp
	T6NE3775Do/p3d/gxP+YSWJVRknZ8tDqYG+tGwu/nrddeqrC1nGO4EtmQCJ06TD1Cbl+aSrCktFG6
	wL9MLaBodIwIxCAKSGg28k9MX6vGSyiwQynTxtWWrB70p6rZNtVLMa9FSrJ3O0x6CvzhUIr6ct8BD
	7BFhPkQaVy0IQJqvPy32V2aTPtpVaB+DA2lMn2/7Xar1IvsGvopTQ7v8RfOThnek80qjTa1E2XT5k
	FJMwCNYLas31q1iUsRJVw1DyIC5Dw4O2yhPKVYIjZNZDe4WBl39BXSc21AwN7P8xAceHfNwtvr/ig
	qIbB2lVoCMgfvEtYO5Jg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggQZm-00066Q-9J; Mon, 07 Jan 2019 08:48:02 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggQZc-0005ut-Fl
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 08:47:55 +0000
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ore@pengutronix.de>)
 id 1ggQZQ-0008NP-AG; Mon, 07 Jan 2019 09:47:40 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.91)
 (envelope-from <ore@pengutronix.de>)
 id 1ggQZP-0001Mc-Jc; Mon, 07 Jan 2019 09:47:39 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Wolfram Sang <wsa@the-dreams.de>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v4 0/2] i2c: imx: rework imx error handling. 
Date: Mon,  7 Jan 2019 09:47:36 +0100
Message-Id: <20190107084738.4130-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_004753_107747_9318D4CC 
X-CRM114-Status: UNSURE (   7.52  )
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
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, linux-i2c@vger.kernel.org,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org,
 NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

changes:
20190107 v4:
 - split one patch to separate patches
 - revert back devm_free(), we need it for -ENODEV case.
 - reword comments.

20181130 v3:
 - reword commit message 
20181112 v2:
 - drop "[PATCH v1 2/3] i2c: imx: probe dma only only on i.MX50 and
   later" and rebase without this patch.
 - Set proper initial author

Oleksij Rempel (2):
  i2c: imx: notify about real errors on dma i2c_imx_dma_request
  i2c: imx: forward error values out of i2c_imx_dma_request()

 drivers/i2c/busses/i2c-imx.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
