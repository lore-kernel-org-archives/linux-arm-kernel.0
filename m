Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1B2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:49:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B4DA217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uYS62ulG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4DA217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=oqlvLGqJwtCf2JHcYptpxHHN1dCannwSuyB3CTnOAwE=; b=uYS62ulGVgTfxx
	kwwGTn/fybB0DQMJB1znUpDHNUAenml+Tz7Cv/V8G+VWetbJD2GSnG4m+ZtwjZ8kx0hmIgvv2/jAm
	FG1RJPTIWovJZSfTowbW72ojqNzWCdIsXWBq5VYsVRLArVzmwv6xRlntQ8fhIt7rfbypQk5naeGuo
	tPU9A5Y0MsdgdmlMY7cYg5w7VoeAdbLV2/hChBDANsozhh+Wfo922T50/K4AxhRbUBwNEG8lKYDGl
	zjP5Fxg0OI8q7iq1f2Kt6Hzw5/iVI2kKUyAmg865zJ5gc4hJ+1fjxBSJ93CVkweRxQqWjC8nRliPd
	+Xzk+RvmA7ZmyvZIUuPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybEt-00068G-Nf; Tue, 26 Feb 2019 11:49:35 +0000
Received: from mga03.intel.com ([134.134.136.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybEk-0005zA-7U
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 11:49:27 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Feb 2019 03:49:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,415,1544515200"; d="scan'208";a="127348227"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmsmga008.fm.intel.com with ESMTP; 26 Feb 2019 03:49:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 6E312D4; Tue, 26 Feb 2019 13:49:21 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH v2 1/2] spi: pxa2xx: Introduce DMA burst size support
Date: Tue, 26 Feb 2019 14:49:20 +0300
Message-Id: <20190226114921.48205-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_034926_311681_C1B3C943 
X-CRM114-Status: GOOD (  15.22  )
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
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Some masters may have different DMA burst size than hard coded default.
In such case respect the value given by DMA burst size provided via
platform data.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-dma.c   | 4 +++-
 drivers/spi/spi-pxa2xx-pci.c   | 5 ++++-
 drivers/spi/spi-pxa2xx.c       | 1 +
 include/linux/spi/pxa2xx_spi.h | 1 +
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index 2fa7f4b43492..3343fff81c7b 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -239,13 +239,15 @@ int pxa2xx_spi_set_dma_burst_and_threshold(struct chip_data *chip,
 					   u32 *threshold)
 {
 	struct pxa2xx_spi_chip *chip_info = spi->controller_data;
+	struct driver_data *drv_data = spi_controller_get_devdata(spi->controller);
+	u32 dma_burst_size = drv_data->master_info->dma_burst_size;
 
 	/*
 	 * If the DMA burst size is given in chip_info we use that,
 	 * otherwise we use the default. Also we use the default FIFO
 	 * thresholds for now.
 	 */
-	*burst_code = chip_info ? chip_info->dma_burst_size : 1;
+	*burst_code = chip_info ? chip_info->dma_burst_size : dma_burst_size;
 	*threshold = SSCR1_RxTresh(RX_THRESH_DFLT)
 		   | SSCR1_TxTresh(TX_THRESH_DFLT);
 
diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index d3de925892cb..3faef7335137 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -5,7 +5,6 @@
  */
 #include <linux/clk-provider.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/spi/pxa2xx_spi.h>
@@ -35,6 +34,8 @@ struct pxa_spi_info {
 	void *tx_param;
 	void *rx_param;
 
+	int dma_burst_size;
+
 	int (*setup)(struct pci_dev *pdev, struct pxa_spi_info *c);
 };
 
@@ -133,6 +134,7 @@ static int mrfld_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 	rx->dma_dev = &dma_dev->dev;
 
 	c->dma_filter = lpss_dma_filter;
+	c->dma_burst_size = 8;
 	return 0;
 }
 
@@ -223,6 +225,7 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	spi_pdata.tx_param = c->tx_param;
 	spi_pdata.rx_param = c->rx_param;
 	spi_pdata.enable_dma = c->rx_param && c->tx_param;
+	spi_pdata.dma_burst_size = c->dma_burst_size ? c->dma_burst_size : 1;
 
 	ssp = &spi_pdata.ssp;
 	ssp->phys_base = pci_resource_start(dev, 0);
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 8dd67d722aae..7a86654045fc 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1569,6 +1569,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	pdata->is_slave = of_property_read_bool(pdev->dev.of_node, "spi-slave");
 	pdata->num_chipselect = 1;
 	pdata->enable_dma = true;
+	pdata->dma_burst_size = 1;
 
 	return pdata;
 }
diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_spi.h
index b0674e330ef6..154da8cd4781 100644
--- a/include/linux/spi/pxa2xx_spi.h
+++ b/include/linux/spi/pxa2xx_spi.h
@@ -25,6 +25,7 @@ struct dma_chan;
 struct pxa2xx_spi_master {
 	u16 num_chipselect;
 	u8 enable_dma;
+	u8 dma_burst_size;
 	bool is_slave;
 
 	/* DMA engine specific config */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
