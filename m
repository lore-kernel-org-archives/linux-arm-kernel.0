Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB75BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:11:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C83A20449
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DFFiUFW7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="AyPn+6wL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C83A20449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jfVorjyZq7a5VxUipOQU9eK6BSfsryGomTPXuYFCRfs=; b=DFFiUFW7+HMYvp
	/ylmEbYCA7ozzBSUvwKumQC6tY9PaNrR9jf52v6S52SF5MjYHM/S34Z6C0cqQbOPGU/oVuG6+onw3
	pB+arUroyniqaCbVlkRirTERrbkYUQuUejX8HWiSIxdvWC1tNrGFxlD5+IoeJZh0PzzbpeL2l1Wwk
	L0vNS910C1BBue3bQuqAxyYrNqyPhJYjsZ4sHd4v5ouu7CgsfOFXQAjZqOUQ31+PF5/yzdyzJOtOW
	PPI1eQHRoU1pNrekAqZcjVbIYvJse2k0e82udsUo0vonQ1fdPCdT/I8h7BDzdVSdgmxr/Bhx77QiX
	pRsyoaUgplEjVdeAACLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfFtV-0001wY-Jy; Fri, 04 Jan 2019 03:11:33 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfFpf-0005we-Cw
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 03:07:38 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c2ecdec0001>; Thu, 03 Jan 2019 19:07:24 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 03 Jan 2019 19:07:35 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 03 Jan 2019 19:07:35 -0800
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 4 Jan
 2019 03:07:34 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Fri, 4 Jan 2019 03:07:34 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c2ecdf40005>; Thu, 03 Jan 2019 19:07:34 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver
 <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH V4 11/20] cpufreq: tegra124: do not handle the CPU rail
Date: Fri, 4 Jan 2019 11:06:53 +0800
Message-ID: <20190104030702.8684-12-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104030702.8684-1-josephl@nvidia.com>
References: <20190104030702.8684-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1546571244; bh=TWR2N1eqFdzWXg5bnVZvFpCYzXEB0k8TwxbFAgbqIkI=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=AyPn+6wLHvqtV3Uycql5VlKWWcqPP6ftPD5ZuDUVMB4wRXyNMA8CmE161yUjOmLQk
 OjmWBv7EyKh3biJ0dcw+O68sVfonvKL/dkAUWXjE8cXf7lnBDZjqemsy70zjGYg1dD
 r4X+Wpfqyb4jvEd8YFm/qknNF5I0wNVM4p1oxvCGBZGJY0fVXAnZbKsw0A+d44Ga+7
 xzU4kapXM33+WfATesbinnfKXnfQneRs4eHZWw3MyNuOUtT+p7Dt7/R67/1GVMXDo0
 6W6IiP5d5sXiuYsiDjeEUODzr89RiCDrHSGGm69CbGh3vugx9ymrhDZSOqZ4Lgp0Xr
 1WsZsn6r6Akvw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_190735_971279_8B8F01FA 
X-CRM114-Status: GOOD (  16.46  )
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
Cc: linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
 Joseph Lo <josephl@nvidia.com>, linux-tegra@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The Tegra124 cpufreq driver has no information to handle the Vdd-CPU
rail. So this driver shouldn't handle for the CPU clock switching from
DFLL to other PLL clocks. It was designed to work on DFLL clock only,
which handle the frequency/voltage scaling in the background.

This patch removes the driver dependency of the CPU rail, as well as not
allow it to be built as a module and remove the removal function. So it
can keep working on DFLL clock.

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Joseph Lo <josephl@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
*V4:
 - no change
*V3:
 - add ack tags
*V2:
 - update the commit message since we change the driver not able to be
 built as a module and remove the removal function in V2
---
 drivers/cpufreq/Kconfig.arm        |  4 +--
 drivers/cpufreq/tegra124-cpufreq.c | 41 ++----------------------------
 2 files changed, 4 insertions(+), 41 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 688f10227793..1a6778e81f90 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -272,8 +272,8 @@ config ARM_TEGRA20_CPUFREQ
 	  This adds the CPUFreq driver support for Tegra20 SOCs.
 
 config ARM_TEGRA124_CPUFREQ
-	tristate "Tegra124 CPUFreq support"
-	depends on ARCH_TEGRA && CPUFREQ_DT && REGULATOR
+	bool "Tegra124 CPUFreq support"
+	depends on ARCH_TEGRA && CPUFREQ_DT
 	default y
 	help
 	  This adds the CPUFreq driver support for Tegra124 SOCs.
diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
index 43530254201a..a1bfde0a7950 100644
--- a/drivers/cpufreq/tegra124-cpufreq.c
+++ b/drivers/cpufreq/tegra124-cpufreq.c
@@ -22,11 +22,9 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
-#include <linux/regulator/consumer.h>
 #include <linux/types.h>
 
 struct tegra124_cpufreq_priv {
-	struct regulator *vdd_cpu_reg;
 	struct clk *cpu_clk;
 	struct clk *pllp_clk;
 	struct clk *pllx_clk;
@@ -60,14 +58,6 @@ static int tegra124_cpu_switch_to_dfll(struct tegra124_cpufreq_priv *priv)
 	return ret;
 }
 
-static void tegra124_cpu_switch_to_pllx(struct tegra124_cpufreq_priv *priv)
-{
-	clk_set_parent(priv->cpu_clk, priv->pllp_clk);
-	clk_disable_unprepare(priv->dfll_clk);
-	regulator_sync_voltage(priv->vdd_cpu_reg);
-	clk_set_parent(priv->cpu_clk, priv->pllx_clk);
-}
-
 static int tegra124_cpufreq_probe(struct platform_device *pdev)
 {
 	struct tegra124_cpufreq_priv *priv;
@@ -88,16 +78,10 @@ static int tegra124_cpufreq_probe(struct platform_device *pdev)
 	if (!np)
 		return -ENODEV;
 
-	priv->vdd_cpu_reg = regulator_get(cpu_dev, "vdd-cpu");
-	if (IS_ERR(priv->vdd_cpu_reg)) {
-		ret = PTR_ERR(priv->vdd_cpu_reg);
-		goto out_put_np;
-	}
-
 	priv->cpu_clk = of_clk_get_by_name(np, "cpu_g");
 	if (IS_ERR(priv->cpu_clk)) {
 		ret = PTR_ERR(priv->cpu_clk);
-		goto out_put_vdd_cpu_reg;
+		goto out_put_np;
 	}
 
 	priv->dfll_clk = of_clk_get_by_name(np, "dfll");
@@ -129,15 +113,13 @@ static int tegra124_cpufreq_probe(struct platform_device *pdev)
 		platform_device_register_full(&cpufreq_dt_devinfo);
 	if (IS_ERR(priv->cpufreq_dt_pdev)) {
 		ret = PTR_ERR(priv->cpufreq_dt_pdev);
-		goto out_switch_to_pllx;
+		goto out_put_pllp_clk;
 	}
 
 	platform_set_drvdata(pdev, priv);
 
 	return 0;
 
-out_switch_to_pllx:
-	tegra124_cpu_switch_to_pllx(priv);
 out_put_pllp_clk:
 	clk_put(priv->pllp_clk);
 out_put_pllx_clk:
@@ -146,34 +128,15 @@ static int tegra124_cpufreq_probe(struct platform_device *pdev)
 	clk_put(priv->dfll_clk);
 out_put_cpu_clk:
 	clk_put(priv->cpu_clk);
-out_put_vdd_cpu_reg:
-	regulator_put(priv->vdd_cpu_reg);
 out_put_np:
 	of_node_put(np);
 
 	return ret;
 }
 
-static int tegra124_cpufreq_remove(struct platform_device *pdev)
-{
-	struct tegra124_cpufreq_priv *priv = platform_get_drvdata(pdev);
-
-	platform_device_unregister(priv->cpufreq_dt_pdev);
-	tegra124_cpu_switch_to_pllx(priv);
-
-	clk_put(priv->pllp_clk);
-	clk_put(priv->pllx_clk);
-	clk_put(priv->dfll_clk);
-	clk_put(priv->cpu_clk);
-	regulator_put(priv->vdd_cpu_reg);
-
-	return 0;
-}
-
 static struct platform_driver tegra124_cpufreq_platdrv = {
 	.driver.name	= "cpufreq-tegra124",
 	.probe		= tegra124_cpufreq_probe,
-	.remove		= tegra124_cpufreq_remove,
 };
 
 static int __init tegra_cpufreq_init(void)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
