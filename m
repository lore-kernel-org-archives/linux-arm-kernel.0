Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21716C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:52:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAE3E217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XWC4MOn1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE3E217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KA3VCViDzy1ggG8CwIQ4kqoxRJVg7eHrJWBFJ4bukhQ=; b=XWC4MOn1lwEXB8
	DPtODxdbbTY0Cc3rwyuV35MdhxyWnlgY1T+ZqF9HYYEmpAp5MrhluOVyWe83EBR8QFs3aTW0qFePt
	OfmDa1c5nUwtWxfI/M7h6nPTiXWHzdzcDedUZg0NXhLmQLKeDsngntpDBUzkhU6XHlE3iFYvhDPKh
	hq+uFnyJMapy6tjNowCSBseWaf2clBH3zHuI853lor/RI47+c+RnWfDc0IeCLJ0PvBmGJ9NjFz/sJ
	EYDi33ULm5U5qWwbJYU1XvP2mjcKV46kHKi63n7wYc0laZfbFE4MyJnCDDW+ZGqgSYe4euk2apUpM
	uqZavjow10Dm36buIAWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grTEu-00005X-IC; Wed, 06 Feb 2019 19:52:08 +0000
Received: from relay11.mail.gandi.net ([217.70.178.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grT5I-0003a7-7s
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 19:42:24 +0000
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
 (Authenticated sender: maxime.ripard@bootlin.com)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id 9E14C10000B;
 Wed,  6 Feb 2019 19:42:08 +0000 (UTC)
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v2 3/7] of: address: Add parent pointer to the
 __of_translate_address args
Date: Wed,  6 Feb 2019 20:41:20 +0100
Message-Id: <9c1de6009a7e09252c01df8d8b906409ec602e16.1549482066.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.ddd928eab0069d426b711e69940918eaf85625ce.1549482066.git-series.maxime.ripard@bootlin.com>
References: <cover.ddd928eab0069d426b711e69940918eaf85625ce.1549482066.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_114212_905026_E06D5FB1 
X-CRM114-Status: GOOD (  17.04  )
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
Cc: devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org,
 Georgi Djakov <georgi.djakov@linaro.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Yong Deng <yong.deng@magewell.com>, Robin Murphy <robin.murphy@arm.com>,
 Dave Martin <dave.martin@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The __of_translate_address function is used to translate the device tree
addresses to physical addresses using the various ranges property to create
the offset.

However, it's shared between the CPU addresses (based on the ranges
property) and the DMA addresses (based on dma-ranges). Since we're going to
add support for a DMA parent node that is not the DT parent node, we need
to change the logic a bit to have an optional parent node that we should
use.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/of/address.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 2270373b30ab..4c5dc21c71ca 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -569,10 +569,10 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
  * relative to that node.
  */
 static u64 __of_translate_address(struct device_node *dev,
+				  struct device_node *parent,
 				  const __be32 *in_addr, const char *rprop,
 				  struct device_node **host)
 {
-	struct device_node *parent = NULL;
 	struct of_bus *bus, *pbus;
 	__be32 addr[OF_MAX_ADDR_CELLS];
 	int na, ns, pna, pns;
@@ -583,11 +583,14 @@ static u64 __of_translate_address(struct device_node *dev,
 	/* Increase refcount at current level */
 	of_node_get(dev);
 
-	*host = NULL;
-	/* Get parent & match bus type */
-	parent = of_get_parent(dev);
-	if (parent == NULL)
-		goto bail;
+	if (!parent) {
+		*host = NULL;
+		/* Get parent & match bus type */
+		parent = of_get_parent(dev);
+		if (parent == NULL)
+			goto bail;
+	}
+
 	bus = of_match_bus(parent);
 
 	/* Count address cells & copy address locally */
@@ -665,7 +668,7 @@ u64 of_translate_address(struct device_node *dev, const __be32 *in_addr)
 	struct device_node *host;
 	u64 ret;
 
-	ret = __of_translate_address(dev, in_addr, "ranges", &host);
+	ret = __of_translate_address(dev, NULL, in_addr, "ranges", &host);
 	if (host) {
 		of_node_put(host);
 		return OF_BAD_ADDR;
@@ -680,7 +683,7 @@ u64 of_translate_dma_address(struct device_node *dev, const __be32 *in_addr)
 	struct device_node *host;
 	u64 ret;
 
-	ret = __of_translate_address(dev, in_addr, "dma-ranges", &host);
+	ret = __of_translate_address(dev, NULL, in_addr, "dma-ranges", &host);
 
 	if (host) {
 		of_node_put(host);
@@ -736,7 +739,7 @@ static u64 of_translate_ioport(struct device_node *dev, const __be32 *in_addr,
 	unsigned long port;
 	struct device_node *host;
 
-	taddr = __of_translate_address(dev, in_addr, "ranges", &host);
+	taddr = __of_translate_address(dev, NULL, in_addr, "ranges", &host);
 	if (host) {
 		/* host-specific port access */
 		port = logic_pio_trans_hwaddr(&host->fwnode, taddr, size);
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
