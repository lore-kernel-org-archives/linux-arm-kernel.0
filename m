Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB34FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:14:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96D7521871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gcHegW3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D7521871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=uhC3l5KeVTVtyF4zwKemnNipbClVaVonGlkhB6Ie6gs=; b=gcHegW3eoXdhQMpsOROYx5efBG
	8K/g3768ENkfhsHfHlFrlyG7VTzSJXMRTKU60y39hxKRVt4GtV/LV9dA+vcrebTqIYJHw/oWRfBT5
	YPpuUQiLpwStBw3jb3I9AU7az4neV7qG2i7mym21ViavzTG9OxPIuahsoPuzv5G/TIsP63e/n2tNZ
	scQwwI/UXGDKQ4FV/jllTAnp3NGSWyCf7RUVaQtHDo5BKJtMrC2tWNskrKJ78BefdBsfj/pqOUfKd
	/BEUSFuyhzBjfVCp+LkHN45SbRlNLa3etN20ST5okzBnICFqSKrHONybV7XDKxx1e6QeRx27B4AJX
	EN/jP+TQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf7W0-0004nz-Sf; Thu, 03 Jan 2019 18:14:44 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf7VL-00048c-11
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 18:14:06 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E44E15BF;
 Thu,  3 Jan 2019 10:14:02 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6C71A3F802;
 Thu,  3 Jan 2019 10:14:02 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 92B741AE0C51; Thu,  3 Jan 2019 18:14:02 +0000 (GMT)
From: Will Deacon <will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] arm64: compat: Don't pull syscall number from regs in
 arm_compat_syscall
Date: Thu,  3 Jan 2019 18:13:59 +0000
Message-Id: <1546539240-20647-3-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1546539240-20647-1-git-send-email-will.deacon@arm.com>
References: <1546539240-20647-1-git-send-email-will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_101403_082923_6AFEB532 
X-CRM114-Status: GOOD (  14.07  )
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
Cc: stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 Dave.Martin@arm.com, pihsun@chromium.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The syscall number may have been changed by a tracer, so we should pass
the actual number in from the caller instead of pulling it from the
saved r7 value directly.

Cc: <stable@vger.kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Pi-Hsun Shih <pihsun@chromium.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/sys_compat.c | 9 ++++-----
 arch/arm64/kernel/syscall.c    | 9 ++++-----
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/sys_compat.c b/arch/arm64/kernel/sys_compat.c
index 5972b7533fa0..54c29cd38ff9 100644
--- a/arch/arm64/kernel/sys_compat.c
+++ b/arch/arm64/kernel/sys_compat.c
@@ -66,12 +66,11 @@ do_compat_cache_op(unsigned long start, unsigned long end, int flags)
 /*
  * Handle all unrecognised system calls.
  */
-long compat_arm_syscall(struct pt_regs *regs)
+long compat_arm_syscall(struct pt_regs *regs, int scno)
 {
-	unsigned int no = regs->regs[7];
 	void __user *addr;
 
-	switch (no) {
+	switch (scno) {
 	/*
 	 * Flush a region from virtual address 'r0' to virtual address 'r1'
 	 * _exclusive_.  There is no alignment requirement on either address;
@@ -107,7 +106,7 @@ long compat_arm_syscall(struct pt_regs *regs)
 		 * way the calling program can gracefully determine whether
 		 * a feature is supported.
 		 */
-		if (no < __ARM_NR_compat_syscall_end)
+		if (scno < __ARM_NR_compat_syscall_end)
 			return -ENOSYS;
 		break;
 	}
@@ -116,6 +115,6 @@ long compat_arm_syscall(struct pt_regs *regs)
 		(compat_thumb_mode(regs) ? 2 : 4);
 
 	arm64_notify_die("Oops - bad compat syscall(2)", regs,
-			 SIGILL, ILL_ILLTRP, addr, no);
+			 SIGILL, ILL_ILLTRP, addr, scno);
 	return 0;
 }
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 032d22312881..5610ac01c1ec 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -13,16 +13,15 @@
 #include <asm/thread_info.h>
 #include <asm/unistd.h>
 
-long compat_arm_syscall(struct pt_regs *regs);
-
+long compat_arm_syscall(struct pt_regs *regs, int scno);
 long sys_ni_syscall(void);
 
-asmlinkage long do_ni_syscall(struct pt_regs *regs)
+static long do_ni_syscall(struct pt_regs *regs, int scno)
 {
 #ifdef CONFIG_COMPAT
 	long ret;
 	if (is_compat_task()) {
-		ret = compat_arm_syscall(regs);
+		ret = compat_arm_syscall(regs, scno);
 		if (ret != -ENOSYS)
 			return ret;
 	}
@@ -47,7 +46,7 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
 		syscall_fn = syscall_table[array_index_nospec(scno, sc_nr)];
 		ret = __invoke_syscall(regs, syscall_fn);
 	} else {
-		ret = do_ni_syscall(regs);
+		ret = do_ni_syscall(regs, scno);
 	}
 
 	regs->regs[0] = ret;
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
