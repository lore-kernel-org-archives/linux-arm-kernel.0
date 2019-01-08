Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FD7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:05:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D47D92171F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oyKMkjTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47D92171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=public-files.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=FhA5y7YawSX9kUvPs2pQdy2WRBq0pHMPl8pwqViDZr0=; b=oyK
	MkjTBThAnZBuWKA3OuORYnBtChDvlaVI3haw6Zzti0oaQR3auddN/y4PHz3MpswSeAH3nMVpItvRD
	oL1bhzvrhjjMISM7pElqz4C9Fd0Hw67s8ieYVKPRnTXRNPQXkcs+/NQfLwGOjOT5qtHidmGu8xO7A
	IwqbRMnms6c8/NpKjMTcKGhGVjTbCO6XmJEVDI5mAfh6s58j1KNwPkZhMXk/BfzUe+0daQMdcWtOI
	Dx9L1HDHsmf/OvEyGis0Om2TXEiK1Sm2mn+RbXb5EjiFLe1JsxzkmCYvFrb0Tl7rGeOwhkf3jZZjE
	qMNTpNWBQU2wUOueEvNATF+0OUETCog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggtt6-0007hZ-O4; Tue, 08 Jan 2019 16:05:56 +0000
Received: from mout.gmx.net ([212.227.15.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggtt3-0007ga-N1; Tue, 08 Jan 2019 16:05:55 +0000
Received: from localhost.localdomain ([91.14.64.214]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0M9sa0-1gaKJm3hyC-00B6US; Tue, 08 Jan 2019 17:05:39 +0100
From: Frank Wunderlich <frank-w@public-files.de>
To: Felix Fietkau <nbd@openwrt.org>, John Crispin <john@phrozen.org>,
 Sean Wang <sean.wang@kernel.org>, Nelson Chang <nelson.chang@mediatek.com>,
 "David S. Miller" <davem@davemloft.net>,
 Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] net: ethernet: mediatek: fix warning in phy_start_aneg
Date: Tue,  8 Jan 2019 17:05:26 +0100
Message-Id: <20190108160526.18928-1-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
X-Provags-ID: V03:K1:l+mp37KjOVJSmnrQlklK3mKCAchMZ0EQQ1Llijw3B/XrLPiw3H4
 pOSn9+778/b+5mU0T8R1EsXyplHgEa4Uf9cFOtH8POmcB9x/j+VQ1arrIlQJIcVlwjX/q32
 4U25wQ6UJUVLIG4k6pnHp8ZVpQn+MRwvCImbC0HquhrZPvHXo1dznYJRJDTbTfNmWBK8FTh
 MqL5VH7rd2XvOzJpsOq5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b0FwHQ8FA68=:Vr1q3Owek51B+r7KjzVsdQ
 AsWui84BV/olgwdOhBXrd7NaMIBs3nYcNtlRXcxhsiM1d8fviE60zlkEbHuFBDUFh9Zeko/ik
 gQsTRzr736En38FNIh6Xu3j+787mYdCTkF/QNIU//SalsgtAYeZBUnZniUnAUoSJbT+wF552h
 gpUHWVHnz4k6J8gV5+6ORh5lnBmYbFqHJlD1LL90tX9hPJ8Ow0ADGKc9XUzJr32LHMhwoYt3H
 t7lGWh7w2edioj62WC1P0jjxBeqW0UPtC08Llk/X/3UikeLJuGCqn2RBdnd+XqdNt476s3/wk
 7PcO9PYGEPeQ/DDnhAklTm1nU7F772IhJb/B0FtK5iqgNR3ExowgmVUHcRExlb5jOVaYwnB3L
 aJPjGXuYGgbaMHwqQUit+RkKXpcinECV2nJAwZYLYmbl4K5Ovg0oXdb6CEgFqI/7R8HzapoR0
 ECWuBIYZw+ZJ/AlPFvUXFCHnha50mr5xQ7SJ275Tuw0Glez4q+LZ8PZ926huDFQ+GgI9PKvKV
 GuNSqaPoRkpDSgjdD+qGtn+rGE1dbfZj3KikUzkt0VfgaIfDDrqLKFxjbgJj6v/OYNWsOid8P
 k8tEFU4kysTU2Z4gheyGlgQU1rrvaXSjHaXWB7W7AwqAiNpaDyK7xbtKnSthhmk13RO2Fh7Ay
 7Uf2IFOpttTtUEHEbgY7KxuY5E+pxpnh3hrFAgf+gjl75+Ij49HAjuS+IGeZ6pyXZTi++d9nl
 U10LeTvFhqpWP74GEjSR6IpfeHUbOCDSslW/gMzrIuw/vv5zvylnPGISrQUOks4yW3OlHi4KG
 +V23+beMlEWwbAeRz6IjAuqpELkUToDZuUFgCCEiuqZTWnX/J8Trkh2rFBN9arslnqDCdal6n
 LNvxpddiiYKeWjj2POJjxccHS0qB6VZeI3K+p+rXJorxveqwBGnpCORCaji93G
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_080554_054757_978AB1FC 
X-CRM114-Status: GOOD (  10.45  )
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

From: Sean Wang <sean.wang@kernel.org>

linux 5.0-rc1 shows following warning on bpi-r2/mt7623 bootup:

[ 5.170597] WARNING: CPU: 3 PID: 1 at drivers/net/phy/phy.c:548 phy_start_aneg+0x110/0x144
[ 5.178826] called from state READY
....
[ 5.264111] [<c0629fd4>] (phy_start_aneg) from [<c0e3e720>] (mtk_init+0x414/0x47c)
[ 5.271630] r7:df5f5eec r6:c0f08c48 r5:00000000 r4:dea67800
[ 5.277256] [<c0e3e30c>] (mtk_init) from [<c07dabbc>] (register_netdevice+0x98/0x51c)
[ 5.285035] r8:00000000 r7:00000000 r6:c0f97080 r5:c0f08c48 r4:dea67800
[ 5.291693] [<c07dab24>] (register_netdevice) from [<c07db06c>] (register_netdev+0x2c/0x44)
[ 5.299989] r8:00000000 r7:dea2e608 r6:deacea00 r5:dea2e604 r4:dea67800
[ 5.306646] [<c07db040>] (register_netdev) from [<c06326d8>] (mtk_probe+0x668/0x7ac)
[ 5.314336] r5:dea2e604 r4:dea2e040
[ 5.317890] [<c0632070>] (mtk_probe) from [<c05a78fc>] (platform_drv_probe+0x58/0xa8)
[ 5.325670] r10:c0f86bac r9:00000000 r8:c0fbe578 r7:00000000 r6:c0f86bac r5:00000000
[ 5.333445] r4:deacea10
[ 5.335963] [<c05a78a4>] (platform_drv_probe) from [<c05a5248>] (really_probe+0x2d8/0x424)

maybe other boards using this generic driver are affected

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 399f565dd85a..e48c06874a85 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -356,6 +356,7 @@ static int mtk_phy_connect(struct net_device *dev)
 	linkmode_copy(dev->phydev->advertising, dev->phydev->supported);
 	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
 			 dev->phydev->advertising);
+	phy_start(dev->phydev);
 	phy_start_aneg(dev->phydev);
 
 	of_node_put(np);
@@ -1821,7 +1822,6 @@ static int mtk_open(struct net_device *dev)
 	else
 		refcount_inc(&eth->dma_refcnt);
 
-	phy_start(dev->phydev);
 	netif_start_queue(dev);
 
 	return 0;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
