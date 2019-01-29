Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE269C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:11:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9F382147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VWhF6FuV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F382147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=3n2PgEizJeTl/710Gt+Mfz4qiqRdoXp2vd7KqA9f8n0=; b=VWhF6FuVoOYlfg
	VToJcnkp3BgejAxhdQ3g7mAZtTIFZ5ShpgEeNJbILz2IkIPvR9mGnKthAnHDnw6fxS0Q4CjGQjnEc
	kcieUxVyokTgwIL/L3iJlvM73iZ9DmlVMXQvr7mI2M6pQtoVwCSKZbjcntJMVKr8TQws/4YHMaOOX
	UiXhMvzCifWkCo7Kvxkj/pI26RBjNkULugue3ECp4Kzao9aR9b4rv42tRqxmDBqjjtMzb31EBj0zi
	HC8af0V6RZjFumxu+E5oGZE4P42lwFx+nPi2r7O/CWwnOGWZSlZRsX5zC0VM3jIZKKCjgvajOjNfu
	mRYVMslkbJ8p9rpfyLwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goTAa-0006Jh-0p; Tue, 29 Jan 2019 13:11:16 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goTAI-000646-Ji
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 13:11:03 +0000
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 493922D077169EA4E213;
 Tue, 29 Jan 2019 21:10:54 +0800 (CST)
Received: from euler.huawei.com (10.175.104.193) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Tue, 29 Jan 2019 21:10:46 +0800
From: Wei Li <liwei391@huawei.com>
To: <julien.thierry@arm.com>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] arm64: fix potential deadlock in
 arm64-provide-pseudo-NMI-with-GICv3
Date: Tue, 29 Jan 2019 21:12:23 +0800
Message-ID: <20190129131223.32505-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.175.104.193]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_051059_246951_93124C97 
X-CRM114-Status: GOOD (  10.91  )
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
Cc: mark.rutland@arm.com, daniel.thompson@linaro.org, jason@lakedaemon.net,
 marc.zyngier@arm.com, catalin.marinas@arm.com, thunder.leizhen@huawei.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, huawei.libin@huawei.com,
 guohanjun@huawei.com, dave.martin@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In some exception handlers, the interrupt is not reenabled by daifclr at first.
The later process may call local_irq_enable() to enable the interrupt, like
gic_handle_irq(). As we known, function local_irq_enable() just change the pmr now.
The following codes what i found may cause a deadlock or some issues else:

do_sp_pc_abort			<- el0_sp_pc
do_el0_ia_bp_hardening	<- el0_ia
kgdb_roundup_cpus		<- el1_dbg

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 arch/arm64/kernel/kgdb.c | 4 ++++
 arch/arm64/mm/fault.c    | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index a20de58061a8..119fbf2c0788 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -25,6 +25,7 @@
 #include <linux/kgdb.h>
 #include <linux/kprobes.h>
 #include <linux/sched/task_stack.h>
+#include <linux/irqchip/arm-gic-v3.h>
 
 #include <asm/debug-monitors.h>
 #include <asm/insn.h>
@@ -291,6 +292,9 @@ static void kgdb_call_nmi_hook(void *ignored)
 
 void kgdb_roundup_cpus(unsigned long flags)
 {
+	if (gic_prio_masking_enabled())
+		gic_arch_enable_irqs();
+
 	local_irq_enable();
 	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
 	local_irq_disable();
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 97ba2ba78aee..f7c39a0b28bc 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -32,6 +32,7 @@
 #include <linux/perf_event.h>
 #include <linux/preempt.h>
 #include <linux/hugetlb.h>
+#include <linux/irqchip/arm-gic-v3.h>
 
 #include <asm/bug.h>
 #include <asm/cmpxchg.h>
@@ -780,6 +781,8 @@ asmlinkage void __exception do_el0_ia_bp_hardening(unsigned long addr,
 	if (addr > TASK_SIZE)
 		arm64_apply_bp_hardening();
 
+	if (gic_prio_masking_enabled())
+		gic_arch_enable_irqs();
 	local_irq_enable();
 	do_mem_abort(addr, esr, regs);
 }
@@ -794,6 +797,9 @@ asmlinkage void __exception do_sp_pc_abort(unsigned long addr,
 	if (user_mode(regs)) {
 		if (instruction_pointer(regs) > TASK_SIZE)
 			arm64_apply_bp_hardening();
+
+		if (gic_prio_masking_enabled())
+			gic_arch_enable_irqs();
 		local_irq_enable();
 	}
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
