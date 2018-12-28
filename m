Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F339C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 20:12:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC69F20866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 20:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gmg+v8QW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="iqmqnztT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC69F20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=oWkTMUSBd6kTgjcETgvGrRC3h1HDvoDFj3VvBXI9NK0=; b=Gmg
	+v8QWE7ocff0cO+u0sjQ1ndUCoq/xPyCUNP3MkAxqoVDOSulE3GCnhikWZg4+iTX9pfd9lEcCw7JN
	ky9hhaNbctJah+u1eLYvW+8h7mYD6l/t6yvBNYlxVjlTZbHVRoZNzgCSl1PbD044If5ew+k1BCrey
	w4QnQczDk3mefymFZjSrSa00faVOiIAaADIoHusDsA4KL97yVE2RhVpaFakZfA+mIFkiM58f4WXxC
	wnyaeD7bPnDF5+yS1xBQ5slctFUaKRdyFXAqEpECHlaJSucf8pGNUtZCA7heCTfhdkI8uCVlMtu4f
	UfZV+gXOi8H2GUjz3pFjN1fKvxcA3oQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcyUG-0004oI-2K; Fri, 28 Dec 2018 20:12:04 +0000
Received: from mta-p8.oit.umn.edu ([134.84.196.208])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcyUC-0004na-P5
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 20:12:02 +0000
Received: from localhost (unknown [127.0.0.1])
 by mta-p8.oit.umn.edu (Postfix) with ESMTP id 105C7DBF
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 20:11:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
 by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y_dONBUAKIhj for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 14:11:46 -0600 (CST)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mta-p8.oit.umn.edu (Postfix) with ESMTPS id E24AADB2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 14:11:46 -0600 (CST)
Received: by mail-io1-f71.google.com with SMTP id d20so19723061iom.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 12:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umn.edu; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=0HvSt97ykFbzJ0i95x3si2xjQYna4NpLDsUQ/E+zItI=;
 b=iqmqnztTf3g4S59H+jFzyAhookaX/BUcP8xblR0LEzo6d+Kigk5c9oM191wsq8rupo
 Ylfw6d692WmD6SCXmqZcic1vq+AcgK+6GF0W0bJ9l7kJee2BJU9Kyz5RM3m0pcmDYZLO
 nVtbZHo9rqBPB9QNBTQxzvC7xE/tgNQJNjpz5+h8BI32+w1pDkrOkbEszWDmus6mU92f
 bXYOIBH5LIVAwZpTWhThEpuTd1o9mobxfwDLwhhjdM/MipuROlOy7F0yLfcydqhKRNks
 ETDZ3XQ5CLJSz/ijoPLSNzzvl/LvBIGOpHQSqTuexZT0Z4YcHF9m4ozjb7odjZd03gEj
 U9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=0HvSt97ykFbzJ0i95x3si2xjQYna4NpLDsUQ/E+zItI=;
 b=DxE0mQ5Iy4TRMgcw0epZoEwWYAUPzcWmxfIpVFOPOq6SI++ulzEE5fDt1tbpynq4pT
 3EJs8Nk8BV7uPSsonb2WWY8iozKW48kpU3gesJ6Nk1KdGQOXuI+dcSKXkKkzrG138sW9
 mxjiXvawZEoER1XFycW1FIn0Xk+0XFmzPy4uJzJrgBwTa9CcEVNw0Xm0tvGpXWC0SLhd
 tMjzn0wQqbsh3HAvUIjnux7P7bUVK8t18R4CyYskXT55xhijFuwAog1x2kRHGRbLLM/V
 Qvy84Yn4XFIGMyfQQaSzrZ9iU8goWu1IkTv72FHERkKw3nBJpaxaL3+i4bQPiuep18Uu
 jzkQ==
X-Gm-Message-State: AA+aEWZnzJc+mTZK6H5kFs5Q8z526EhnGfFP/SLzxZj5Is4+IVroDXiO
 QuEUuNTb/pG3/jFtstWj59pQY77wX8PxeQyx/w6K7oNYfCtVVOoR8kzClCS8cAHFvmjMg+9mksV
 S7Qr2ysTFcx4+DH5W/NMn6xdO5BjrhbZa00migc8=
X-Received: by 2002:a02:5f49:: with SMTP id r70mr19011007jab.128.1546027906411; 
 Fri, 28 Dec 2018 12:11:46 -0800 (PST)
X-Google-Smtp-Source: AFSGD/Vn/7aJ/pf1MpYrMM3KbH2UMHwByETt89ky+gFhjfvXoNCXDGesy/q1qKNvt5QIr9LAnCDt/Q==
X-Received: by 2002:a02:5f49:: with SMTP id r70mr19010994jab.128.1546027906160; 
 Fri, 28 Dec 2018 12:11:46 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu.
 [134.84.121.78])
 by smtp.gmail.com with ESMTPSA id q14sm14904982itb.36.2018.12.28.12.11.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Dec 2018 12:11:45 -0800 (PST)
From: Aditya Pakki <pakki001@umn.edu>
To: pakki001@umn.edu
Subject: [PATCH] dmaengine: qcom_hidma: Check for driver register failure
Date: Fri, 28 Dec 2018 14:11:19 -0600
Message-Id: <20181228201119.11920-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_121200_904369_76D185FA 
X-CRM114-Status: GOOD (  13.55  )
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
Cc: dmaengine@vger.kernel.org, kjlu@umn.edu, Sinan Kaya <okaya@kernel.org>,
 linux-kernel@vger.kernel.org, David Brown <david.brown@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
 Andy Gross <andy.gross@linaro.org>, Dan Williams <dan.j.williams@intel.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

While initializing the driver, the function platform_driver_register can
fail and return an error. Consistent with other invocations, this patch
returns the error upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/dma/qcom/hidma_mgmt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
index d64edeb6771a..681de12f4c67 100644
--- a/drivers/dma/qcom/hidma_mgmt.c
+++ b/drivers/dma/qcom/hidma_mgmt.c
@@ -423,9 +423,8 @@ static int __init hidma_mgmt_init(void)
 		hidma_mgmt_of_populate_channels(child);
 	}
 #endif
-	platform_driver_register(&hidma_mgmt_driver);
+	return platform_driver_register(&hidma_mgmt_driver);
 
-	return 0;
 }
 module_init(hidma_mgmt_init);
 MODULE_LICENSE("GPL v2");
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
