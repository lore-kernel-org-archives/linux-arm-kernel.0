Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE17C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:28:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21A83214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HurAtnc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A83214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4Azdpd6/M9fQWvzXRzCIItL3JYilq4clLMEvC7QHLi4=; b=HurAtnc2uYvjeF
	6u0jtYNnevWT4uBy8yB8mwXdYbSgP9CxWYyx/+fwLWJEnkgJSng2bZkZRh+DV0FMZk5oRbujQBHfj
	CWQxz/+ilrbwfRm7dU5/nm2WJrZXiE6367tmCbHSVr3zMUf+uriQJmpL12YYd0zQi1Pqo9czmH/7b
	9bF6ic8DJBdLYe6YhW2HluPzI0AL+mbsnI8NLQvDIFFd/kXtUCxmNC6f/6qCcMAfyKWCcRkltzf2t
	iR+sgGBzQ5a89yM0EWVxqHBeu+i3tim02o+AVjxoW4PJy3KFbp0JHTPF/w7CmBSr2R543eYfuPnhi
	rmKLoIIcfRyL5e5vdFLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghe8E-0003bu-D7; Thu, 10 Jan 2019 17:28:38 +0000
Received: from mout.kundenserver.de ([217.72.192.75])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghe8A-0003bF-LQ
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 17:28:36 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MXp1O-1gn0kD2DHw-00Y6aZ; Thu, 10 Jan 2019 18:22:29 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] timex: change syscalls to use struct __kernel_timex
Date: Thu, 10 Jan 2019 18:22:11 +0100
Message-Id: <20190110172216.313063-7-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110172216.313063-1-arnd@arndb.de>
References: <20190110172216.313063-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:4lo+P0Jssf80yBpLJNqYJgkfsZFwI33q3gIWB3cTNQ6r/2Wo8AP
 K0fcuczrITU2zqExzuVqdUFRe951ZBXZdhvuNYueI9HRB/wAuM//Jxw32Zhzt7rs+9cWSNa
 oelu2KFU17/9u1/baRsXVk4dlNgBuOSrd/sBG/x9LFm4MsBvDE0xR2Nv7Z/ch6WGgE4G9sa
 rgGYWLhXf4N1GHKl2M65w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ex1jn0af5BU=:bdsVGTxlAhmtjwRIgR6eTI
 A6S5rnxwNHQOTJ5wkUU8iQj15DJ8B4PGE5oaXe2FiwQd1vUxLtu4LolchmDA2f1eXTej9jyu6
 x9UcI0IGhLKozYOViHtZZYanwoHR6sZ7k1NSDOwP6srOhNDZiJII2LdQvL6Cvxf9ulGif9liF
 WK0zzsiHfFCIZowb20Lu6CgLh8apZBrhB3+jR/iohmjOjAnyGBmvzP2SMk+0tQziIIBMEbeou
 UCZNwl5e87zMy+AInX9jyvLnjNIqvAB8VQhmKrueWUiWOCm0zQ3ZDYjEvYPwjNkSdqZoAyxtg
 iBEhmi2A4DTtZLTGBU0sLZYx3GekSmri2P1ly3jZHAJSVuma20FgAR5vxIW739U/DPQp5Wizt
 T/ofzDRrit15IQybfvoIqZaPuOVWQlYW94MMLa7hKcDt7ACA7q5nXyPdfDl9hAVQzyYIG1gqc
 QZbQPEElC+uYbRh2GjCHhlmL0Bxv2EH9pLRPNDEnRZKScKzhhXmIfsRE9BiOo47k1szyt0sJo
 8GB80a+OMHVA9umcqSAutnVoNJjn79SVERawkT+g+agsDkSH6q/EauYLfQxeDjWHW/rgZ6+KF
 B2nvfG/KIkVGZdAfyFh7x/Q1V9lhOgfGbiwxLaMLjKn17be5kAu/Ns+N4Q5OIUYeW3V6dpiKg
 ng2TAuGMOKmBfVJLshy1Ld5uwcy0rCu24SLYmPTihXMdum5WLSbioTUZBTr42yrettAcxMDS3
 5wnuXitzJJuDXGn/RQ6if954eiQU6enck0+NWw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_092835_007877_C6FB0859 
X-CRM114-Status: GOOD (  12.10  )
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
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, mpe@ellerman.id.au,
 deller@gmx.de, x86@kernel.org, linux@armlinux.org.uk, mingo@redhat.com,
 geert@linux-m68k.org, benh@kernel.crashing.org, firoz.khan@linaro.org,
 mattst88@gmail.com, fenghua.yu@intel.com, Arnd Bergmann <arnd@arndb.de>,
 heiko.carstens@de.ibm.com, linux-fsdevel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, luto@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, monstr@monstr.eu, tony.luck@intel.com,
 linux-parisc@vger.kernel.org, netdev@vger.kernel.org,
 linux-mips@vger.kernel.org, paul.burton@mips.com, ebiederm@xmission.com,
 linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
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
index 8e86d9623d4e..394e8db7e57e 100644
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
