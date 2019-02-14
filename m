Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D278CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:54:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A101821928
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gLkDE/r+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A101821928
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KlJ5VSuZcJ9oE6Hh8K75mmTvSoHKdUHSqvsxDi2Nh28=; b=gLkDE/r+ONUUY+
	PLFkxyBsN+KUy00JG10ZQc4M67rAzaayGQUfGaZn5Nk3VZp6LqPPztNorrfbM1EHO8iK9jOAFRzGV
	6zZdqc3wi62hHxJ5hOSOKXgGDVDmCzrE67x4v/Dir3JKtaQtoHw+EvZfmIUBTROnbZgdADpX9EJR0
	UE+KEAFqqlByHNnDGJVNhCxXnmw2EO4yLRJA4K7kDodBwlr6vIexyIMI7E9dv9K/yfWapa8qaM5tK
	q/IOsNt+T8qkWfr/RtSBHxg1bfhzLXW0UIMABScRy71hpMKLX7+PrUB9JuRBInkDXJAJy4/WQUIQx
	PhxVjlCtmHPqOEIk3NHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guKHl-0003KZ-D0; Thu, 14 Feb 2019 16:54:53 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guKHR-0002vM-Fe
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 16:54:35 +0000
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1EGplDe015219; Thu, 14 Feb 2019 17:54:30 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2qmwsumk2t-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Thu, 14 Feb 2019 17:54:30 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1EF9C31;
 Thu, 14 Feb 2019 16:54:30 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E7BE9A472;
 Thu, 14 Feb 2019 16:54:29 +0000 (GMT)
Received: from localhost (10.75.127.47) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 14 Feb 2019 17:54:30
 +0100
From: Alexandre Torgue <alexandre.torgue@st.com>
To: Linus Walleij <linus.walleij@linaro.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>
Subject: [PATCH 2/2] pinctrl: stm32: return error upon hwspinlock failure
Date: Thu, 14 Feb 2019 17:54:25 +0100
Message-ID: <1550163266-19975-3-git-send-email-alexandre.torgue@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550163266-19975-1-git-send-email-alexandre.torgue@st.com>
References: <1550163266-19975-1-git-send-email-alexandre.torgue@st.com>
MIME-Version: 1.0
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-14_09:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_085433_888527_C1F56BB4 
X-CRM114-Status: UNSURE (   9.53  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-gpio@vger.kernel.org, alexandre.torgue@st.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Return error to the caller when the hwspinlock can't get locked.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index f6279c8..0b9ff5a 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -583,8 +583,8 @@ static int stm32_pmx_get_func_groups(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
-static void stm32_pmx_set_mode(struct stm32_gpio_bank *bank,
-		int pin, u32 mode, u32 alt)
+static int stm32_pmx_set_mode(struct stm32_gpio_bank *bank,
+			      int pin, u32 mode, u32 alt)
 {
 	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
 	u32 val;
@@ -620,6 +620,8 @@ static void stm32_pmx_set_mode(struct stm32_gpio_bank *bank,
 unlock:
 	spin_unlock_irqrestore(&bank->lock, flags);
 	clk_disable(bank->clk);
+
+	return err;
 }
 
 void stm32_pmx_get_mode(struct stm32_gpio_bank *bank, int pin, u32 *mode,
@@ -676,9 +678,7 @@ static int stm32_pmx_set_mux(struct pinctrl_dev *pctldev,
 	mode = stm32_gpio_get_mode(function);
 	alt = stm32_gpio_get_alt(function);
 
-	stm32_pmx_set_mode(bank, pin, mode, alt);
-
-	return 0;
+	return stm32_pmx_set_mode(bank, pin, mode, alt);
 }
 
 static int stm32_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
@@ -688,9 +688,7 @@ static int stm32_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
 	struct stm32_gpio_bank *bank = gpiochip_get_data(range->gc);
 	int pin = stm32_gpio_pin(gpio);
 
-	stm32_pmx_set_mode(bank, pin, !input, 0);
-
-	return 0;
+	return stm32_pmx_set_mode(bank, pin, !input, 0);
 }
 
 static const struct pinmux_ops stm32_pmx_ops = {
@@ -704,8 +702,8 @@ static const struct pinmux_ops stm32_pmx_ops = {
 
 /* Pinconf functions */
 
-static void stm32_pconf_set_driving(struct stm32_gpio_bank *bank,
-	unsigned offset, u32 drive)
+static int stm32_pconf_set_driving(struct stm32_gpio_bank *bank,
+				   unsigned offset, u32 drive)
 {
 	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
 	unsigned long flags;
@@ -734,6 +732,8 @@ static void stm32_pconf_set_driving(struct stm32_gpio_bank *bank,
 unlock:
 	spin_unlock_irqrestore(&bank->lock, flags);
 	clk_disable(bank->clk);
+
+	return err;
 }
 
 static u32 stm32_pconf_get_driving(struct stm32_gpio_bank *bank,
@@ -754,8 +754,8 @@ static u32 stm32_pconf_get_driving(struct stm32_gpio_bank *bank,
 	return (val >> offset);
 }
 
-static void stm32_pconf_set_speed(struct stm32_gpio_bank *bank,
-	unsigned offset, u32 speed)
+static int stm32_pconf_set_speed(struct stm32_gpio_bank *bank,
+				 unsigned offset, u32 speed)
 {
 	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
 	unsigned long flags;
@@ -784,6 +784,8 @@ static void stm32_pconf_set_speed(struct stm32_gpio_bank *bank,
 unlock:
 	spin_unlock_irqrestore(&bank->lock, flags);
 	clk_disable(bank->clk);
+
+	return err;
 }
 
 static u32 stm32_pconf_get_speed(struct stm32_gpio_bank *bank,
@@ -804,8 +806,8 @@ static u32 stm32_pconf_get_speed(struct stm32_gpio_bank *bank,
 	return (val >> (offset * 2));
 }
 
-static void stm32_pconf_set_bias(struct stm32_gpio_bank *bank,
-	unsigned offset, u32 bias)
+static int stm32_pconf_set_bias(struct stm32_gpio_bank *bank,
+				unsigned offset, u32 bias)
 {
 	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
 	unsigned long flags;
@@ -834,6 +836,8 @@ static void stm32_pconf_set_bias(struct stm32_gpio_bank *bank,
 unlock:
 	spin_unlock_irqrestore(&bank->lock, flags);
 	clk_disable(bank->clk);
+
+	return err;
 }
 
 static u32 stm32_pconf_get_bias(struct stm32_gpio_bank *bank,
@@ -896,22 +900,22 @@ static int stm32_pconf_parse_conf(struct pinctrl_dev *pctldev,
 
 	switch (param) {
 	case PIN_CONFIG_DRIVE_PUSH_PULL:
-		stm32_pconf_set_driving(bank, offset, 0);
+		ret = stm32_pconf_set_driving(bank, offset, 0);
 		break;
 	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
-		stm32_pconf_set_driving(bank, offset, 1);
+		ret = stm32_pconf_set_driving(bank, offset, 1);
 		break;
 	case PIN_CONFIG_SLEW_RATE:
-		stm32_pconf_set_speed(bank, offset, arg);
+		ret = stm32_pconf_set_speed(bank, offset, arg);
 		break;
 	case PIN_CONFIG_BIAS_DISABLE:
-		stm32_pconf_set_bias(bank, offset, 0);
+		ret = stm32_pconf_set_bias(bank, offset, 0);
 		break;
 	case PIN_CONFIG_BIAS_PULL_UP:
-		stm32_pconf_set_bias(bank, offset, 1);
+		ret = stm32_pconf_set_bias(bank, offset, 1);
 		break;
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		stm32_pconf_set_bias(bank, offset, 2);
+		ret = stm32_pconf_set_bias(bank, offset, 2);
 		break;
 	case PIN_CONFIG_OUTPUT:
 		__stm32_gpio_set(bank, offset, arg);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
