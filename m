Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D44AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:35:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D496320850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HWL4Y9Xr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D496320850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9J47l5GrxYQaVexlbiBMWPsNctedjZdv7RbHEA5zE/s=; b=HWL4Y9Xri+1UFL
	K0YqAx5dm+Xrb0Yc0/Gp8lZ9OfpvPLE6rbTgAQs11C4yuZ1ZhdcLI084VZ1kGFPCH8OxPDf84oRMJ
	CjZOum2PBhisXRE0CM0nAlMg2+0yoPBIfmXUTPf86UfOoOHiU2U9GzK34tz4tl95FzvmuLAWGygnb
	p85Bgg987H/QBrgPZWR2lA745AaMKiXsVTFTsXpCBUGDy9pDNyRZxErUlvSz+urt+I6VjLVdkhH9I
	a0xhzSL5TGzlrUezHBMpAHuXm1cjDNOhkHMEV4iQ5VXBWtV6/En1tBGxyjbw1WlFk4N0kyBdzmQ/K
	jRhb+NTa6SBfdZtAnQvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkX7M-0000px-44; Fri, 18 Jan 2019 16:35:40 +0000
Received: from mout.kundenserver.de ([212.227.17.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkX6E-0007Pf-T5
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:34:39 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MJm8N-1gUmN93A53-00K81C; Fri, 18 Jan 2019 17:19:46 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 23/29] timex: change syscalls to use struct __kernel_timex
Date: Fri, 18 Jan 2019 17:18:29 +0100
Message-Id: <20190118161835.2259170-24-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:kVG9L0004kjVGZ3jTNXRJe2zDldO8i8hhwk/XZl6p/GXzXXvSu2
 S5s+hnfGO6V8L06OXZk9Nmq1uc5XK0SX/tvCGfMVZwqYFwiNbnQCEsDmqBr0jqt+TgbwpgG
 rE1jCFnNroPTGvKPMDwi6YeE/oC7sqo/dZ97spnSvZMQuFdzPWZsc1U7WyjH13VgDKbUZqy
 Al7mfxahnL861tlGnkoFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3UzWYXmd5CU=:n/IoNxXRvTDgJU6zABlpKR
 CvBc3VJkVz4VrdUvso8uzfGNGDDhEOVUHVWpmYVn2gIG9/3mjlAa19btI2kx2BeWGgtDOTlCu
 nQhhZ5uO33I97iQOqooV/i4hzq39ffcRlkO7RXUZcOxmw1pYoPONvz3lVoN+uXODa1+0lwkqP
 nUBMjmeQvKrrwdmHfQdDukhiXTzhskjVfVgk0BqYTwPO7Jo7IzN8b2Datm5WLVE+Eg+7gEMHN
 uYHacbaXDgjcG0qmTSyk2COcszaOthUZ2ZcLP3AFipL/RDbPXJC+eGR+fCTxNGJxuDl9HdiX4
 +ZYgvQetq6zGev+OBIE/z7SooCNPysiCSqbjFUDPHpB6R7FylH13+3J20rUJo1acNiRsL/EPm
 wu5tYcijZrPMBnYFMu23oqmK9ko293wg7Q/zQZO/JcdwGRGH4iYXTNbQiqqVfWrImlXtTMwij
 CoHyCMD8Hpeb9M+x2ILqPDu0VSLVlybPSD5vAkd/vmrWhdDWjb/n7sw3oQymWXGkvU7T0vEZs
 6ioK7hEsTY+2rCEcqjPlteL4loHr0N7IKu2RW89eNMjPWGhV8JlhxhkPmtaEshvJKAtBustYb
 RPYjmt7U4lb8GqF5f4hjCT7nUhNyWdeUO5KN9lsiBEVYrnTiBaUOIFMGPQoOLU7Hvk4qYfZe9
 3CGebR05bLFJCyMt+oh6kSe2pBLqfsioqjCcRffTFvi/bf225wQkhLG8XWYb4zoMGUVUlKPQO
 vIehqczGVVzOQeVDu76QtcJUnDqL6hbZjlTVM6m6WsoIg/EBdg2J/pD8wD9AABHlIpJn5ZA3K
 DqWaza54Y5WkXjKQnsfr+Wwi2fyv2U5K5rdBMFEaMk0TqxgpoU/48yGin+iK6V+sJWNG3i9z9
 nWP1azl+iFnTkFDm4cDpMLDcBToccPnfCnBbtd97XCwUuh7ZUA3lZ1cksoJZMd
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_083431_489053_F94D9C73 
X-CRM114-Status: GOOD (  11.51  )
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

From: Deepa Dinamani <deepa.kernel@gmail.com>

struct timex is not y2038 safe.
Switch all the syscall apis to use y2038 safe __kernel_timex.

Note that sys_adjtimex() does not have a y2038 safe solution.  C libraries
can implement it by calling clock_adjtime(CLOCK_REALTIME, ...).

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/syscalls.h   | 6 +++---
 kernel/time/posix-timers.c | 2 +-
 kernel/time/time.c         | 4 +++-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index baa4b70b02d3..09330d5bda0c 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -54,7 +54,7 @@ struct __sysctl_args;
 struct sysinfo;
 struct timespec;
 struct timeval;
-struct timex;
+struct __kernel_timex;
 struct timezone;
 struct tms;
 struct utimbuf;
@@ -695,7 +695,7 @@ asmlinkage long sys_gettimeofday(struct timeval __user *tv,
 				struct timezone __user *tz);
 asmlinkage long sys_settimeofday(struct timeval __user *tv,
 				struct timezone __user *tz);
-asmlinkage long sys_adjtimex(struct timex __user *txc_p);
+asmlinkage long sys_adjtimex(struct __kernel_timex __user *txc_p);
 
 /* kernel/timer.c */
 asmlinkage long sys_getpid(void);
@@ -870,7 +870,7 @@ asmlinkage long sys_open_by_handle_at(int mountdirfd,
 				      struct file_handle __user *handle,
 				      int flags);
 asmlinkage long sys_clock_adjtime(clockid_t which_clock,
-				struct timex __user *tx);
+				struct __kernel_timex __user *tx);
 asmlinkage long sys_syncfs(int fd);
 asmlinkage long sys_setns(int fd, int nstype);
 asmlinkage long sys_sendmmsg(int fd, struct mmsghdr __user *msg,
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 2d84b3db1ade..de79f85ae14f 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1060,7 +1060,7 @@ int do_clock_adjtime(const clockid_t which_clock, struct __kernel_timex * ktx)
 }
 
 SYSCALL_DEFINE2(clock_adjtime, const clockid_t, which_clock,
-		struct timex __user *, utx)
+		struct __kernel_timex __user *, utx)
 {
 	struct __kernel_timex ktx;
 	int err;
diff --git a/kernel/time/time.c b/kernel/time/time.c
index d179d33f639a..78b5c8f1495a 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -263,7 +263,8 @@ COMPAT_SYSCALL_DEFINE2(settimeofday, struct old_timeval32 __user *, tv,
 }
 #endif
 
-SYSCALL_DEFINE1(adjtimex, struct timex __user *, txc_p)
+#if !defined(CONFIG_64BIT_TIME) || defined(CONFIG_64BIT)
+SYSCALL_DEFINE1(adjtimex, struct __kernel_timex __user *, txc_p)
 {
 	struct __kernel_timex txc;		/* Local copy of parameter */
 	int ret;
@@ -277,6 +278,7 @@ SYSCALL_DEFINE1(adjtimex, struct timex __user *, txc_p)
 	ret = do_adjtimex(&txc);
 	return copy_to_user(txc_p, &txc, sizeof(struct __kernel_timex)) ? -EFAULT : ret;
 }
+#endif
 
 #ifdef CONFIG_COMPAT_32BIT_TIME
 int get_old_timex32(struct __kernel_timex *txc, const struct old_timex32 __user *utp)
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
