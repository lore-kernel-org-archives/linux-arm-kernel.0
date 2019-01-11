Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040F5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:11:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBAC720878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U4DcLJcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBAC720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=bMqKiw3I9dvYOdVpDLsAzbDXYSI/Vi7sNvtEvRGrfzY=; b=U4D
	cLJcjVHGkMAoIKjh05muXTIasYRSRfAfE2B9ZYCGfqv7pieOXRPkbou64vkBCldVKRI3xxXqn6ema
	dbw//3pWAk+P6W0YUaHXqBqIm2iHQOKciWCVjRda/9geoPSxv6sYzjX5IUIDkG2Jsv/2lBNeZfqPZ
	xvNCQA7D3GvbEc1p6DANsn2I9oVk1m0xlTcnctlx4moIi+E/KjvDlz6k7YeA4HH5zty5y9nKQcxzb
	NKzBjGIvxZ/ET5Tnn0LysQaYX+UEcgzgfkMxQxTd90VQTrDcAzgFVgy6A9IH/xkugK56kV/Kn1LJG
	KulJKg0r7uRp0/lJHIHLqohO/SeKxxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi51W-0003sV-5X; Fri, 11 Jan 2019 22:11:30 +0000
Received: from inva020.nxp.com ([92.121.34.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi51S-0003s2-KG
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 22:11:28 +0000
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1E9061A0200;
 Fri, 11 Jan 2019 23:11:24 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D891D1A01FC;
 Fri, 11 Jan 2019 23:11:23 +0100 (CET)
Received: from someleo.am.freescale.net (someleo.am.freescale.net
 [10.81.33.49])
 by inv1260.us-phx01.nxp.com (Postfix) with ESMTP id F0C5D40CAF;
 Fri, 11 Jan 2019 15:11:22 -0700 (MST)
From: Li Yang <leoyang.li@nxp.com>
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>,
 Scott Wood <oss@buserror.net>
Subject: [PATCH] soc: fsl: guts: reuse machine name from device tree
Date: Fri, 11 Jan 2019 16:11:07 -0600
Message-Id: <20190111221107.952-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_141126_853119_4AFBD82C 
X-CRM114-Status: UNSURE (   9.91  )
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
Cc: Li Yang <leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Reuse the string machine from the device tree data structure instead
of duplicating the data again.  This also prevents a potential memory
allocation failure that was not handled previously.  Also fixes an early
put of root device node.

Reported-by: Nicholas Mc Guire <hofrat@osadl.org>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 drivers/soc/fsl/guts.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 302e0c8d69d9..4f9655087bd7 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -32,6 +32,7 @@ struct fsl_soc_die_attr {
 static struct guts *guts;
 static struct soc_device_attribute soc_dev_attr;
 static struct soc_device *soc_dev;
+static struct device_node *root;
 
 
 /* SoC die attribute definition for QorIQ platform */
@@ -132,7 +133,7 @@ EXPORT_SYMBOL(fsl_guts_get_svr);
 
 static int fsl_guts_probe(struct platform_device *pdev)
 {
-	struct device_node *root, *np = pdev->dev.of_node;
+	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 	const struct fsl_soc_die_attr *soc_die;
@@ -155,9 +156,8 @@ static int fsl_guts_probe(struct platform_device *pdev)
 	root = of_find_node_by_path("/");
 	if (of_property_read_string(root, "model", &machine))
 		of_property_read_string_index(root, "compatible", 0, &machine);
-	of_node_put(root);
 	if (machine)
-		soc_dev_attr.machine = devm_kstrdup(dev, machine, GFP_KERNEL);
+		soc_dev_attr.machine = machine;
 
 	svr = fsl_guts_get_svr();
 	soc_die = fsl_soc_die_match(svr, fsl_soc_die);
@@ -192,6 +192,7 @@ static int fsl_guts_probe(struct platform_device *pdev)
 static int fsl_guts_remove(struct platform_device *dev)
 {
 	soc_device_unregister(soc_dev);
+	of_node_put(root);
 	return 0;
 }
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
