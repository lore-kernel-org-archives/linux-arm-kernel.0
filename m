Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3BBC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:06:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DED5520849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ORZwqzQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED5520849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=xDTqkEJ6CIin15+C7o3ixkuMYtACVU6Z4F8gv+DGXCw=; b=ORZwqzQX7sHJ96yirZRMQxj+uG
	N78pZ3AQLs8+0WXm3A3fjOd/XqQzMSpJe1O3fJdXPaZcaGDYbR8GiOKWwmBJow85670OnUWgZIZRN
	ZcrJuNMeIAoEI7Hi2fRJbs5MssonH2SXezxe0i7FhIeb9vbgywhenVgDw6Zixc/+OVYd0zK+1+97R
	wGl3si+mqAOsveEUuV5u0W6AaoOFZiki41fVv5y4y0/V9o0pwmJ7OHZX/9EOgfihFHNjm1homzC4Q
	Af+XAJuKymV/P3C3w5bfH1I9BLkn5HOXTTq/KbxuizaF0pLb/73hEnyj65cjZCCxvmCXnkOQaFqBe
	9Jl4mqCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWd3e-00045N-8a; Tue, 11 Dec 2018 08:06:22 +0000
Received: from mail-out.m-online.net ([212.18.0.9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWd35-0003NH-Iu; Tue, 11 Dec 2018 08:05:53 +0000
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 43DXYc1FDXz1r2cC;
 Tue, 11 Dec 2018 09:05:24 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
 by mail.m-online.net (Postfix) with ESMTP id 43DXYc0Ghqz1qrnJ;
 Tue, 11 Dec 2018 09:05:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
 with ESMTP id 7tYr4Ma-_Qow; Tue, 11 Dec 2018 09:05:22 +0100 (CET)
X-Auth-Info: vEhu7Uh0aFLABhva+u7giMJXYyMx2ajaAFfp049DCYg=
Received: from xpert.denx.de (unknown [62.91.23.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Tue, 11 Dec 2018 09:05:22 +0100 (CET)
From: Parthiban Nallathambi <pn@denx.de>
To: manivannan.sadhasivam@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
 mark.rutland@arm.com, wsa@the-dreams.de
Subject: [PATCH v3 3/4] i2c: Add Actions Semiconductor Owl family S700 I2C
 support
Date: Tue, 11 Dec 2018 09:04:47 +0100
Message-Id: <20181211080448.24007-4-pn@denx.de>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181211080448.24007-1-pn@denx.de>
References: <20181211080448.24007-1-pn@denx.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_000548_537388_56BA7646 
X-CRM114-Status: GOOD (  10.32  )
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
Cc: devicetree@vger.kernel.org, linux@cubietech.com,
 linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
 thomas.liau@actions-semi.com, linux-i2c@vger.kernel.org,
 Parthiban Nallathambi <pn@denx.de>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add S700 to the list of devices supported by Owl I2C driver.

Add Actions Semiconductor Owl family S700 I2C driver.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/i2c/busses/i2c-owl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-owl.c b/drivers/i2c/busses/i2c-owl.c
index 96b4572e6d9c..b6b5a495118b 100644
--- a/drivers/i2c/busses/i2c-owl.c
+++ b/drivers/i2c/busses/i2c-owl.c
@@ -475,6 +475,7 @@ static int owl_i2c_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id owl_i2c_of_match[] = {
+	{ .compatible = "actions,s700-i2c" },
 	{ .compatible = "actions,s900-i2c" },
 	{ /* sentinel */ }
 };
-- 
2.17.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
