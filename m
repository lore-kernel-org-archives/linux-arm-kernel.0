Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF50AC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:40:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0C2A2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="unymvohM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C2A2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0SBbTv2ATtn9se/gskr4awJDFsPoo7apNTZMHYvwicY=; b=unymvohMO3IuFX
	JMwpUj896sX+XiD6hPD0ocav9/jvI4KZReK5wGo/iN3rM2F/R48MA/qCW38wrIOMtWSuhFampP6gb
	0hwfNTz0lUHlQf8Zp/Y2EL3Uw7tVm2xFu84qnoxSf/57d30oS2vUle2T/+9AExNapLHaJ2vMg/n/I
	4M8sl0wVk9vQ1dEB0/OXFpCVe1vrkT0dfok5l0JDwWwGNufmj1FbHQjCVPZtFzioSHP0EN7MVTehn
	dS+G3NVdRwPSlexYb4+LIOBYiUqPJ1DaooN4pr0bOuAbBQHAHyqEYYEp16VfZ3udLAgQnIRSmN61E
	y8Z3RapeAns2mtDYqbAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gosuh-0006tc-Sz; Wed, 30 Jan 2019 16:40:35 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gostK-0004O4-Eu
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 16:39:13 +0000
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0UGQxCl005460; Wed, 30 Jan 2019 17:39:03 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2q8dw3aaps-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Wed, 30 Jan 2019 17:39:03 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EA8D634;
 Wed, 30 Jan 2019 16:39:02 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BC0CBA71D;
 Wed, 30 Jan 2019 16:39:02 +0000 (GMT)
Received: from localhost (10.75.127.44) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2;
 Wed, 30 Jan 2019 17:39:02 +0100
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
 <alexandre.torgue@st.com>
Subject: [PATCH 3/4] nvmem: stm32: add support for STM32MP15 BSEC to control
 OTP data
Date: Wed, 30 Jan 2019 17:38:55 +0100
Message-ID: <1548866336-14765-4-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548866336-14765-1-git-send-email-fabrice.gasnier@st.com>
References: <1548866336-14765-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-30_12:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_083910_796644_921A66EA 
X-CRM114-Status: GOOD (  16.96  )
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

On STM32MP15, OTP area may be read/written by using BSEC (boot, security
and OTP control). BSEC registers set is composed of various regions, among
which control registers and OTP shadow registers.
Secure monitor calls are involved in this process to allow (or deny)
access to the full range of OTP data.
This adds support for reading and writing OTP data using SMC services.
Data content can be aligned on 16-bits or 8-bits. Then take care of it,
since BSEC data is 32-bits wide.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/nvmem/stm32-romem.c | 134 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 129 insertions(+), 5 deletions(-)

diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
index dadbcc2..efb9f38 100644
--- a/drivers/nvmem/stm32-romem.c
+++ b/drivers/nvmem/stm32-romem.c
@@ -6,11 +6,29 @@
  * Author: Fabrice Gasnier <fabrice.gasnier@st.com> for STMicroelectronics.
  */
 
+#include <linux/arm-smccc.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of_device.h>
 
+/* BSEC secure service access from non-secure */
+#define STM32_SMC_BSEC			0x82001003
+#define STM32_SMC_READ_SHADOW		0x01
+#define STM32_SMC_PROG_OTP		0x02
+#define STM32_SMC_WRITE_SHADOW		0x03
+#define STM32_SMC_READ_OTP		0x04
+
+/* shadow registers offest */
+#define STM32MP15_BSEC_DATA0		0x200
+
+/* 32 (x 32-bits) lower shadow registers */
+#define STM32MP15_BSEC_NUM_LOWER	32
+
+struct stm32_romem_cfg {
+	int size;
+};
+
 struct stm32_romem_priv {
 	void __iomem *base;
 	struct nvmem_config cfg;
@@ -29,8 +47,98 @@ static int stm32_romem_read(void *context, unsigned int offset, void *buf,
 	return 0;
 }
 
+static int stm32_bsec_smc(u8 op, u32 otp, u32 data, u32 *result)
+{
+#if IS_ENABLED(CONFIG_HAVE_ARM_SMCCC)
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(STM32_SMC_BSEC, op, otp, data, 0, 0, 0, 0, &res);
+	if (res.a0)
+		return -EIO;
+
+	if (result)
+		*result = (u32)res.a1;
+
+	return 0;
+#else
+	return -ENXIO;
+#endif
+}
+
+static int stm32_bsec_read(void *context, unsigned int offset, void *buf,
+			   size_t bytes)
+{
+	struct stm32_romem_priv *priv = context;
+	struct device *dev = priv->cfg.dev;
+	u32 roffset, rbytes, val;
+	u8 *buf8 = buf, *val8 = (u8 *)&val;
+	int i, j = 0, ret, skip_bytes, size;
+
+	/* Round unaligned access to 32-bits */
+	roffset = rounddown(offset, 4);
+	skip_bytes = offset & 0x3;
+	rbytes = roundup(bytes + skip_bytes, 4);
+
+	if (roffset + rbytes > priv->cfg.size)
+		return -EINVAL;
+
+	for (i = roffset; (i < roffset + rbytes); i += 4) {
+		u32 otp = i >> 2;
+
+		if (otp < STM32MP15_BSEC_NUM_LOWER) {
+			/* read lower data from shadow registers */
+			val = readl_relaxed(
+				priv->base + STM32MP15_BSEC_DATA0 + i);
+		} else {
+			ret = stm32_bsec_smc(STM32_SMC_READ_SHADOW, otp, 0,
+					     &val);
+			if (ret) {
+				dev_err(dev, "Can't read data%d (%d)\n", otp,
+					ret);
+				return ret;
+			}
+		}
+		/* skip first bytes in case of unaligned read */
+		if (skip_bytes)
+			size = min(bytes, (size_t)(4 - skip_bytes));
+		else
+			size = min(bytes, (size_t)4);
+		memcpy(&buf8[j], &val8[skip_bytes], size);
+		bytes -= size;
+		j += size;
+		skip_bytes = 0;
+	}
+
+	return 0;
+}
+
+static int stm32_bsec_write(void *context, unsigned int offset, void *buf,
+			    size_t bytes)
+{
+	struct stm32_romem_priv *priv = context;
+	struct device *dev = priv->cfg.dev;
+	u32 *buf32 = buf;
+	int ret, i;
+
+	/* Allow only writing complete 32-bits aligned words */
+	if ((bytes % 4) || (offset % 4))
+		return -EINVAL;
+
+	for (i = offset; i < offset + bytes; i += 4) {
+		ret = stm32_bsec_smc(STM32_SMC_PROG_OTP, i >> 2, *buf32++,
+				     NULL);
+		if (ret) {
+			dev_err(dev, "Can't write data%d (%d)\n", i >> 2, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int stm32_romem_probe(struct platform_device *pdev)
 {
+	const struct stm32_romem_cfg *cfg;
 	struct device *dev = &pdev->dev;
 	struct stm32_romem_priv *priv;
 	struct resource *res;
@@ -45,21 +153,37 @@ static int stm32_romem_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->base);
 
 	priv->cfg.name = "stm32-romem";
-	priv->cfg.read_only = true;
 	priv->cfg.word_size = 1;
 	priv->cfg.stride = 1;
-	priv->cfg.size = resource_size(res);
-	priv->cfg.reg_read = stm32_romem_read;
 	priv->cfg.dev = dev;
 	priv->cfg.priv = priv;
 	priv->cfg.owner = THIS_MODULE;
 
+	cfg = (const struct stm32_romem_cfg *)
+		of_match_device(dev->driver->of_match_table, dev)->data;
+	if (!cfg) {
+		priv->cfg.read_only = true;
+		priv->cfg.size = resource_size(res);
+		priv->cfg.reg_read = stm32_romem_read;
+	} else {
+		priv->cfg.size = cfg->size;
+		priv->cfg.reg_read = stm32_bsec_read;
+		priv->cfg.reg_write = stm32_bsec_write;
+	}
+
 	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &priv->cfg));
 }
 
+static const struct stm32_romem_cfg stm32mp15_bsec_cfg = {
+	.size = 384, /* 96 x 32-bits data words */
+};
+
 static const struct of_device_id stm32_romem_of_match[] = {
-	{ .compatible = "st,stm32-romem", },
-	{},
+	{ .compatible = "st,stm32-romem", }, {
+		.compatible = "st,stm32mp15-bsec",
+		.data = (void *)&stm32mp15_bsec_cfg,
+	}, {
+	},
 };
 MODULE_DEVICE_TABLE(of, stm32_romem_of_match);
 
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
