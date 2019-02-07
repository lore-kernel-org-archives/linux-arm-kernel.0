Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A399C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:47:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28D022075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qCRcMYIm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="a800tihM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D022075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vGNKoAI3vtiBCGmb1Y/QGIHoyr2Av7PvmHMnblK9fuY=; b=qCRcMYImHs8sXi
	/qlxRPOdaYorjhdn/EGWG52xYHuXmmVl0osfDiR0ZsPwZHgDxDlQcXpbRrrpq8ilC36tY7kfvqlpT
	yHlTjg2VNOWQIeHXBViCNGV9U115X7IhTa2pO61BoWiRpYsft+EoGMM3wHSj6lOsH+d9HHBnxZu6c
	rXR1AQlnh/m3OO1uG/MjTEfKIZYPOrEKZPrkk0qdX51X72RMIzxFlYoSNRGPy5ed3KoEwPGX2y5Ql
	nWVlE/e6J7AwPxj6qcYq4qEzDTOuaK68Y40Vv8XDS9vzk/7KGFLg2PuxMkF6hfjIqNYCN/Ujik5dx
	VPCfUJF1UvbtKF2d14Fg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grgGt-00031o-OS; Thu, 07 Feb 2019 09:47:03 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grgGq-000301-E4
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 09:47:02 +0000
Received: from zyt.lan (unknown [IPv6:2a02:169:34b6:0:5054:ff:fe4f:85bd])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id 19F065C2075;
 Thu,  7 Feb 2019 10:46:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1549532816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q9JIjm2XShART9bRtAJa3PQf/5iayYwLOgmQZvNMPZ8=;
 b=a800tihMN7/H5PzVHaI5hn2PY5vShg2fdM6OQWBc7+/YK2zx7fj8Yr6yA4Cd4xYQIOWhuG
 IhF4PKc+Gl2B5c1JCae6XttVbdE2KHxureXgj46X8CLiiZKfN2FFx29le3+wZ34OM43Vvn
 pwharhwHIrFLFlgAsIvky+xdjDWBe8E=
From: Stefan Agner <stefan@agner.ch>
To: linux@armlinux.org.uk
Subject: [PATCH 4/5] ARM: use unified assembler in c files
Date: Thu,  7 Feb 2019 10:48:28 +0100
Message-Id: <fed4850fb5d8a8ca874affa05d8d116d53e25b88.1549532513.git.stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1549532513.git.stefan@agner.ch>
References: <cover.1549532513.git.stefan@agner.ch>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_014700_631712_EE4CE6BD 
X-CRM114-Status: GOOD (  12.05  )
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

Use unified assembler syntax (UAL) in inline assembler. Divided
syntax is considered depricated. This will also allow to build
the kernel using LLVM's integrated assembler.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/mm/copypage-v4mc.c | 2 +-
 arch/arm/mm/copypage-v4wb.c | 2 +-
 arch/arm/mm/copypage-v4wt.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/copypage-v4mc.c b/arch/arm/mm/copypage-v4mc.c
index b03202cddddb..b19c7ad1a6de 100644
--- a/arch/arm/mm/copypage-v4mc.c
+++ b/arch/arm/mm/copypage-v4mc.c
@@ -56,7 +56,7 @@ static void mc_copy_user_page(void *from, void *to)
 	ldmia	%0!, {r2, r3, ip, lr}		@ 4\n\
 	subs	%2, %2, #1			@ 1\n\
 	stmia	%1!, {r2, r3, ip, lr}		@ 4\n\
-	ldmneia	%0!, {r2, r3, ip, lr}		@ 4\n\
+	ldmiane	%0!, {r2, r3, ip, lr}		@ 4\n\
 	bne	1b				@ "
 	: "+&r" (from), "+&r" (to), "=&r" (tmp)
 	: "2" (PAGE_SIZE / 64)
diff --git a/arch/arm/mm/copypage-v4wb.c b/arch/arm/mm/copypage-v4wb.c
index cd3e165afeed..6e3c9b69dd25 100644
--- a/arch/arm/mm/copypage-v4wb.c
+++ b/arch/arm/mm/copypage-v4wb.c
@@ -38,7 +38,7 @@ static void v4wb_copy_user_page(void *kto, const void *kfrom)
 	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
 	subs	%2, %2, #1			@ 1\n\
 	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
-	ldmneia	%1!, {r3, r4, ip, lr}		@ 4\n\
+	ldmiane	%1!, {r3, r4, ip, lr}		@ 4\n\
 	bne	1b				@ 1\n\
 	mcr	p15, 0, %1, c7, c10, 4		@ 1   drain WB"
 	: "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
diff --git a/arch/arm/mm/copypage-v4wt.c b/arch/arm/mm/copypage-v4wt.c
index 8614572e1296..4a40fa1cbc2a 100644
--- a/arch/arm/mm/copypage-v4wt.c
+++ b/arch/arm/mm/copypage-v4wt.c
@@ -34,7 +34,7 @@ static void v4wt_copy_user_page(void *kto, const void *kfrom)
 	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
 	subs	%2, %2, #1			@ 1\n\
 	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
-	ldmneia	%1!, {r3, r4, ip, lr}		@ 4\n\
+	ldmiane	%1!, {r3, r4, ip, lr}		@ 4\n\
 	bne	1b				@ 1\n\
 	mcr	p15, 0, %2, c7, c7, 0		@ flush ID cache"
 	: "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
