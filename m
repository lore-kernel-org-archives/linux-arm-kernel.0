Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9C5C37123
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:24:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 380FB20861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y/6JP2JK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380FB20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=vogW2EQiP1t3E2FkpkiDXl3odkQZuGsajgDW4wA++cI=; b=Y/6
	JP2JK7SD5NV9+a4dMGT14EVaKfKJavynoW1OrPZAj2inTeGrjBSr947VdMM1JL/VveZfoz7KV/Cmi
	r7eJtyue9kQyYXUtiZo4CY8MdabUbIoT3T6guAvt8jCpVR7hR0OFiwYYKekNeM8ItuMBuBTKl9p9t
	GqnMa5+zrtwIrp/O9n5DH1pJ/BCqBtz4ICPJv4OM16ZqWcF6YjtigbiBLERP0laptz6aYhYGi7q3p
	5spljcnalf99eTpdHRdBjdqBrLB1No7MScpGNUXLjrogjKJHdoM8w68ZmqmQgQDbBY3pkpMKIOVdZ
	7upkUJbruXUwyferDXuYUlYrlIo0oBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glh3E-0004iA-9a; Mon, 21 Jan 2019 21:24:12 +0000
Received: from mail.ispras.ru ([83.149.199.45])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glh3A-0004hP-9Q
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 21:24:10 +0000
Received: from localhost.localdomain (unknown [85.140.183.8])
 by mail.ispras.ru (Postfix) with ESMTPSA id 3ABAE54006B;
 Tue, 22 Jan 2019 00:24:01 +0300 (MSK)
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Felipe Balbi <balbi@kernel.org>
Subject: [PATCH v2] usb: dwc3: exynos: Fix error handling of clk_prepare_enable
Date: Tue, 22 Jan 2019 00:23:50 +0300
Message-Id: <1548105830-26376-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_132408_507510_1E6955D7 
X-CRM114-Status: GOOD (  10.01  )
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
Cc: ldv-project@linuxtesting.org, linux-samsung-soc@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
 Alexey Khoroshilov <khoroshilov@ispras.ru>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

If clk_prepare_enable() fails in dwc3_exynos_probe() or in
dwc3_exynos_resume(), exynos->clks[0] is left undisabled
because of usage preincrement in while condition.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Fixes: 9f2168367a0a ("usb: dwc3: exynos: Rework clock handling and prepare for new variants")
---
v2: Add fix for the second instance in dwc3_exynos_resume() per Marek Szyprowski note.

 drivers/usb/dwc3/dwc3-exynos.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index cb7fcd7c0ad8..c1e9ea621f41 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -78,7 +78,7 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 	for (i = 0; i < exynos->num_clks; i++) {
 		ret = clk_prepare_enable(exynos->clks[i]);
 		if (ret) {
-			while (--i > 0)
+			while (i-- > 0)
 				clk_disable_unprepare(exynos->clks[i]);
 			return ret;
 		}
@@ -223,7 +223,7 @@ static int dwc3_exynos_resume(struct device *dev)
 	for (i = 0; i < exynos->num_clks; i++) {
 		ret = clk_prepare_enable(exynos->clks[i]);
 		if (ret) {
-			while (--i > 0)
+			while (i-- > 0)
 				clk_disable_unprepare(exynos->clks[i]);
 			return ret;
 		}
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
