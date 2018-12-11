Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AAAC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:08:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB6472081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uf73BoSk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6472081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=92UZmTkejHAJ1abKwvNi5zckCebBY+9gTMeaDof4bWg=; b=Uf73BoSk8DYPvE
	YMm9DdtRxkIkgw3kMio0EsBEPvytsmWF/lGS+otgjqDsHHlGb3xt9uLjucjIeMDrS6i23CHPFHCWO
	I7nmTGqikGRyFUbyKZLaigjK7npbS0uXj/JYSbB/wdXKkc179bT7p5FdnB95FZHohHkhozSRSGx4Z
	OIwvJ1fHofnN0EdAI3jvmz8Dz++CiBNIwn2/WQgpXJDUwH2FFqs0fctg+l+E8eesmlsJfeDB5x9PR
	UaF6uaUCnKHbFpERuqX0989CjAMqOS00J+FFT+YiGDkzENCmjdpkQuyArpbkztfc5Yd/j5WMHb8jr
	ky1TxG/js0KxQ8+uA/HQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWiiQ-0003RY-Si; Tue, 11 Dec 2018 14:08:50 +0000
Received: from mout.kundenserver.de ([212.227.17.24])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWiiM-0003Qt-W3
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 14:08:48 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MBDrM-1gbi7L3ghq-00Chw4; Tue, 11 Dec 2018 15:08:34 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH] arm64: fix ARM64_USER_VA_BITS_52 builds
Date: Tue, 11 Dec 2018 15:08:10 +0100
Message-Id: <20181211140832.567893-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:W8udSShYvyH2j34sw3w7eYzyrXFcmW0ipO2ab2+4cFO+lUFO9yo
 4vEbNhJVXBnPirMSNGxF751ms+Suxfl+yOtttZuU5MELGbWxgbWM2CrtN0x0qNMTZo5WXvv
 axMny95TG9XcnYKiDdvtTCxgrO/HPPrhf+28pI/V1UIDDFhZAlliyNALydz2NcdWKowgibs
 GJ2IiBly6lUU0aRqchL8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N1Qpeb7539s=:8xA3AuLjgt8wwTfIBajXLl
 vnJtF7/Q4d5RLcKyEy1IUiQKxudnhmgjGJ+GzTLGgA1FWJrYHPu/TGEygNWugRDdDRVswc2i2
 SJzxmdzg59rTxyBpNZZCXiu6X9tRdL2g3P7rLvnWVPWwtRpxI5FGTovyEicHTnVB9W18BwGqW
 2zPCnD47e8JOzKxUZ3ZWeSBYNwGzH7yOwysMvCGQzr9Jj4XgDui2QJFtHyEGbw3R916xsKab4
 k+MrjpcnKlA4wfJACRS2yPSEzBZhwpO7rfxZcqdDLwVpD+xXGx6BWaXXrLsQ9zpgmQyDvAGXU
 pQX6u0flb8d37zeB5WyMY87Pwj2hXXX6gHUIRdz6s3kJdegY7eTWraJ/tRYdXjWDWNqnTEaS/
 TkVfPUN+V6lv6iEYeiwYEoPIGC/NMEMZJ/Vaolxilcy5zNVVls+RQc7ZzlNyS/jub+xw1cv19
 41drbp2H8aIRdLuyTYUtMnhu3lmh3g0eVfhzMEWgCr2uDURP98wq91p/5oPExBTPaRS4kpSP+
 4tdeW5U9xRvYB2aHepNJkdjSxseICkaQPbQkwK09rt3phB96K946Yn4fFFyOFRoHKAW9LKUUn
 GceU417td5P+UJG6QW+kuMK3WICqxVqh42v5ezh+KxTYZnGiwcZNFB9LW3oabW6H2dBmwZhGv
 gzYJmyXwRLNsXPHoNuuPJySK2LmWCN2F4/JXKQhOaCw0fBI+OTfq7+f/2HxX7Ir0/Yy6HEevg
 PXj1AKT32QBZYeLklYKnG9JjUjBlQShW4YNL7A==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_060847_334545_8DED3B34 
X-CRM114-Status: GOOD (  12.22  )
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
Cc: linux-arm-kernel@lists.infradead.org,
 Kristina Martsenko <kristina.martsenko@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In some randconfig builds, the new CONFIG_ARM64_USER_VA_BITS_52
triggered a build failure:

arch/arm64/mm/proc.S:287: Error: immediate out of range

As it turns out, we were incorrectly setting PGTABLE_LEVELS here,
lacking any other default value.
This fixes the calculation of CONFIG_PGTABLE_LEVELS to consider
all combinations again.

Fixes: 68d23da4373a ("arm64: Kconfig: Re-jig CONFIG options for 52-bit VA")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index df201d93697d..a0f3b921b6e6 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -278,7 +278,7 @@ config PGTABLE_LEVELS
 	int
 	default 2 if ARM64_16K_PAGES && ARM64_VA_BITS_36
 	default 2 if ARM64_64K_PAGES && ARM64_VA_BITS_42
-	default 3 if ARM64_64K_PAGES && ARM64_VA_BITS_48
+	default 3 if ARM64_64K_PAGES && (ARM64_VA_BITS_48 || ARM64_USER_VA_BITS_52)
 	default 3 if ARM64_4K_PAGES && ARM64_VA_BITS_39
 	default 3 if ARM64_16K_PAGES && ARM64_VA_BITS_47
 	default 4 if !ARM64_64K_PAGES && ARM64_VA_BITS_48
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
