Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA9DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:14:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1DB32073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="METO9kxv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1DB32073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=1qnXjWDpYA9nThmxzhtQW+M1liF+nBbZCjNxtJctdU4=; b=METO9kxvxLi15tR78W9rpbu7TL
	JgstQDTcvBmwLlIhbCvrHc7MU6jBKwQ8exO/kcwuMsG0c4wFqu1jn0dDiyZUjP/cQgCWgzbkJFi5k
	sRhiXtWWwMtNMSahtHWx7+JJIi9/bN86m77Ps/Suc/j8RXYk+em7dAjd/Pi+2geaqu5TrylL9f7k5
	5P7ZIawWyzW2yyxK4ZkktK99WdxLXp8hQo/4vtpReNzsA7PrqIec0hNhjqeyDw3TPPDpJ2G1lARst
	8fygEIH07Cz4EACrLf4g1Pf0G96Ccd9SDUkeTJEEssQDV7BvUCjb11NvRg0KJY1hQxESKwPPHUHP4
	Tu9ShBZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf7VO-00049r-Or; Thu, 03 Jan 2019 18:14:06 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf7VL-00048d-14
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 18:14:05 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88F5415BE;
 Thu,  3 Jan 2019 10:14:02 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 572713F706;
 Thu,  3 Jan 2019 10:14:02 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 8242D1AE09EC; Thu,  3 Jan 2019 18:14:02 +0000 (GMT)
From: Will Deacon <will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] arm64: compat: Avoid sending SIGILL for unallocated
 syscall numbers
Date: Thu,  3 Jan 2019 18:13:58 +0000
Message-Id: <1546539240-20647-2-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1546539240-20647-1-git-send-email-will.deacon@arm.com>
References: <1546539240-20647-1-git-send-email-will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_101403_104924_41364472 
X-CRM114-Status: GOOD (  13.07  )
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

The ARM Linux kernel handles the EABI syscall numbers as follows:

  0           - NR_SYSCALLS-1	: Invoke syscall via syscall table
  NR_SYSCALLS - 0xeffff		: -ENOSYS (to be allocated in future)
  0xf0000     - 0xf07ff		: Private syscall or -ENOSYS if not allocated
  > 0xf07ff			: SIGILL

Our compat code gets this wrong and ends up sending SIGILL in response
to all syscalls greater than NR_SYSCALLS which have a value greater
than 0x7ff in the bottom 16 bits.

Fix this by defining the end of the ARM private syscall region and
checking the syscall number against that directly. Update the comment
while we're at it.

Cc: <stable@vger.kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>
Reported-by: Pi-Hsun Shih <pihsun@chromium.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/unistd.h | 5 +++--
 arch/arm64/kernel/sys_compat.c  | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index b13ca091f833..be66a54ee3a1 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -40,8 +40,9 @@
  * The following SVCs are ARM private.
  */
 #define __ARM_NR_COMPAT_BASE		0x0f0000
-#define __ARM_NR_compat_cacheflush	(__ARM_NR_COMPAT_BASE+2)
-#define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE+5)
+#define __ARM_NR_compat_cacheflush	(__ARM_NR_COMPAT_BASE + 2)
+#define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
+#define __ARM_NR_compat_syscall_end	(__ARM_NR_COMPAT_BASE + 0x800)
 
 #define __NR_compat_syscalls		399
 #endif
diff --git a/arch/arm64/kernel/sys_compat.c b/arch/arm64/kernel/sys_compat.c
index 32653d156747..5972b7533fa0 100644
--- a/arch/arm64/kernel/sys_compat.c
+++ b/arch/arm64/kernel/sys_compat.c
@@ -102,12 +102,12 @@ long compat_arm_syscall(struct pt_regs *regs)
 
 	default:
 		/*
-		 * Calls 9f00xx..9f07ff are defined to return -ENOSYS
+		 * Calls 0xf0xxx..0xf07ff are defined to return -ENOSYS
 		 * if not implemented, rather than raising SIGILL. This
 		 * way the calling program can gracefully determine whether
 		 * a feature is supported.
 		 */
-		if ((no & 0xffff) <= 0x7ff)
+		if (no < __ARM_NR_compat_syscall_end)
 			return -ENOSYS;
 		break;
 	}
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
