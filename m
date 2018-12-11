Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E55BC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:34:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 632FC20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kYrdA5nf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632FC20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=public-files.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=K3KLg3eKRrK8dkmDC4RCHhQb4q/QaALFR5L+7YaCf0g=; b=kYrdA5nfY/7fGZbac89uf8WIcL
	QvSBUAD/pL+hx+/hNqlbJvpTl0Jy7PimzJBhj4Mrqakl1H4TDJKP6TgDdSCwbVJXJgsT+K/2lkAuH
	NXxDW8RiM72leMkZMOcWzsqGzW5LEX8MXsTzvsQWEznsVPLJVO04X1F7l50KZyX459mOpLYrdIKeO
	LP+282GvLEA32rLiGRpF7oIRVagkqHu6K0s3qfgXSefTyH/Da6JeSW38p65TO+VdSgZwsOAyO2lGd
	DEpb+GPsHteqVbkfqJa0x8uI9aXpW98Kxxl/h6f7AI2ARKr+l2Buak0715Irs2Wqmrc3j6/8Xaata
	+FQq55ag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWnnX-0000hm-CR; Tue, 11 Dec 2018 19:34:27 +0000
Received: from mout.gmx.net ([212.227.15.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWnnG-0000RV-9W; Tue, 11 Dec 2018 19:34:12 +0000
Received: from localhost.localdomain ([91.14.83.44]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M08ia-1hR7Ou3at2-00uML8; Tue, 11
 Dec 2018 20:33:36 +0100
From: Frank Wunderlich <frank-w@public-files.de>
To: Andrew Lunn <andrew@lunn.ch>,
 Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: [PATCH 4/7] [DSA] add support for GMAC2 wired to ext
Date: Tue, 11 Dec 2018 20:33:11 +0100
Message-Id: <20181211193314.10695-4-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211193314.10695-1-frank-w@public-files.de>
References: <20181211193314.10695-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:mNf+lMJ6ZYyVAuGoQxrUK+NE4jg2KXrE9YW3eDBUMs0VsSBu+ru
 7NDUQwiFjxltR9n9InSwmxnPcc7OSowC2jtwrHOCn9ePD39GW2JO19SEeCplPK2W3xGK5RT
 BEB9lEUfNmPU84q+gcmiNLQUCPbGShAq3apwgqmZ0CiHTjaF9ggZRQMU0oXB5VEEyIiyEbK
 iE1ds/3xmtws2TVrdSccQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1PNnxaiOx+g=:BJ48jsOM96hzcW9/OPlpch
 +EtUZvQHyINePnT8kRd7awM+5Cnvbf6mJpTGpOzPaHRq1s+wTlqZqp8AmCKSgT84T1gJCrrDW
 FiNTULpnsBhURyrrDqIXiSd1IR4FmkeX7FO0tYEyzM0L6oJzZ8fHr9AYSdeumAAMdP7ZSKkEr
 nU3A5+5BsxF3V4n2WBRK9s11l6SNr/2YleaSpiO6hUPnGdc0carQXidbE9BYkn2qfq+8W5J/a
 Y1BYFqJeMiaee9s1KtaNu/j3e62sG+QWPm4WxFIgeDgIcYdzUd9VZC7951McjjV8iEEP9yOTJ
 r9maVURJ6lIqUAbOp8OSOKWxjMv9IavhApVVsGrRYywZ8uVPWwlGvx/Vgyd6RP6xeWKoX+xo+
 kl2gS0vtMUkhpdL5UdW2cO9tGLRxuQcaA15GUKUjAyMO3xsnOLWGDL8BtGNh06Dc0lwkljR0a
 /hXxI7AQEY5NQA3aOLwcGPcROWgJ2tvG03QHKI8broMgc1bh/k13XLwFv4wo4DZUb4ztUn952
 uOXuVQX9rQzZVX3u7VDgIMXLuXYqTQXdTPhON/D31R2O6pK/tfSPJ/ImWHWiYf6Wyh+TB1moU
 xoB6CTueGCnrKVwXGD1KT0lBTED7irt22NAe18K8ahvX8ZZ0/lkqELKmIDn0rSxO1AotYsZja
 nz1mfyOFMJTjGmcvVBgLkBT2WQ4YDJYBXxP68dW5EKSIpq7SNqi64OOuai7DOFWIwdV8p2Nwh
 3BKkQBKkX1wSy7bSAY0fkETckGggiUJbqTOMB//lPg550aS72NiRNUAUEeFsKp1XokokrHBFH
 9scqDph1HRVY1C3sA06iSvOAtYcXrX1mz2MoRSvCTgzCIPvELFh++Uy8SSMC+/rGVR2lLgAX6
 TOiDpqwg5zUqtSn9pLAlBYN8VwXh/TNQ72GkM40PR9LLyjjrAkzpn5GbMqZTZ5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_113410_695537_D9DD135B 
X-CRM114-Status: UNSURE (   8.06  )
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
https://github.com/openwrt/openwrt/blob/master/target/linux/mediatek/patches-4.14/0032-net-dsa-mediatek-add-support-for-GMAC2-wired-to-ext-.patch

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/net/dsa/mt7530.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index a5de9bffe5be..a6a15a063e3e 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1277,6 +1277,11 @@ mt7530_setup(struct dsa_switch *ds)
 	val = mt7530_read(priv, MT7530_MHWTRAP);
 	val &= ~MHWTRAP_P6_DIS & ~MHWTRAP_PHY_ACCESS;
 	val |= MHWTRAP_MANUAL;
+	if (!dsa_is_cpu_port(ds, 5)) {
+		val |= MHWTRAP_P5_DIS;
+		val |= MHWTRAP_P5_MAC_SEL;
+		val |= MHWTRAP_P5_RGMII_MODE;
+	}
 	mt7530_write(priv, MT7530_MHWTRAP, val);
 
 	/* Enable and reset MIB counters */
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
