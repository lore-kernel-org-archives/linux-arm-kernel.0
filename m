Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F824C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:03:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C7E6222C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OH+xOsRL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="gT6iLXdo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7E6222C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WTCC3EPHcC6Dxk7oBrIeJKLs4ua/3gzqD08omUjU2VE=; b=OH+xOsRL57XvSy
	mSIQeptQoTNjQ2HUAgd0+P6N+Pe1RQlRiqsUY7NmiamRaV4VB3ZX5u+tcr2t4+G0KQoIFTPAqIJaY
	kRmnPp2Q/wMmWAPtUpbAdFLgUGTPoqukl0CJs3S9ZkxJul9OuHinRvTkX4vw2cAY4TFauyW5HtpXs
	thwXRnyRt0DaYEo9nIAtLII6bcD+J7JDiiuoS5G9CVdax2E1t4cGdECLRRoQ8R2kDtzCt4L7zu8lK
	Qby4WGX4A3JKqJIfNp8ehzKjjGaKEAA0dL5ZGJQYtOYwx5wRonQAR21vjFYLIRv5AeB3ohzIjekKt
	eloncgp/teOsuDElJ0pg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gteHF-0006yc-8K; Tue, 12 Feb 2019 20:03:33 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gteFs-0005jn-1U
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 20:02:14 +0000
Received: from zyt.lan (unknown [IPv6:2a02:169:34b6::564])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id 197985C0E6D;
 Tue, 12 Feb 2019 21:01:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1550001718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0PDJlT11jb85GGKJHyPtJki8m65dii11XEoaId/97eQ=;
 b=gT6iLXdo1z0oce1QJuhyBajiKHaYASrK4Y/BW8qNzmd0JlFNh/1TCkVFkXHMMgIRGea2yd
 UvqnvtvjOW23hxHmkmow97YRQNpN3sHWwZWgc/kwwNsVAzrLY3Rrux2Ay5l2QRL+8CvCQu
 2ozbN4Tdc1WhmmeTty6gA/Q9mLic0nE=
From: Stefan Agner <stefan@agner.ch>
To: linux@armlinux.org.uk
Subject: [PATCH v3 5/5] ARM: warn if divided syntax assembler is used
Date: Tue, 12 Feb 2019 21:02:01 +0100
Message-Id: <447621a6c829e37d30f589653fe4a0ade36ac52a.1550001435.git.stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1550001435.git.stefan@agner.ch>
References: <cover.1550001435.git.stefan@agner.ch>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_120208_299697_6ADA63A0 
X-CRM114-Status: GOOD (  11.41  )
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
 Nicolas Pitre <nico@linaro.org>, natechancellor@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Remove the -mno-warn-deprecated assembler flag to make sure the GNU
assembler warns in case non-unified syntax is used.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Acked-by: Nicolas Pitre <nico@linaro.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes in v2:
- Remove AFLAGS_NOWARN from CFLAGS_ISA

 arch/arm/Makefile | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index a0d08a3c9d33..9561325c5201 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -112,19 +112,16 @@ ifeq ($(CONFIG_ARM_UNWIND),y)
 CFLAGS_ABI	+=-funwind-tables
 endif
 
-# Accept old syntax despite ".syntax unified"
-AFLAGS_NOWARN	:=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
-
 ifeq ($(CONFIG_THUMB2_KERNEL),y)
 AFLAGS_AUTOIT	:=$(call as-option,-Wa$(comma)-mimplicit-it=always,-Wa$(comma)-mauto-it)
-CFLAGS_ISA	:=-mthumb $(AFLAGS_AUTOIT) $(AFLAGS_NOWARN)
+CFLAGS_ISA	:=-mthumb $(AFLAGS_AUTOIT)
 AFLAGS_ISA	:=$(CFLAGS_ISA) -Wa$(comma)-mthumb
 # Work around buggy relocation from gas if requested:
 ifeq ($(CONFIG_THUMB2_AVOID_R_ARM_THM_JUMP11),y)
 KBUILD_CFLAGS_MODULE	+=-fno-optimize-sibling-calls
 endif
 else
-CFLAGS_ISA	:=$(call cc-option,-marm,) $(AFLAGS_NOWARN)
+CFLAGS_ISA	:=$(call cc-option,-marm,)
 AFLAGS_ISA	:=$(CFLAGS_ISA)
 endif
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
