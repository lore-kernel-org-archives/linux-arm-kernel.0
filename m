Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A31FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:36:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28C91208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wut5Slv/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="SZ3XB+RQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C91208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=k4QvyensYFXkWy76+DCh2AQYWH1R2FANE4vQxE8ira8=; b=Wut5Slv/XB0/4V
	fsrbBhS5nEJODfTNDCw7qCQaD6KbCZ89D5lqhzVOVTNTmtkZjQrwQ7hCGOLjV+6hmKjMuAAb4/83c
	rFBT4+HhNVeQ8xiaVMV43NsHpXMBm2NBOC2MifP+Y0Fwcs3e+KCnxOk8b7k5z/fCwgHZtjFD5yHMh
	exmmlekbJ2TBTavCM51AdpXV11aNdwJV4ByyzYyyRdEvN3uJMarllXiqBnETF6Tym4xxk5ukx7/Dy
	E3Mpzz6noeTbexnPUM2egFeha2qXeb188+rcmAXLHWT0EZbp+dWSvqmBup7BBz4eCfC+LbEDB8opN
	6odfo11AgueK2gevwMDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf472-0000Ns-F8; Thu, 03 Jan 2019 14:36:44 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf46z-0000Mj-NM
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 14:36:43 +0000
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id 366345C0471;
 Thu,  3 Jan 2019 15:36:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1546526195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:
 content-transfer-encoding:content-transfer-encoding:in-reply-to:
 references; bh=Kt8C8T/txUtgcPdvCiXlfr+CtmaIZNTW1fwIY2FBNcM=;
 b=SZ3XB+RQw8x4qI7n6Iym7UHFqR9A8LoH42+5/nIpekvmeibMKsHgKKCxUb1OpUDFhhTdOx
 0gnR2OfOk0Z8e/b724Tj+aNqDVTNneWKgBVESorpTarGAc58FiEj/uZ9+bUGMpgwJmjqrs
 wKYjbKxsPngdsgLtjbVMPNvH2yFwXBU=
From: Stefan Agner <stefan@agner.ch>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de
Subject: [PATCH] ARM: imx: don't build ssi-fiq if not required
Date: Thu,  3 Jan 2019 15:36:31 +0100
Message-Id: <20190103143631.29284-1-stefan@agner.ch>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-Spam: Yes
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_063641_904153_F48226B4 
X-CRM114-Status: GOOD (  11.57  )
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
Cc: arnd@arndb.de, linux@armlinux.org.uk, Stefan Agner <stefan@agner.ch>,
 linux-kernel@vger.kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
 fabio.estevam@nxp.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The symbols provided by ssi-fiq are used in sound/soc/fsl/imx-pcm-fiq.c
only. Build ssi-fiq.o/ssi-fiq-ksym.o only if SND_SOC_IMX_PCM_FIQ is
enabled.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/mach-imx/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index bae179af21f6..12b05708832d 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -31,7 +31,7 @@ obj-$(CONFIG_SOC_IMX6SX) += cpuidle-imx6sx.o
 obj-$(CONFIG_SOC_IMX6UL) += cpuidle-imx6sx.o
 endif
 
-ifdef CONFIG_SND_IMX_SOC
+ifdef CONFIG_SND_SOC_IMX_PCM_FIQ
 obj-y += ssi-fiq.o
 obj-y += ssi-fiq-ksym.o
 endif
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
