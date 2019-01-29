Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1D9C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:53:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F8F020844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CVJIkGpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8F020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ctJZeN3GZY96m/bq5nhkRJtYwoexveOk4fDFkvqszvw=; b=CVJIkGpK+Bz/CH
	RZQaANVS7qD5i0z7CGBke4wTWKQ9t7DbGmm+ltFERxxlP92VRxHTs+Rq4mHRMlXMVJ2itDa1vp1qk
	zjIyfh/gyprPI5zZ8UvRdENhr4x3UGH5vzRXIUzRn1wRA1exUqxTNlpeXPU+g3mlcyjYJbWdhDwl+
	JaRbaZ9LB9mgOwN5JTN0WddHZvOGSW26WL+cG5hgMq2wRXJ5SyFG578kRDi8pbgt8G+lMCfv999WB
	0BeykQIC6GAVA75kLx/12sHy39TCYzmPsvdR46uHT9q/4CA9HmNc8PHjXleSnh+WHlWVRjwPRHoKr
	vsj771btCqDFBnHoZqgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goYVO-0001C2-O4; Tue, 29 Jan 2019 18:53:06 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goYST-0005qk-Iq
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 18:50:12 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA8C41596;
 Tue, 29 Jan 2019 10:50:04 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48CA03F557;
 Tue, 29 Jan 2019 10:50:02 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v8 09/26] ACPI / APEI: Generalise the estatus queue's notify
 code
Date: Tue, 29 Jan 2019 18:48:45 +0000
Message-Id: <20190129184902.102850-10-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129184902.102850-1-james.morse@arm.com>
References: <20190129184902.102850-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_105005_999833_88FD9BA5 
X-CRM114-Status: GOOD (  14.89  )
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
 Xie XiuQi <xiexiuqi@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, linux-mm@kvack.org,
 Borislav Petkov <bp@alien8.de>, james.morse@arm.com,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Refactor the estatus queue's pool notification routine from
NOTIFY_NMI's handlers. This will allow another notification
method to use the estatus queue without duplicating this code.

Add rcu_read_lock()/rcu_read_unlock() around the list
list_for_each_entry_rcu() walker. These aren't strictly necessary as
the whole nmi_enter/nmi_exit() window is a spooky RCU read-side
critical section.

in_nmi_queue_one_entry() is separate from the rcu-list walker for a
later caller that doesn't need to walk a list.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Punit Agrawal <punit.agrawal@arm.com>
Tested-by: Tyler Baicar <tbaicar@codeaurora.org>

---
Changes since v7:
 * Moved err= onto a separate line to make this more readable
 * Dropped ghes_ prefix on new static functions
 * Renamed stuff, 'notify' has an overloaded meaning,

Changes since v6:
 * Removed pool grow/remove code as this is no longer necessary.

Changes since v3:
 * Removed duplicate or redundant paragraphs in commit message.
 * Fixed the style of a zero check.
Changes since v1:
   * Tidied up _in_nmi_notify_one().
---
 drivers/acpi/apei/ghes.c | 65 ++++++++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index af3c10f47f20..cb3d88de711f 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -912,37 +912,58 @@ static void __process_error(struct ghes *ghes)
 #endif
 }
 
-static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
+static int ghes_in_nmi_queue_one_entry(struct ghes *ghes)
 {
 	u64 buf_paddr;
-	struct ghes *ghes;
-	int sev, ret = NMI_DONE;
+	int sev;
 
-	if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
-		return ret;
+	if (ghes_read_estatus(ghes, &buf_paddr)) {
+		ghes_clear_estatus(ghes, buf_paddr);
+		return -ENOENT;
+	}
 
-	list_for_each_entry_rcu(ghes, &ghes_nmi, list) {
-		if (ghes_read_estatus(ghes, &buf_paddr)) {
-			ghes_clear_estatus(ghes, buf_paddr);
-			continue;
-		} else {
-			ret = NMI_HANDLED;
-		}
+	sev = ghes_severity(ghes->estatus->error_severity);
+	if (sev >= GHES_SEV_PANIC) {
+		ghes_print_queued_estatus();
+		__ghes_panic(ghes, buf_paddr);
+	}
 
-		sev = ghes_severity(ghes->estatus->error_severity);
-		if (sev >= GHES_SEV_PANIC) {
-			ghes_print_queued_estatus();
-			__ghes_panic(ghes, buf_paddr);
-		}
+	__process_error(ghes);
+	ghes_clear_estatus(ghes, buf_paddr);
 
-		__process_error(ghes);
-		ghes_clear_estatus(ghes, buf_paddr);
+	return 0;
+}
+
+static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list)
+{
+	int err, ret = -ENOENT;
+	struct ghes *ghes;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(ghes, rcu_list, list) {
+		err = ghes_in_nmi_queue_one_entry(ghes);
+		if (!err)
+			ret = 0;
 	}
+	rcu_read_unlock();
 
-#ifdef CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG
-	if (ret == NMI_HANDLED)
+	if (IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) && !ret)
 		irq_work_queue(&ghes_proc_irq_work);
-#endif
+
+	return ret;
+}
+
+static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
+{
+	int err, ret = NMI_DONE;
+
+	if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
+		return ret;
+
+	err = ghes_in_nmi_spool_from_list(&ghes_nmi);
+	if (!err)
+		ret = NMI_HANDLED;
+
 	atomic_dec(&ghes_in_nmi);
 	return ret;
 }
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
