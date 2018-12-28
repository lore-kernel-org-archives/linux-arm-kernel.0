Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9CFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:27:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A9BA20869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bLXMjUPj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="cpqEPuMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9BA20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=bCT2L2vnTFm9fZBsOtW0JNVEt2dHcMq0ZS5K7mIoPyA=; b=bLX
	MjUPjy0D3i2hTq71LY/6QzKVPqSuov9V1xM2mMrB6al3/apV+dMkwfXHRxtQ1TWdKO2+PJnmtTOOp
	WffQh/cmA+gwpEchWo9bhopPExhZFBE6waDFvW2L2JLtrclWAcEf9oKt+A55s4t5B/MGd6ixgjLfu
	Uwe5yDr7dZBHZlArGd3ugsKDwVxJs27afR/B2k1T4W0f1MFEkqnnkk2JCbxeLlJJ/f5+XR/OuGzQO
	Wfi4wKivZJ63+GLtQ4xFOsh2AF0PNwnW+4/2fDir+AxTPCWeAlbv17NE5TQ6eltvk9nOr+DrJ1keH
	NB3nMHGKA8Jnh6pQXuUu3rrKbCbjOaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcxmu-0004rr-Dw; Fri, 28 Dec 2018 19:27:16 +0000
Received: from mta-p7.oit.umn.edu ([134.84.196.207])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcxmp-0004qW-Th
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 19:27:13 +0000
Received: from localhost (unknown [127.0.0.1])
 by mta-p7.oit.umn.edu (Postfix) with ESMTP id 6F424CDA
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 19:26:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
 by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 30z1Cs5lZANH for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 13:26:56 -0600 (CST)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 3EDF6CD2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 13:26:56 -0600 (CST)
Received: by mail-io1-f71.google.com with SMTP id f24so25900266ioh.21
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 11:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umn.edu; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=VldzEkSUwU4quRySA+++63MArOsxjr3CwLUopnEh27M=;
 b=cpqEPuMAl6CJjvPu2HuEkO9Sy8JW7fgHSzGkrpRQXShAhhO5F4saDjRvdHaT4vSUFA
 RsB9TAbB/JO3z6tFTe8EByLMc5ywmWInpA0y0jdp7RMNu1ZClYIeob0NQI+KuIzrhVmj
 NPW/cjf+Qzv4VDQsZdYFR4q/nXgX+D0Zs+zsTkoWdSTOk/UP6popli8UgGWPw32VbhmV
 96EeN8pYvE0dTwR4te0PmBm8DvMtsVsCvWQvTz7R36y3XuRG2uTST+rzLQKZAlIsF3ww
 TPZOpV0bznJq0+A7aZC3dYfewhmXXcnDvzxgmMgKzWu0kCk0BpMRWJlstTf4ZRzzfGiN
 63gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=VldzEkSUwU4quRySA+++63MArOsxjr3CwLUopnEh27M=;
 b=q9jseO+JNEPdQKXsJHHNXnuZV64lopN9wH2Ky39v/hLskV4/lp3E/rhj+zghkOZphv
 TdE4iK/zmxzuUeOIUrU6PKQ4kNck4O7DeaLxB3gDin/2jKT7s8/VizF1/CXanA1QRlhL
 SM0mCwwuc+ZUyG6RxWJGsv6tmnpLRLRcUAdJMIoAFy2pOIMnHgaFAKchOTIkOIRIjvJB
 NAGzFVp8pXmRI0ohR4TJM/9Zh+64yYsTahMnvy+SRydctw6fADB+99XhIkavcpvcAhEc
 Nc7RaPJa6NW2sPNd7qzM2Hky+oKKTt9EgjBRfP2baFbFncQnFrswi/O870UszwbcSu8i
 q0jg==
X-Gm-Message-State: AJcUukf5aO+2jwEGmUkK+MCZzlq7qSqOkmHp+eFHgCTZ/LO+/YjaBK38
 xcDjzQi39NpMunYD4P7f3/znfZDqQfHmNX4QukXiD5n1M70T3Ts02GBr8+JmRU7kn62xCz+4HsE
 otY+qk/hIsuc9G2QP5wUb4P4YPPynHK9JHE4sboI=
X-Received: by 2002:a5d:84c1:: with SMTP id z1mr18737947ior.277.1546025215856; 
 Fri, 28 Dec 2018 11:26:55 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4TuBzvxsakZv63tseX+zsnpda+aJweOk90qpQSAjwyv9hnzhA3FbCpOZCwOdvCUbgP8lX/Pg==
X-Received: by 2002:a5d:84c1:: with SMTP id z1mr18737939ior.277.1546025215632; 
 Fri, 28 Dec 2018 11:26:55 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu.
 [134.84.121.78])
 by smtp.gmail.com with ESMTPSA id m18sm1020267ion.78.2018.12.28.11.26.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Dec 2018 11:26:55 -0800 (PST)
From: Aditya Pakki <pakki001@umn.edu>
To: pakki001@umn.edu
Subject: [PATCH] dmaengine: stm32-mdma: Add a check on read_u32_array
Date: Fri, 28 Dec 2018 13:26:41 -0600
Message-Id: <20181228192641.9713-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_112712_049771_910DF740 
X-CRM114-Status: GOOD (  12.62  )
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
Cc: Alexandre Torgue <alexandre.torgue@st.com>, kjlu@umn.edu,
 linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, dmaengine@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In stm32_mdma_probe, after reading the property "st,ahb-addr-masks", the
second call is not checked for failure. This time of check to time of use
case of "count" error is sent upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/dma/stm32-mdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index 390e4cae0e1a..485dea177704 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1579,9 +1579,11 @@ static int stm32_mdma_probe(struct platform_device *pdev)
 
 	dmadev->nr_channels = nr_channels;
 	dmadev->nr_requests = nr_requests;
-	device_property_read_u32_array(&pdev->dev, "st,ahb-addr-masks",
+	ret = device_property_read_u32_array(&pdev->dev, "st,ahb-addr-masks",
 				       dmadev->ahb_addr_masks,
 				       count);
+	if (ret)
+		return ret;
 	dmadev->nr_ahb_addr_masks = count;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
