Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D9AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:25:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE3B4206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M7mQ7BJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3B4206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qmkQg2ZzXZobYGCgEPk1bG84ikvkqj3tX/ngi5I+Ngc=; b=M7mQ7BJP/gTFCY
	vUNrmPRJVgSkcllAiUQI5+yvpUUSsUc+NJwYtLi5vyNbbW7VdBJtZD5oQsQbWew93IlmVfGMhiwup
	X2b13gzTS3/K12c4VIhltyceUQazcTDI8mE/czM4XAa6d2pA9yhZ0mWpUEZ3Dk3rbpKYQfDEu/MVt
	pmNnkMKvupjp8wgjDqeMbi6nG8tqDDQYmpOSfnyN6U5ZPE6YCd30l+V8k9YQ9IstpIzrNKqonixBX
	QV6H2DceF8YkWMUrcsrOQSj0BiIFQzqlZnUrJkosAQknmns/yDYLlEyum+Fy1V7/qJiytXdtHQFmt
	I0IOGN0if/npB6COsRNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUBdn-0002v2-SS; Tue, 04 Dec 2018 14:25:35 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUBbm-0007fe-OK
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 14:23:47 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 22E2C20EA7; Tue,  4 Dec 2018 15:23:20 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 0FE3B20E22;
 Tue,  4 Dec 2018 15:22:43 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 17/21] drm/sun4i: frontend: Add a quirk structure
Date: Tue,  4 Dec 2018 15:22:14 +0100
Message-Id: <20181204142218.16284-18-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
References: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_062331_949356_46CE882C 
X-CRM114-Status: GOOD (  16.21  )
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
Cc: Daniel Vetter <daniel@ffwll.ch>, Maxime Ripard <maxime.ripard@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-sunxi@googlegroups.com,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The ACCESS_CTRL bit is not found on all the variants of the frontend, so
let's introduce a structure that will hold whether or not we need to set
it, and associate it with the compatible.

This will be extended for further similar quirks later on.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 21 +++++++++++++++++----
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  6 ++++++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index c80338368992..5a2e2057fe6c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/component.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
@@ -74,9 +75,10 @@ static void sun4i_frontend_scaler_init(struct sun4i_frontend *frontend)
 {
 	int i;
 
-	regmap_write_bits(frontend->regs, SUN4I_FRONTEND_FRM_CTRL_REG,
-			  SUN4I_FRONTEND_FRM_CTRL_COEF_ACCESS_CTRL,
-			  SUN4I_FRONTEND_FRM_CTRL_COEF_ACCESS_CTRL);
+	if (frontend->data->has_coef_access_ctrl)
+		regmap_write_bits(frontend->regs, SUN4I_FRONTEND_FRM_CTRL_REG,
+				  SUN4I_FRONTEND_FRM_CTRL_COEF_ACCESS_CTRL,
+				  SUN4I_FRONTEND_FRM_CTRL_COEF_ACCESS_CTRL);
 
 	for (i = 0; i < 32; i++) {
 		regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_HORZCOEF0_REG(i),
@@ -563,6 +565,10 @@ static int sun4i_frontend_bind(struct device *dev, struct device *master,
 	frontend->dev = dev;
 	frontend->node = dev->of_node;
 
+	frontend->data = of_device_get_match_data(dev);
+	if (!frontend->data)
+		return -ENODEV;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(regs))
@@ -675,8 +681,15 @@ static const struct dev_pm_ops sun4i_frontend_pm_ops = {
 	.runtime_suspend	= sun4i_frontend_runtime_suspend,
 };
 
+static const struct sun4i_frontend_data sun8i_a33_frontend = {
+	.has_coef_access_ctrl	= true,
+};
+
 const struct of_device_id sun4i_frontend_of_table[] = {
-	{ .compatible = "allwinner,sun8i-a33-display-frontend" },
+	{
+		.compatible = "allwinner,sun8i-a33-display-frontend",
+		.data = &sun8i_a33_frontend
+	},
 	{ }
 };
 EXPORT_SYMBOL(sun4i_frontend_of_table);
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index 9434407ea40d..22b8afa3795e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -101,6 +101,10 @@ struct drm_plane;
 struct regmap;
 struct reset_control;
 
+struct sun4i_frontend_data {
+	bool	has_coef_access_ctrl;
+};
+
 struct sun4i_frontend {
 	struct list_head	list;
 	struct device		*dev;
@@ -111,6 +115,8 @@ struct sun4i_frontend {
 	struct clk		*ram_clk;
 	struct regmap		*regs;
 	struct reset_control	*reset;
+
+	const struct sun4i_frontend_data	*data;
 };
 
 extern const struct of_device_id sun4i_frontend_of_table[];
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
