Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFC7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:01:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC8C9206A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NmbRTvOk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8C9206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3A6q2n4M8H3Ys1W4vs1yryKishw3tRFZxUZ728aY6WY=; b=NmbRTvOkXwnQmA
	7E0XxEBtKUnoawV7Ot7FRaMSJd3/sLCciM3kyCeVa+6RMi/fnF+ChWWIGO2mdkbp693tMbKpbXA4e
	iClBZXwQvXkc5Ry+rQv+GIjosCv28FESMu3wJd812QtP61U+O0JoctZU0O0jNTAKPQ3yA0nF4j7G9
	eB1szDL/VQm56MUCh4K9X9G+jUVX2xVmMp9ryK8fp7M9RvR5viKzGSKIIe5G8sXmcU2hAq16vKHPh
	11996KD3Jkr9XnxYRN3IYI8raLNEBvcFcqq1FORsZZ0cH0U1wE230NWXUsE+6wPvIfgRN2XhRM25+
	Euy8a5AuENa15pQSiDgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggvgr-0002Ru-BV; Tue, 08 Jan 2019 18:01:25 +0000
Received: from shell.v3.sk ([90.176.6.54])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggvef-0007Rf-Pm
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 17:59:28 +0000
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id C9898FFF78;
 Tue,  8 Jan 2019 18:59:07 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 7463PA4-DgbY; Tue,  8 Jan 2019 18:58:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id F16FE100061;
 Tue,  8 Jan 2019 18:58:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id giFGylPeJgct; Tue,  8 Jan 2019 18:58:31 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com
 [213.175.37.10])
 by zimbra.v3.sk (Postfix) with ESMTPSA id ED5EB100050;
 Tue,  8 Jan 2019 18:58:25 +0100 (CET)
From: Lubomir Rintel <lkundrak@v3.sk>
To: Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>,
 platform-driver-x86@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Subject: [PATCH v4 11/15] power: supply: olpc_battery: Use DT to get battery
 version
Date: Tue,  8 Jan 2019 18:58:14 +0100
Message-Id: <20190108175818.705110-12-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108175818.705110-1-lkundrak@v3.sk>
References: <20190108175818.705110-1-lkundrak@v3.sk>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_095910_840101_89F0BDF3 
X-CRM114-Status: GOOD (  11.86  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 James Cameron <quozl@laptop.org>, linux-pm@vger.kernel.org, x86@kernel.org,
 Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
 Lubomir Rintel <lkundrak@v3.sk>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Avoid using the x86 OLPC platform specific call to get the board
version. That wouldn't work on FDT-based ARM MMP2 platform.

Add the XO 1.5 compatible string too. This is actually not completely
necessary as the battery nodes on XO 1.5 claim to be compatible with
"olpc,xo1-battery", but there are, in fact, differencies.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

---
Changes since v2:
- Clarify the XO 1 compatibility in the commit message.

Changes since v1:
- Sort the new include a bit higher

 drivers/power/supply/olpc_battery.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
index 5a97e42a3547..5323987d9284 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/err.h>
 #include <linux/device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/jiffies.h>
@@ -622,11 +623,13 @@ static int olpc_battery_probe(struct platform_device *pdev)
 	olpc_ac = power_supply_register(&pdev->dev, &olpc_ac_desc, NULL);
 	if (IS_ERR(olpc_ac))
 		return PTR_ERR(olpc_ac);
-
-	if (olpc_board_at_least(olpc_board_pre(0xd0))) { /* XO-1.5 */
+	if (of_property_match_string(pdev->dev.of_node, "compatible",
+					"olpc,xo1.5-battery") >= 0) {
+		/* XO-1.5 */
 		olpc_bat_desc.properties = olpc_xo15_bat_props;
 		olpc_bat_desc.num_properties = ARRAY_SIZE(olpc_xo15_bat_props);
-	} else { /* XO-1 */
+	} else {
+		/* XO-1 */
 		olpc_bat_desc.properties = olpc_xo1_bat_props;
 		olpc_bat_desc.num_properties = ARRAY_SIZE(olpc_xo1_bat_props);
 	}
@@ -672,6 +675,7 @@ static int olpc_battery_remove(struct platform_device *pdev)
 
 static const struct of_device_id olpc_battery_ids[] = {
 	{ .compatible = "olpc,xo1-battery" },
+	{ .compatible = "olpc,xo1.5-battery" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, olpc_battery_ids);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
