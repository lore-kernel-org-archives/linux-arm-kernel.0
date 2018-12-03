Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FECC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:09:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6601820850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aHIRfFgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6601820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jEp/NXC59fZPpCLYaffPfZeMsAJlYpfbdTp1oyCJZrk=; b=aHIRfFgfvOjLbT
	dS8JZ1ZZhxYN7466yoSFJHJm3mgGgYXhGhKWcTbDVMKIn1eGgIqdTW6d+yh3MoBb4k4N1SZaes6Z1
	v+UVV5TZMmHCuNceWlB0benLUEJSAkbYE7VDnj4mR+HHKJ1XVaKKUuccwHbgbEeHQQwk6bhjTUCDQ
	B6Txy02qVeZ+e+r2XWk/6t8Y+y7qCGyjGpnyxQ6rUX0y24a9uzZduCW1f3Iq9VF3vv74BZsN/YrOA
	AwJdFzro+3ZyLQYQJe3lERYTs2fSLqGTwcBcaEg+4TrYCroS84ul9Hv+r2zGZ5d2VmYSU29vgUYIt
	2Ke/9VGKSORqfMrU2llQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTsf1-0007yK-VM; Mon, 03 Dec 2018 18:09:36 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTsco-0005NU-Ie
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:07:55 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09ED2174E;
 Mon,  3 Dec 2018 10:07:16 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 396EB3F719;
 Mon,  3 Dec 2018 10:07:13 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v7 11/25] ACPI / APEI: Move NOTIFY_SEA between the
 estatus-queue and NOTIFY_NMI
Date: Mon,  3 Dec 2018 18:05:59 +0000
Message-Id: <20181203180613.228133-12-james.morse@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181203180613.228133-1-james.morse@arm.com>
References: <20181203180613.228133-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_100719_988770_FC49ADE8 
X-CRM114-Status: GOOD (  18.70  )
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
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>,
 Fan Wu <wufan@codeaurora.org>, Xie XiuQi <xiexiuqi@huawei.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, linux-mm@kvack.org,
 Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The estatus-queue code is currently hidden by the NOTIFY_NMI #ifdefs.
Once NOTIFY_SEA starts using the estatus-queue we can stop hiding
it as each architecture has a user that can't be turned off.

Split the existing CONFIG_HAVE_ACPI_APEI_NMI block in two, and move
the SEA code into the gap.

This patch moves code around ... and changes the stale comment
describing why the status queue is necessary: printk() is no
longer the issue, its the helpers like memory_failure_queue() that
aren't nmi safe.

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/acpi/apei/ghes.c | 113 ++++++++++++++++++++-------------------
 1 file changed, 59 insertions(+), 54 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 15d94373ba72..00fe4785e469 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -765,66 +765,21 @@ static struct notifier_block ghes_notifier_hed = {
 	.notifier_call = ghes_notify_hed,
 };
 
-#ifdef CONFIG_ACPI_APEI_SEA
-static LIST_HEAD(ghes_sea);
-
-/*
- * Return 0 only if one of the SEA error sources successfully reported an error
- * record sent from the firmware.
- */
-int ghes_notify_sea(void)
-{
-	struct ghes *ghes;
-	int ret = -ENOENT;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(ghes, &ghes_sea, list) {
-		if (!ghes_proc(ghes))
-			ret = 0;
-	}
-	rcu_read_unlock();
-	return ret;
-}
-
-static void ghes_sea_add(struct ghes *ghes)
-{
-	mutex_lock(&ghes_list_mutex);
-	list_add_rcu(&ghes->list, &ghes_sea);
-	mutex_unlock(&ghes_list_mutex);
-}
-
-static void ghes_sea_remove(struct ghes *ghes)
-{
-	mutex_lock(&ghes_list_mutex);
-	list_del_rcu(&ghes->list);
-	mutex_unlock(&ghes_list_mutex);
-	synchronize_rcu();
-}
-#else /* CONFIG_ACPI_APEI_SEA */
-static inline void ghes_sea_add(struct ghes *ghes) { }
-static inline void ghes_sea_remove(struct ghes *ghes) { }
-#endif /* CONFIG_ACPI_APEI_SEA */
-
 #ifdef CONFIG_HAVE_ACPI_APEI_NMI
 /*
- * printk is not safe in NMI context.  So in NMI handler, we allocate
- * required memory from lock-less memory allocator
- * (ghes_estatus_pool), save estatus into it, put them into lock-less
- * list (ghes_estatus_llist), then delay printk into IRQ context via
- * irq_work (ghes_proc_irq_work).  ghes_estatus_size_request record
- * required pool size by all NMI error source.
+ * Handlers for CPER records may not be NMI safe. For example,
+ * memory_failure_queue() takes spinlocks and calls schedule_work_on().
+ * In any NMI-like handler, memory from ghes_estatus_pool is used to save
+ * estatus, and added to the ghes_estatus_llist. irq_work_queue() causes
+ * ghes_proc_in_irq() to run in IRQ context where each estatus in
+ * ghes_estatus_llist is processed.
+ *
+ * Memory from the ghes_estatus_pool is also used with the ghes_estatus_cache
+ * to suppress frequent messages.
  */
 static struct llist_head ghes_estatus_llist;
 static struct irq_work ghes_proc_irq_work;
 
-/*
- * NMI may be triggered on any CPU, so ghes_in_nmi is used for
- * having only one concurrent reader.
- */
-static atomic_t ghes_in_nmi = ATOMIC_INIT(0);
-
-static LIST_HEAD(ghes_nmi);
-
 static void ghes_proc_in_irq(struct irq_work *irq_work)
 {
 	struct llist_node *llnode, *next;
@@ -950,6 +905,56 @@ static int ghes_estatus_queue_notified(struct list_head *rcu_list)
 
 	return ret;
 }
+#endif /* CONFIG_HAVE_ACPI_APEI_NMI */
+
+#ifdef CONFIG_ACPI_APEI_SEA
+static LIST_HEAD(ghes_sea);
+
+/*
+ * Return 0 only if one of the SEA error sources successfully reported an error
+ * record sent from the firmware.
+ */
+int ghes_notify_sea(void)
+{
+	struct ghes *ghes;
+	int ret = -ENOENT;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(ghes, &ghes_sea, list) {
+		if (!ghes_proc(ghes))
+			ret = 0;
+	}
+	rcu_read_unlock();
+	return ret;
+}
+
+static void ghes_sea_add(struct ghes *ghes)
+{
+	mutex_lock(&ghes_list_mutex);
+	list_add_rcu(&ghes->list, &ghes_sea);
+	mutex_unlock(&ghes_list_mutex);
+}
+
+static void ghes_sea_remove(struct ghes *ghes)
+{
+	mutex_lock(&ghes_list_mutex);
+	list_del_rcu(&ghes->list);
+	mutex_unlock(&ghes_list_mutex);
+	synchronize_rcu();
+}
+#else /* CONFIG_ACPI_APEI_SEA */
+static inline void ghes_sea_add(struct ghes *ghes) { }
+static inline void ghes_sea_remove(struct ghes *ghes) { }
+#endif /* CONFIG_ACPI_APEI_SEA */
+
+#ifdef CONFIG_HAVE_ACPI_APEI_NMI
+/*
+ * NMI may be triggered on any CPU, so ghes_in_nmi is used for
+ * having only one concurrent reader.
+ */
+static atomic_t ghes_in_nmi = ATOMIC_INIT(0);
+
+static LIST_HEAD(ghes_nmi);
 
 static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 {
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
