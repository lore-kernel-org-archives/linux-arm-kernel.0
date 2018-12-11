Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2FFC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:35:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C660E20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NVGkyc6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C660E20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=public-files.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=7TiP5xNkvoEq6eXdC9AILawAmzyOnydeAnFB29RNAMU=; b=NVGkyc6+Qbh8NdVVEucxCByc0z
	2pWrOL0eXCGkinbgigr5zdS6pnvYUbgnkJBBxTsDAQ3vdeGyHBMDrrdJWSLOhM2Cah7OR8pa0PGuP
	v6jDwOxyh0Sc2tLJREwbddYzO21+YaB43UeFmU+L0EcrGEionVJUlef/g/0Ckq32cux3IKtKk5rv9
	LEV9c4z18pGn9GMdP7a1QU0/mwZDM1QibeyosSOfNcYaWKau0+pbCCVylQ9TIz+T4hKa9BPSjRd0O
	j6FaBH65TEffBcwCEdNjamVnYHCOgEJxc47xT6k7/m/OgiY4QBepBvvQsB2pwhjdwomi05rsqWJlY
	Zn9czhUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWnob-0002xT-P7; Tue, 11 Dec 2018 19:35:33 +0000
Received: from mout.gmx.net ([212.227.15.18])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWnnG-0000Ra-Sb; Tue, 11 Dec 2018 19:34:14 +0000
Received: from localhost.localdomain ([91.14.83.44]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M54fe-1hNFmP0NIc-00zIHc; Tue, 11
 Dec 2018 20:33:39 +0100
From: Frank Wunderlich <frank-w@public-files.de>
To: Andrew Lunn <andrew@lunn.ch>,
 Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: [PATCH 6/7] [DSA] tell GDMA when we are turning on the special tag
Date: Tue, 11 Dec 2018 20:33:13 +0100
Message-Id: <20181211193314.10695-6-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211193314.10695-1-frank-w@public-files.de>
References: <20181211193314.10695-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:uFgKQXFf5ffjFoYiHtcDtZDgE2oDlHS562h3FDJ6QC9XXwBnE5y
 CONdUO19qPjv3zRQmvcGXVS4tLjnPeRJozuJIcvahp7pGrsM5uKsFgEQ4MN0gWFeVMBw9Gx
 +B8CcF6tBpPNoof+Uq92L/FGvYka5vZkxE7/vtEW/DfB7+lxsQyPUCmTk+/L/6kxVpMovZs
 B1zP3X69gkvpbYuWNhnLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xO9EQCi536I=:b+bOI7S7AJJsRlQortI3Sq
 i3+ejQQd/dbczxZJbXf0gavnEkFxzLfhTU6IHCKfLC21vUP3qaqNfh/AfsT3MjPoWfzu3q08+
 8ly4JxvNvC6s+4VhsX185bxDZcRG5CiaDoK193i6L5wMvAoJtHiEyynwKcohsLsyVQIqli/6b
 GeYb+h0nXf6DneF3vg76rFL+RdTBqAYsjvl5L9L1RIgFzdKKgMPRuPnAYEDPzMOY5BQKa+T3Z
 fyYG2vXwr92E6pKzCn4s5Bknugrbdx4cAA4NGgxKDCWD6H/MZzJcxJUnv5KdZ2a47vkGvbcRw
 fMlyFYzampC8n2OgBD8aGoEF9mQqz6lyhLQ4S+bGUMqrFGtAqB+sHBwN9c6Sepwgmg5Ikigre
 8FfR6vDOtv47SeP0MRI0ikMrPOrwiXRxb01LP29ZR4cI5j3l3EXDk6d8xz3X2BjcObqdF+Lmv
 gqrPEXl/euUHKzRCtbPoldTvg1sCZO4zfmszDW+oMCGQdomxPfc+SuQb1dQmHAIzC+Fbr6oLi
 7wQOhSkXBmPucuWuBnR3xTwUGnwF46/Vqqdk0nPeYE7YPyM6IWXVBsjCRLYdi3F/gUmI+bimt
 UmGKv+PsRRadlM1sO9myKVmUBqZa00fn28ejntrT4GXe6J3fQDZJPbbFhVO7AqgJdh/7vA8Ef
 BCfvzFc0JW9QoGFkMscmYzhbjx6C6blefrhkWAs0d4ciO6gl/SLlqQMYS2KWddD/2zpG4qlrn
 JfnuAuGSFG/QW3P6jz1F9G+RSPOcmvOQ0G5WrfyB9xr+boHBzVqWZN1hAjhsUdo0jixJqigCW
 w8nWL6CTh4Kal4+vTX4ojDozl5WDtejsCgblaZzWkHBGv2hra+95Wf6lBQw6GOOGciWfGv85v
 U1JVf8V4RIc0+n9nGv0t8ikqKEh0pOAnZd+ND5Md0FsEDw+lMMkW5YnKB7IZAx
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_113411_218482_4969AB10 
X-CRM114-Status: UNSURE (   9.01  )
X-CRM114-Notice: Please train this message.
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
https://github.com/openwrt/openwrt/blob/master/target/linux/mediatek/patches-4.14/0044-net-next-dsa-mediatek-tell-GDMA-when-we-are-turning-.patch

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/net/dsa/mt7530.c | 6 ++++++
 drivers/net/dsa/mt7530.h | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 441320d4d779..83669f53cb36 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -681,6 +681,12 @@ mt7530_cpu_port_enable(struct mt7530_priv *priv,
 	mt7530_write(priv, MT7530_PVC_P(port),
 		     PORT_SPEC_TAG);
 
+	/* Enable Mediatek header mode on the GMAC that the cpu port
+	 * connects to
+	 */
+	regmap_write_bits(priv->ethernet, MTK_GDMA_FWD_CFG(port),
+			  GDMA_SPEC_TAG, GDMA_SPEC_TAG);
+
 	/* Setup the MAC by default for the cpu port */
 	mt7530_write(priv, MT7530_PMCR_P(port), PMCR_CPUP_LINK);
 
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index d9b407a22a58..310f2536175b 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -23,6 +23,10 @@
 
 #define TRGMII_BASE(x)			(0x10000 + (x))
 
+/* Registers for GDMA configuration access */
+#define MTK_GDMA_FWD_CFG(x)		(0x500 + (x * 0x1000))
+#define GDMA_SPEC_TAG			BIT(24)
+
 /* Registers to ethsys access */
 #define ETHSYS_CLKCFG0			0x2c
 #define  ETHSYS_TRGMII_CLK_SEL362_5	BIT(11)
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
