Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE7AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:16:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B7B820818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZXPa3WHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7B820818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=5p5ZzO9SbyNey8D1EDcV1xQuYl/hdEybrEt9EowtTSQ=; b=ZXPa3WHRf4siwnld+44bbi+kv6
	G5a0NAvO2HFjW/iUluqHdGOA9auZ/FIAq+PUeVaaOVXrwb06cdUy+7OR0cS9IistKWNGAaf82pKFa
	2vSGnsZUNWYuqezHbsreAtvTgnlYOPdbVmv6kuUh5khui1zW45EPAiIhNc1ZcVFAGj2LmY63+90eS
	diXWdEB4fUtgwP4+R07RJFUxqr9GBXNj1P1wO2cWcrzey+/EskEtYr1B5l1vYTCg/ZL6ykqAVW+wA
	d1jRkwPCWlAe2O4GiiWJu2ItxjVxhPSrbl5WzD/aNo+TB8Va6zIXHi0dsXw8AXrFPhkLkcpx5hSbC
	6YKWilMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx54Y-00038Q-J1; Fri, 22 Feb 2019 07:16:38 +0000
Received: from mxhk.zte.com.cn ([63.217.80.70])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx53q-0002NV-QI; Fri, 22 Feb 2019 07:15:58 +0000
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
 by Forcepoint Email with ESMTPS id 0775689F7E63BE8FA48E;
 Fri, 22 Feb 2019 15:15:43 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
 by mse01.zte.com.cn with ESMTP id x1M7FONF037279;
 Fri, 22 Feb 2019 15:15:24 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2019022215160221-1228878 ;
 Fri, 22 Feb 2019 15:16:02 +0800 
From: Wen Yang <wen.yang99@zte.com.cn>
To: linus.walleij@linaro.org
Subject: [PATCH 2/5] net: mscc: ocelot: fix a leaked reference by adding a
 missing of_node_put
Date: Fri, 22 Feb 2019 15:15:39 +0800
Message-Id: <1550819742-32155-2-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1550819742-32155-1-git-send-email-wen.yang99@zte.com.cn>
References: <1550819742-32155-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2019-02-22 15:16:02,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-02-22 15:15:08, Serialize complete at 2019-02-22 15:15:08
X-MAIL: mse01.zte.com.cn x1M7FONF037279
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_231555_041048_D35469F2 
X-CRM114-Status: GOOD (  11.81  )
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

The call to of_parse_phandle returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./drivers/net/ethernet/mscc/ocelot_board.c:293:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 249, but without a corresponding object release within this function.
./drivers/net/ethernet/mscc/ocelot_board.c:312:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 249, but without a corresponding object release within this function.
./drivers/net/ethernet/mscc/ocelot_board.c:336:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 249, but without a corresponding object release within this function.
./drivers/net/ethernet/mscc/ocelot_board.c:339:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 249, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/ethernet/mscc/ocelot_board.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_board.c b/drivers/net/ethernet/mscc/ocelot_board.c
index ca3ea2f..f1485a6 100644
--- a/drivers/net/ethernet/mscc/ocelot_board.c
+++ b/drivers/net/ethernet/mscc/ocelot_board.c
@@ -290,7 +290,7 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
 
 		err = ocelot_probe_port(ocelot, port, regs, phy);
 		if (err)
-			return err;
+			goto err_probe_ports;
 
 		err = of_get_phy_mode(portnp);
 		if (err < 0)
@@ -309,7 +309,8 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
 			dev_err(ocelot->dev,
 				"invalid phy mode for port%d, (Q)SGMII only\n",
 				port);
-			return -EINVAL;
+			err = -EINVAL;
+			goto err_probe_ports;
 		}
 
 		serdes = devm_of_phy_get(ocelot->dev, portnp, NULL);
@@ -328,6 +329,7 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
 		ocelot->ports[port]->serdes = serdes;
 	}
 
+	of_node_put(ports);
 	register_netdevice_notifier(&ocelot_netdevice_nb);
 	register_switchdev_blocking_notifier(&ocelot_switchdev_blocking_nb);
 
@@ -336,6 +338,7 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
 	return 0;
 
 err_probe_ports:
+	of_node_put(ports);
 	return err;
 }
 
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
