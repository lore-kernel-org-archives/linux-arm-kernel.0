Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1A2C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:29:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ED0F20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="laghXYRK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jAQyYAVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED0F20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y4fyj719iM9E1ZrHX9rM0CFq8+LHf9wacw5xVSy4MPI=; b=laghXYRKlEJy48
	VDr1iVnZj+cmjIx6j6hXw2Majld/x5sl/7wJ6avUn1+IDELdTkp4vkA72CgYdGYhwL8/9XBY1OZxM
	R56EDOHFgxsk9SUYUOgpRS8vVD6QB9wOPEgQXObkdjpfQK/W6lueLNP6BRBaBvH7h6LiP0Vbq4UiW
	99wAxEHCSbOvf5qlp/1xdYosATGdkjM69s8qHeCRK9GkqqbxCOlB9pNTsU6UYz2w2+mv6wy1UzhhT
	24evmRneoZEIojemEGEjRjFawZ8PK/cjD4faMPm+e8b3hWzD21GGBUmmrzB0En/37sq/M2oOa3nyH
	D6cxW8x64h8D8CF/6hdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU70q-0002BF-7b; Tue, 04 Dec 2018 09:29:04 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU6yn-0008Gx-DC
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 09:27:13 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0648580000>; Tue, 04 Dec 2018 01:26:48 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 04 Dec 2018 01:26:46 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 04 Dec 2018 01:26:46 -0800
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Dec
 2018 09:26:46 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Tue, 4 Dec 2018 09:26:46 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c0648540003>; Tue, 04 Dec 2018 01:26:45 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver
 <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH 05/19] clk: tegra: dfll: registration for multiple SoCs
Date: Tue, 4 Dec 2018 17:25:34 +0800
Message-ID: <20181204092548.3038-6-josephl@nvidia.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204092548.3038-1-josephl@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1543915608; bh=3+hDQSHosfLUjNyQx+ccH8i9y/yEj2CwPulL2jsrTsA=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=jAQyYAVOFItt/U2XSPwrT1k4qQtLBDKwk3jKeXxIuLvBazFDtbh87b/fz+PA6MdDp
 mw/oydZdch0VaZFHdpKSz24oUOslDKvtfLv2vcAmHwJSunTWBKT5NDlgsjZCDKecLY
 CFJdS78tOrCBEu6iJUqrgrge7Ttv9naRzGjbWAciQ/onQIWQBVn9fUctmZRPvhKjrn
 /WT9yHm3PRwJIdXGupXTNJAYaFieuWC3qgRRfTjlMM2mkAm+WuJ8bH4v1kmeNylDuv
 YT5yKhAG7m1EQq8/nW+l6TcCuE4UMuJRh3ss3k8prcHboh+YcQpmV2eFW5AJy2z7Nk
 Y/SZ+3JYxedpw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_012657_962372_0DE3FFB7 
X-CRM114-Status: GOOD (  12.51  )
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
Cc: linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Joseph Lo <josephl@nvidia.com>
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
---
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 45 ++++++++++++++++------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
index 269d3595758b..1a2cc113e5c8 100644
--- a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
+++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
@@ -1,7 +1,7 @@
 /*
  * Tegra124 DFLL FCPU clock source driver
  *
- * Copyright (C) 2012-2014 NVIDIA Corporation.  All rights reserved.
+ * Copyright (C) 2012-2018 NVIDIA Corporation.  All rights reserved.
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
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
