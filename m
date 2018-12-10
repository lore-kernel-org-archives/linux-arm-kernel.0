Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9146DC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:13:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 579C220821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CuXOROUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 579C220821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oXOweY+S0DR9sbj6ZYVRv2v4PAfVQ3UZk8Ii8zFLZ5A=; b=CuXOROUuV1CQpN
	ZZD41DnrltYoysHuce2HTf6nqPGH/ZNO+p6c/B0XvxEaJEoDcC1zKOicMaKOyB+raaX6qQ4HGEIE7
	854RGpmmOKl7plNxZOT+izSxHvVlmWNpxgUMzhPiAPE8FjpXKcIQ+UKoBsaXT09Ajpe3GTe3dCV9X
	dhwi1Xpa5eb3mSD4+M7HlSbG2RqdDDBM5fTRnyyFLoduKvKhGcBtY/qrEaRzwXPnLfETxzvj78IBA
	OWOpo5G/7ActQIQbjC0EGc7ei6MRt3BxiuBZjO+ah3WMuYogTbySwm2t5ZdmIVVOLYzDUXiNydkF6
	QmtSD7sV9G3jrIW7wAHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWToG-0005B1-6p; Mon, 10 Dec 2018 22:13:52 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWToD-00059S-26
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 22:13:50 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id 363DF8132;
 Mon, 10 Dec 2018 22:13:43 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Subject: [PATCH 2/2] bus: ti-sysc: Check for no-reset and no-idle flags at the
 child level
Date: Mon, 10 Dec 2018 14:13:34 -0800
Message-Id: <20181210221334.24982-2-tony@atomide.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210221334.24982-1-tony@atomide.com>
References: <20181210221334.24982-1-tony@atomide.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_141349_142488_EC27724F 
X-CRM114-Status: GOOD (  13.14  )
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
Cc: Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 Dave Gerlach <d-gerlach@ti.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Tero Kristo <t-kristo@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
 Keerthy <j-keerthy@ti.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

With ti-sysc, we need to now have the device tree properties for
ti,no-reset-on-init and ti,no-idle-on-init at the module level instead
of the child device level.

Let's check for these properties at the child device level to enable
quirks, and warn about moving the properties to the module level.

Otherwise am335x-evm based boards tagging gpio1 with ti,no-reset-on-init
will have their DDR power disabled if wired up in such a tricky way.

Note that this should not be an issue for earlier kernels as we don't
rely on this until the dts files have been updated to probe with ti-sysc
interconnect target driver.

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reported-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -91,6 +91,9 @@ struct sysc {
 	struct delayed_work idle_work;
 };
 
+static void sysc_parse_dts_quirks(struct sysc *ddata, struct device_node *np,
+				  bool is_child);
+
 void sysc_write(struct sysc *ddata, int offset, u32 value)
 {
 	writel_relaxed(value, ddata->module_va + offset);
@@ -379,6 +382,7 @@ static int sysc_check_one_child(struct sysc *ddata,
 		dev_warn(ddata->dev, "really a child ti,hwmods property?");
 
 	sysc_check_quirk_stdout(ddata, np);
+	sysc_parse_dts_quirks(ddata, np, true);
 
 	return 0;
 }
@@ -1279,23 +1283,37 @@ static const struct sysc_dts_quirk sysc_dts_quirks[] = {
 	  .mask = SYSC_QUIRK_NO_RESET_ON_INIT, },
 };
 
-static int sysc_init_dts_quirks(struct sysc *ddata)
+static void sysc_parse_dts_quirks(struct sysc *ddata, struct device_node *np,
+				  bool is_child)
 {
-	struct device_node *np = ddata->dev->of_node;
 	const struct property *prop;
-	int i, len, error;
-	u32 val;
-
-	ddata->legacy_mode = of_get_property(np, "ti,hwmods", NULL);
+	int i, len;
 
 	for (i = 0; i < ARRAY_SIZE(sysc_dts_quirks); i++) {
-		prop = of_get_property(np, sysc_dts_quirks[i].name, &len);
+		const char *name = sysc_dts_quirks[i].name;
+
+		prop = of_get_property(np, name, &len);
 		if (!prop)
 			continue;
 
 		ddata->cfg.quirks |= sysc_dts_quirks[i].mask;
+		if (is_child) {
+			dev_warn(ddata->dev,
+				 "dts flag should be at module level for %s\n",
+				 name);
+		}
 	}
+}
+
+static int sysc_init_dts_quirks(struct sysc *ddata)
+{
+	struct device_node *np = ddata->dev->of_node;
+	int error;
+	u32 val;
+
+	ddata->legacy_mode = of_get_property(np, "ti,hwmods", NULL);
 
+	sysc_parse_dts_quirks(ddata, np, false);
 	error = of_property_read_u32(np, "ti,sysc-delay-us", &val);
 	if (!error) {
 		if (val > 255) {
-- 
2.19.2

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
