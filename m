Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6990CC10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:58:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32ADD21738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g1O5T9a0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32ADD21738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=uaVcTpTe4ey89prM77rsulvucir817wElBoVJZLVhwk=; b=g1O5T9a0Ag3aEhkLrONCHHNQBj
	w93R4UzCq36Rll1tGE7Tj3bb5UHdjjv5OroxaikreQUaGjLrqw+mDLlzp5YNFTW9Wpqxu03ZQBFIR
	9OxyoghHXK3UAHtAU39M9mNoCbNv+lWhyV+aWVzqxy5J0T5zWz1fIdwh41W3SUnCvXe4hFSaV55YM
	Kr/9VFZmdaGwpGrj+izf/i2mzrwwPF8pKYhQ9TWkaCDKTtiDtFcWngjtni1BKAvpAG/nLmjE6ng8l
	14GSv7AzMFSr6I5AYeZ7i3VfM6VIC4MPqdZT4v/iDaCp3C9G7+j7AZMSTMQdP//6+W21E26md2qNP
	tlwCwSoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwAao-0002vU-Kv; Tue, 19 Feb 2019 18:58:10 +0000
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwAal-0002up-Py
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 18:58:09 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Feb 2019 10:58:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; d="scan'208";a="117434299"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
 by orsmga006.jf.intel.com with ESMTP; 19 Feb 2019 10:58:00 -0800
From: thor.thayer@linux.intel.com
To: bp@alien8.de, dinguyen@kernel.org, linux@armlinux.org.uk,
 mchehab@kernel.org, james.morse@arm.com
Subject: [PATCH 1/2] EDAC, altera: Add separate SDRAM EDAC config
Date: Tue, 19 Feb 2019 12:59:58 -0600
Message-Id: <1550602799-22737-2-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550602799-22737-1-git-send-email-thor.thayer@linux.intel.com>
References: <1550602799-22737-1-git-send-email-thor.thayer@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_105807_877576_48A9DDFE 
X-CRM114-Status: GOOD (  16.09  )
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
Cc: thor.thayer@linux.intel.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

The CONFIG_ALTERA_EDAC flag always enables the SDRAM
EDAC. On the newer architectures, there are cases where
the peripheral EDACs are enabled but SDRAM needs to be
disabled.
This change moves SDRAM functions so they can be contained
inside the conditional CONFIG.
Create new CONFIG option just for SDRAM.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 drivers/edac/Kconfig       | 14 +++++++---
 drivers/edac/altera_edac.c | 67 +++++++++++++++++++++++++---------------------
 2 files changed, 47 insertions(+), 34 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 102a47a09f25..47eb4d13ed5f 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -391,9 +391,17 @@ config EDAC_ALTERA
 	depends on EDAC=y && (ARCH_SOCFPGA || ARCH_STRATIX10)
 	help
 	  Support for error detection and correction on the
-	  Altera SOCs. This must be selected for SDRAM ECC.
-	  Note that the preloader must initialize the SDRAM
-	  before loading the kernel.
+	  Altera SOCs. This is the global enable for the
+	  various Altera peripherals.
+
+config EDAC_ALTERA_SDRAM
+	bool "Altera SDRAM ECC"
+	depends on EDAC_ALTERA=y
+	help
+	  Support for error detection and correction on the
+	  Altera SDRAM Memory for Altera SoCs. Note that the
+	  preloader must initialize the SDRAM before loading
+	  the kernel.
 
 config EDAC_ALTERA_L2C
 	bool "Altera L2 Cache ECC"
diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 98e0bd8d9f50..1bcf9aea0cdf 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -29,6 +29,7 @@
 #define EDAC_MOD_STR		"altera_edac"
 #define EDAC_DEVICE		"Altera"
 
+#ifdef CONFIG_EDAC_ALTERA_SDRAM
 static const struct altr_sdram_prv_data c5_data = {
 	.ecc_ctrl_offset    = CV_CTLCFG_OFST,
 	.ecc_ctl_en_mask    = CV_CTLCFG_ECC_AUTO_EN,
@@ -468,6 +469,39 @@ static int altr_sdram_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/*
+ * If you want to suspend, need to disable EDAC by removing it
+ * from the device tree or defconfig.
+ */
+#ifdef CONFIG_PM
+static int altr_sdram_prepare(struct device *dev)
+{
+	pr_err("Suspend not allowed when EDAC is enabled.\n");
+
+	return -EPERM;
+}
+
+static const struct dev_pm_ops altr_sdram_pm_ops = {
+	.prepare = altr_sdram_prepare,
+};
+#endif
+
+static struct platform_driver altr_sdram_edac_driver = {
+	.probe = altr_sdram_probe,
+	.remove = altr_sdram_remove,
+	.driver = {
+		.name = "altr_sdram_edac",
+#ifdef CONFIG_PM
+		.pm = &altr_sdram_pm_ops,
+#endif
+		.of_match_table = altr_sdram_ctrl_of_match,
+	},
+};
+
+module_platform_driver(altr_sdram_edac_driver);
+
+#endif	/* CONFIG_EDAC_ALTERA_SDRAM */
+
 /**************** Stratix 10 EDAC Memory Controller Functions ************/
 
 /**
@@ -530,37 +564,6 @@ static const struct regmap_config s10_sdram_regmap_cfg = {
 
 /************** </Stratix10 EDAC Memory Controller Functions> ***********/
 
-/*
- * If you want to suspend, need to disable EDAC by removing it
- * from the device tree or defconfig.
- */
-#ifdef CONFIG_PM
-static int altr_sdram_prepare(struct device *dev)
-{
-	pr_err("Suspend not allowed when EDAC is enabled.\n");
-
-	return -EPERM;
-}
-
-static const struct dev_pm_ops altr_sdram_pm_ops = {
-	.prepare = altr_sdram_prepare,
-};
-#endif
-
-static struct platform_driver altr_sdram_edac_driver = {
-	.probe = altr_sdram_probe,
-	.remove = altr_sdram_remove,
-	.driver = {
-		.name = "altr_sdram_edac",
-#ifdef CONFIG_PM
-		.pm = &altr_sdram_pm_ops,
-#endif
-		.of_match_table = altr_sdram_ctrl_of_match,
-	},
-};
-
-module_platform_driver(altr_sdram_edac_driver);
-
 /************************* EDAC Parent Probe *************************/
 
 static const struct of_device_id altr_edac_device_of_match[];
@@ -2143,11 +2146,13 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 
 			altr_edac_a10_device_add(edac, child);
 
+#ifdef CONFIG_EDAC_ALTERA_SDRAM
 		else if ((of_device_is_compatible(child, "altr,sdram-edac-a10")) ||
 			 (of_device_is_compatible(child, "altr,sdram-edac-s10")))
 			of_platform_populate(pdev->dev.of_node,
 					     altr_sdram_ctrl_of_match,
 					     NULL, &pdev->dev);
+#endif
 	}
 
 	return 0;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
