Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73CDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:21:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9795B20873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M9XBxTRE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WCWW2S/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9795B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=WrHWsu0O2lw/kuyhzcVforKUqR7XAFDE94KjQwPCPJs=; b=M9XBxTREjczrW/x4BpAfM94kzJ
	OdpnB7eLfGKQ5aRm4bKPrlTyGAuvwPw096mVfxLw0ccvznG6C68LCDpMFR/XWGwJN7aTpDH/w2KR+
	zTZwzo0xNAxiAGESaDZJ+G6+k+QVO2GCeM08ToO765UgFdLgYH6a+81VnfQItww60CdqmV23QJ3N3
	NXUQFzvyNrkAqMV+fpQCIznVWs5VEL0oNkFYaHFigQfa2UwfgYB2CCO22gS3yFVs7opfBARjA0NtT
	IqfSMc01OBm1niVURTOuLQNJTfkMQF0gxnxSkRxLtRTyzodms7D/3fKZ3Vs7+EmWy1OUs9YfPnh4x
	4uxVQr8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gizNF-0008Nm-8z; Mon, 14 Jan 2019 10:21:41 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gizMs-000814-7p
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 10:21:21 +0000
Received: by mail-pg1-x542.google.com with SMTP id y4so9258215pgc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 02:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=yxCl8KASROd/ypLyaZ23DK2nTV9xmxQ5lybfWhMjKwY=;
 b=WCWW2S/ZjFTW6FLCyacIhioNMyweYfdFqfyoN5VeLCOZj4OzsxhB0aDGq6kTYdhz+r
 vEDh6r0eeJvAZB/SBBTMQ+pAC6DUX6z0iVAW17AH8bkYJR9uWn3VhilhrDlYpinr4WeJ
 T2Rf5KH/17o/UnXIu2jZT8qr2ry81Xil65ocw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=yxCl8KASROd/ypLyaZ23DK2nTV9xmxQ5lybfWhMjKwY=;
 b=X80JoAvUW91XqvdfWIDra2YrwzfuIDHQRl/EkaqVvLgZFyYPTkJWv/vMJ1LYhXfjlv
 +hNQ9ToBJoHKCrL98S3A9ze/MDa2omDAd13RvplWSc/iscGPHI6qaN8zYX4aCIj32KMC
 s4zSjg01xUJyhaCTMNppxB/JTZE8zV2TCgKRtnLc4y5Bwsln39Cdqzr2fBWrCJhwZwcG
 SUZUK3QBDAU3SLdfDV4J9IIL+xpqod5NSCRFAhha5NmNJb4Cu36lWnCgR7YQq1UvjBln
 Qz5lBvfo2HQ4jOy3yupuH6QmSZoL8yXLucvr5Sw1+/PvkrUmmtgIN3HJqKCIHUSTUvk5
 Tnjw==
X-Gm-Message-State: AJcUukdkxmmt1fNY4YYn1hrpxMxiAf599xFinsQDOFyvRqMmJNSMMRFw
 4oMPOD9m6a2hpGnWQOsq3QbQ
X-Google-Smtp-Source: ALg8bN5f45Bf4gwEl3pHiDHb9Nrd21QDIKmoyoJBHoB4eEWSkRmE1H8gtYxiCra8KuijJWmlAQyv6g==
X-Received: by 2002:a62:444b:: with SMTP id r72mr25048552pfa.184.1547461277296; 
 Mon, 14 Jan 2019 02:21:17 -0800 (PST)
Received: from localhost.localdomain
 ([2409:4072:6306:f12b:7d9b:d1a4:6536:aa21])
 by smtp.gmail.com with ESMTPSA id 15sm36429pfr.55.2019.01.14.02.21.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Jan 2019 02:21:16 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: shawnguo@kernel.org,
	leoyang.li@nxp.com,
	robh+dt@kernel.org
Subject: [PATCH v2 2/3] dt-bindings: arm: fsl: Add devicetree binding for
 Oxalis
Date: Mon, 14 Jan 2019 15:50:52 +0530
Message-Id: <20190114102053.16013-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190114102053.16013-1-manivannan.sadhasivam@linaro.org>
References: <20190114102053.16013-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_022118_547611_C60AFD63 
X-CRM114-Status: GOOD (  11.99  )
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
Cc: devicetree@vger.kernel.org, a.tropschug@ebs-systart.com,
 m.bittner@ebs-systart.com, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add devicetree binding for Oxalis board in JSON format. While adding
that, let's fix the description for LS1012A also.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index d34fe0749199..0f30142fe316 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -173,12 +173,13 @@ properties:
               - fsl,vf610
               - fsl,vf610m4
 
-      - description: LS1021A based Boards
+      - description: LS1012A based Boards
         items:
           - enum:
               - fsl,ls1012a-rdb
               - fsl,ls1012a-frdm
               - fsl,ls1012a-qds
+              - ebs-systart,oxalis
           - const: fsl,ls1021a
 
       - description: LS1043A based Boards
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
