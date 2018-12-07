Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5058EC67838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:08:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EA2020989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MPBMPAus"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA2020989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=2GxG3vQkwZaTooSZ6yjtP94Rayf78LUlSlgxReTHZYs=; b=MPBMPAusgpFxXt
	42SBsVhRyzVfvQCuefyiTCdLTDG0kCmqcrev7UYdKV+0r3UymG+kXhTTlKXEk5rDkrjOMONj5wW0K
	fwlqmSJFfMWR7yQsk2UJJcBPCE9NpP79axs9mTklYO14cMw/BtZ2sKe/e5oMWa+ltX70IxuakqkRY
	sQD0a3ZQhdLRfXfdeXRzpaKdnwS783VkHosMLTFTxhsoMp/10J+6EEs2hRjl4usNyaLfnwuCVwDNa
	9WW8A/18s5sLEHYrmkE5FiLYl/F5Awoa2NiED1l4GDkJ2We66LeelBqlQ+gPiiseijCGLNSJD0Vn+
	AvIaInTbuQ9CZcEyKwag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVLUZ-00073y-OD; Fri, 07 Dec 2018 19:08:51 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVLUW-0006zk-Oh
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 19:08:50 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id 67DEB80C0;
 Fri,  7 Dec 2018 19:08:40 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: Linus Walleij <linus.walleij@linaro.org>,
 Alexandre Courbot <gnurou@gmail.com>
Subject: [PATCH] gpio: gpio-omap: Revert deferred wakeup quirk handling for
 regressions
Date: Fri,  7 Dec 2018 11:08:29 -0800
Message-Id: <20181207190829.57864-1-tony@atomide.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_110848_842057_994E6B00 
X-CRM114-Status: GOOD (  14.32  )
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
Cc: Grygorii Strashko <grygorii.strashko@ti.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Keerthy <j-keerthy@ti.com>,
 Tero Kristo <t-kristo@ti.com>, linux-gpio@vger.kernel.org,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Ladislav Michl <ladis@linux-mips.org>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Commit ec0daae685b2 ("gpio: omap: Add level wakeup handling for omap4
based SoCs") attempted to fix omap4 GPIO wakeup handling as it was
blocking deeper SoC idle states. However this caused a regression for
GPIOs during runtime having over second long latencies for Ethernet
GPIO interrupt as reportedy by Russell King <rmk+kernel@armlinux.org.uk>.

Let's fix this issue by doing a partial revert of the breaking commit.
We still want to keep the quirk handling around as it is also used for
OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER.

The real fix for omap4 GPIO wakeup handling involves fixes for
omap_set_gpio_trigger() and omap_gpio_unmask_irq() and will be posted
separately. And we must keep the wakeup bit enabled during runtime
because of module doing clock autogating with autoidle configured.

Reported-by: Russell King <rmk+kernel@armlinux.org.uk>
Fixes: ec0daae685b2 ("gpio: omap: Add level wakeup handling for omap4
based SoCs")
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Ladislav Michl <ladis@linux-mips.org>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/gpio/gpio-omap.c | 64 ++++------------------------------------
 1 file changed, 5 insertions(+), 59 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -32,7 +32,6 @@
 #define OMAP4_GPIO_DEBOUNCINGTIME_MASK 0xFF
 
 #define OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER	BIT(2)
-#define OMAP_GPIO_QUIRK_DEFERRED_WKUP_EN	BIT(1)
 
 struct gpio_regs {
 	u32 irqenable1;
@@ -379,18 +378,9 @@ static inline void omap_set_gpio_trigger(struct gpio_bank *bank, int gpio,
 			readl_relaxed(bank->base + bank->regs->fallingdetect);
 
 	if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
-		/* Defer wkup_en register update until we idle? */
-		if (bank->quirks & OMAP_GPIO_QUIRK_DEFERRED_WKUP_EN) {
-			if (trigger)
-				bank->context.wake_en |= gpio_bit;
-			else
-				bank->context.wake_en &= ~gpio_bit;
-		} else {
-			omap_gpio_rmw(base, bank->regs->wkup_en, gpio_bit,
-				      trigger != 0);
-			bank->context.wake_en =
-				readl_relaxed(bank->base + bank->regs->wkup_en);
-		}
+		omap_gpio_rmw(base, bank->regs->wkup_en, gpio_bit, trigger != 0);
+		bank->context.wake_en =
+			readl_relaxed(bank->base + bank->regs->wkup_en);
 	}
 
 	/* This part needs to be executed always for OMAP{34xx, 44xx} */
@@ -942,44 +932,6 @@ omap2_gpio_disable_level_quirk(struct gpio_bank *bank)
 		       bank->base + bank->regs->risingdetect);
 }
 
-/*
- * On omap4 and later SoC variants a level interrupt with wkup_en
- * enabled blocks the GPIO functional clock from idling until the GPIO
- * instance has been reset. To avoid that, we must set wkup_en only for
- * idle for level interrupts, and clear level registers for the duration
- * of idle. The level interrupts will be still there on wakeup by their
- * nature.
- */
-static void __maybe_unused
-omap4_gpio_enable_level_quirk(struct gpio_bank *bank)
-{
-	/* Update wake register for idle, edge bits might be already set */
-	writel_relaxed(bank->context.wake_en,
-		       bank->base + bank->regs->wkup_en);
-
-	/* Clear level registers for idle */
-	writel_relaxed(0, bank->base + bank->regs->leveldetect0);
-	writel_relaxed(0, bank->base + bank->regs->leveldetect1);
-}
-
-static void __maybe_unused
-omap4_gpio_disable_level_quirk(struct gpio_bank *bank)
-{
-	/* Restore level registers after idle */
-	writel_relaxed(bank->context.leveldetect0,
-		       bank->base + bank->regs->leveldetect0);
-	writel_relaxed(bank->context.leveldetect1,
-		       bank->base + bank->regs->leveldetect1);
-
-	/* Clear saved wkup_en for level, it will be set for next idle again */
-	bank->context.wake_en &= ~(bank->context.leveldetect0 |
-				   bank->context.leveldetect1);
-
-	/* Update wake with only edge configuration */
-	writel_relaxed(bank->context.wake_en,
-		       bank->base + bank->regs->wkup_en);
-}
-
 /*---------------------------------------------------------------------*/
 
 static int omap_mpuio_suspend_noirq(struct device *dev)
@@ -1412,12 +1364,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 				omap_set_gpio_dataout_mask_multiple;
 	}
 
-	if (bank->quirks & OMAP_GPIO_QUIRK_DEFERRED_WKUP_EN) {
-		bank->funcs.idle_enable_level_quirk =
-			omap4_gpio_enable_level_quirk;
-		bank->funcs.idle_disable_level_quirk =
-			omap4_gpio_disable_level_quirk;
-	} else if (bank->quirks & OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER) {
+	if (bank->quirks & OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER) {
 		bank->funcs.idle_enable_level_quirk =
 			omap2_gpio_enable_level_quirk;
 		bank->funcs.idle_disable_level_quirk =
@@ -1806,8 +1753,7 @@ static const struct omap_gpio_platform_data omap4_pdata = {
 	.regs = &omap4_gpio_regs,
 	.bank_width = 32,
 	.dbck_flag = true,
-	.quirks = OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER |
-		  OMAP_GPIO_QUIRK_DEFERRED_WKUP_EN,
+	.quirks = OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER,
 };
 
 static const struct of_device_id omap_gpio_match[] = {
-- 
2.19.2

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
