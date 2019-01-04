Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F454C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:09:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D393520449
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DI2jfixG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rb5lKfKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D393520449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=egr1MFsRlpq2DGhf5uuvBn8PtS88otH1dxkn1tCL+/o=; b=DI2jfixG7tWqvz
	m0arVeYC2TMAHauifzXIaxPv/Z5Elb3JUoYdFFfJuTK1dm/eTDyq/BXz3SGywXmIcLfRQsFIViT5L
	s5xOxq7PYVn1L+ZdbDr7YLhyo5b7bP9OLTmSe7AvCK9e6+p9eZBVp4t4z/W6E78+knlD2ml+/xKIu
	6u/ed/4QbCvN2JH3PYLudbxgpPy/4CGmrFTwV7PTleCDU+h+bU+zCcVTJTNSStBiR2RHh7VoYaUYS
	nz1b4ANivo0eP+mVX/50nuVSinfXIcFRPsIa6Zyrc3E/i1LuOINJPHKtZxxYn2DkxzA1JGK/8RWhm
	8aJiUUDTo3zD7KrahYHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfFrY-0007QO-Cm; Fri, 04 Jan 2019 03:09:32 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfFpS-0005jr-0Z
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 03:07:28 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c2ecddb0000>; Thu, 03 Jan 2019 19:07:07 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 03 Jan 2019 19:07:21 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 03 Jan 2019 19:07:21 -0800
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 4 Jan
 2019 03:07:21 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Fri, 4 Jan 2019 03:07:21 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c2ecde70001>; Thu, 03 Jan 2019 19:07:20 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver
 <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH V4 05/20] clk: tegra: dfll: registration for multiple SoCs
Date: Fri, 4 Jan 2019 11:06:47 +0800
Message-ID: <20190104030702.8684-6-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104030702.8684-1-josephl@nvidia.com>
References: <20190104030702.8684-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1546571227; bh=+I5R+vt1RctPNQ/lHbSOl45ehRPZgqudDxFi+bhS2CQ=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=rb5lKfKBK0XgjQ+gvk3uHnq2gQ/x1CF9ez2sfDFKNXrUtfPrXK+JZCutAiAp0o9sW
 Gqi1W/Wt4jpzkGfO9l799JmhZLYqdHkAQhYFa9wX8BBW+sol8wJIQBeSAV8t2j6vVe
 sGadOUwwJXqAXnvt/QHpy0FfRRcJE2BWP+c5H1R5T8qsCbUPKsEeTaqNMQjVao2qZs
 uHr2bMU3dval75RByEjPwy8L6AxJ0h4qTmaq3ZGvBWLsiSEyalyMIiK6Kk5yfc5USr
 miWm2SbRLgeGyeZiRlK66KV72C7qTZ38V2sravCNmdlAQhYz0J10CXaSRLxeuNUYk+
 qgFMUnQ/nuSEQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_190722_643842_79F7A8C8 
X-CRM114-Status: GOOD (  12.06  )
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
Cc: linux-tegra@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Peter De Schrijver <pdeschrijver@nvidia.com>

In a future patch, support for the DFLL in Tegra210 will be introduced.
This requires support for more than 1 set of CVB and CPU max frequency
tables.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Joseph Lo <josephl@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
*V4:
 - add ack tag
*V3:
 - no change
*V2:
 - add ack tag
---
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 45 ++++++++++++++++------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
index 269d3595758b..2bf6a769e5ce 100644
--- a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
+++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
@@ -1,7 +1,7 @@
 /*
  * Tegra124 DFLL FCPU clock source driver
  *
- * Copyright (C) 2012-2014 NVIDIA Corporation.  All rights reserved.
+ * Copyright (C) 2012-2019 NVIDIA Corporation.  All rights reserved.
  *
  * Aleksandr Frid <afrid@nvidia.com>
  * Paul Walmsley <pwalmsley@nvidia.com>
@@ -21,6 +21,7 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <soc/tegra/fuse.h>
 
@@ -28,8 +29,15 @@
 #include "clk-dfll.h"
 #include "cvb.h"
 
+struct dfll_fcpu_data {
+	const unsigned long *cpu_max_freq_table;
+	unsigned int cpu_max_freq_table_size;
+	const struct cvb_table *cpu_cvb_tables;
+	unsigned int cpu_cvb_tables_size;
+};
+
 /* Maximum CPU frequency, indexed by CPU speedo id */
-static const unsigned long cpu_max_freq_table[] = {
+static const unsigned long tegra124_cpu_max_freq_table[] = {
 	[0] = 2014500000UL,
 	[1] = 2320500000UL,
 	[2] = 2116500000UL,
@@ -82,16 +90,36 @@ static const struct cvb_table tegra124_cpu_cvb_tables[] = {
 	},
 };
 
+static const struct dfll_fcpu_data tegra124_dfll_fcpu_data = {
+	.cpu_max_freq_table = tegra124_cpu_max_freq_table,
+	.cpu_max_freq_table_size = ARRAY_SIZE(tegra124_cpu_max_freq_table),
+	.cpu_cvb_tables = tegra124_cpu_cvb_tables,
+	.cpu_cvb_tables_size = ARRAY_SIZE(tegra124_cpu_cvb_tables)
+};
+
+static const struct of_device_id tegra124_dfll_fcpu_of_match[] = {
+	{
+		.compatible = "nvidia,tegra124-dfll",
+		.data = &tegra124_dfll_fcpu_data,
+	},
+	{ },
+};
+
 static int tegra124_dfll_fcpu_probe(struct platform_device *pdev)
 {
 	int process_id, speedo_id, speedo_value, err;
 	struct tegra_dfll_soc_data *soc;
+	const struct dfll_fcpu_data *fcpu_data;
+
+	fcpu_data = of_device_get_match_data(&pdev->dev);
+	if (!fcpu_data)
+		return -ENODEV;
 
 	process_id = tegra_sku_info.cpu_process_id;
 	speedo_id = tegra_sku_info.cpu_speedo_id;
 	speedo_value = tegra_sku_info.cpu_speedo_value;
 
-	if (speedo_id >= ARRAY_SIZE(cpu_max_freq_table)) {
+	if (speedo_id >= fcpu_data->cpu_max_freq_table_size) {
 		dev_err(&pdev->dev, "unknown max CPU freq for speedo_id=%d\n",
 			speedo_id);
 		return -ENODEV;
@@ -107,10 +135,10 @@ static int tegra124_dfll_fcpu_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	soc->max_freq = cpu_max_freq_table[speedo_id];
+	soc->max_freq = fcpu_data->cpu_max_freq_table[speedo_id];
 
-	soc->cvb = tegra_cvb_add_opp_table(soc->dev, tegra124_cpu_cvb_tables,
-					   ARRAY_SIZE(tegra124_cpu_cvb_tables),
+	soc->cvb = tegra_cvb_add_opp_table(soc->dev, fcpu_data->cpu_cvb_tables,
+					   fcpu_data->cpu_cvb_tables_size,
 					   process_id, speedo_id, speedo_value,
 					   soc->max_freq);
 	if (IS_ERR(soc->cvb)) {
@@ -142,11 +170,6 @@ static int tegra124_dfll_fcpu_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id tegra124_dfll_fcpu_of_match[] = {
-	{ .compatible = "nvidia,tegra124-dfll", },
-	{ },
-};
-
 static const struct dev_pm_ops tegra124_dfll_pm_ops = {
 	SET_RUNTIME_PM_OPS(tegra_dfll_runtime_suspend,
 			   tegra_dfll_runtime_resume, NULL)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
