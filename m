Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B049DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:32:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 814B220578
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EItoPzr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814B220578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Caen62yZH4qTZXhee1fZYO4Mi63zbj+VHQF1+84O1kk=; b=EItoPzr9JWXnAY
	1mYGJutKk6AMzbNks9o/weLJ02lQjx/KbBXd95OT4v0/I1bcE63umeRiVhTMi30S09JcuMumJCWdt
	eL9AmlU0LuJ2j/CTUqz4YkfQxF4gOVFGbyWAYYy9wZPWXs3Fa0HXysN8bblxO+d8usDaSDPLehpvD
	9CcvFNZVfBf4PtVK91jDslliCHnFrqn++23VnTlXcIESNLJwRua6RjDAjTVk4qBtDdzeWGKjhdk0N
	UbEwXP60TDHg+zFYTCGZi1pUVeKhwQ4+L53W6SuVzBb3WQydJQbcYKP6BHQ1SwLEo4Rzg0hMTeZIe
	azlcrBzHQyqaoTCtiYWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYusN-0003xK-IS; Mon, 17 Dec 2018 15:32:11 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYusK-0003wT-1V
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 15:32:09 +0000
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7]
 helo=dude.pengutronix.de.)
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gYus4-0006Kg-NT; Mon, 17 Dec 2018 16:31:52 +0100
From: Lucas Stach <l.stach@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 2/2] soc: imx: gpcv2: handle reset clocks
Date: Mon, 17 Dec 2018 16:31:52 +0100
Message-Id: <20181217153152.21135-2-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181217153152.21135-1-l.stach@pengutronix.de>
References: <20181217153152.21135-1-l.stach@pengutronix.de>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_073208_301257_95C2EF41 
X-CRM114-Status: GOOD (  17.30  )
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
Cc: devicetree@vger.kernel.org, patchwork-lst@pengutronix.de,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Some power domains handled by the GPCv2 driver need to enable the clocks
for devies inside the domain, so that the reset propagation and proper
power-up sequencing happens. Handle them in the same way as on GPCv1.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 .../bindings/power/fsl,imx-gpcv2.txt          |  3 +
 drivers/soc/imx/gpcv2.c                       | 60 ++++++++++++++++++-
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
index 7c947a996df1..7c7e972aaa42 100644
--- a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
+++ b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
@@ -32,6 +32,9 @@ Required properties:
 Optional properties:
 
 - power-supply: Power supply used to power the domain
+- clocks: a number of phandles to clocks that need to be enabled during
+  domain power-up sequencing to ensure reset propagation into devices
+  located inside this power domain
 
 Example:
 
diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index a8dd0cddb3d2..176f473127b6 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -8,6 +8,7 @@
  * Copyright 2015-2017 Pengutronix, Lucas Stach <kernel@pengutronix.de>
  */
 
+#include <linux/clk.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
@@ -98,10 +99,14 @@
 
 #define GPC_PGC_CTRL_PCR		BIT(0)
 
+#define GPC_CLK_MAX		6
+
 struct imx_pgc_domain {
 	struct generic_pm_domain genpd;
 	struct regmap *regmap;
 	struct regulator *regulator;
+	struct clk *clk[GPC_CLK_MAX];
+	int num_clks;
 
 	unsigned int pgc;
 
@@ -132,7 +137,7 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
 	const bool enable_power_control = !on;
 	const bool has_regulator = !IS_ERR(domain->regulator);
 	unsigned long deadline;
-	int ret = 0;
+	int i, ret = 0;
 
 	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
 			   domain->bits.map, domain->bits.map);
@@ -145,6 +150,10 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
 		}
 	}
 
+	/* Enable reset clocks for all devices in the domain */
+	for (i = 0; i < domain->num_clks; i++)
+		clk_prepare_enable(domain->clk[i]);
+
 	if (enable_power_control)
 		regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
 				   GPC_PGC_CTRL_PCR, GPC_PGC_CTRL_PCR);
@@ -190,6 +199,10 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
 		regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
 				   GPC_PGC_CTRL_PCR, 0);
 
+	/* Disable reset clocks for all devices in the domain */
+	for (i = 0; i < domain->num_clks; i++)
+		clk_disable_unprepare(domain->clk[i]);
+
 	if (has_regulator && !on) {
 		int err;
 
@@ -440,6 +453,41 @@ static const struct imx_pgc_domain_data imx8m_pgc_domain_data = {
 	.reg_access_table = &imx8m_access_table,
 };
 
+static int imx_pgc_get_clocks(struct imx_pgc_domain *domain)
+{
+	int i, ret;
+
+	for (i = 0; ; i++) {
+		struct clk *clk = of_clk_get(domain->dev->of_node, i);
+		if (IS_ERR(clk))
+			break;
+		if (i >= GPC_CLK_MAX) {
+			dev_err(domain->dev, "more than %d clocks\n",
+				GPC_CLK_MAX);
+			ret = -EINVAL;
+			goto clk_err;
+		}
+		domain->clk[i] = clk;
+	}
+	domain->num_clks = i;
+
+	return 0;
+
+clk_err:
+	while (i--)
+		clk_put(domain->clk[i]);
+
+	return ret;
+}
+
+static void imx_pgc_put_clocks(struct imx_pgc_domain *domain)
+{
+	int i;
+
+	for (i = domain->num_clks - 1; i >= 0; i--)
+		clk_put(domain->clk[i]);
+}
+
 static int imx_pgc_domain_probe(struct platform_device *pdev)
 {
 	struct imx_pgc_domain *domain = pdev->dev.platform_data;
@@ -459,9 +507,17 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 				      domain->voltage, domain->voltage);
 	}
 
+	ret = imx_pgc_get_clocks(domain);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(domain->dev, "Failed to get domain's clocks\n");
+		return ret;
+	}
+
 	ret = pm_genpd_init(&domain->genpd, NULL, true);
 	if (ret) {
 		dev_err(domain->dev, "Failed to init power domain\n");
+		imx_pgc_put_clocks(domain);
 		return ret;
 	}
 
@@ -470,6 +526,7 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(domain->dev, "Failed to add genpd provider\n");
 		pm_genpd_remove(&domain->genpd);
+		imx_pgc_put_clocks(domain);
 	}
 
 	return ret;
@@ -481,6 +538,7 @@ static int imx_pgc_domain_remove(struct platform_device *pdev)
 
 	of_genpd_del_provider(domain->dev->of_node);
 	pm_genpd_remove(&domain->genpd);
+	imx_pgc_put_clocks(domain);
 
 	return 0;
 }
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
