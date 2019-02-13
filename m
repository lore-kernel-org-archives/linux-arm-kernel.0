Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E9FC282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:51:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA01321901
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cuAZvfjs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA01321901
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M5j2IxfesE4BUKr2ezWVkFg8+ZqRV17kJxEzqVFZfCY=; b=cuAZvfjs9PgVP0
	uDSs9win94xNu3NVuaDx9oPiDr9iXarTOs6lmp/oR0qbaWiMT7LMgHprORsN8psYRYLw8yNWRwI6m
	eWCTF44Qz4Gqi8qphvSxj3IJDqdgXECfhGYXZmgfeN6sEIHA9kWBLG8B97O7i/3jlu1yVGsb6fX3R
	fYIzcLHDsUnWu4fPkRONZiihcYhgNzU3trr9rMmsg2eQc2CGdVHZDTskkOgs+tzL61Don6p6+Kl6a
	OtaV0dhneVTbAD5tJE2E1DL1mdWc2idE32ROIB72hHMuqmQ4XoFvZyJZLxg3QwoH7iyL7ikFjBYWb
	HOGL8p30jUK3rVE9hdyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gts8O-0002Ov-Pl; Wed, 13 Feb 2019 10:51:20 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gts7p-0001fo-Lk
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 10:50:47 +0000
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1DAkvCZ020740; Wed, 13 Feb 2019 11:50:40 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2qjfy6akcr-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Wed, 13 Feb 2019 11:50:40 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2899334;
 Wed, 13 Feb 2019 10:50:38 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ECBFB4EE5;
 Wed, 13 Feb 2019 10:50:37 +0000 (GMT)
Received: from localhost (10.75.127.51) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2;
 Wed, 13 Feb 2019 11:50:37 +0100
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <thierry.reding@gmail.com>, <robh+dt@kernel.org>
Subject: [PATCH v3 2/3] pwm: stm32-lp: Add power management support
Date: Wed, 13 Feb 2019 11:50:11 +0100
Message-ID: <1550055012-23348-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550055012-23348-1-git-send-email-fabrice.gasnier@st.com>
References: <1550055012-23348-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-13_07:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_025046_000342_AEDBB502 
X-CRM114-Status: GOOD (  12.49  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com,
 tduszyns@gmail.com, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 mcoquelin.stm32@gmail.com, u.kleine-koenig@pengutronix.de,
 fabrice.gasnier@st.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add suspend/resume PM sleep ops. When going to low power, enforce the PWM
channel isn't active. Let the PWM consumers disable it during their own
suspend sequence. Only perform a check here, and handle the pinctrl states.
See [1].
[1] https://lkml.org/lkml/2019/2/5/770

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v2:
- Don't disable PWM channel: let the PWM user disable it. Refuse to
  suspend in case it's been left enabled.
- Drop the ifdefs, use __maybe_unused instead.
---
 drivers/pwm/pwm-stm32-lp.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 0059b24c..2211a64 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -13,6 +13,7 @@
 #include <linux/mfd/stm32-lptimer.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 
@@ -223,6 +224,29 @@ static int stm32_pwm_lp_remove(struct platform_device *pdev)
 	return pwmchip_remove(&priv->chip);
 }
 
+static int __maybe_unused stm32_pwm_lp_suspend(struct device *dev)
+{
+	struct stm32_pwm_lp *priv = dev_get_drvdata(dev);
+	struct pwm_state state;
+
+	pwm_get_state(&priv->chip.pwms[0], &state);
+	if (state.enabled) {
+		dev_err(dev, "The consumer didn't stop us (%s)\n",
+			priv->chip.pwms[0].label);
+		return -EBUSY;
+	}
+
+	return pinctrl_pm_select_sleep_state(dev);
+}
+
+static int __maybe_unused stm32_pwm_lp_resume(struct device *dev)
+{
+	return pinctrl_pm_select_default_state(dev);
+}
+
+static SIMPLE_DEV_PM_OPS(stm32_pwm_lp_pm_ops, stm32_pwm_lp_suspend,
+			 stm32_pwm_lp_resume);
+
 static const struct of_device_id stm32_pwm_lp_of_match[] = {
 	{ .compatible = "st,stm32-pwm-lp", },
 	{},
@@ -235,6 +259,7 @@ static int stm32_pwm_lp_remove(struct platform_device *pdev)
 	.driver	= {
 		.name = "stm32-pwm-lp",
 		.of_match_table = of_match_ptr(stm32_pwm_lp_of_match),
+		.pm = &stm32_pwm_lp_pm_ops,
 	},
 };
 module_platform_driver(stm32_pwm_lp_driver);
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
