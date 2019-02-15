Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C12DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:02:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBF6D21B1C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rk5MRvQ2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="pRnaMg1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF6D21B1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=VRztHYXhSuNwyyYNVXOcTUz5Znj9qCSs3O+4E92dXFc=; b=Rk5
	MRvQ2QzGiNdRWEPjtz80b3nJEinQF4yhLNGCyty/uLvsDiTR6YTs/2IEi5/yNo1sdkmzhMqD4U17e
	a2/rUAc10tKsUNajM1uR/8uXZk43nY3ijlY/DQ+37JIL3cedyOs3vtgrAsdXB9p8VArzAtFZERoNI
	ATQgf6sf9XHxsTgxeEhYDMkqSohdpdcL5ueFlq8luUWMpnP51AOGqLArLFa0YwopHisdPoD+qQGM9
	DcJHqTr2u+lO9MTRe/0JXH9yzRFdwP202g0bSaK9AN0HC+C85GJp0zRtt4L6mKo2lrWN03FqCRccz
	T/yv1TI4V08aSrbgOV8Vzjqkkk98U9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guYRa-0004EV-Jg; Fri, 15 Feb 2019 08:01:58 +0000
Received: from m12-14.163.com ([220.181.12.14])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guYRU-0004Df-PO
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 08:01:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=1xcxi4Zr4aaPTy57CW
 jvbD7ZyvLCvnjLBec3BAsIsjM=; b=pRnaMg1hm66xPFgwm1Q3PVweWIrXSWD+/a
 TZZFPji0TJEnyKfzoNoR3ZODelxlNL8csKzgHiNU9QotHHj/wDWP7Wr+JwOOtmfR
 cwUBfbK64jOWTntmariCi8SVNPZ13bDeQ872wJBhV9NcZ07TyeoxhTbMSNZzcOUD
 uWAPD+ZMY=
Received: from localhost.localdomain (unknown [182.139.212.12])
 by smtp10 (Coremail) with SMTP id DsCowADn7+PicWZcXym0Fw--.3412S2;
 Fri, 15 Feb 2019 16:01:39 +0800 (CST)
From: WangBo <wdjjwb@163.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: nomadik: fix possible object reference leak
Date: Fri, 15 Feb 2019 16:01:36 +0800
Message-Id: <1550217696-3006-1-git-send-email-wdjjwb@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DsCowADn7+PicWZcXym0Fw--.3412S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cry7AF1ftryxGFWUCrW7Arb_yoW8Cr18pF
 W7JFWagryUtF47K34rGa1fZrWSk3WI9w42q3s2939Fgay3Jr93Gr48KFyavrZ5CF93G3y3
 JrWUtFy8ZF4DAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jyKZXUUUUU=
X-Originating-IP: [182.139.212.12]
X-CM-SenderInfo: xzgmy4re6rljoofrz/1tbiOwNcGVXlh4wh-QAAsa
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_000153_880691_9F10F9FA 
X-CRM114-Status: UNSURE (   8.68  )
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
Cc: linux-gpio@vger.kernel.org, linus.walleij@linaro.org, wang.bo116@zte.com.cn,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The of_find_device_by_node takes a reference to the struct device
when find the match device ,we should release it when fail.

Signed-off-by: WangBo <wang.bo116@zte.com.cn>
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 4cc2c47f8778..ec02739bd21b 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1056,17 +1056,22 @@ static struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
 	}
 	if (of_property_read_u32(np, "gpio-bank", &id)) {
 		dev_err(&pdev->dev, "populate: gpio-bank property not found\n");
+		platform_device_put(gpio_pdev);
 		return ERR_PTR(-EINVAL);
 	}
 
 	/* Already populated? */
 	nmk_chip = nmk_gpio_chips[id];
-	if (nmk_chip)
+	if (nmk_chip) {
+		platform_device_put(gpio_pdev);
 		return nmk_chip;
+	}
 
 	nmk_chip = devm_kzalloc(&pdev->dev, sizeof(*nmk_chip), GFP_KERNEL);
-	if (!nmk_chip)
+	if (!nmk_chip) {
+		platform_device_put(gpio_pdev);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	nmk_chip->bank = id;
 	chip = &nmk_chip->chip;
@@ -1077,13 +1082,17 @@ static struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
 
 	res = platform_get_resource(gpio_pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(base))
+	if (IS_ERR(base)) {
+		platform_device_put(gpio_pdev);
 		return ERR_CAST(base);
+	}
 	nmk_chip->addr = base;
 
 	clk = clk_get(&gpio_pdev->dev, NULL);
-	if (IS_ERR(clk))
+	if (IS_ERR(clk)) {
+		platform_device_put(gpio_pdev);
 		return (void *) clk;
+	}
 	clk_prepare(clk);
 	nmk_chip->clk = clk;
 
-- 
2.15.2



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
