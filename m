Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957ADC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:36:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6413F2087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gSmLvfJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6413F2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ClkYATIT8EM7jMMJLwyTQNv2yY+EMr4dEN8mV8e30Ug=; b=gSmLvfJBKYvvIG
	3uxZnTTWUnrIxZ8h0/kf3YZH3oQNAgJMA2rVgUkwHv4wbSUIGya0QRcBuW8iE79ByMIgLqhDyMZEe
	B7x1vyiwOq4qyglrxvGzdY6oUna2i6nhGQQ8yFfcCsPPU8IT0fUVmDlSLT1hATVZTy3iK6v+VszBk
	QyXqPY6+kKh28DRoeUKAofB6mheTLH1QfSTsQLq2X/PTzF5NfyM3I6ilL5NMYa5e6GuuIdEZTo6NA
	55znI6zknDFkPQfVoQHOJdBo+fLe6BlhzH4cztThCS9rYEQpXlRhqzSccrFISO0LTtPQYOS2ZKg3E
	Xy3mZPurN0w1tjRefacg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkX7Y-000119-Te; Fri, 18 Jan 2019 16:35:52 +0000
Received: from mout.kundenserver.de ([212.227.17.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkX6D-0007Pa-Qb
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:34:39 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MC2sF-1gwJ6T0HvR-00CT2U; Fri, 18 Jan 2019 17:19:44 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 21/29] sparc64: add custom adjtimex/clock_adjtime functions
Date: Fri, 18 Jan 2019 17:18:27 +0100
Message-Id: <20190118161835.2259170-22-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:SDXMCuyJzLqpJAifGRt40gvyBoqJCXKqswb2YTNLUtxnFDoMx/W
 +5ExJy+FfAJFZvijBjxP7IkCAiIawdbKOvGJdHKe9DVR4sJVPUHEfAz3zX8H8AA1DPfXKDv
 n3bInnzQVYWnqUfK3yPxDADtBoRxSd/sjf+LzwFX142gsdtJUUWkWGc2DO57CpmFKCkYQ/X
 gZwaHIWb6cg/fck75AVYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0x8XPy8Xaxg=:LuIRE7zi+S0ZScG43Q4V7+
 srL+8XA5FZ/BDsDh7oZ5mSGIh1mBf6X3LKB7b3UyWyrTD+CorIfWuVBDY5S94mJ6LAa+llsdP
 k4afnrEgZe7dv2RsEDK/eMObdTrJep2ZHi93W44UojthNRPLR08vNb1QcxoXGjUCFGCvodP8n
 DaJdF0Hjc/vETDubm3ADJh0t7ZPAi5WSqivRx/E0oHHU+8jVMuRFejqUHn9jAo9PFATwmC1XE
 ABu7C55ytfJ3Wj0H9Y1KMgFBhxUJujBr5xEgghpVUw/10jzeVvbbJi+E2JS5bIPvZ9cKunjJT
 yxYbxMr0Yft2W9aIfQRt5Nr5fKBvqy+3tRKer21xz+c1Z+ysjwpq5f4FxpficjIYZ3txV0zAl
 N4ZHmsuXM3JIYi5uSAv9Mrl7DDRFSF783gv6aCL1HSOi5TD6sqIpSHYWDP0yfNfgyy5qQXYb8
 qFtFTLzk4uNytMwtPnE9Q39Ufiy5vLpJJvjI1qFU0+bD5Cns3ISb66AQ/hiQIEtO9t2ttFiup
 EfaEGzH61MqTIr3aHO0nFDyc1kCvyN+z2txXApfo5rGNmdV27qrmpGgNqHz3cD+j9i86y1x8n
 L4GgrdGXVhzZp2uQnfOuOJIiHh8d7+05LHEvb+fuuNYfagVMHiEpBO/5GAdFGkcG+1SG1n1V0
 NMErKoBS4vkm82HuOF4is9BSu7/LGp3S7oMw8UvoWHvJ8JDdy4RcBVXsGbaApAGSyST1Ex1wr
 gtgN+G+BHFCSKfh10208uC4YgQCDI2TZoVJ96aV2UGNKggNvlRqouI8jDfiDYKheDq/Tk/iBN
 CXZzqCAXMZD5jvAnALhVE2J8oquTi51uHgBZTuhX3t517K9IcUBZhEAF3YnNZTeS9pmzElJ+G
 sHEsWlumsXAuYMIZMFHg5j7JUhDkFp0JrBe70Lg4+ZVbRnf6iOp3pXnNc0Ggsg
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_083430_294536_9E65194A 
X-CRM114-Status: GOOD (  17.27  )
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

sparc64 is the only architecture on Linux that has a 'timeval'
definition with a 32-bit tv_usec but a 64-bit tv_sec. This causes
problems for sparc32 compat mode when we convert it to use the
new __kernel_timex type that has the same layout as all other
64-bit architectures.

To avoid adding sparc64 specific code into the generic adjtimex
implementation, this adds a wrapper in the sparc64 system call handling
that converts the sparc64 'timex' into the new '__kernel_timex'.

At this point, the two structures are defined to be identical,
but that will change in the next step once we convert sparc32.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sparc/kernel/sys_sparc_64.c       | 59 +++++++++++++++++++++++++-
 arch/sparc/kernel/syscalls/syscall.tbl |  6 ++-
 include/linux/timex.h                  |  2 +
 kernel/time/posix-timers.c             | 24 +++++------
 4 files changed, 76 insertions(+), 15 deletions(-)

diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 1c079e7bab09..37de18a11207 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -28,8 +28,9 @@
 #include <linux/random.h>
 #include <linux/export.h>
 #include <linux/context_tracking.h>
-
+#include <linux/timex.h>
 #include <linux/uaccess.h>
+
 #include <asm/utrap.h>
 #include <asm/unistd.h>
 
@@ -544,6 +545,62 @@ SYSCALL_DEFINE2(getdomainname, char __user *, name, int, len)
 	return err;
 }
 
+SYSCALL_DEFINE1(sparc_adjtimex, struct timex __user *, txc_p)
+{
+	struct timex txc;		/* Local copy of parameter */
+	struct timex *kt = (void *)&txc;
+	int ret;
+
+	/* Copy the user data space into the kernel copy
+	 * structure. But bear in mind that the structures
+	 * may change
+	 */
+	if (copy_from_user(&txc, txc_p, sizeof(struct timex)))
+		return -EFAULT;
+
+	/*
+	 * override for sparc64 specific timeval type: tv_usec
+	 * is 32 bit wide instead of 64-bit in __kernel_timex
+	 */
+	kt->time.tv_usec = txc.time.tv_usec;
+	ret = do_adjtimex(kt);
+	txc.time.tv_usec = kt->time.tv_usec;
+
+	return copy_to_user(txc_p, &txc, sizeof(struct timex)) ? -EFAULT : ret;
+}
+
+SYSCALL_DEFINE2(sparc_clock_adjtime, const clockid_t, which_clock,struct timex __user *, txc_p)
+{
+	struct timex txc;		/* Local copy of parameter */
+	struct timex *kt = (void *)&txc;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_POSIX_TIMERS)) {
+		pr_err_once("process %d (%s) attempted a POSIX timer syscall "
+		    "while CONFIG_POSIX_TIMERS is not set\n",
+		    current->pid, current->comm);
+
+		return -ENOSYS;
+	}
+
+	/* Copy the user data space into the kernel copy
+	 * structure. But bear in mind that the structures
+	 * may change
+	 */
+	if (copy_from_user(&txc, txc_p, sizeof(struct timex)))
+		return -EFAULT;
+
+	/*
+	 * override for sparc64 specific timeval type: tv_usec
+	 * is 32 bit wide instead of 64-bit in __kernel_timex
+	 */
+	kt->time.tv_usec = txc.time.tv_usec;
+	ret = do_clock_adjtime(which_clock, kt);
+	txc.time.tv_usec = kt->time.tv_usec;
+
+	return copy_to_user(txc_p, &txc, sizeof(struct timex)) ? -EFAULT : ret;
+}
+
 SYSCALL_DEFINE5(utrap_install, utrap_entry_t, type,
 		utrap_handler_t, new_p, utrap_handler_t, new_d,
 		utrap_handler_t __user *, old_p,
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 24ebef675184..e70110375399 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -258,7 +258,8 @@
 216	64	sigreturn		sys_nis_syscall
 217	common	clone			sys_clone
 218	common	ioprio_get		sys_ioprio_get
-219	common	adjtimex		sys_adjtimex			compat_sys_adjtimex
+219	32	adjtimex		sys_adjtimex			compat_sys_adjtimex
+219	64	adjtimex		sys_sparc_adjtimex
 220	32	sigprocmask		sys_sigprocmask			compat_sys_sigprocmask
 220	64	sigprocmask		sys_nis_syscall
 221	common	create_module		sys_ni_syscall
@@ -377,7 +378,8 @@
 331	common	prlimit64		sys_prlimit64
 332	common	name_to_handle_at	sys_name_to_handle_at
 333	common	open_by_handle_at	sys_open_by_handle_at		compat_sys_open_by_handle_at
-334	common	clock_adjtime		sys_clock_adjtime		compat_sys_clock_adjtime
+334	32	clock_adjtime		sys_clock_adjtime		compat_sys_clock_adjtime
+334	64	clock_adjtime		sys_sparc_clock_adjtime
 335	common	syncfs			sys_syncfs
 336	common	sendmmsg		sys_sendmmsg			compat_sys_sendmmsg
 337	common	setns			sys_setns
diff --git a/include/linux/timex.h b/include/linux/timex.h
index 7f40e9e42ecc..a15e6aeb8d49 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -159,6 +159,8 @@ extern unsigned long tick_nsec;		/* SHIFTED_HZ period (nsec) */
 #define NTP_INTERVAL_LENGTH (NSEC_PER_SEC/NTP_INTERVAL_FREQ)
 
 extern int do_adjtimex(struct timex *);
+extern int do_clock_adjtime(const clockid_t which_clock, struct timex * ktx);
+
 extern void hardpps(const struct timespec64 *, const struct timespec64 *);
 
 int read_current_timer(unsigned long *timer_val);
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 8955f32f2a36..8f7f1dd95940 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1047,22 +1047,28 @@ SYSCALL_DEFINE2(clock_gettime, const clockid_t, which_clock,
 	return error;
 }
 
-SYSCALL_DEFINE2(clock_adjtime, const clockid_t, which_clock,
-		struct timex __user *, utx)
+int do_clock_adjtime(const clockid_t which_clock, struct timex * ktx)
 {
 	const struct k_clock *kc = clockid_to_kclock(which_clock);
-	struct timex ktx;
-	int err;
 
 	if (!kc)
 		return -EINVAL;
 	if (!kc->clock_adj)
 		return -EOPNOTSUPP;
 
+	return kc->clock_adj(which_clock, ktx);
+}
+
+SYSCALL_DEFINE2(clock_adjtime, const clockid_t, which_clock,
+		struct timex __user *, utx)
+{
+	struct timex ktx;
+	int err;
+
 	if (copy_from_user(&ktx, utx, sizeof(ktx)))
 		return -EFAULT;
 
-	err = kc->clock_adj(which_clock, &ktx);
+	err = do_clock_adjtime(which_clock, &ktx);
 
 	if (err >= 0 && copy_to_user(utx, &ktx, sizeof(ktx)))
 		return -EFAULT;
@@ -1126,20 +1132,14 @@ COMPAT_SYSCALL_DEFINE2(clock_gettime, clockid_t, which_clock,
 COMPAT_SYSCALL_DEFINE2(clock_adjtime, clockid_t, which_clock,
 		       struct old_timex32 __user *, utp)
 {
-	const struct k_clock *kc = clockid_to_kclock(which_clock);
 	struct timex ktx;
 	int err;
 
-	if (!kc)
-		return -EINVAL;
-	if (!kc->clock_adj)
-		return -EOPNOTSUPP;
-
 	err = get_old_timex32(&ktx, utp);
 	if (err)
 		return err;
 
-	err = kc->clock_adj(which_clock, &ktx);
+	err = do_clock_adjtime(which_clock, &ktx);
 
 	if (err >= 0)
 		err = put_old_timex32(utp, &ktx);
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
