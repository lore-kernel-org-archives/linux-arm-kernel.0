Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC8DC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:39:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8413F2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TIyxqaj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8413F2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lh5bEkDubT/ZsTm2MGBDi0MdO6ea87Zs1i8YBnznC1Q=; b=TIyxqaj2nSXYhf
	j9TQrOmFc2BN2NbneFcJdOxiuvZ7C8fY84wqzjFtTbeimi9jDM34WSLz4C/8oNrs1lgja3ZlH/Xhq
	Nc9qTYcZlH3/x5mZfNe304XXGFFCyHdoK4vRGkjaO2T14Sn4OIdpNa6pmP+TY+8D6+f2XB+vFcYIa
	BEsixjgkaGZ6l4s8QkSkhrKmOVGVsk8dYjcdI356W4g2yiW2xPOX8AUMPj49W2Zl90TY8ULxtMaio
	PTghk9dkeviR3JhotnRDPTuKYKLIsAtggd8ZttcUq0jUp+BCjrI0F5w7hnOyLhlTWMC2Dip1t0JSu
	xv35y988+t0o2kzQhNcQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gosta-0004aJ-4V; Wed, 30 Jan 2019 16:39:26 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gostJ-0004O1-VM
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 16:39:11 +0000
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0UGVW1i028413; Wed, 30 Jan 2019 17:39:02 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2q8e72a777-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Wed, 30 Jan 2019 17:39:02 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 20EC031;
 Wed, 30 Jan 2019 16:39:02 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ECFDAA71D;
 Wed, 30 Jan 2019 16:39:01 +0000 (GMT)
Received: from localhost (10.75.127.44) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2;
 Wed, 30 Jan 2019 17:39:01 +0100
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
 <alexandre.torgue@st.com>
Subject: [PATCH 2/4] nvmem: Add driver for STM32 factory-programmed read only
 mem
Date: Wed, 30 Jan 2019 17:38:54 +0100
Message-ID: <1548866336-14765-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548866336-14765-1-git-send-email-fabrice.gasnier@st.com>
References: <1548866336-14765-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-30_12:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_083910_299729_405AFD4A 
X-CRM114-Status: GOOD (  14.46  )
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
Cc: mark.rutland@arm.com, lionel.debieve@st.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com,
 fabrice.gasnier@st.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a read only nvmem driver for STM32 factory-programmed memory area
(on-chip non-volatile storage).

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/nvmem/Kconfig       | 10 ++++++
 drivers/nvmem/Makefile      |  2 ++
 drivers/nvmem/stm32-romem.c | 78 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+)
 create mode 100644 drivers/nvmem/stm32-romem.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 0a7a470e..f398b18 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -113,6 +113,16 @@ config NVMEM_BCM_OCOTP
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem-bcm-ocotp.
 
+config NVMEM_STM32_ROMEM
+	tristate "STMicroelectronics STM32 factory-programmed memory support"
+	depends on ARCH_STM32 || COMPILE_TEST
+	help
+	  Say y here to enable read-only access for STMicroelectronics STM32
+	  factory-programmed memory area.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem-stm32-romem.
+
 config NVMEM_SUNXI_SID
 	tristate "Allwinner SoCs SID support"
 	depends on ARCH_SUNXI
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 4e8c616..e85c946 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -26,6 +26,8 @@ nvmem_qfprom-y			:= qfprom.o
 obj-$(CONFIG_ROCKCHIP_EFUSE)	+= nvmem_rockchip_efuse.o
 nvmem_rockchip_efuse-y		:= rockchip-efuse.o
 obj-$(CONFIG_NVMEM_SUNXI_SID)	+= nvmem_sunxi_sid.o
+nvmem_stm32_romem-y 		:= stm32-romem.o
+obj-$(CONFIG_NVMEM_STM32_ROMEM) += nvmem_stm32_romem.o
 nvmem_sunxi_sid-y		:= sunxi_sid.o
 obj-$(CONFIG_UNIPHIER_EFUSE)	+= nvmem-uniphier-efuse.o
 nvmem-uniphier-efuse-y		:= uniphier-efuse.o
diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
new file mode 100644
index 0000000..dadbcc2
--- /dev/null
+++ b/drivers/nvmem/stm32-romem.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * STM32 Factory-programmed memory read access driver
+ *
+ * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
+ * Author: Fabrice Gasnier <fabrice.gasnier@st.com> for STMicroelectronics.
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of_device.h>
+
+struct stm32_romem_priv {
+	void __iomem *base;
+	struct nvmem_config cfg;
+};
+
+static int stm32_romem_read(void *context, unsigned int offset, void *buf,
+			    size_t bytes)
+{
+	struct stm32_romem_priv *priv = context;
+	u8 *buf8 = buf;
+	int i;
+
+	for (i = offset; i < offset + bytes; i++)
+		*buf8++ = readb_relaxed(priv->base + i);
+
+	return 0;
+}
+
+static int stm32_romem_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct stm32_romem_priv *priv;
+	struct resource *res;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->cfg.name = "stm32-romem";
+	priv->cfg.read_only = true;
+	priv->cfg.word_size = 1;
+	priv->cfg.stride = 1;
+	priv->cfg.size = resource_size(res);
+	priv->cfg.reg_read = stm32_romem_read;
+	priv->cfg.dev = dev;
+	priv->cfg.priv = priv;
+	priv->cfg.owner = THIS_MODULE;
+
+	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &priv->cfg));
+}
+
+static const struct of_device_id stm32_romem_of_match[] = {
+	{ .compatible = "st,stm32-romem", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, stm32_romem_of_match);
+
+static struct platform_driver stm32_romem_driver = {
+	.probe = stm32_romem_probe,
+	.driver = {
+		.name = "stm32-romem",
+		.of_match_table = of_match_ptr(stm32_romem_of_match),
+	},
+};
+module_platform_driver(stm32_romem_driver);
+
+MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics STM32 RO-MEM");
+MODULE_ALIAS("platform:nvmem-stm32-romem");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
