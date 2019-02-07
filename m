Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB91C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:48:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B6CB2075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SjUuU7Ky";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="YyC8He12"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B6CB2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k7KIjJP8Evw43WsQHIWeS4FraXqaURiNVAWwoc+zb0k=; b=SjUuU7KySmxJBL
	muz6Sgrg20UT4PFVwhPuYG7vfCPFZw+mCsfXF54w5BcolkmdvYURvGuNbZXUjM0JQpBgk0JmNWVTL
	CO87uHPxrphwrOEQ49E32OXCqyB7WP3nrew1s9G1Y47E5XTGztfBJDVc6n6CtwBjoKvMqSOBwRIVy
	m64JTgAMEKEcOG2bMiPMvBgfubK7ZbYS5PSQ71J7yCtG9OGtog/ZBmCtIk+RXIBTiBfRE2hS6A1IR
	bQzr2Kz8UmnjC3kbNPPp8vXG3wlKhKX+t7GcC8RK/VTA/tGUyLL7efYv7lUULYTOBtA0srl3MI4vF
	NpJTwN/Y4C0e1Mca+tnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grgHm-0003t8-Uu; Thu, 07 Feb 2019 09:47:59 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grgGt-00031n-HR
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 09:47:06 +0000
Received: from zyt.lan (unknown [IPv6:2a02:169:34b6:0:5054:ff:fe4f:85bd])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id 304D75C2080;
 Thu,  7 Feb 2019 10:46:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1549532816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9wFJ9ATYCTctc0PTg1OV7FRoxmu9QOfiUozfNp6Jfco=;
 b=YyC8He12CM9ZDutLSSGt6M3lwoEfZIkOACzHR8YHo+j/ji3YRYFYMLJ7leVBVj5tdG04/3
 Os+ZtnAJe44KCBeBxTXx3o+0KbgQg6iZpmUUN9XBhNONGZBT7SG7RvjAyjG/S3uoCiEYnQ
 xQWB2xyluPh/O/XymOvmYdYk9HkJa4E=
From: Stefan Agner <stefan@agner.ch>
To: linux@armlinux.org.uk
Subject: [PATCH 5/5] ARM: warn if divided syntax assembler is used
Date: Thu,  7 Feb 2019 10:48:29 +0100
Message-Id: <c44f25a2d9e2f64fe41d910b09868c0f6ec3a3c9.1549532513.git.stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1549532513.git.stefan@agner.ch>
References: <cover.1549532513.git.stefan@agner.ch>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_014703_982030_3D430621 
X-CRM114-Status: GOOD (  10.00  )
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
Cc: nicolas.pitre@linaro.org, mark.rutland@arm.com, arnd@arndb.de,
 ard.biesheuvel@linaro.org, will.deacon@arm.com, julien.thierry@arm.com,
 ndesaulniers@google.com, linux-kernel@vger.kernel.org,
 Stefan Agner <stefan@agner.ch>, thierry.reding@gmail.com,
 natechancellor@gmail.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Remove the -mno-warn-deprecated assembler flag to make sure the GNU
assembler warns in case non-unified syntax is used.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index a0d08a3c9d33..811498e16673 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -112,9 +112,6 @@ ifeq ($(CONFIG_ARM_UNWIND),y)
 CFLAGS_ABI	+=-funwind-tables
 endif
 
-# Accept old syntax despite ".syntax unified"
-AFLAGS_NOWARN	:=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
-
 ifeq ($(CONFIG_THUMB2_KERNEL),y)
 AFLAGS_AUTOIT	:=$(call as-option,-Wa$(comma)-mimplicit-it=always,-Wa$(comma)-mauto-it)
 CFLAGS_ISA	:=-mthumb $(AFLAGS_AUTOIT) $(AFLAGS_NOWARN)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
