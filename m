Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A30C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 19:55:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 511A0214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 19:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NV9urXFW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="YqRhkZj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 511A0214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=rOfFoWr9RpL7o0B6MjpyQb/2Uthm0Oyy//x5AhXxbIE=; b=NV9
	urXFWjKMsYrglMc1b6/B7kxmqimuOcg8k6CUClPr/oUxgCqt3xNy5QBBmHMrdY7LNSrDsPQC36bAW
	xAauciwZ+tmeIc/yZMbpeL9zGPbhMu1lsEfvzitb+TKakqVybr4meJ8CEqJ9ScsQ04r9U8YqVe83s
	NuMSIf7VLXoDdOU8ikHsGnJJqLmJn5zokYdKSBb1eR9jUQ43RjzS1kzxb12UTz5xbzPPYSBJGMGuO
	YxgeqjUnOrCa9UrqORXZ3gb9sC5OUOcwHnHgkUk65ghbPJIiW05saP/skKiwWMc02Np3qVrh+01XM
	5P2GVgKfY1Iv/4PMt4EFyq9IXg4tp+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcbkV-00055F-NA; Thu, 27 Dec 2018 19:55:19 +0000
Received: from mta-p7.oit.umn.edu ([134.84.196.207])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcbkS-0003PU-L0
 for linux-arm-kernel@lists.infradead.org; Thu, 27 Dec 2018 19:55:18 +0000
Received: from localhost (unknown [127.0.0.1])
 by mta-p7.oit.umn.edu (Postfix) with ESMTP id 75A11CCD
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 27 Dec 2018 19:55:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
 by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H3QTkvJUUPDR for <linux-arm-kernel@lists.infradead.org>;
 Thu, 27 Dec 2018 13:55:03 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4EEFC254
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 27 Dec 2018 13:55:03 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id t4so3199146iog.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 27 Dec 2018 11:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umn.edu; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=Hu1jqh/oLjWGatdKi5LxSCSeLVZPpR4Y3Ivsb+hWC3U=;
 b=YqRhkZj1F8AP93nQIT6mtvISNfqK8COn7pwOcfi7KqxZbdqIqVRgZmgx1MEmfjvWmA
 WoUVirnxQSUk42Fd0s/4noJolIKBIhGCOfEJTWkAnyLNwxA4Cz1ViNCmYgisrlPPewfk
 zAgfS9s+8wODjb2EiBgK9P1t2MeT/GHMtEJHlGHhoT99exP+BJQl51iw+MCYXBZa8POY
 pJwYfqZIITkiY3EQ3I6mIplgpKObYm8Zqo49KzW7oSPDoG28n4cBt7dbj4ulSw03cucG
 dP2NWOZnfk09yYcP6pAa2IboKllSZlIrxxcZKHUUgzFZJlrmxC/bdt4hgEUpHPxh+oNV
 /JKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Hu1jqh/oLjWGatdKi5LxSCSeLVZPpR4Y3Ivsb+hWC3U=;
 b=tUjFp3T/otzmzFVVu0WFQIZz2kDPTHcwM7dvtnPOhcXMSQOJ0iWlJn6Wkwo4rYMvGX
 WrYvU1ECN108ifPFiRmu0/ctWPNQKmVTExCxgZpvqaDKfOu2K2Igq87XwALFzAmBCJ07
 ee95Ufvu0nOhT0LQC2eBCetgqpL0pAqyuIVPFUmU6qBIz4es1TCl91pjYNQKWe45hTN3
 8DeDGujUPt5hpqTDW9wZl084rW4WPWG292PA8aj9bTwXV5wSx+3N8mHnKS6AcY9Api/o
 NIvgBkj5lC7UKellZxRzJ4XyJjqnSz2zcWeyD/GMYjTzQuBl6BD1LTfVVwb0lMrcHo2/
 xSAw==
X-Gm-Message-State: AJcUukfmA7F3MAdoxIIdaDStmE2LlXalfN/Fw9SHfEMNwe5CIvlJi59r
 6rhyMxnyFcMh92BpZ5yB6DwN2oKMUJ+/N2JU2VCcvxW2YjVuzlZrikwMWzrpQE1RQykUNVj2D1C
 4/g+WdB01nlQGL5mN5SIEZLewacScSmxLJgrRm/k=
X-Received: by 2002:a5d:934a:: with SMTP id i10mr16607193ioo.162.1545940502655; 
 Thu, 27 Dec 2018 11:55:02 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4/Fs7FcOOR/IB5wY4/JpfTvK7IM0aan8n8kWN1UC5NgHKhfiIwHkmxVp6ucjZWR79qMZTU5A==
X-Received: by 2002:a5d:934a:: with SMTP id i10mr16607177ioo.162.1545940502407; 
 Thu, 27 Dec 2018 11:55:02 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu.
 [134.84.121.78])
 by smtp.gmail.com with ESMTPSA id 137sm15667190itm.21.2018.12.27.11.55.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Dec 2018 11:55:01 -0800 (PST)
From: Aditya Pakki <pakki001@umn.edu>
To: pakki001@umn.edu
Subject: [PATCH] iio: adc: xilinx: check return value of xadc_write_adc_reg
Date: Thu, 27 Dec 2018 13:54:52 -0600
Message-Id: <20181227195454.26344-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_115516_778198_EA4062F2 
X-CRM114-Status: GOOD (  14.48  )
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
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 kjlu@umn.edu, Michal Simek <michal.simek@xilinx.com>,
 linux-kernel@vger.kernel.org, Manish Narani <manish.narani@xilinx.com>,
 linux-arm-kernel@lists.infradead.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In function xadc_probe, xadc_write_adc_reg can return an error value
when write fails. The fix checks for the return value consistent with
other invocations of the latter function.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/iio/adc/xilinx-xadc-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 3f6be5ac049a..b13c61539d46 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1273,8 +1273,10 @@ static int xadc_probe(struct platform_device *pdev)
 			xadc->threshold[i] = 0xffff;
 		else
 			xadc->threshold[i] = 0;
-		xadc_write_adc_reg(xadc, XADC_REG_THRESHOLD(i),
+		ret = xadc_write_adc_reg(xadc, XADC_REG_THRESHOLD(i),
 			xadc->threshold[i]);
+		if (ret)
+			goto err_free_irq;
 	}
 
 	/* Go to non-buffered mode */
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
