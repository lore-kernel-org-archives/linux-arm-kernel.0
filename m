Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3111C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:14:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9102721908
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VXDHpTWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9102721908
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:
	From:To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=AlPxLOJ8I7fV+8M6R802uWm9EtTYH1d5iJ8LVC1zvPo=; b=VXDHpTWVdolaDv
	IWk0PZQr/BtR0aH+RZFrqbFKxQeNlEJmyUKPm1r/KR/aRg/iX8rHe67Oqer+ho17r2riESrqEEQAm
	EFAvoHE7vWi2DkhSkW0nuvtqGoGP4zjBU9tgNyBqiSbfm/AcFnBh3Y7X/+Fp5O3wJ4P99vjS/kdI0
	WXX/DtbzK+Ic9jq6cUt7F/a3nVW2JYPqxxDSN0Dm1dYUQbkE8NwmWKF6BWFEnLIrZNWsmQHQT5eTd
	YeoIQLrYbf9bNdGhPt6yOPulc8/5VpGOd134mEWTGb+vZHqGsv51N3zIybdj2KzjXRVClmWhu2CpL
	xbWuFvwE1RuOIRMdhB8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaHok-0003Or-QI; Fri, 21 Dec 2018 10:14:06 +0000
Received: from smtp3-g21.free.fr ([212.27.42.3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaHoh-0003O0-4h
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 10:14:04 +0000
Received: from [192.168.108.68] (unknown [213.36.7.13])
 (Authenticated sender: marc.w.gonzalez)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id 5CD3513F8BA;
 Fri, 21 Dec 2018 11:13:18 +0100 (CET)
To: Kishon Vijay Abraham <kishon@ti.com>, Andy Gross <andy.gross@linaro.org>, 
 David Brown <david.brown@linaro.org>, Yaniv Gardi <ygardi@codeaurora.org>
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCH v1] phy: qcom-ufs: Use iopoll.h readl_poll_timeout macro
Message-ID: <88cd3a2e-2acc-02ff-9f27-284d3b679d10@free.fr>
Date: Fri, 21 Dec 2018 11:13:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_021403_332109_F6424F21 
X-CRM114-Status: GOOD (  11.05  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, MSM <linux-arm-msm@vger.kernel.org>,
 Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Matt Wagantall <mattw@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 Mitchel Humpherys <mitchelh@codeaurora.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The private copy of readl_poll_timeout is no longer needed.
Use the implementation in iopoll.h instead.

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 drivers/phy/qualcomm/phy-qcom-ufs-i.h | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-ufs-i.h b/drivers/phy/qualcomm/phy-qcom-ufs-i.h
index 681644e43248..f798fb64de94 100644
--- a/drivers/phy/qualcomm/phy-qcom-ufs-i.h
+++ b/drivers/phy/qualcomm/phy-qcom-ufs-i.h
@@ -23,24 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/delay.h>
-
-#define readl_poll_timeout(addr, val, cond, sleep_us, timeout_us) \
-({ \
-	ktime_t timeout = ktime_add_us(ktime_get(), timeout_us); \
-	might_sleep_if(timeout_us); \
-	for (;;) { \
-		(val) = readl(addr); \
-		if (cond) \
-			break; \
-		if (timeout_us && ktime_compare(ktime_get(), timeout) > 0) { \
-			(val) = readl(addr); \
-			break; \
-		} \
-		if (sleep_us) \
-			usleep_range(DIV_ROUND_UP(sleep_us, 4), sleep_us); \
-	} \
-	(cond) ? 0 : -ETIMEDOUT; \
-})
+#include <linux/iopoll.h>
 
 #define UFS_QCOM_PHY_CAL_ENTRY(reg, val)	\
 	{				\
-- 
2.17.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
