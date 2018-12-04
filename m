Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89C1C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:28:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AEC920851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DD7Mni17";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Jd+uUEYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AEC920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xwd4sEWIP1+mwWs0uHhiolCqyfLavSs0O199/r1A9T4=; b=DD7Mni17R2Oq4h
	8A3Kruv46YblPGBYy5EaldX3C9Zad+eyJMHgsOjwBXR083YNj5E/MQ8y9kQtCSqHjDHd4QqZ4XzBs
	ggCA6xtGB5bGewb/RKk/sUAPH9kPobbmF+1iD1pgCa3xyKnSKdj4zOU2ZOrBaMQhQ+s0cNnbo5qLk
	7b6lyeiBYcOlcnRdFukXcwgsyV8Ln4BrRQ5OeANjl4ENeZp+IMKB5woIdlH5hYwQyfgR05U0Pcpbq
	F+w9nAVefxapvOY1p6i90VAYKwfaIYr4zqtxDzXnPBHd/D5fg3QsndGHd1W4rMyDAjZFBcvW8NMDU
	yFyggC0XbB5mmKJp6WZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU70a-0001xI-RQ; Tue, 04 Dec 2018 09:28:48 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU6z1-00006Q-5k
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 09:27:58 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0648660000>; Tue, 04 Dec 2018 01:27:02 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 04 Dec 2018 01:27:00 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 04 Dec 2018 01:27:00 -0800
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Dec
 2018 09:27:00 +0000
Received: from HQMAIL106.nvidia.com (172.18.146.12) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Dec
 2018 09:26:59 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Tue, 4 Dec 2018 09:26:59 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c0648620000>; Tue, 04 Dec 2018 01:26:59 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver
 <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH 11/19] cpufreq: tegra124: do not handle the CPU rail
Date: Tue, 4 Dec 2018 17:25:40 +0800
Message-ID: <20181204092548.3038-12-josephl@nvidia.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204092548.3038-1-josephl@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1543915622; bh=keK1cFRn89M3cmuIffiAPACzFEXeNYnLBLsdkkMVf14=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=Jd+uUEYvcxJq3OU88H3tbNTlHTaVCEMqDNSjyQujoU4J09+7ZmWys6r9nmvO1ankt
 9ftaPNTEfkFlGxe30ofdCPM69HLkOv9Sd26hDDUz6ch6R3NAN7VMMMdeBz86xEO9px
 7wfygFfoNDmRl8oMk/+o2eNpWISvZjrp1Z4kTbX1xbPCali+GRLXFJkQpf3JrLTgP8
 9y3nt1nO3BfRscqExQ2ImTRVADyLuRLY8dVSpJVsOtAYmKZsDhXYRggWIWYEWcnvoM
 Ph+Pyl4pso+jH6LvCAu59YRh++mERFAY9zVmxdMoIifoek+Jtz4DGz3XkT/IlKGTo1
 p+SE1/TCDyNzg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_012711_899961_80397BD8 
X-CRM114-Status: GOOD (  15.40  )
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
rail. So the driver shouldn't handle for the CPU clock switching from
DFLL to other PLL clocks. It was designed to work on DFLL clock only,
which handle the frequency/voltage scaling in the background. This
patch removes the driver dependency of the CPU rail.

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 drivers/cpufreq/Kconfig.arm        |  2 +-
 drivers/cpufreq/tegra124-cpufreq.c | 26 ++------------------------
 2 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 4e1131ef85ae..a609f8820c47 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -262,7 +262,7 @@ config ARM_TEGRA20_CPUFREQ
 
 config ARM_TEGRA124_CPUFREQ
 	tristate "Tegra124 CPUFreq support"
-	depends on ARCH_TEGRA && CPUFREQ_DT && REGULATOR
+	depends on ARCH_TEGRA && CPUFREQ_DT
 	default y
 	help
 	  This adds the CPUFreq driver support for Tegra124 SOCs.
diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
index 43530254201a..448d00763d00 100644
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
@@ -146,8 +128,6 @@ static int tegra124_cpufreq_probe(struct platform_device *pdev)
 	clk_put(priv->dfll_clk);
 out_put_cpu_clk:
 	clk_put(priv->cpu_clk);
-out_put_vdd_cpu_reg:
-	regulator_put(priv->vdd_cpu_reg);
 out_put_np:
 	of_node_put(np);
 
@@ -159,13 +139,11 @@ static int tegra124_cpufreq_remove(struct platform_device *pdev)
 	struct tegra124_cpufreq_priv *priv = platform_get_drvdata(pdev);
 
 	platform_device_unregister(priv->cpufreq_dt_pdev);
-	tegra124_cpu_switch_to_pllx(priv);
 
 	clk_put(priv->pllp_clk);
 	clk_put(priv->pllx_clk);
 	clk_put(priv->dfll_clk);
 	clk_put(priv->cpu_clk);
-	regulator_put(priv->vdd_cpu_reg);
 
 	return 0;
 }
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
