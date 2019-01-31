Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CF7C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:52:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AE822087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mDtTiBZt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pPgg1DIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE822087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=EXEOV0gqEc+8VY3lh18OojXRoiBVwZkiRWJMVYd3yBc=; b=mDtTiBZtBqLTLYVSILNUpcgztr
	VW+wdBNK1R95X2qo1KDkgJrRjIW5owm7QKMAWcK5VMzW6Uv41wxKzg3PV7sdtj1CWwmeecuVL5hJ1
	EhmXjgcCq9dSF6FbVws4dCQGtfv1663HjRkQOxis1eEbXwI0nXbPl97jEQddXX9IT0a/4MSqb1Ylp
	m2AXVWdxKk2KHqc3KJE670bc9vlesnSZXgRaH92i0ZOOF2LyfezOsev/e/puw7FIT1YsKft2grXRL
	y2X8OJiwKKrDDg+AIfsmzsjhVcjsAbkNhjl0Jh74Z47xqq/0tqr1EUF04NtXyk9HB7ageZWPOPcXc
	GsXuK+eA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp84u-0006ZM-TW; Thu, 31 Jan 2019 08:52:08 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp834-00052v-5r
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 08:50:17 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20190131085012euoutp02e7b2e6cd7011430e73164c99d2f8ddfd~_4rqUXGuh1222712227euoutp02P
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 08:50:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20190131085012euoutp02e7b2e6cd7011430e73164c99d2f8ddfd~_4rqUXGuh1222712227euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1548924612;
 bh=4xMoC/JxPClX+CtWb5Gm6QZEQL5oSmpJwmoKVZyNZLY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pPgg1DIcD0jtUY6PNBm7tB4SETh6qudE0cRqj5e3VNmzkhP/jYRbwEgs10tWOZqM/
 /Mp/+wZXS6Y9Tc+D4vQ4sWtRmTbFiX7iuegCHsmE3jHnDCgphclNz1Dt8OeVb/Bj6p
 S9Cuf4vkc4236jmHusd12xtPsEk45HqHe/by4tFg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190131085011eucas1p2854f30a60501b58d506774d92657ab52~_4rpgjA9q2509325093eucas1p2n;
 Thu, 31 Jan 2019 08:50:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 3F.13.04441.3C6B25C5; Thu, 31
 Jan 2019 08:50:11 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20190131085011eucas1p2c315d69c8902fbceff689f3a92e0c5d9~_4rozClwC1957419574eucas1p2E;
 Thu, 31 Jan 2019 08:50:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20190131085010eusmtrp21d60cd2ac17f412744e8cb40c3844058~_4rojktiE2341223412eusmtrp2k;
 Thu, 31 Jan 2019 08:50:10 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-05-5c52b6c3259d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 7D.B4.04284.2C6B25C5; Thu, 31
 Jan 2019 08:50:10 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190131085010eusmtip1f08e8da7c2f9a102701aaacd3857b665~_4rnyklBQ1303913039eusmtip1E;
 Thu, 31 Jan 2019 08:50:10 +0000 (GMT)
From: Lukasz Luba <l.luba@partner.samsung.com>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 8/8] ARM: exynos_defconfig: enable DMC driver
Date: Thu, 31 Jan 2019 09:49:54 +0100
Message-Id: <1548924594-19084-9-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0hTcRTut3vvdh2urlP0oKa0MLKHD7D4gSEWBpceWFoUZdjKi4lu6m5a
 ptKU8pWWGGqopYVOG4o511KzNF2ZDjUT1KxEKog0I3yRiJV7WP995zvfd75z4NCEVE+50jHK
 i5xKKY+TCcWk4dXSwM5uQ1iE3/ST7bjpTiOFS78Mk3h0/iuFK40DFO6b0hD41udpAg8OPhLh
 /szvIjyudse6zyMUHm6rEOK5AiPCdwafC3BX8TOEG4wfRfh9Rp0Qd3/PpoId2OGRIYItVw+R
 rE6bK2Sbq6+yL360C9ibei1i53QeR0SnxHuiuLiYZE7lG3RWfGFpVkcmGOnL32r0AjV6KcpD
 djQwATBTdZ3MQ2JaytQh+Ln4VGAt5hGsmMoIazGHoGyiiVqz1M+/tllqETzVlBP/LBWFk6t+
 mhYyPtCiTTQbnJhU+DDaYdEQTBYBDYu9AnPDkQmGsfYC0oxJxgs+FHdYeAlzAFoftiNrmge8
 G8glzNiOOQjVeSuWQcD0iWBWM2lbKQQ+fm22XeQIUz16G3aHP62VAivmoT9HK7TiNMjubbFp
 AqG7Z4gyL00w3tDY5mul98Kza+8tNDDrYWzGwUwTq7DIUEpYaQnkZEmt6q2gz39jC3KG2voS
 23AWappvWS6RMvcQjDyBQuRZ9j+rCiEtcuGSeEU0x/sruUs+vFzBJymjfc7HK3Ro9ZdMv3tm
 W9DC23NdiKGRzF4y2XA0QkrJk/kURRcCmpA5SfyXQyOkkih5yhVOFR+pSorj+C7kRpMyF0nq
 usnTUiZafpGL5bgETrXWFdB2rmrkvUFRbmeKK443hCs1J25wCUWG5BG3ps1RvhLP2MOdkWTi
 guOQOjLdOLwYybql5o0HHusucSzLvy/+dHB++cGuiZUz+7bfzZyoDt+2+9ftkDSvTVvEpo3G
 2iz+kF+oJExas3O5kzJl2CvqT46VP96friGOB6cHebnIdc7GzIAdCzKSvyD330aoePlfVwvN
 3EcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsVy+t/xu7qHtgXFGBy6bWqxccZ6VovpTy6z
 WFz/8pzVYv6Rc6wWp14tY7bof/ya2eL8+Q3sFmeb3rBb3GqQsdj0+BqrxeVdc9gsPvceYbSY
 cX4fk8WhqXsZLdYeuctucbtxBZvF4TftrA6CHpevXWT2mN1wkcVj06pONo/NS+o9Dr7bw+TR
 t2UVo8fnTXIB7FF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZll
 qUX6dgl6GT8/bWIpOMJR8XLpFqYGxqPsXYycHBICJhJrvpxg6WLk4hASWMoocbD/CyNEQkxi
 0r7tUEXCEn+udbGB2EICnxglvu6U6mLk4GAT0JPYsaoQJCwiUC/R/+YSG8gcZoEpzBKL599h
 BUkICzhI3NjTywJiswioStyZup8JxOYV8JLYuXIP1C45iZvnOplBbE4Bb4klXX+ZIXZ5Sfz4
 95FxAiPfAkaGVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIFxsu3Yz807GC9tDD7EKMDBqMTD
 +2BtYIwQa2JZcWXuIUYJDmYlEV7D3/4xQrwpiZVVqUX58UWlOanFhxhNgY6ayCwlmpwPjOG8
 knhDU0NzC0tDc2NzYzMLJXHe8waVUUIC6YklqdmpqQWpRTB9TBycUg2M+Vlmmo4KkyRX/V6R
 2rwpXTmHv2zRTtadQTM8X72ee2ABQ/6Xdp1/HH2Hpr3+knfrqm0Gp2GRipjLjtL23VO6iru7
 mG1+5fxtfxGym5e9nbNm4W1Hn6Tv+bm//KZlFz76di3p16X1f26/z+o9Z/+w9vrLSkb1mnNt
 75f8v6IztahT9afjIctlSizFGYmGWsxFxYkAxGpN0qkCAAA=
X-CMS-MailID: 20190131085011eucas1p2c315d69c8902fbceff689f3a92e0c5d9
X-Msg-Generator: CA
X-RootMTR: 20190131085011eucas1p2c315d69c8902fbceff689f3a92e0c5d9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190131085011eucas1p2c315d69c8902fbceff689f3a92e0c5d9
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190131085011eucas1p2c315d69c8902fbceff689f3a92e0c5d9@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_005014_547506_C1C2EA02 
X-CRM114-Status: GOOD (  11.80  )
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
Cc: b.zolnierkie@samsung.com, Russell King <linux@armlinux.org.uk>,
 krzk@kernel.org, Lukasz Luba <l.luba@partner.samsung.com>,
 cw00.choi@samsung.com, kyungmin.park@samsung.com, kgene@kernel.org,
 myungjoo.ham@samsung.com, s.nawrocki@samsung.com,
 Guenter Roeck <groeck@chromium.org>, Benson Leung <bleung@chromium.org>,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enable driver for Dynamic Memory Controller dynamic frequency and
voltage scaling in Exynos5422 SoCs.

CC: Russell King <linux@armlinux.org.uk>
CC: Kukjin Kim <kgene@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>
CC: Marek Szyprowski <m.szyprowski@samsung.com>
CC: Guenter Roeck <groeck@chromium.org>
CC: Benson Leung <bleung@chromium.org>
CC: linux-arm-kernel@lists.infradead.org
CC: linux-samsung-soc@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index d635edf..b5dddcc 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -291,6 +291,7 @@ CONFIG_DEVFREQ_GOV_PERFORMANCE=y
 CONFIG_DEVFREQ_GOV_POWERSAVE=y
 CONFIG_DEVFREQ_GOV_USERSPACE=y
 CONFIG_ARM_EXYNOS_BUS_DEVFREQ=y
+CONFIG_ARM_EXYNOS5422_DMC_DEVFREQ=y
 CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP=y
 CONFIG_EXYNOS_IOMMU=y
 CONFIG_EXTCON=y
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
