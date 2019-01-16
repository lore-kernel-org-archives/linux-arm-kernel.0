Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B453FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:29:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84766206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GPa13xOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84766206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=HIp0IGsVUOmZXsGCMfsHHj3mp4Vhn63lx9hKLSbgCfw=; b=GPa13xOLo1yR2R65EhTjWt9S5o
	2wVzNQXDh8GJdN6LgVZQTIcWpTBPA1uY/vSGhnY2kYHyFSXwdeeQ2NWL5q4j8458eiXywNdHSHMeK
	CcyIF1TPY3F5RqSkQUzwqVywILZsmX+I1q/puB48s1jdliZ1r3gyKHPvWnQ51tOjTDiw7DPGzhxER
	6ANQlmeRm6ybv1AVOGHH/81PZ2Uu3xX7XC7L/dKy1EYchxa9lwBLRXNJj3Be8CZkld4VPUWbMlakN
	cdPNq3QJUKANRlUECuwEmJxhfodgPZbRKlFqtM8vRBE4br85CcuoW8RhiHPkZ72ES8uYqnDhm2fG0
	CTWMIb8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjjO3-0004bq-El; Wed, 16 Jan 2019 11:29:35 +0000
Received: from inva021.nxp.com ([92.121.34.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjjNz-0004bR-VO
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 11:29:33 +0000
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 847BB2000BB;
 Wed, 16 Jan 2019 12:29:30 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 77A3C200046;
 Wed, 16 Jan 2019 12:29:30 +0100 (CET)
Received: from fsr-ub1864-101.ea.freescale.net
 (fsr-ub1864-101.ea.freescale.net [10.171.82.46])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id DAC532060F;
 Wed, 16 Jan 2019 12:29:29 +0100 (CET)
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: linux-i2c@vger.kernel.org, linux-imx@nxp.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, wsa@the-dreams.de
Subject: [PATCH v2 2/2] i2c: imx: defer probing on dma channel request
Date: Wed, 16 Jan 2019 13:28:55 +0200
Message-Id: <20190116112855.13824-2-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190116112855.13824-1-laurentiu.tudor@nxp.com>
References: <20190116112855.13824-1-laurentiu.tudor@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_032932_197005_2E3B32BC 
X-CRM114-Status: GOOD (  11.14  )
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
Cc: fabio.estevam@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 leoyang.li@nxp.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

If the dma controller is not yet probed, defer i2c probe.
The error path in probe was slightly modified (no functional change)
to avoid triggering this WARN_ON():
"cg-pll0-div1 already disabled
WARNING: CPU: 1 PID: 1 at drivers/clk/clk.c:828 clk_core_disable+0xa8/0xb0"

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
Changes in v2:
 - rebased on latest i2c tree
 - fix small error introduced by a previous commit (first patch)

 drivers/i2c/busses/i2c-imx.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 42fed40198a0..4e34b1572756 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1111,7 +1111,8 @@ static int i2c_imx_probe(struct platform_device *pdev)
 				pdev->name, i2c_imx);
 	if (ret) {
 		dev_err(&pdev->dev, "can't claim irq %d\n", irq);
-		goto clk_disable;
+		clk_disable_unprepare(i2c_imx->clk);
+		return ret;
 	}
 
 	/* Init queue */
@@ -1161,19 +1162,25 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
+	/* Init DMA config if supported */
+	ret = i2c_imx_dma_request(i2c_imx, phy_addr);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_info(&pdev->dev, "can't use DMA, using PIO instead.\n");
+		else
+			goto del_adapter;
+	}
+
 	dev_dbg(&i2c_imx->adapter.dev, "claimed irq %d\n", irq);
 	dev_dbg(&i2c_imx->adapter.dev, "device resources: %pR\n", res);
 	dev_dbg(&i2c_imx->adapter.dev, "adapter name: \"%s\"\n",
 		i2c_imx->adapter.name);
 
-	/* Init DMA config if supported */
-	ret = i2c_imx_dma_request(i2c_imx, phy_addr);
-	if (ret < 0)
-		goto clk_notifier_unregister;
-
 	dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
 	return 0;   /* Return OK */
 
+del_adapter:
+	i2c_del_adapter(&i2c_imx->adapter);
 clk_notifier_unregister:
 	clk_notifier_unregister(i2c_imx->clk, &i2c_imx->clk_change_nb);
 rpm_disable:
@@ -1182,8 +1189,6 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 
-clk_disable:
-	clk_disable_unprepare(i2c_imx->clk);
 	return ret;
 }
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
