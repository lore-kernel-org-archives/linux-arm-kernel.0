Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01893C10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:16:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C22B420818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WP1JZ6TN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22B420818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=XIh0AnkQ7PQRgGLSM4I9fENSw9yrvoBUmkGyQfUln+4=; b=WP1
	JZ6TNB7JPAY35Ek201O+y92yYGI2bQFoXzHLzjdN0YpyNqXVc3Z8XKz63ebikQ7xZQ/IOXuVLLHMk
	hLptU/8hswou0FcJwQOp/cY/I6BPHHNVfFMbh7Hh/wjs5BGdff/upJRgOY/mcgiegltxktIegrEHQ
	jTAwQUwT0E/NB4PrfghoRekv0HZWKE01FTZllUAND/H5Q/MaJ2CQ2xkDeMgmkZo6ktR8a4rv6b8oJ
	6VrXZ0UW5Ml+M0DTl6jxE7tgMiN5NbAajwl7345qJHOtQt6lfyINyPbwaOhUn0o547bmWaeYYArUg
	N2Mu6/LgC2QaOQ+oRtvZL58nF+R0OnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx53u-0002Q8-Ay; Fri, 22 Feb 2019 07:15:58 +0000
Received: from mxhk.zte.com.cn ([63.217.80.70])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx53q-0002NU-PY; Fri, 22 Feb 2019 07:15:56 +0000
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
 by Forcepoint Email with ESMTPS id 2CF9DDD809A2863B0878;
 Fri, 22 Feb 2019 15:15:41 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
 by mse01.zte.com.cn with ESMTP id x1M7FLSP037220;
 Fri, 22 Feb 2019 15:15:21 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2019022215155958-1228853 ;
 Fri, 22 Feb 2019 15:15:59 +0800 
From: Wen Yang <wen.yang99@zte.com.cn>
To: linus.walleij@linaro.org
Subject: [PATCH 1/5] net: dsa: fix a leaked reference by adding a missing
 of_node_put
Date: Fri, 22 Feb 2019 15:15:38 +0800
Message-Id: <1550819742-32155-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2019-02-22 15:15:59,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-02-22 15:15:05, Serialize complete at 2019-02-22 15:15:05
X-MAIL: mse01.zte.com.cn x1M7FLSP037220
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_231555_002614_8572A2EF 
X-CRM114-Status: GOOD (  11.97  )
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
Cc: wang.yi59@zte.com.cn, andrew@lunn.ch, alexandre.belloni@bootlin.com,
 f.fainelli@gmail.com, michal.simek@xilinx.com, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, Wen Yang <wen.yang99@zte.com.cn>, matthias.bgg@gmail.com,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 anirudh@xilinx.com, lorenzo.bianconi83@gmail.com, UNGLinuxDriver@microchip.com,
 John.Linn@xilinx.com, vivien.didelot@gmail.com, kvalo@codeaurora.org,
 nbd@nbd.name
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The call to of_get_child_by_name returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./drivers/net/dsa/rtl8366rb.c:510:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 501, but without a corresponding object release within this function.
./drivers/net/dsa/rtl8366rb.c:518:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 501, but without a corresponding object release within this function.
./drivers/net/dsa/rtl8366rb.c:540:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 501, but without a corresponding object release within this function.
./drivers/net/dsa/rtl8366rb.c:548:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 501, but without a corresponding object release within this function.
./drivers/net/dsa/rtl8366rb.c:556:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 501, but without a corresponding object release within this function.
./drivers/net/dsa/rtl8366rb.c:561:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 501, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Vivien Didelot <vivien.didelot@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/dsa/rtl8366rb.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/rtl8366rb.c b/drivers/net/dsa/rtl8366rb.c
index a4d5049..f4b14b6 100644
--- a/drivers/net/dsa/rtl8366rb.c
+++ b/drivers/net/dsa/rtl8366rb.c
@@ -507,7 +507,8 @@ static int rtl8366rb_setup_cascaded_irq(struct realtek_smi *smi)
 	irq = of_irq_get(intc, 0);
 	if (irq <= 0) {
 		dev_err(smi->dev, "failed to get parent IRQ\n");
-		return irq ? irq : -EINVAL;
+		ret = irq ? irq : -EINVAL;
+		goto out_put_node;
 	}
 
 	/* This clears the IRQ status register */
@@ -515,7 +516,7 @@ static int rtl8366rb_setup_cascaded_irq(struct realtek_smi *smi)
 			  &val);
 	if (ret) {
 		dev_err(smi->dev, "can't read interrupt status\n");
-		return ret;
+		goto out_put_node;
 	}
 
 	/* Fetch IRQ edge information from the descriptor */
@@ -537,7 +538,7 @@ static int rtl8366rb_setup_cascaded_irq(struct realtek_smi *smi)
 				 val);
 	if (ret) {
 		dev_err(smi->dev, "could not configure IRQ polarity\n");
-		return ret;
+		goto out_put_node;
 	}
 
 	ret = devm_request_threaded_irq(smi->dev, irq, NULL,
@@ -545,7 +546,7 @@ static int rtl8366rb_setup_cascaded_irq(struct realtek_smi *smi)
 					"RTL8366RB", smi);
 	if (ret) {
 		dev_err(smi->dev, "unable to request irq: %d\n", ret);
-		return ret;
+		goto out_put_node;
 	}
 	smi->irqdomain = irq_domain_add_linear(intc,
 					       RTL8366RB_NUM_INTERRUPT,
@@ -553,12 +554,15 @@ static int rtl8366rb_setup_cascaded_irq(struct realtek_smi *smi)
 					       smi);
 	if (!smi->irqdomain) {
 		dev_err(smi->dev, "failed to create IRQ domain\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_put_node;
 	}
 	for (i = 0; i < smi->num_ports; i++)
 		irq_set_parent(irq_create_mapping(smi->irqdomain, i), irq);
 
-	return 0;
+out_put_node:
+	of_node_put(intc);
+	return ret;
 }
 
 static int rtl8366rb_set_addr(struct realtek_smi *smi)
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
