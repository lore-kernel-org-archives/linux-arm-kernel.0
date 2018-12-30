Return-Path: <SRS0=kGow=PH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C831DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:08:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97AD32084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m5IsExUM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="TWVKCXmz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97AD32084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gt04DDiuw6/o9MPqYbvorS4IqeCJkbWOnsLvrhDNF6Q=; b=m5IsExUMUcNkwZ
	hWOduyfDs7vUEkYvzXabp7L1S0q5tVLodKeFrEhcV3Rqvfp9mc5PjDrUU0pRl2H4UPNRXWZ8UsxFu
	1d+I3ashJcNk+dQUT9Kn+9hgCpxP8D+Ami6KllHuHyE6QgdJi9Qo50cJsAazseCy/w8VlUSvHCh2i
	5tcPHCFNjHeYudDoGE/xaKXG6n9GuU8z7XbKMiQvZLabjWaxUE8RRVHevyxwYx79GsowSQ6/g4rCD
	2jrtv/eVcCKr8IWOXAUphPZGBdkg/K2q0yX7+rCoQ6/o3WnCTPFklXy1o1+t2lMVuh5IA4nuVXt9I
	Doxpnn8MrtunVKOJKPqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdddl-0006oF-Tc; Sun, 30 Dec 2018 16:08:37 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdddi-0006lx-67
 for linux-arm-kernel@lists.infradead.org; Sun, 30 Dec 2018 16:08:35 +0000
Received: from zyt.lan (unknown [IPv6:2a02:169:3465::564])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id 830505C15D7;
 Sun, 30 Dec 2018 17:08:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1546186096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wHZ+5wVBKdrXHtPOlXGesXY7FAd4RXaImoF2BmZY4TI=;
 b=TWVKCXmzSWksDjBXpJP9rkRXA6Xw3SK6XmzwC6atbIXlgWRfyzVdwEJ6UbCjVcydHwwQcc
 qAWv1S3kLFR/mQxXddm8NvncjnkTA1hayDi/wnDOdrmi6sESopiOk6crQygSmuNsy4LK7v
 MLpY01M8LUYoOUMnRbgPH22ox2gM6Jg=
From: Stefan Agner <stefan@agner.ch>
To: linux@armlinux.org.uk
Subject: [PATCH 3/3] ARM: spinlock: use unified assembler language syntax
Date: Sun, 30 Dec 2018 17:08:19 +0100
Message-Id: <088ecb1e526e3ccfd58dd3f7cae8a98edd23008c.1546185298.git.stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1546185298.git.stefan@agner.ch>
References: <cover.1546185298.git.stefan@agner.ch>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181230_080834_430731_477EA792 
X-CRM114-Status: GOOD (  11.96  )
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
 ard.biesheuvel@linaro.org, peterz@infradead.org, will.deacon@arm.com,
 julien.thierry@arm.com, ndesaulniers@google.com, linux-kernel@vger.kernel.org,
 Stefan Agner <stefan@agner.ch>, mingo@redhat.com, natechancellor@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Convert the conditional infix to a postfix to make sure this inline
assembly is unified syntax.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/include/asm/spinlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
index 099c78fcf62d..563ecedf2a1f 100644
--- a/arch/arm/include/asm/spinlock.h
+++ b/arch/arm/include/asm/spinlock.h
@@ -214,7 +214,7 @@ static inline void arch_read_lock(arch_rwlock_t *rw)
 "	adds	%0, %0, #1\n"
 "	strexpl	%1, %0, [%2]\n"
 	WFE("mi")
-"	rsbpls	%0, %1, #0\n"
+"	rsbspl	%0, %1, #0\n"
 "	bmi	1b"
 	: "=&r" (tmp), "=&r" (tmp2)
 	: "r" (&rw->lock)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
