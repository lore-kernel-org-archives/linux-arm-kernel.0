Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D64C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:20:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 330FE2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AVtlCnEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330FE2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UUND5O9ZMy9fF3q1lAl6rCbBRbCFZaeYVwgfMnA4938=; b=AVtlCnEvvAI6k3
	M/kbsRLG+9PXn1Pr9BIhu5nrmNSyBfFvO9LrYSM6rkGchSygOMq8FQ3oxrztrFh68iZT2TZoxNQgc
	AnQa60c8ElpwI6dHv7RzsCCSpdUYiImbCsMtMPoUB9AropGsGE3YQ6GqRYbCI/reMlwUovxy3Oj2Z
	2PTsuqBiwJd6hIWkHe0rDb6YtWdxBXBFXjO2TrXB/B2wxVHYnp+tjJk3oiRxph2KXM/N4aoeZUXXl
	Mv+t6kwM3AiFXvPoy35+LxXf5cIcGkTg7Vv4TcLxWio8hYV61kZyFRnzFhMYwT4s/uF7LmMmjxSb/
	9975wlZqiU6KjU0qqbZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWss-0001aB-50; Fri, 18 Jan 2019 16:20:42 +0000
Received: from mout.kundenserver.de ([217.72.192.75])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWsb-0001Mw-2k
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:20:26 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MKKd7-1gWQWS33t9-00LmRg; Fri, 18 Jan 2019 17:19:23 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 06/29] ARM: add migrate_pages() system call
Date: Fri, 18 Jan 2019 17:18:12 +0100
Message-Id: <20190118161835.2259170-7-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:o3bTb4elB3z+286rn9+b5BP7tK9ifOmWUW+jka5ZcLRoBINPDJf
 u8PIZcP2oUy73YnUflDiwxkNfXIDgII5Pyhk+V14swnaTnFx5ocmSc3GvbMfPHBlAdH2hOO
 HnGoII6EJed1+C6r0RoTYwRkjRvEbyOrLcmhc5DagzjWZlLv5X7xA8BSuap5Ej3vVq2kBkR
 J33viKVBFQ1JhizF8SI/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3TL+IMUlpzQ=:W4KhIatfhW7FMFXhanW/DA
 GRXuaIVZT5yLKobF9hxOAr0++qzuCRc1CvEdJhCRmyjg3tVnuVTea/UC1uvUl5+b8WbMQGZ2y
 IhAzxeBsFmWL53O9WpTTqoDT/nboxRQDmswH0/f/GTKPMN2z3vZwVUlRhzoSirbpF+lnxfjOZ
 sN/4WLTGYuHpbqrOxsstykpo2y8LRe1POgk4jbusH6bQF90n6M4iRhVrGRIOrVw2bdttMMlAA
 uT0OtEXxzSfFi0CYobAlGKnZqnyNhrd53D0fMCInpqHILWFd1DtjVcSRRThpH/sAtDi0bB10+
 Ugb1IEqZY/t6Vwsm27UEtY2WdRDnob3jplYpxp7LEYnA9+MmRRxsSQGX4rwbfAh61hF01Z6w6
 c1gGmtntitfEHrg2cn23IhBqYw4oKw2FRJOxB9tDFAw7RHOCw9DS4DZeuAH/963xwTtIZQzNY
 1aXUG6Znslmrc13+enLNNpHHdqS95uRqE0RLgCHtmqVJSvSINH3VB0iFWhAu52D9FeScou6Jt
 DMCljPSLrh3jHaukqC84MTlYT6tYVfPoAwYvF7QgVEd2kgvyMgY2cHJMjfNpvBVodJDtgelWN
 WyT2nqJHgERRpJagCPwbdtU6mcbVNfRzxffHnacQ4vUxt4V/sJi/kqkoPRbuRzxPSp7atXUfB
 1YBkP5nZaJQ1KkngOFAwcAZDCXzHTa7u9SVJNuPiXS2Wwsi0eYe4gZnZnIKeg8MQ2APOz+PXy
 XOmiTdMMxuVgn48bnD8Kw1Cy5XKVXUIjyQPYnQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_082025_427698_300D5076 
X-CRM114-Status: GOOD (  12.36  )
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
Cc: dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 catalin.marinas@arm.com, will.deacon@arm.com, jcmvbkbc@gmail.com,
 deepa.kernel@gmail.com, hpa@zytor.com, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, mpe@ellerman.id.au, deller@gmx.de, x86@kernel.org,
 linux@armlinux.org.uk, mingo@redhat.com, geert@linux-m68k.org,
 benh@kernel.crashing.org, firoz.khan@linaro.org, mattst88@gmail.com,
 fenghua.yu@intel.com, Arnd Bergmann <arnd@arndb.de>, heiko.carstens@de.ibm.com,
 linux-fsdevel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 luto@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 monstr@monstr.eu, tony.luck@intel.com, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, linux-mips@vger.kernel.org, paul.burton@mips.com,
 ebiederm@xmission.com, linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The migrate_pages system call has an assigned number on all architectures
except ARM. When it got added initially in commit d80ade7b3231 ("ARM:
Fix warning: #warning syscall migrate_pages not implemented"), it was
intentionally left out based on the observation that there are no 32-bit
ARM NUMA systems.

However, there are now arm64 NUMA machines that can in theory run 32-bit
kernels (actually enabling NUMA there would require additional work)
as well as 32-bit user space on 64-bit kernels, so that argument is no
longer very strong.

Assigning the number lets us use the system call on 64-bit kernels as well
as providing a more consistent set of syscalls across architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/unistd.h     | 1 -
 arch/arm/tools/syscall.tbl        | 1 +
 arch/arm64/include/asm/unistd.h   | 2 +-
 arch/arm64/include/asm/unistd32.h | 2 ++
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
index 88ef2ce1f69a..d713587dfcf4 100644
--- a/arch/arm/include/asm/unistd.h
+++ b/arch/arm/include/asm/unistd.h
@@ -45,7 +45,6 @@
  * Unimplemented (or alternatively implemented) syscalls
  */
 #define __IGNORE_fadvise64_64
-#define __IGNORE_migrate_pages
 
 #ifdef __ARM_EABI__
 /*
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 8edf93b4490f..86de9eb34296 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -414,3 +414,4 @@
 397	common	statx			sys_statx
 398	common	rseq			sys_rseq
 399	common	io_pgetevents		sys_io_pgetevents
+400	common	migrate_pages		sys_migrate_pages
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index a7b1fc58ffdf..261216c3336e 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -44,7 +44,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		400
+#define __NR_compat_syscalls		401
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 04ee190b90fe..f15bcbacb8f6 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -821,6 +821,8 @@ __SYSCALL(__NR_statx, sys_statx)
 __SYSCALL(__NR_rseq, sys_rseq)
 #define __NR_io_pgetevents 399
 __SYSCALL(__NR_io_pgetevents, compat_sys_io_pgetevents)
+#define __NR_migrate_pages 400
+__SYSCALL(__NR_migrate_pages, compat_sys_migrate_pages)
 
 /*
  * Please add new compat syscalls above this comment and update
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
