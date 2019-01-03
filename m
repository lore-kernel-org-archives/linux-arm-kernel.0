Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB0CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:14:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFCAC2073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fBUx6hyN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCAC2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=LQnpcxSffPb8Dstx67I7bmYYorGGQKv77v8D6Patj8g=; b=fBUx6hyNiej+mnn2aLCr2rhOQ3
	74xA12Z0qEMXHdxwDW3TV3vlrQKKTaXn1Wae8tx8PHnynuyki9RBtoMJS0j0CVZrgXHuTfqIEEtuz
	ydJIMkT5fohYGr2KKUK2TxeSaWgQSyRJHUQ1u5of7BrwA7Nea7L5/BvJiH/SZYFYPIZp54U6Ceskl
	vdVtEoC4BkCdXSsA9g9iW+KX+DyWNRjiP8F0WLOvtYX6Y34qqkhhyEEKY4WLx9KmNaOOA+PdWaiGb
	xj6o4BRmc4GXaVqwa40IjsYxWCOH3drq+bnB5OLj5vKauPu/cko4OQUyMYvJ4baPfVPlxdSKLNjmf
	XAWOR2dw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf7Vn-0004Z5-1M; Thu, 03 Jan 2019 18:14:31 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf7VL-000494-Fz
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 18:14:06 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF2BF1650;
 Thu,  3 Jan 2019 10:14:02 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7DB063F5D4;
 Thu,  3 Jan 2019 10:14:02 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id A91D21AE0C73; Thu,  3 Jan 2019 18:14:02 +0000 (GMT)
From: Will Deacon <will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] arm64: compat: Hook up io_pgetevents() for 32-bit tasks
Date: Thu,  3 Jan 2019 18:14:00 +0000
Message-Id: <1546539240-20647-4-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1546539240-20647-1-git-send-email-will.deacon@arm.com>
References: <1546539240-20647-1-git-send-email-will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_101403_826214_432D933D 
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
Cc: Will Deacon <will.deacon@arm.com>, Dave.Martin@arm.com, pihsun@chromium.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Commit 73aeb2cbcdc9 ("ARM: 8787/1: wire up io_pgetevents syscall")
hooked up the io_pgetevents() system call for 32-bit ARM, so we can
do the same for the compat wrapper on arm64.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/unistd.h   | 2 +-
 arch/arm64/include/asm/unistd32.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index be66a54ee3a1..395097caf0ea 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -44,7 +44,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_compat_syscall_end	(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		399
+#define __NR_compat_syscalls		400
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 2cd6dcf8d246..04ee190b90fe 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -819,6 +819,8 @@ __SYSCALL(__NR_pkey_free, sys_pkey_free)
 __SYSCALL(__NR_statx, sys_statx)
 #define __NR_rseq 398
 __SYSCALL(__NR_rseq, sys_rseq)
+#define __NR_io_pgetevents 399
+__SYSCALL(__NR_io_pgetevents, compat_sys_io_pgetevents)
 
 /*
  * Please add new compat syscalls above this comment and update
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
