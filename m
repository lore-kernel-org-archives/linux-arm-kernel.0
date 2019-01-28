Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C08C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:09:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAC2F20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qgf7fujE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="b8CU70kt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="AWjjoniX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC2F20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=h1ghwZNgH2ib20G4qiN0nvmia2JTLNQgIR0cCL4Fegk=; b=qgf7fujENyUQI4MBivCM2cu0Ow
	6UOqGwBQijezrW517UNdxeISE6EF3dNi/xxx4mYI2PhhstmOcsdbRGxynp04cNtmuHtIKoNoZhHlb
	HirJboUPTRpN9SrXEc72kLsBJuth4ITY6HHcoLUGdoxYvOKu9Giz7wTomdlTQ5S8LyHFeZJarq13H
	MijOgDbyCjsoAYgoCO7YAyiw5kLlMtjlGtpU5qF+Sbuw+iVAtuPEBdNbBSvP1li+Jol8Rwr1L6dmy
	3atJR7UGI8apnikyUp3IkVb1Zt3ZmwJ06+PtQ/CJQ+I4fO0gNYw5P+7WXSiQ41TFmmP+HFyO6obxy
	8JwUi2Ug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go06w-0002i5-Go; Mon, 28 Jan 2019 06:09:34 +0000
Received: from node.akkea.ca ([192.155.83.177])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go06E-0002AF-Cx
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 06:08:52 +0000
Received: from localhost (localhost [127.0.0.1])
 by node.akkea.ca (Postfix) with ESMTP id 477074E2056;
 Mon, 28 Jan 2019 06:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1548655730; bh=QmIBLVdbJ3X4Zs3xnT5fPDB4oumJvEdRGSTkpTuJ1IY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=b8CU70ktiDkZpcm+wWRJIw9jpU6z7PbEOGA0NIg0BCGT6Ww1gQD5/ILOB8xbkj8qj
 LLix5RnXTd2KCOuQq/l2Z6wLh26Hks5Rd8r+NeoifT3ktqrIGerQcc/BF1MJFeeO/S
 MSPzVEvPWVe83MXYBbL9Nw5sggzWnXPa+1cQAKTQ=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
 by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B6J09s486Qe7; Mon, 28 Jan 2019 06:08:49 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca
 [198.48.167.13])
 by node.akkea.ca (Postfix) with ESMTPSA id 36A2C4E204B;
 Mon, 28 Jan 2019 06:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1548655729; bh=QmIBLVdbJ3X4Zs3xnT5fPDB4oumJvEdRGSTkpTuJ1IY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=AWjjoniXOD+Z+ZSRmsENhUdOWO3cDG9GAwi9la/RH6b42yLiSxm2qL07VJz4ZQiwZ
 W1AqqpjfBE8fbKUA0ezQwoWJm2B4wC+7mBFSTFARXChp+cnlPKejmHvFm7wE9t2a7p
 GCwUZcsbc8M6tKyYhiqSPkJNcl0ir4m8+x39fKuc=
From: "Angus Ainslie (Purism)" <angus@akkea.ca>
To: angus@akkea.ca
Subject: [PATCH v5 2/5] dmaengine: imx-sdma: add imx8mq sdma compatible parts
Date: Sun, 27 Jan 2019 23:08:37 -0700
Message-Id: <20190128060840.31695-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190128060840.31695-1-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190128060840.31695-1-angus@akkea.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_220850_454808_6BD80D30 
X-CRM114-Status: UNSURE (   7.86  )
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, angus.ainslie@puri.sm,
 linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This is identical to the imx7d.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/dma/imx-sdma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 757fad2fbfae..c4db4fe6bcc9 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -578,6 +578,9 @@ static const struct platform_device_id sdma_devtypes[] = {
 	}, {
 		.name = "imx7d-sdma",
 		.driver_data = (unsigned long)&sdma_imx7d,
+	}, {
+		.name = "imx8mq-sdma",
+		.driver_data = (unsigned long)&sdma_imx7d,
 	}, {
 		/* sentinel */
 	}
@@ -592,6 +595,7 @@ static const struct of_device_id sdma_dt_ids[] = {
 	{ .compatible = "fsl,imx31-sdma", .data = &sdma_imx31, },
 	{ .compatible = "fsl,imx25-sdma", .data = &sdma_imx25, },
 	{ .compatible = "fsl,imx7d-sdma", .data = &sdma_imx7d, },
+	{ .compatible = "fsl,imx8mq-sdma", .data = &sdma_imx7d, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sdma_dt_ids);
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
