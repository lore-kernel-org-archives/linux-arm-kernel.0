Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF7DC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:52:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 744C320844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iZCBBW7i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 744C320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2/FpSWZXuTu9OOhVc2SmRgAmcsXK16ed+6ziVLnAxyQ=; b=iZCBBW7i9pl41v
	yprJ8SfA5+t9c2np5OPwCr44KSiLzjzH4Uwx+DhPwwPWXSWUvnwXhyVxcRwnpQFYRyvsiwQiRash1
	X7LHZPOhw3e0fg3l2CV8SgVm5sVXp72PSdjCCxMbQzjEvlEWnOPIedQ9siILl+M7c9VyVBRfmFc/n
	5/USIVoGEGgpWpRbAKsfP/NW+/sFwxzfmfC52FiqXNCQN4amvOlgwK1Srp4VYVv/s/GLKv8Eplttp
	PlJZMh+O/knH7+RPh2gpaeNFYBiFKrosQgOf5mPjQo3pz/Bghve6bKKbOW8N6ob52ltKvcP6M/QWB
	bOJM+KlZ1ykjh6axpFDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goYV1-0000mz-GD; Tue, 29 Jan 2019 18:52:43 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goYSc-0006Hp-Gg
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 18:50:27 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADFF21596;
 Tue, 29 Jan 2019 10:50:13 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D7D83F557;
 Tue, 29 Jan 2019 10:50:10 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v8 12/26] ACPI / APEI: Switch NOTIFY_SEA to use the estatus
 queue
Date: Tue, 29 Jan 2019 18:48:48 +0000
Message-Id: <20190129184902.102850-13-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129184902.102850-1-james.morse@arm.com>
References: <20190129184902.102850-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_105015_068775_187CE9D9 
X-CRM114-Status: GOOD (  18.49  )
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

Now that the estatus queue can be used by more than one notification
method, we can move notifications that have NMI-like behaviour over.

Switch NOTIFY_SEA over to use the estatus queue. This makes it behave
in the same way as x86's NOTIFY_NMI.

Remove Kconfig's ability to turn ACPI_APEI_SEA off if ACPI_APEI_GHES
is selected. This roughly matches the x86 NOTIFY_NMI behaviour, and means
each architecture has at least one user of the estatus-queue, meaning it
doesn't need guarding with ifdef.

Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v6:
 * Lost all the pool grow/shrink stuff,
 * Changed Kconfig so this can't be turned off to avoid kconfig complexity:
 * Dropped Tyler's tested-by.
 * For now we need #ifdef around the SEA code as the arch code assumes its there.
 * Removed Punit's reviewed-by due to the swirling #ifdeffery
---
 drivers/acpi/apei/Kconfig | 12 +-----------
 drivers/acpi/apei/ghes.c  | 22 +++++-----------------
 2 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 52ae5438edeb..6b18f8bc7be3 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -41,19 +41,9 @@ config ACPI_APEI_PCIEAER
 	  Turn on this option to enable the corresponding support.
 
 config ACPI_APEI_SEA
-	bool "APEI Synchronous External Abort logging/recovering support"
+	bool
 	depends on ARM64 && ACPI_APEI_GHES
 	default y
-	help
-	  This option should be enabled if the system supports
-	  firmware first handling of SEA (Synchronous External Abort).
-	  SEA happens with certain faults of data abort or instruction
-	  abort synchronous exceptions on ARMv8 systems. If a system
-	  supports firmware first handling of SEA, the platform analyzes
-	  and handles hardware error notifications from SEA, and it may then
-	  form a HW error record for the OS to parse and handle. This
-	  option allows the OS to look for such hardware error record, and
-	  take appropriate action.
 
 config ACPI_APEI_MEMORY_FAILURE
 	bool "APEI memory error recovering support"
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 576dce29159d..ab794ab29554 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -767,7 +767,6 @@ static struct notifier_block ghes_notifier_hed = {
 	.notifier_call = ghes_notify_hed,
 };
 
-#ifdef CONFIG_HAVE_ACPI_APEI_NMI
 /*
  * Handlers for CPER records may not be NMI safe. For example,
  * memory_failure_queue() takes spinlocks and calls schedule_work_on().
@@ -904,7 +903,6 @@ static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list)
 
 	return ret;
 }
-#endif /* CONFIG_HAVE_ACPI_APEI_NMI */
 
 #ifdef CONFIG_ACPI_APEI_SEA
 static LIST_HEAD(ghes_sea);
@@ -915,16 +913,7 @@ static LIST_HEAD(ghes_sea);
  */
 int ghes_notify_sea(void)
 {
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
+	return ghes_in_nmi_spool_from_list(&ghes_sea);
 }
 
 static void ghes_sea_add(struct ghes *ghes)
@@ -992,16 +981,15 @@ static void ghes_nmi_remove(struct ghes *ghes)
 	 */
 	synchronize_rcu();
 }
+#else /* CONFIG_HAVE_ACPI_APEI_NMI */
+static inline void ghes_nmi_add(struct ghes *ghes) { }
+static inline void ghes_nmi_remove(struct ghes *ghes) { }
+#endif /* CONFIG_HAVE_ACPI_APEI_NMI */
 
 static void ghes_nmi_init_cxt(void)
 {
 	init_irq_work(&ghes_proc_irq_work, ghes_proc_in_irq);
 }
-#else /* CONFIG_HAVE_ACPI_APEI_NMI */
-static inline void ghes_nmi_add(struct ghes *ghes) { }
-static inline void ghes_nmi_remove(struct ghes *ghes) { }
-static inline void ghes_nmi_init_cxt(void) { }
-#endif /* CONFIG_HAVE_ACPI_APEI_NMI */
 
 static int ghes_probe(struct platform_device *ghes_dev)
 {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
