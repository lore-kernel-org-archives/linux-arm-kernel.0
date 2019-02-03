Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BD0C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:04:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8279421841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CE9vZXW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8279421841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OUPeVNbJeOmZYhtbMmWfUZsQY6YBnrapOXNuxsPv2SE=; b=CE9vZXW3YlN2rs
	igLdem0Mc+X+FsOtyqolluNa/3Et0q35e8OaZqgbq1Aotv56Xx1aZk8xffqZaTOPVaJnN87pdQrYD
	RO//ddVLSJHqem8yOdty/vRho1zwruy/4MwC4URikvkCdKh4pNdBkXagAp7BjxYzJloW3y/iv37GR
	fEwYn47B9LwSOhmIc2lL5djWwN5EQa0Cqpe4CsfiW+Uh+GXOVPv6UpBQUTP/cU2xKR+0Wg/icAwQx
	9RvjpmVb18eUfuAaozbl+UpjuDud3UfTODF0WzZH5yhTMntOXXFWHHnRKyZe8SB48xzj7hXwUOZmL
	oJ1zYSVl9ZRgI62EO2oQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqKFk-00047j-5w; Sun, 03 Feb 2019 16:04:16 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqKFX-0003xO-63
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 16:04:04 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 9E56B5FB7A; Mon,  4 Feb 2019 00:04:01 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Yong Deng <yong.deng@magewell.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 1/3] media: sun6i: Fix CSI regmap's max_register
Date: Mon,  4 Feb 2019 00:03:56 +0800
Message-Id: <20190203160358.21050-2-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190203160358.21050-1-wens@csie.org>
References: <20190203160358.21050-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_080403_360326_D47D4A33 
X-CRM114-Status: GOOD (  13.19  )
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
Cc: stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

max_register is currently set to 0x1000. This is beyond the mapped
address range of the hardware, so attempts to dump the regmap from
debugfs would trigger a kernel exception.

Furthermore, the useful registers only occupy a small section at the
beginning of the full range. Change the value to 0x9c, the last known
register on the V3s and H3.

On the A31, the register range is extended to support additional
capture channels. Since this is not yet supported, ignore it for now.

Fixes: 5cc7522d8965 ("media: sun6i: Add support for Allwinner CSI V3s")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index ee882b66a5ea..332cf81a7ecf 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -793,7 +793,7 @@ static const struct regmap_config sun6i_csi_regmap_config = {
 	.reg_bits       = 32,
 	.reg_stride     = 4,
 	.val_bits       = 32,
-	.max_register	= 0x1000,
+	.max_register	= 0x9c,
 };
 
 static int sun6i_csi_resource_request(struct sun6i_csi_dev *sdev,
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
