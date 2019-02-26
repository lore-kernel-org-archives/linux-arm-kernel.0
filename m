Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614FBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:25:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F9A02173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TwACgWYt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9A02173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ttp63iQ+Lj80OGqJ+hE23KBjFrtwaPUVQtyObhNvUMQ=; b=TwACgWYthok0v5
	AsF+uOSfmdj8k/7A5Vj/zcTD3/iNVY5silwJufqAQA7R8qPIv1XD2xb8J0Fey3rjGMJaJg/97PQgF
	C/CXPRNb8zy16Ssucr3nDMRyjGkrMjs8R60Kqc9/6TanLFwSAMeNFlv/hmPPl1skcjXT1B6UwuaLm
	R8h95YY4Tsa7ouxgjkJihA/DVs89c/vLD/ehiap/deTCD/D0JSqS5T6TrrIENGXXB/WnRjr72MLu5
	a76pJ+YzoAuUkWAUVcmRyV4gQYyKESJXnir75g6nUkMm2dKwtnda5HeVDJIoSM3wGvunJnNGueJbW
	jiXKmG4C2ZAP5pnrdpdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyYz5-0007Bd-6D; Tue, 26 Feb 2019 09:25:07 +0000
Received: from mga05.intel.com ([192.55.52.43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyYym-0006vs-NG
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 09:24:54 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Feb 2019 01:24:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,415,1544515200"; d="scan'208";a="146607221"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmsmga002.fm.intel.com with ESMTP; 26 Feb 2019 01:24:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id D406A161; Tue, 26 Feb 2019 11:24:41 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 devicetree@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH v1 2/3] spi: pxa2xx: Introduce dma-burst-sz property support
Date: Tue, 26 Feb 2019 12:24:40 +0300
Message-Id: <20190226092441.49198-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226092441.49198-1-andriy.shevchenko@linux.intel.com>
References: <20190226092441.49198-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_012452_571235_CF85FE5D 
X-CRM114-Status: GOOD (  16.88  )
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
In such case respect the value given by dma-burst-size property.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-dma.c   | 4 +++-
 drivers/spi/spi-pxa2xx-pci.c   | 8 +++++++-
 drivers/spi/spi-pxa2xx.c       | 5 ++++-
 include/linux/spi/pxa2xx_spi.h | 1 +
 4 files changed, 15 insertions(+), 3 deletions(-)

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
index d3de925892cb..1db1b64cfba8 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -5,9 +5,9 @@
  */
 #include <linux/clk-provider.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/spi/pxa2xx_spi.h>
 
 #include <linux/dmaengine.h>
@@ -200,6 +200,7 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	struct pxa2xx_spi_master spi_pdata;
 	struct ssp_device *ssp;
 	struct pxa_spi_info *c;
+	u32 dma_burst_sz;
 	char buf[40];
 
 	ret = pcim_enable_device(dev);
@@ -217,12 +218,17 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 			return ret;
 	}
 
+	ret = device_property_read_u32(&dev->dev, "dma-burst-sz", &dma_burst_sz);
+	if (ret)
+		dma_burst_sz = 1;
+
 	memset(&spi_pdata, 0, sizeof(spi_pdata));
 	spi_pdata.num_chipselect = (c->num_chipselect > 0) ? c->num_chipselect : dev->devfn;
 	spi_pdata.dma_filter = c->dma_filter;
 	spi_pdata.tx_param = c->tx_param;
 	spi_pdata.rx_param = c->rx_param;
 	spi_pdata.enable_dma = c->rx_param && c->tx_param;
+	spi_pdata.dma_burst_size = dma_burst_sz;
 
 	ssp = &spi_pdata.ssp;
 	ssp->phys_base = pci_resource_start(dev, 0);
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 8dd67d722aae..393e020c757a 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -24,6 +24,7 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
@@ -1512,6 +1513,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	const struct acpi_device_id *adev_id = NULL;
 	const struct pci_device_id *pcidev_id = NULL;
 	const struct of_device_id *of_id = NULL;
+	struct device *dev = &pdev->dev;
 	enum pxa_ssp_type type;
 
 	adev = ACPI_COMPANION(&pdev->dev);
@@ -1566,9 +1568,10 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	ssp->pdev = pdev;
 	ssp->port_id = pxa2xx_spi_get_port_id(adev);
 
-	pdata->is_slave = of_property_read_bool(pdev->dev.of_node, "spi-slave");
+	pdata->is_slave = device_property_read_bool(dev, "spi-slave");
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
