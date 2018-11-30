Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13A2C64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:34:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5DFC2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ElEaL7CM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5DFC2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=5JBObvbKp3lOzywdEbLa8bwZZjP1vRIP00Cbzy2WJNA=; b=ElEaL7CMjYtpUFJU+6kzIC97WT
	vzTPIgjpMXjgxIMw5jekJFGOhYLM5kcowJ8oD6pHcxNCKxTID67KgcLcEzMBQx6skeoa6ksLfDvPR
	qtIrBdxhXG0eMyvPCHUwWTsyWAV6ncfrRpWVkYBwnfJIJghbVHpxWLT5mLhsOkCZ/r7NnDsFnCNNU
	dRrTYj/M7L62eVjsLsv6KN071ed9Lh5mbFoK0EA+JDIEiy2IWGXhlCnnCACEHkQz78IyVDVHRzc3A
	E/a8WPMywHE5VlGC2GR1noz/ZC//MzrvuZ1T2LCykp6n3fkYq+7T6pmm2p8lwgeijCDvyw0Flecub
	MvfhTmFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSmgP-00088F-TN; Fri, 30 Nov 2018 17:34:29 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSmgL-00087I-H1
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 17:34:26 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4C8B1596;
 Fri, 30 Nov 2018 09:34:13 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B50883F73C;
 Fri, 30 Nov 2018 09:34:13 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 846C21AE0808; Fri, 30 Nov 2018 17:34:32 +0000 (GMT)
From: Will Deacon <will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] preempt: Move PREEMPT_NEED_RESCHED definition into
 arch code
Date: Fri, 30 Nov 2018 17:34:30 +0000
Message-Id: <1543599271-14339-2-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1543599271-14339-1-git-send-email-will.deacon@arm.com>
References: <1543599271-14339-1-git-send-email-will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_093425_573214_6D91C373 
X-CRM114-Status: GOOD (  13.06  )
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
Cc: ard.biesheuvel@linaro.org, peterz@infradead.org, catalin.marinas@arm.com,
 rml@tech9.net, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 schwidefsky@de.ibm.com, tglx@linutronix.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

PREEMPT_NEED_RESCHED is never used directly, so move it into the arch
code where it can potentially be implemented using either a different
bit in the preempt count or as an entirely separate entity.

Cc: Robert Love <rml@tech9.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/s390/include/asm/preempt.h | 2 ++
 arch/x86/include/asm/preempt.h  | 3 +++
 include/linux/preempt.h         | 3 ---
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/preempt.h b/arch/s390/include/asm/preempt.h
index 23a14d187fb1..b5ea9e14c017 100644
--- a/arch/s390/include/asm/preempt.h
+++ b/arch/s390/include/asm/preempt.h
@@ -8,6 +8,8 @@
 
 #ifdef CONFIG_HAVE_MARCH_Z196_FEATURES
 
+/* We use the MSB mostly because its available */
+#define PREEMPT_NEED_RESCHED	0x80000000
 #define PREEMPT_ENABLED	(0 + PREEMPT_NEED_RESCHED)
 
 static inline int preempt_count(void)
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 90cb2f36c042..99a7fa9ab0a3 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -8,6 +8,9 @@
 
 DECLARE_PER_CPU(int, __preempt_count);
 
+/* We use the MSB mostly because its available */
+#define PREEMPT_NEED_RESCHED	0x80000000
+
 /*
  * We use the PREEMPT_NEED_RESCHED bit as an inverted NEED_RESCHED such
  * that a decrement hitting 0 means we can and should reschedule.
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index c01813c3fbe9..dd92b1a93919 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -53,9 +53,6 @@
 
 #define SOFTIRQ_DISABLE_OFFSET	(2 * SOFTIRQ_OFFSET)
 
-/* We use the MSB mostly because its available */
-#define PREEMPT_NEED_RESCHED	0x80000000
-
 #define PREEMPT_DISABLED	(PREEMPT_DISABLE_OFFSET + PREEMPT_ENABLED)
 
 /*
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
