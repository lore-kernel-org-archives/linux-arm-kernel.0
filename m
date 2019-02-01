Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB09C282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:47:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBED6218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KxAApOvR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tpCLd3Y0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBED6218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=R9lkMf/iwIpNhd6MPG66qWi4G0pDLBBwqXNWNsJZBkQ=; b=KxAApOvRuAp1EUQ7VYu2ovKJsf
	asfTEC1hAHSrdtWmrBjne5aTcobUodWHMSQ06vn7XeKzawrAcMEAcrCHP0qbPy2SXj/unttD8AHUA
	WBmT45RbybQuohGq2AT6L+nJUpKNp5D1bJlv00ZYLqSGJLdY+594ND/lwNsGOmL7AUauY8BR5jp5i
	gQKiWYfhh/qFr3K1gVU36a7XrMfvfgu0u0l3caof8mnXYVIuMdnqrXwHLaKi89jpbnfaowQwqpcwf
	xa1vI9zGQoe9+vUZT6sBCcDwVnqrK39CMo+6on3nTNa301zPSTmbc+2jzUXI1XEe4HM6PJK0zt/s2
	HvwNOvOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpbyQ-00047v-Qe; Fri, 01 Feb 2019 16:47:26 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpbyM-000451-RN
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 16:47:25 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20190201164719euoutp011b80bddd479f7d2fbd10d337952ff5b3~-S1hln6XU1936319363euoutp017
 for <linux-arm-kernel@lists.infradead.org>;
 Fri,  1 Feb 2019 16:47:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20190201164719euoutp011b80bddd479f7d2fbd10d337952ff5b3~-S1hln6XU1936319363euoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1549039639;
 bh=4O5crTvde9vF0PpacAVRzuJF6TGoQktWztAR6yioIxg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tpCLd3Y08y6WwZRb+eymHrmfwP59hKzaE1zFyoCZP40BjrwKjTN2SYFj2O5VRiKKo
 WvGwXqBEynd4NkMx/dN5c4baCaPO3s7DNveggIZGFwQmoPRzDNZCI5EQ1SWqhNrCjL
 IBKaaDrzgDcp6kP8IAp8YdPlykxA87vl4Xx/scsA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190201164719eucas1p215be3b5beedd0cb48d91179eb3d65edc~-S1g0ytYK1211512115eucas1p2I;
 Fri,  1 Feb 2019 16:47:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 6B.E3.04441.618745C5; Fri,  1
 Feb 2019 16:47:18 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20190201164718eucas1p1bca3a199d60e109e1da654d8afff2a47~-S1f6vZV-2643926439eucas1p1T;
 Fri,  1 Feb 2019 16:47:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20190201164717eusmtrp1ab288121c3a3b3e4b6ddc8f0f329c353~-S1fr1jUf3167231672eusmtrp1S;
 Fri,  1 Feb 2019 16:47:17 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-cf-5c547816cea1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 60.30.04128.518745C5; Fri,  1
 Feb 2019 16:47:17 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20190201164717eusmtip2efc7e94ed3b0d62cf020a48b5feddfc1~-S1e-svTz3272832728eusmtip2j;
 Fri,  1 Feb 2019 16:47:17 +0000 (GMT)
From: Lukasz Luba <l.luba@partner.samsung.com>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v4 1/8] clk: samsung: add needed IDs for DMC clocks in
 Exynos5420
Date: Fri,  1 Feb 2019 17:46:45 +0100
Message-Id: <1549039612-28905-2-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTURzv7O7uXleL6+bjZGIw7U0uwQ8XsrLHh6FfwoysLLvlTa1t2q7z
 kUZW5mNYioJa5INIpnOhTlExpzmXI0Q3U3ylMRoRli58o2Dl3K2+/f6/x/n/zuHgiLAO9cET
 FMm0UkHJxDw+t7VvbfCIV1pk9NGJCgnZVN6AkmNL31CyyjSIkoX2HwhpsTRi5MCjWYyczPIl
 9fZRlBzueMkjF5+aAFlu6eKQb0zTGFkzNsQhPz2s5ZFPDCaM7J3NRUMJqa5SB6R6bT5P2vz6
 gbTH0cmRPmvRAumi3u8c7zI/JJaWJaTQSsmJ6/z4tkJ+kk2QZrP5ZwHTdjVwwyERDPuqu4Ea
 8HEhUQugdbKDHZYA7NZrUNewCKC6d4T3N6LLHcVcggbAx0Xz3H8Re3bZpoLjPCIQtmvvOgMe
 RAacGutGnB6EmOJAw/MarlMQEefhatcE5sRcYi/sfv9uCwuIMLiqs2KubX5wYjAfcWI3Ihzm
 2du2+kFCj8GV5UGuy3QWri00c1xYBL+bW9iwL+wvKWA9DBzI07JXyIS5H9pZzzHYax5CnaUR
 4iBs6JC46FNw6JVxi4bETjg+5+6kkU1Y3FqGuGgBzMsRutwHYEuBlS3gBTW6UvZwKZx1lLKP
 WAngyNdOpAjsefF/WTUAWuBNqxh5HM0EKejUQIaSMypFXODNRLkebH6g/l/mhXaw/PGGERA4
 EO8QNK5HRAtRKoVJlxsBxBGxh+D07chooSCWSr9HKxNjlCoZzRjBbpwr9hZkbLNdERJxVDJ9
 h6aTaOVflYO7+WSBfTGqes79hplUgwVLOqPfuCbK+ay21nnIkoI8HSVZP2eM2UYwMm0OCKkF
 9Ear529rkySs2PG2x1190RYl0/TP1mdeiEqp6kwYN1Mr+/HKiC9uiXbf9YrDt4yXdmn8C6KW
 rip086Lg412OkOHwOTl/I2XOMOx3UlcV0DIcWijmMvFU0CFEyVB/AO82ZRk8AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42I5/e/4PV3RipAYg/Wr9Sw2zljPanH9y3NW
 i/lHzrFa9D9+zWxx/vwGdouzTW/YLW41yFhsenyN1eLyrjlsFp97jzBazDi/j8li7ZG77BZL
 r19ksrjduILNonXvEXaLw2/aWR0EPNbMW8PosWlVJ5vH5iX1Hgff7WHy6NuyitHj8ya5ALYo
 PZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYzt/VwF
 D3grHjxQbmA8wt3FyMkhIWAisab9GnsXIxeHkMBSRom2Xa2sEAkxiUn7trND2MISf651sUEU
 fWKUaFzxlqmLkYODTUBPYseqQpAaEYF6if43l9hAbGaBV0wSDe81QEqEBQIlOhaqgoRZBFQl
 9h89ADaSV8BL4vuaC1Dj5SRunutkBrE5BbwlOh5vZwSxhYBqVv07wDyBkW8BI8MqRpHU0uLc
 9NxiI73ixNzi0rx0veT83E2MwGjYduznlh2MXe+CDzEKcDAq8fBu+BUUI8SaWFZcmXuIUYKD
 WUmE1ykrJEaINyWxsiq1KD++qDQntfgQoynQUROZpUST84GRmlcSb2hqaG5haWhubG5sZqEk
 znveoDJKSCA9sSQ1OzW1ILUIpo+Jg1OqgdG4VDtTSPr21KU3a3nYLsdrBIV31W+/IqL86uHR
 jraoHGEeh9Ns/HNOq+ZvfefVMM3y5Fw54zT5gEy+67/3Kn52bD6V3JqccsA54T+PPGt5z6rZ
 9qxVOtVViw1POarVPylnZbxr1cWw2Hr9h8+cHk7FQaF+D1WXFK5d09DowlTxVUB/xzMvJZbi
 jERDLeai4kQAEk/QtJwCAAA=
X-CMS-MailID: 20190201164718eucas1p1bca3a199d60e109e1da654d8afff2a47
X-Msg-Generator: CA
X-RootMTR: 20190201164718eucas1p1bca3a199d60e109e1da654d8afff2a47
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190201164718eucas1p1bca3a199d60e109e1da654d8afff2a47
References: <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190201164718eucas1p1bca3a199d60e109e1da654d8afff2a47@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_084723_208180_BF15BA1C 
X-CRM114-Status: GOOD (  10.58  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
 b.zolnierkie@samsung.com, krzk@kernel.org,
 Lukasz Luba <l.luba@partner.samsung.com>, cw00.choi@samsung.com,
 kyungmin.park@samsung.com, kgene@kernel.org, myungjoo.ham@samsung.com,
 s.nawrocki@samsung.com, linux-arm-kernel@lists.infradead.org,
 m.szyprowski@samsung.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Define new IDs for clocks used by Dynamic Memory Controller in
Exynos5422 SoC.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 include/dt-bindings/clock/exynos5420.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
index 355f469..0d00fbb 100644
--- a/include/dt-bindings/clock/exynos5420.h
+++ b/include/dt-bindings/clock/exynos5420.h
@@ -60,6 +60,7 @@
 #define CLK_MAU_EPLL		159
 #define CLK_SCLK_HSIC_12M	160
 #define CLK_SCLK_MPHY_IXTAL24	161
+#define CLK_SCLK_BPLL		162
 
 /* gate clocks */
 #define CLK_UART0		257
@@ -195,6 +196,16 @@
 #define CLK_ACLK432_CAM		518
 #define CLK_ACLK_FL1550_CAM	519
 #define CLK_ACLK550_CAM		520
+#define CLK_CLKM_PHY0		521
+#define CLK_CLKM_PHY1		522
+#define CLK_ACLK_PPMU_DREX0_0	523
+#define CLK_ACLK_PPMU_DREX0_1	524
+#define CLK_ACLK_PPMU_DREX1_0	525
+#define CLK_ACLK_PPMU_DREX1_1	526
+#define CLK_PCLK_PPMU_DREX0_0	527
+#define CLK_PCLK_PPMU_DREX0_1	528
+#define CLK_PCLK_PPMU_DREX1_0	529
+#define CLK_PCLK_PPMU_DREX1_1	530
 
 /* mux clocks */
 #define CLK_MOUT_HDMI		640
@@ -217,6 +228,8 @@
 #define CLK_MOUT_EPLL		657
 #define CLK_MOUT_MAU_EPLL	658
 #define CLK_MOUT_USER_MAU_EPLL	659
+#define CLK_MOUT_SCLK_SPLL	660
+#define CLK_MOUT_MX_MSPLL_CCORE_PHY	661
 
 /* divider clocks */
 #define CLK_DOUT_PIXEL		768
@@ -248,8 +261,9 @@
 #define CLK_DOUT_CCLK_DREX0	794
 #define CLK_DOUT_CLK2X_PHY0	795
 #define CLK_DOUT_PCLK_CORE_MEM	796
+#define CLK_FF_DOUT_SPLL2	797
 
 /* must be greater than maximal clock id */
-#define CLK_NR_CLKS		797
+#define CLK_NR_CLKS		798
 
 #endif /* _DT_BINDINGS_CLOCK_EXYNOS_5420_H */
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
