Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BE4C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 11:12:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 594982082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 11:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fDkXaNdx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594982082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=kLbmPPH2w28rLT6zkrEFdUH5RbvHKWzfSBWc5ODg6Tg=; b=fDkXaNdxlQhzPI
	Vt8lP9TjKNXW6B7zPdBWH2ChCc0O8nnEzKhVy4mdw/OYSyRKVX3LFj748oR/l6wKmUB9HXTxPdSKg
	sujNfkXDjGLYNytQKrZfL/5KAd3Omct2jK//E3JnXpKH7PfIZd5vAS2W/7pdgQSQ8iUHhRn3/wP3X
	BXh2EbbXsVdz1COXXCkUv01Nw03Ucp5xMZUfCxdj0R48BL1LiVTDRq/UCNDv0opRhNs2D3f1aUZIq
	APXl5k9oGV45JiB8YLZy5axleGlkheZR1hpnM+X1KjEpYbUPVimCgeX7wXtQpHbVcv9ALSU6lt+uK
	QecuDgJTWptchAIBB/TA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTPgD-0003cK-5k; Sun, 02 Dec 2018 11:12:53 +0000
Received: from shell.v3.sk ([90.176.6.54])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTPg8-0003ba-Pi
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 11:12:50 +0000
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id F2853C7E34;
 Sun,  2 Dec 2018 12:12:30 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 2K7_tONg8Rcx; Sun,  2 Dec 2018 12:12:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id 429D7C7E35;
 Sun,  2 Dec 2018 12:12:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id mCZKP6n99bWm; Sun,  2 Dec 2018 12:12:27 +0100 (CET)
Received: from odvarok.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
 by zimbra.v3.sk (Postfix) with ESMTPSA id 5D627C7E34;
 Sun,  2 Dec 2018 12:12:27 +0100 (CET)
From: Lubomir Rintel <lkundrak@v3.sk>
To: arm-soc <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Olof Johansson <olof@lixom.net>
Subject: [PATCH] ARM: mmp/mmp2: fix cpu_is_mmp2() on mmp2-dt
Date: Sun,  2 Dec 2018 12:12:24 +0100
Message-Id: <20181202111224.1450-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_031248_997306_239A9400 
X-CRM114-Status: GOOD (  10.65  )
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
Cc: Eric Miao <eric.y.miao@gmail.com>, James Cameron <quozl@laptop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Lubomir Rintel <lkundrak@v3.sk>,
 Pavel Machek <pavel@ucw.cz>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

cpu_is_mmp2() was equivalent to cpu_is_pj4(), wouldn't be correct for
multiplatform kernels. Fix it by also considering mmp_chip_id, as is
done for cpu_is_pxa168() and cpu_is_pxa910() above.

Moreover, it is only available with CONFIG_CPU_MMP2 and thus doesn't work
on DT-based MMP2 machines. Enable it on CONFIG_MACH_MMP2_DT too.

Note: CONFIG_CPU_MMP2 is only used for machines that use board files
instead of DT. It should perhaps be renamed. I'm not doing it now, because
I don't have a better idea.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/mach-mmp/cputype.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mmp/cputype.h b/arch/arm/mach-mmp/cputype.h
index 446edaeb78a7..a96abcf521b4 100644
--- a/arch/arm/mach-mmp/cputype.h
+++ b/arch/arm/mach-mmp/cputype.h
@@ -44,10 +44,12 @@ static inline int cpu_is_pxa910(void)
 #define cpu_is_pxa910()	(0)
 #endif
 
-#ifdef CONFIG_CPU_MMP2
+#if defined(CONFIG_CPU_MMP2) || defined(CONFIG_MACH_MMP2_DT)
 static inline int cpu_is_mmp2(void)
 {
-	return (((read_cpuid_id() >> 8) & 0xff) == 0x58);
+	return (((read_cpuid_id() >> 8) & 0xff) == 0x58) &&
+		(((mmp_chip_id & 0xfff) == 0x410) ||
+		 ((mmp_chip_id & 0xfff) == 0x610));
 }
 #else
 #define cpu_is_mmp2()	(0)
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
