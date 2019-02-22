Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A012CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:16:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E2862086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mySZS2+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2862086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Vj9WJ9rA4WYGn1G3LaYpGvYLFCo1Ut8EkFExVaRbC+4=; b=mySZS2+Zq29TOYXDgxsi5HxSV9
	8m/nPjLTyRAJ891Lxr1Ev4CGPTxZwxhWWEy4PJI2vjUJli51gXUO5A4R45N/PvbIxbMLYxO3xy0LH
	pMMBxa+YZO+BGwiBWhr9VSXdLmrsmfwGx++6atPd8g9mEEHgVp9qILOeUjf1MOscM1rpPRnds/n4S
	mA+Np6mt6hj65+G7prlWOvOm3BFx8KM2CPiPSWmz4zTGg49ReJbEtShTH8Gkl/TuvpkuvuM/i/8aq
	0wcbtWrFfJeoKkfhxAvQN1RBN2rnCod9EW0krQuPL2RYYShHIUeZETnaKsRuIqfYkD27fuBn0PhwG
	pDcKz/2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx54R-0002zq-ES; Fri, 22 Feb 2019 07:16:31 +0000
Received: from out1.zte.com.cn ([202.103.147.172] helo=mxct.zte.com.cn)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx53q-0002Nt-Pc; Fri, 22 Feb 2019 07:15:58 +0000
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
 by Forcepoint Email with ESMTPS id 1CE6E30B3A56BFC8A583;
 Fri, 22 Feb 2019 15:15:48 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
 by mse01.zte.com.cn with ESMTP id x1M7FZ3u037479;
 Fri, 22 Feb 2019 15:15:35 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2019022215161343-1228965 ;
 Fri, 22 Feb 2019 15:16:13 +0800 
From: Wen Yang <wen.yang99@zte.com.cn>
To: linus.walleij@linaro.org
Subject: [PATCH 5/5] net: dsa: fix a leaked reference by adding missing
 of_node_put
Date: Fri, 22 Feb 2019 15:15:42 +0800
Message-Id: <1550819742-32155-5-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1550819742-32155-1-git-send-email-wen.yang99@zte.com.cn>
References: <1550819742-32155-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2019-02-22 15:16:13,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-02-22 15:15:19, Serialize complete at 2019-02-22 15:15:19
X-MAIL: mse01.zte.com.cn x1M7FZ3u037479
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_231554_997287_6EADDBF1 
X-CRM114-Status: GOOD (  13.88  )
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
./net/dsa/port.c:294:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 284, but without a corresponding object release within this function.
./net/dsa/dsa2.c:627:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 618, but without a corresponding object release within this function.
./net/dsa/dsa2.c:630:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 618, but without a corresponding object release within this function.
./net/dsa/dsa2.c:636:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 618, but without a corresponding object release within this function.
./net/dsa/dsa2.c:639:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 618, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Vivien Didelot <vivien.didelot@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 net/dsa/dsa2.c | 16 ++++++++++------
 net/dsa/port.c |  1 +
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index 8c431e0..89823f0 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -613,7 +613,7 @@ static int dsa_switch_parse_ports_of(struct dsa_switch *ds,
 	struct device_node *ports, *port;
 	struct dsa_port *dp;
 	u32 reg;
-	int err;
+	int err = 0;
 
 	ports = of_get_child_by_name(dn, "ports");
 	if (!ports) {
@@ -624,19 +624,23 @@ static int dsa_switch_parse_ports_of(struct dsa_switch *ds,
 	for_each_available_child_of_node(ports, port) {
 		err = of_property_read_u32(port, "reg", &reg);
 		if (err)
-			return err;
+			goto out_put_node;
 
-		if (reg >= ds->num_ports)
-			return -EINVAL;
+		if (reg >= ds->num_ports) {
+			err = -EINVAL;
+			goto out_put_node;
+		}
 
 		dp = &ds->ports[reg];
 
 		err = dsa_port_parse_of(dp, port);
 		if (err)
-			return err;
+			goto out_put_node;
 	}
 
-	return 0;
+out_put_node:
+	of_node_put(ports);
+	return err;
 }
 
 static int dsa_switch_parse_member_of(struct dsa_switch *ds,
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 2d7e01b..a6d9a04 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -291,6 +291,7 @@ static struct phy_device *dsa_port_get_phy_device(struct dsa_port *dp)
 		return ERR_PTR(-EPROBE_DEFER);
 	}
 
+	of_node_put(phy_dn);
 	return phydev;
 }
 
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
