Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EDAC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:56:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B2A0206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G4EVoxy3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2A0206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=EcYqwgdCeJ3Mfbj1IL/N05YXy4zKRynsjF/adNH9Ey0=; b=G4EVoxy3wIvfOnUS8+hzPzDkK9
	QPQ/oSxOqZY/tIT9VU5WRim8kR6zAKz01Armd+2AK5xdVTbviy/Dr9DVvHmmQs5v6m5ru7NrzVwi4
	DYxIiFHgQJzCIiU9d2gBBZaBv9HDDb1QnfPHTEUNWr4q8R1yu5PCKnKq5aqhxJ4e9vgFhjAUh9esJ
	q/ebhraJzYk8wHrrP8NrKx1WmLSPmLv5UTltsZ/kAWcbsXkMAOHrPfjFYwN+SjLFehL/1wmJs6HVe
	0cRwUgbZj8cVdNseakJMEEiWPJ+mlqUgDTCfaOLlzHCZiMX94y57HpaVz1ktfANIrZ6XJr/Han/r3
	36bhotug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTohi-0003Gh-9K; Mon, 03 Dec 2018 13:56:06 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTohE-0002kb-24
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 13:55:43 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95820168F;
 Mon,  3 Dec 2018 05:55:27 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E42523F614;
 Mon,  3 Dec 2018 05:55:25 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v2 1/2] uaccess: Check no rescheduling function is called
 in unsafe region
Date: Mon,  3 Dec 2018 13:55:17 +0000
Message-Id: <1543845318-24543-2-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1543845318-24543-1-git-send-email-julien.thierry@arm.com>
References: <1543845318-24543-1-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_055536_123945_25B2FD06 
X-CRM114-Status: GOOD (  16.11  )
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
Cc: Julien Thierry <julien.thierry@arm.com>, peterz@infradead.org,
 catalin.marinas@arm.com, will.deacon@arm.com, mingo@redhat.com,
 james.morse@arm.com, hpa@zytor.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

While running a user_access regions, it is not supported to reschedule.
Add an overridable primitive to indicate whether a user_access region is
active and check that this is not the case when calling rescheduling
functions.

Also, add a comment clarifying the behaviour of user_access regions.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
---
 include/linux/kernel.h  |  6 ++++--
 include/linux/uaccess.h | 11 +++++++++++
 kernel/sched/core.c     | 19 +++++++++++++++++++
 3 files changed, 34 insertions(+), 2 deletions(-)

I'm not sure these are the best locations to check this but I was hoping
this patch could start the discussion.

Should I move the check? Should I add a config option to conditionally
build those checks?

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d6aac75..fe0e984 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -237,11 +237,13 @@
 struct pt_regs;
 struct user;

+extern void __might_resched(const char *file, int line);
 #ifdef CONFIG_PREEMPT_VOLUNTARY
 extern int _cond_resched(void);
-# define might_resched() _cond_resched()
+# define might_resched() \
+	do { __might_resched(__FILE__, __LINE__); _cond_resched(); } while (0)
 #else
-# define might_resched() do { } while (0)
+# define might_resched() __might_resched(__FILE__, __LINE__)
 #endif

 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index efe79c1..50adb84 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -266,6 +266,13 @@ static inline unsigned long __copy_from_user_inatomic_nocache(void *to,
 #define probe_kernel_address(addr, retval)		\
 	probe_kernel_read(&retval, addr, sizeof(retval))

+/*
+ * user_access_begin() and user_access_end() define a region where
+ * unsafe user accessors can be used.
+ * During execution of this region, no sleeping functions should be called.
+ * Exceptions and interrupt shall exit the user_access region and re-enter it
+ * when returning to the interrupted context.
+ */
 #ifndef user_access_begin
 #define user_access_begin() do { } while (0)
 #define user_access_end() do { } while (0)
@@ -273,6 +280,10 @@ static inline unsigned long __copy_from_user_inatomic_nocache(void *to,
 #define unsafe_put_user(x, ptr, err) do { if (unlikely(__put_user(x, ptr))) goto err; } while (0)
 #endif

+#ifndef unsafe_user_region_active
+#define unsafe_user_region_active()	false
+#endif
+
 #ifdef CONFIG_HARDENED_USERCOPY
 void usercopy_warn(const char *name, const char *detail, bool to_user,
 		   unsigned long offset, unsigned long len);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6fedf3a..03f53c8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3289,6 +3289,13 @@ static inline void schedule_debug(struct task_struct *prev)
 		__schedule_bug(prev);
 		preempt_count_set(PREEMPT_DISABLED);
 	}
+
+	if (unlikely(unsafe_user_region_active())) {
+		printk(KERN_ERR "BUG: scheduling while user_access enabled: %s/%d/0x%08x\n",
+		       prev->comm, prev->pid, preempt_count());
+		dump_stack();
+	}
+
 	rcu_sleep_check();

 	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
@@ -6151,6 +6158,18 @@ void ___might_sleep(const char *file, int line, int preempt_offset)
 EXPORT_SYMBOL(___might_sleep);
 #endif

+void __might_resched(const char *file, int line)
+{
+	if (!unsafe_user_region_active())
+		return;
+
+	printk(KERN_ERR
+		"BUG: rescheduling function called from user access context at %s:%d\n",
+			file, line);
+	dump_stack();
+}
+EXPORT_SYMBOL(__might_resched);
+
 #ifdef CONFIG_MAGIC_SYSRQ
 void normalize_rt_tasks(void)
 {
--
1.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
