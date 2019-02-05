Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D18C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:59:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91D242083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rilP/ghy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGdnhpla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D242083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=KwMglpvJXzCsnTWIHfohmCoxEMufZ0p3VX611CcLXgA=; b=ril
	P/ghysMaHdW0OFn3eCAxvvv99F9KnmtwuYfuVGkskZpmtekD4sJ1zWWHGdLzIXfZ9IooQ+FNFqltU
	lPHmQYsPKPry04aTSKl7cixzIVUoTBd17n6umgZPgle1p/U4SN1YVLsJd9sggZ2YaLBViTjw4Xe9w
	h8BJDPJTV06MjzrMfYKS9lL+qom6OD0OQLvs+90SO2iObOnXvErd0LbP6SK/eLGR4VViXmkZfaU7v
	0/EJRTO9iOc0rPvBGlqaqqWFSpRPnJ11ugBRkfaz2WxoH9IBfXuHwLUumcpyoMrhvymjo2KjMzDTE
	55UDU9q82hQzy99P+CE3cKgpBcHVQQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr6sQ-00065b-EK; Tue, 05 Feb 2019 19:59:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr6sN-000650-8j
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 19:59:24 +0000
Received: from localhost.localdomain (unknown [194.230.155.153])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 546012083B;
 Tue,  5 Feb 2019 19:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549396762;
 bh=Lmc2QzvU6mlVrbu9yAFloJg089oDSJS72xZtA5Ecs9U=;
 h=From:To:Cc:Subject:Date:From;
 b=VGdnhplap5z5ZwIRXClS50FCFf/blPWIqOmbeypB2YRKVeAP25CDSvKgi81uuSmy/
 HNauCpsYg+yYp+w2M39XWSgaf4o9/NLJ/EtcRYuRZN9Luph2KAf6gKgZKFuiyCErQ2
 CX2HsO2EWqd2TKOWrzWi88W1Zbi8NNKPKZ0E9m0s=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tomasz Figa <tomasz.figa@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Linus Walleij <linus.walleij@linaro.org>, Kukjin Kim <kgene@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] pinctrl: samsung: Remove legacy API for handling external
 wakeup interrupts mask
Date: Tue,  5 Feb 2019 20:59:09 +0100
Message-Id: <20190205195909.3565-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_115923_321792_D4E8FCC7 
X-CRM114-Status: GOOD (  10.79  )
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
Cc: Sylwester Nawrocki <snawrocki@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Remove the legacy, ugly API of exposing the static value of external
wakeup interrupts mask, because all arch-machine users where converted
to use generic implementation from pinctrl driver.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Sylwester Nawrocki <snawrocki@kernel.org>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>

---

Dear Linus,

Could you apply this directly? It is an old cleanup patch, waiting for
dependencies to get into mainline (v5.0-rc1).

Changes since v3:
1. Rebased on latest linux-next.
---
 drivers/pinctrl/samsung/pinctrl-exynos.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index f49ea3d92aa1..ebc27b06718c 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -325,13 +325,6 @@ int exynos_eint_gpio_init(struct samsung_pinctrl_drv_data *d)
 	return ret;
 }
 
-static u32 exynos_eint_wake_mask = 0xffffffff;
-
-u32 exynos_get_eint_wake_mask(void)
-{
-	return exynos_eint_wake_mask;
-}
-
 static int exynos_wkup_irq_set_wake(struct irq_data *irqd, unsigned int on)
 {
 	struct irq_chip *chip = irq_data_get_irq_chip(irqd);
@@ -342,10 +335,9 @@ static int exynos_wkup_irq_set_wake(struct irq_data *irqd, unsigned int on)
 	pr_info("wake %s for irq %d\n", on ? "enabled" : "disabled", irqd->irq);
 
 	if (!on)
-		exynos_eint_wake_mask |= bit;
+		our_chip->eint_wake_mask_value |= bit;
 	else
-		exynos_eint_wake_mask &= ~bit;
-	our_chip->eint_wake_mask_value = exynos_eint_wake_mask;
+		our_chip->eint_wake_mask_value &= ~bit;
 
 	return 0;
 }
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
