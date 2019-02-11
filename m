Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C82C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:04:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65510222AD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VPW8liHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65510222AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IenMirDwlzPZwXIKJjy772jS4GTQhc/V8C6MtxySeX4=; b=VPW8liHVUxc3bD
	cPl0QNYCDphrSUQrv9FrJrZtrbgiJ/jI/HqIE+ozBy03fzEhf3Q0Wp1Js6rN0AexiQub9jXO+jD9V
	43PxtblFbWfB1SqhkMLvC+NF30n28eMOsB3omMRkuG70GOz0ElhDNzVRkr+R4ARPG3w+7s1q+TeBk
	RqfQbRWm0RXs7/dcXKV8IxnVYLEoQ7HgLN1WyydUzVdrl6OXjGECApZkFsVDya4vyRyP4KKXczHe2
	zFuUawE+NwORTnYYFhG63Nhniqemd9F9SFayobHzaJWu9DBDOMuCr0YlqlhQvq7Z5mfSgVCceO8Yq
	+E32vwSr4+G4dzele7Bw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtD81-0001GI-E4; Mon, 11 Feb 2019 15:04:13 +0000
Received: from relay1-d.mail.gandi.net ([217.70.183.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtD7F-0000Si-6B
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 15:03:34 +0000
X-Originating-IP: 185.94.189.187
Received: from localhost (unknown [185.94.189.187])
 (Authenticated sender: maxime.ripard@bootlin.com)
 by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id AD597240019;
 Mon, 11 Feb 2019 15:03:19 +0000 (UTC)
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v3 4/7] of: address: Add support for the parent DMA bus
Date: Mon, 11 Feb 2019 16:02:52 +0100
Message-Id: <fc76568f10be15b0dfc7515d6affecb20de3e479.1549897336.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.f2e5fbb4d21384168973fa32377a33d627768146.1549897336.git-series.maxime.ripard@bootlin.com>
References: <cover.f2e5fbb4d21384168973fa32377a33d627768146.1549897336.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_070325_584309_02545B01 
X-CRM114-Status: GOOD (  14.68  )
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

Some SoCs have devices that are using a separate bus from the main bus to
perform DMA.

These buses might have some restrictions and/or different mapping than from
the CPU side, so we'd need to express those using the usual dma-ranges, but
using a different DT node than the node's parent.

Now that the generic interconnect bindings are available, we can model an
interconnect with the reserved name "dma" for those use-cases.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/of/address.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 4c5dc21c71ca..0e9d87a664f5 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -583,8 +583,8 @@ static u64 __of_translate_address(struct device_node *dev,
 	/* Increase refcount at current level */
 	of_node_get(dev);
 
+	*host = NULL;
 	if (!parent) {
-		*host = NULL;
 		/* Get parent & match bus type */
 		parent = of_get_parent(dev);
 		if (parent == NULL)
@@ -678,12 +678,34 @@ u64 of_translate_address(struct device_node *dev, const __be32 *in_addr)
 }
 EXPORT_SYMBOL(of_translate_address);
 
+static struct device_node *__of_get_dma_parent(struct device_node *np)
+{
+	struct of_phandle_args args;
+	unsigned int index;
+	int ret;
+
+	ret = of_property_match_string(np, "interconnect-names", "dma");
+	if (ret < 0)
+		return of_get_parent(np);
+
+	ret = of_parse_phandle_with_args(np, "interconnects",
+					 "#interconnect-cells",
+					 index, &args);
+	if (ret < 0)
+		return of_get_parent(np);
+
+	return of_node_get(args.np);
+}
+
 u64 of_translate_dma_address(struct device_node *dev, const __be32 *in_addr)
 {
+	struct device_node *parent;
 	struct device_node *host;
 	u64 ret;
 
-	ret = __of_translate_address(dev, NULL, in_addr, "dma-ranges", &host);
+	parent = __of_get_dma_parent(dev);
+	ret = __of_translate_address(dev, parent, in_addr, "dma-ranges", &host);
+	of_node_put(parent);
 
 	if (host) {
 		of_node_put(host);
@@ -911,9 +933,15 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
 		return -EINVAL;
 
 	while (1) {
+		struct device_node *parent;
+
 		naddr = of_n_addr_cells(node);
 		nsize = of_n_size_cells(node);
-		node = of_get_next_parent(node);
+
+		parent = __of_get_dma_parent(node);
+		of_node_put(node);
+
+		node = parent;
 		if (!node)
 			break;
 
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
