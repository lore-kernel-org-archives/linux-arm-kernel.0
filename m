Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BF0C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:35:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45F5A2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rwINBUrg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F5A2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=public-files.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=U+/EAFEn1IFwc6hTGp6NeEAMsYy2OpQ5bpv33OL7sOI=; b=rwINBUrgrpqjxyERP/nAxUf2X7
	XMsJ1y4N2km5A8/L2O4k16Uc0Qkp89KcOwJ3y0MAXE4LSFf5AvpGqKDJAZZmozXoLF4a8zP6jnmkB
	nLpfHU6Au13euVLXuZk9U64Kxh9AyWi2MWaBkIxifowUuRABvQWT5jRdo2w7+/BawsB7mQT9sPsbe
	3AT74sQjqz/sjzFRmpBVGvQ49HAUKLZgJ0Co25dwlixgiyVXaeVGK94OUE2+LVsfimD9imBKVoNXW
	wcE4A51PrpBAz4XJzv2eRv6h+mKNjHSt4vnB2lUNHC9mV2vN+JSIvXVV5hE5HonR5jgzT6LQg3IEO
	0ZwIgHtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWnoM-0002F8-O8; Tue, 11 Dec 2018 19:35:18 +0000
Received: from mout.gmx.net ([212.227.15.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWnnG-0000RW-9Q; Tue, 11 Dec 2018 19:34:14 +0000
Received: from localhost.localdomain ([91.14.83.44]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LsCdj-1hamJM3fcl-013wyj; Tue, 11
 Dec 2018 20:33:36 +0100
From: Frank Wunderlich <frank-w@public-files.de>
To: Andrew Lunn <andrew@lunn.ch>,
 Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: [PATCH 3/7] [DSA] adding handling of second CPU-Port
Date: Tue, 11 Dec 2018 20:33:10 +0100
Message-Id: <20181211193314.10695-3-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211193314.10695-1-frank-w@public-files.de>
References: <20181211193314.10695-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:uULslvaJwqYnz381Koxpp6SKyzdTC4qeUILpCFIU4cdT8rKSU56
 iv/wHJ6crRXZ/tTwcyFwxGkf8fi9XMcpX08h7hsiMoaUzBNf7gG7URiKAKS6pIHeEmAZxSz
 CofnXo9NEkz0YCFB2C/LjRBv0M2+OZcSVf3kLjI9C37axiUhtijlR/0RUzG7/3fSEEQPrEx
 xYxLjEitSJkFVYBU+lxEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ek4UThKCdyQ=:meMDkmieU45Eup87jixZrk
 FYAlrUIMSYNp119ik5EV9+s1Gwx84nXo9SrCSG/G9Q9tGzOYTcnPCD1nEtEwOvA+MT7J8ovUH
 N1dYWMa5MW5o+aLpH7GT6R7yxgZg6ftYUWfv48ORI1UtQtWHKi63h8nV1fflVEoZ4Y1ietwWK
 o3liUs8DoqiHDoZ+EbwiAamJd76Q6TH9unSf4zEBIO6WjOaMh0IVRqHfZvvqmBOgNiNJbYFx2
 Y9ZuI0cpr91mDEI2wDT5KYUxXEMCZ03sst6vbFpwIzVd1xCGmDW1h6/uHvwRUj1OUryZpcTbC
 C+FzVbkOxGXeRolng7+NXaPENhol7G5UH3nQ2qtZEWb0j1T7foHhR/ogTwMQm7OVks4VrEvug
 r7kXkbC6bAkxyEB19BuMjvFynCzdTlLxDKI4Nyj2EvSMWcojIw4d6rBcHcljyzmDWxL23M/sZ
 wZXFqelrqY6EojZYjGTkOtHZkFauTYL8ON35nh5gRQ0UBpkY5JEo97Vs42likl4BBrJJEatB5
 490LOV0zCLrx41XUsLsEu3IfpE08uCS9KeU6HrvPm690T1QU0mtV7I0awh270y1l+0Sp8mL8D
 UW3x7SDhXulGHYFaE9ReabvE0XqtEY4FCCn6y7fNnn1vjozFrQC9ULYW84EtLnhqWa6Sr3M9s
 U/0ntKQ3k8aBA6cvVJ1IRaGkw/59pBu2s4+QYHEYDPLMIfwZhVpFb0mDg7jyRQG/Xfn2zOri7
 yGVWEtb7s1feRfgRr8Bx/hqO//1ahvWV061/RT4ZrgXjLKdF2vI5GBucoflPZemLdxyf5VND1
 qyAGRokZOZCmj4X+H2S2unEuuJj63lp4nlRBVE/6SdWQTuwmQygC/CIIZIQsao5hXfyUa+H9v
 wQlr6P82Lp0x+uKB3hLdaKu3/5rJWj3as7MTThsmBTU0jMOFK6+S+C5M14F+4/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_113410_687399_B7A48729 
X-CRM114-Status: GOOD (  12.01  )
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
Cc: Frank Wunderlich <frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

based on
https://github.com/openwrt/openwrt/blob/master/target/linux/mediatek/patches-4.14/0033-dsa-multi-cpu.patch

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 net/dsa/dsa2.c  | 18 ++++++++++++++++++
 net/dsa/slave.c |  3 ++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index 77420675e9ed..4a6ebfe647f0 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -303,6 +303,8 @@ static int dsa_port_setup(struct dsa_port *dp)
 				ds->index, dp->index);
 			return err;
 		}
+		if (dp->master)
+			dp->master->dsa_ptr = dp;
 		break;
 	case DSA_PORT_TYPE_DSA:
 		/* dp->index is used now as port_number. However
@@ -323,12 +325,17 @@ static int dsa_port_setup(struct dsa_port *dp)
 		devlink_port_attrs_set(&dp->devlink_port,
 				       DEVLINK_PORT_FLAVOUR_PHYSICAL,
 				       dp->index, false, 0);
+		err = dsa_user_parse(dp, dp->index, ds);
+		if (err)
+			return err;
+
 		err = dsa_slave_create(dp);
 		if (err)
 			dev_err(ds->dev, "failed to create slave for port %d.%d\n",
 				ds->index, dp->index);
 		else
 			devlink_port_type_eth_set(&dp->devlink_port, dp->slave);
+
 		break;
 	}
 
@@ -344,6 +351,14 @@ static void dsa_port_teardown(struct dsa_port *dp)
 	case DSA_PORT_TYPE_UNUSED:
 		break;
 	case DSA_PORT_TYPE_CPU:
+		dsa_port_link_unregister_of(dp);
+		if (dp->master)
+			dp->master->dsa_ptr = NULL;
+		if (dp->ethernet) {
+			dev_put(dp->ethernet);
+			dp->ethernet = NULL;
+		}
+		break;
 	case DSA_PORT_TYPE_DSA:
 		dsa_port_link_unregister_of(dp);
 		break;
@@ -598,6 +613,9 @@ static int dsa_port_parse_cpu(struct dsa_port *dp, struct net_device *master)
 	dp->master = master;
 	dp->dst = dst;
 
+	dev_hold(master);
+	ds->ports[dp->index].ethernet = master;
+
 	return 0;
 }
 
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 7d0c19e7edcf..f0fdb9e5d05f 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1312,11 +1312,11 @@ static void dsa_slave_notify(struct net_device *dev, unsigned long val)
 int dsa_slave_create(struct dsa_port *port)
 {
 	const struct dsa_port *cpu_dp = port->cpu_dp;
-	struct net_device *master = cpu_dp->master;
 	struct dsa_switch *ds = port->ds;
 	const char *name = port->name;
 	struct net_device *slave_dev;
 	struct dsa_slave_priv *p;
+	struct net_device *master = ds->ports[port->upstream].ethernet;
 	int ret;
 
 	if (!ds->num_tx_queues)
@@ -1355,6 +1355,7 @@ int dsa_slave_create(struct dsa_port *port)
 	p->dp = port;
 	INIT_LIST_HEAD(&p->mall_tc_list);
 	p->xmit = cpu_dp->tag_ops->xmit;
+	p->master = master;
 	port->slave = slave_dev;
 
 	netif_carrier_off(slave_dev);
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
