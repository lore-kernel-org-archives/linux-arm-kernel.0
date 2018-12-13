Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B104C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:20:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF7C20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EOmb4KAv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BgkUEwxG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF7C20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Message-id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:List-Owner; bh=NgClqEz7FnZY61j9skTUNZrLIX2N/OBCi4C0DqmXDpE=; b=EO
	mb4KAvYQUtBy8/FU+FJvy6ku7DmG/XXsKuA4hr2+0QJ5vHImpbrjVGWOiRrglex2bxgzUs1KbT0zw
	O+3wZNGcEG5XIPSHtYaUsF1LgrwA5jDIl6K1KIqVwmT2JqFedXbeFLosIIOxg+0XQQu3iaH/kRzkj
	pl3u5RQ8PHXBMPw9Nbm5LpVCNpvsLjRga1+zBo7+AcmMgWsWfrOVNxOumFPOfTir4p2kLwd9yyt4D
	D81jBIBGosF+8M0oxpWq6+ZNOl+a36RxF06CJ+6vzkaRyF+ZFu9fRv7DuYLJZTtn8J9FptRjRoDzI
	N2j/fSse+r5dsmiKY9/ckTrJ3O56W6eg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXQun-00006P-K4; Thu, 13 Dec 2018 13:20:33 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQuj-00004t-FT
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 13:20:31 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20181213132015euoutp021aead4c13e2758ba7c036bf2ff8c6f68~v5wckTmEo1841518415euoutp02T;
 Thu, 13 Dec 2018 13:20:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20181213132015euoutp021aead4c13e2758ba7c036bf2ff8c6f68~v5wckTmEo1841518415euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1544707215;
 bh=7HxiWOLy+A38p3LZ0hDkDUt8Fq2+AnA7poGNCEtk51E=;
 h=From:To:Cc:Subject:Date:References:From;
 b=BgkUEwxGtRJkQXE1PG8/8ozVpZrluEvYc8w6V1sAuFr8vaK9ND8xrIHJLu4y4nv++
 oYguTHSv4CzdOhjVsbttupHvpPGdaCkrizZQrtNrTEqNjWMrR6uwQiGENNfmmkXa4H
 JtIxbOfCyO4ZOHKNgwEdP1VT3l5L6LIVcZGWyiBA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20181213132014eucas1p1fc2e73004b8b7e22d06b8aed69ff16e2~v5wb1iVZ_3102831028eucas1p1g;
 Thu, 13 Dec 2018 13:20:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 4D.5A.04441.D8C521C5; Thu, 13
 Dec 2018 13:20:13 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20181213132013eucas1p27cac2e47f756ea4f38c73cf651f5a13d~v5wbDocJM1941419414eucas1p2Q;
 Thu, 13 Dec 2018 13:20:13 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-c2-5c125c8d323b
Received: from eusync3.samsung.com ( [203.254.199.213]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 5A.67.04128.D8C521C5; Thu, 13
 Dec 2018 13:20:13 +0000 (GMT)
Received: from mcdsrvbld02.digital.local ([106.116.37.23]) by
 eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
 (built May  5 2014)) with ESMTPA id <0PJO00LSFFPI4140@eusync3.samsung.com>;
 Thu, 13 Dec 2018 13:20:13 +0000 (GMT)
From: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
Subject: [PATCH] drm/exynos: Change Andrzej Pietrasiewicz's e-mail address
Date: Thu, 13 Dec 2018 14:19:46 +0100
Message-id: <20181213131946.1880-1-andrzej.p@samsung.com>
X-Mailer: git-send-email 2.11.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsWy7djP87q9MUIxBjse21j0njvJZDHrZTuL
 xYo1TxgtNs5Yz2px5et7NotJ9yewWLy4d5HFov/xa2aL8+c3sFucbXrDbrHp8TVWixnn9zFZ
 rD1yl91ixuSXbA58Hjtn3WX32LSqk81j+7cHrB73u48zeWxeUu/Rt2UVo8fnTXIB7FFcNimp
 OZllqUX6dglcGZ+OLWApWMxdsWzjFtYGxr2cXYycHBICJhJTft9n7WLk4hASWMEocax1CzOE
 85lR4vOjr0wwVRsmz4dKLGOU+DnxJBuE08Qk8XzpLlaQKjYBY4m9BzsYQWwRgTyJq9PaweLM
 AteYJY5PNwexhQW8JC6/mg9WwyKgKvHl2w6wDbwClhKNr2axQGyTl9jVdhHsJgmBNWwSF/+c
 Z4NIuEh0TmxihbCFJV4d38IOYctIXJ7cDdVcL7Hpyx6o+imMEvfmekPY1hKHj1+EOohPYtK2
 6UDvcADFeSU62oQgSjwkPj6fBXaPkECsxAFgpExglFjAyLCKUTy1tDg3PbXYMC+1XK84Mbe4
 NC9dLzk/dxMjMH5P/zv+aQfj10tJhxgFOBiVeHgPyArGCLEmlhVX5h5ilOBgVhLhfRwFFOJN
 SaysSi3Kjy8qzUktPsQozcGiJM5bzfAgWkggPbEkNTs1tSC1CCbLxMEp1cCYWX5WMq/gyasE
 3hTv5Gkajw6WFcgUakRP+n4su07y9ao9jsvK3i+Oq6z3OlHg3RXbd+voXO+VtQe8CgsUuY+3
 hqqf2HwsQeZHwSU75fdvVva+6NR9kl+VI1F+y82o9I3hRuGevdw7IyR7t5RMPVXnvHfu8q0M
 D1QSmVr32QWFJIu4pq6onarEUpyRaKjFXFScCACdDtOv2wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDLMWRmVeSWpSXmKPExsVy+t/xq7q9MUIxBncnSVn0njvJZDHrZTuL
 xYo1TxgtNs5Yz2px5et7NotJ9yewWLy4d5HFov/xa2aL8+c3sFucbXrDbrHp8TVWixnn9zFZ
 rD1yl91ixuSXbA58Hjtn3WX32LSqk81j+7cHrB73u48zeWxeUu/Rt2UVo8fnTXIB7FFcNimp
 OZllqUX6dglcGZ+OLWApWMxdsWzjFtYGxr2cXYycHBICJhIbJs9n7mLk4hASWMIoceXWBVYI
 p4VJou/oMjaQKjYBY4m9BzsYQWwRgTyJRUsPgBUxC9xgltiw5DQzSEJYwEvi8qv5YEUsAqoS
 X77tYAKxeQUsJRpfzWKBWCcvsavtIusERq4FjAyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcx
 AsNs27GfW3Ywdr0LPsQowMGoxMN7QFYwRog1say4MvcQowQHs5II7+MooBBvSmJlVWpRfnxR
 aU5q8SFGaQ4WJXHe8waVUUIC6YklqdmpqQWpRTBZJg5OqQbGmoViPPP2n3x2yuLMZ7v+dav8
 BJNiN/Qtsda9+tW+2dr33IqMoLyN6jfWrA5i7vozZcG+NDGfJ9uKjYwSM8+uDfRIOX3JSsT+
 7LSAeU/5REWqt/2oXiic+GxDnp5x2OHXfE5N1ue66rnS734+u/PH6/va5jyXzhc3tG5/2BTG
 b/X73dlUtkWpSizFGYmGWsxFxYkAh223dC8CAAA=
X-CMS-MailID: 20181213132013eucas1p27cac2e47f756ea4f38c73cf651f5a13d
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181213132013eucas1p27cac2e47f756ea4f38c73cf651f5a13d
References: <CGME20181213132013eucas1p27cac2e47f756ea4f38c73cf651f5a13d@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_052029_824869_0808694B 
X-CRM114-Status: GOOD (  14.90  )
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
Cc: Joonyoung Shim <jy0922.shim@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Inki Dae <inki.dae@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
 Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

My @samusung.com address is going to cease existing soon, so change it to
an address which can actually be used to contact me.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_scaler.c | 2 +-
 drivers/gpu/drm/exynos/regs-scaler.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_scaler.c b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
index cd66774..cad9627 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_scaler.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
@@ -1,7 +1,7 @@
 /*
  * Copyright (C) 2017 Samsung Electronics Co.Ltd
  * Author:
- *	Andrzej Pietrasiewicz <andrzej.p@samsung.com>
+ *	Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/drivers/gpu/drm/exynos/regs-scaler.h b/drivers/gpu/drm/exynos/regs-scaler.h
index fc7ccad..512a2ba 100644
--- a/drivers/gpu/drm/exynos/regs-scaler.h
+++ b/drivers/gpu/drm/exynos/regs-scaler.h
@@ -2,7 +2,7 @@
  *
  * Copyright (c) 2017 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
- * Author: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
+ * Author: Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
  *
  * Register definition file for Samsung scaler driver
  *
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
