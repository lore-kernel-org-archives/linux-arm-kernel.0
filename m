Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333F1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:23:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02CC221726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZptB9GhG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="di+lNTNe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02CC221726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=YprGDb+7qZ/QmGVYFNwJ3jmaCXEYD2ag0JIl/O0PNq8=; b=Zpt
	B9GhG37wY5QPTnNkSXfKMvHa2AH32rKYqjIaKTMXXBJwuz8IN9ue1ns6vMC3jAlghCFcsH5MJrSnj
	/h91BIcU+RrDQdr8g6/xraU4CNB05p/z7IysboWq/cHdeTHGxgRrOP8mjwIVtvQgTHX+qjxTkeuWV
	feSbPV0mgX2v7Zbe+AmsUS72zPD1F8E0C3jLAWRyJOsm84fLp6GMPGvPvO/9rnDZZeiKVB6oaYT52
	EnWzfGW734MBpGLZB8P6LjZ8GCaPveXNhe5hbk7Bt4fP+ygZ5O3fpxHUsLF8ou7hDwFMRnDsSZdwb
	9V0O07sep97SuRLlSC4oQG3n366SMpw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbyqx-0002Jm-GO; Wed, 26 Dec 2018 02:23:23 +0000
Received: from mta-p6.oit.umn.edu ([134.84.196.206])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbyqr-0002IU-Bo
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 02:23:21 +0000
Received: from localhost (unknown [127.0.0.1])
 by mta-p6.oit.umn.edu (Postfix) with ESMTP id D613EC01
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 26 Dec 2018 02:23:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
 by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KhpKalrTzz8G for <linux-arm-kernel@lists.infradead.org>;
 Tue, 25 Dec 2018 20:23:04 -0600 (CST)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com
 [209.85.166.197])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mta-p6.oit.umn.edu (Postfix) with ESMTPS id AD6D7BE7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 25 Dec 2018 20:23:04 -0600 (CST)
Received: by mail-it1-f197.google.com with SMTP id 123so18550934itv.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 25 Dec 2018 18:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umn.edu; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=cu8L5CSVbazjBHbPhWjYELagrYCmPrkJmVmLcFehgX0=;
 b=di+lNTNeBipjGXK+tGQNXQ/GFr0DTNwP7tNlRS97MCm6cG+SJmaRMJYXkzx717LzlG
 W1RNE0R1Yy4HYwhv4jcn36HSK76lNe800R/J9FL5VS+/1a+FC8iGODcMUGRFGer6O/ZE
 ab0brs1g54l3lFgcTXx8N+qVeHiWs3MHlX1v+kVmL7Kzd+NEyZxEij0xQrOGgRqEBrrk
 PDBfL7MAV348B/SnfBaD6dxPo8o6QFpSBsLtDVEpm+6lbwuROUdhtDoYOYF1ZL1Hi+yI
 TMDV6li1qKEMW5PhUJz0w6oBJ7gmHqDlzobyeHL4JKW/WL5YYlNpV5iXIHzjxCmS5T/6
 5t/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=cu8L5CSVbazjBHbPhWjYELagrYCmPrkJmVmLcFehgX0=;
 b=iY7qwD3vxwvmWBU+V2k86oZFgbITtCXrJRElqZ0H1/6vc+sHd5zGvj43dmNHbqCGkI
 TcxAab8vLtUla1g7GxxtDFkj0Lfmztr2s7SZapBQUZMHJ801FMBoY2fptTRUIj2M6ND5
 85xyDSbmJwjVOwSmYcXvsTKbvy28bLEfU3WMZzqPX3l+Njh7MXSE1GX8lk+97b2E9O60
 pbKgTw/mprcUWkLC7qzvYcvMFw2VM/OK9DLmhVt1wV7GCO2c6MQZRaRrXbZ36xmLO49N
 yYy+EVvTDm0HqKlYpRtM9vDotC65DQAg6kSeWELf6VCZh2L6bi4/iIKM5ZB4gRFU8djL
 OOJQ==
X-Gm-Message-State: AJcUukfFyq7dlms+7j7rwz7eNmRopWlfqWX8VTaE65p3fObRHAGrlDCo
 x2qBa1Wu1MNrug8XNdcBGebOM3FP/KLvhuELucsSD3cCjFJJTPMUDP1MOnRXgK5lwLbDJK8nf4R
 ZjxW5cYv8IMU37eDQQjyUCOssDOWQwYxMB6FGseQ=
X-Received: by 2002:a6b:b2d2:: with SMTP id
 b201mr12526865iof.303.1545790984285; 
 Tue, 25 Dec 2018 18:23:04 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4Fd1qmDpyHH2kUifSAS2wjP7wQc3YVJ7Ux+5qwk3JxkaqBdiAev3dswZcM0W068jQf6A+LWg==
X-Received: by 2002:a6b:b2d2:: with SMTP id
 b201mr12526856iof.303.1545790984010; 
 Tue, 25 Dec 2018 18:23:04 -0800 (PST)
Received: from localhost.localdomain
 (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net.
 [173.230.104.22])
 by smtp.gmail.com with ESMTPSA id c21sm15343229iob.22.2018.12.25.18.23.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 25 Dec 2018 18:23:03 -0800 (PST)
From: Kangjie Lu <kjlu@umn.edu>
To: kjlu@umn.edu
Subject: [PATCH] pci: dwc: add a check for resetting gpio
Date: Tue, 25 Dec 2018 20:22:36 -0600
Message-Id: <20181226022236.71682-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181225_182317_507894_E310771C 
X-CRM114-Status: GOOD (  14.07  )
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
 pakki001@umn.edu, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

devm_gpio_request_one() could fail. The fix checks its status and issues
an error if it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/pci/controller/dwc/pci-exynos.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index cee5f2f590e2..e3a045e215d2 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -226,9 +226,12 @@ static void exynos_pcie_assert_reset(struct exynos_pcie *ep)
 	struct dw_pcie *pci = ep->pci;
 	struct device *dev = pci->dev;
 
-	if (ep->reset_gpio >= 0)
-		devm_gpio_request_one(dev, ep->reset_gpio,
-				GPIOF_OUT_INIT_HIGH, "RESET");
+	if (ep->reset_gpio >= 0) {
+		if (devm_gpio_request_one(dev, ep->reset_gpio,
+				GPIOF_OUT_INIT_HIGH, "RESET"))
+			dev_err(dev, "Failed requesting reset gpio %d\n",
+					ep->reset_gpio);
+	}
 }
 
 static int exynos_pcie_establish_link(struct exynos_pcie *ep)
-- 
2.17.2 (Apple Git-113)


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
