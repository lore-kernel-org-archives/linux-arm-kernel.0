Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74D2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:05:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73D7B222D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PhWCOibp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D7B222D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=IBLn3lJAESsH6JXnBkh+iM2rF9bqrjOJjGs86fetqfU=; b=PhWCOibpwgu0yK
	TzydGIFbEoBy3hTzgZyVVoCz5ssyw+66D67C42zM3PwWcAukHDcmolbt0k0YEWyQSqNZG93MbWH0K
	hXdLubb0v53w2FPucT+LFRqsGPwfdq/K5XRzlrtaJprVcqmk4dSSNb5/4OIS0RF2IeRoqT9UDZ7f1
	3M2/XRtyYYQKkzHeIbKqykG4ltv8Lu52hE6TfMEcekce5wvXKWbS8ELsxxDs6bOyXdAZVQCzE8wjQ
	6NIo10+lOMHA969JqkfeabEVHg3dlvBWF0Zq2es/Qw2ZpzRmnSMzcXPkG9c8/YwNi2yybONRRhHJj
	2xXscCK+TR9qX1q9iJmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gujk1-0003e3-Eh; Fri, 15 Feb 2019 20:05:45 +0000
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gujjy-0003dL-Cv
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 20:05:44 +0000
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
 (envelope-from <bigeasy@linutronix.de>)
 id 1gujjp-0001cd-Ed; Fri, 15 Feb 2019 21:05:33 +0100
Date: Fri, 15 Feb 2019 21:05:33 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH] ARM: enable irq in translation/section permission fault
 handlers
Message-ID: <20190215200533.ypfrdekg7j4ucu6a@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_120542_582801_B30E576B 
X-CRM114-Status: GOOD (  12.66  )
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
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Bernd Edlinger <bernd.edlinger@hotmail.de>,
 Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 yadi.hu@windriver.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: "Yadi.hu" <yadi.hu@windriver.com>

Accessing a kernel address in user space causes a SIGSEGV which is sent
via
-> do_DataAbort
   -> do_sect_fault || do_translation_fault
      -> do_bad_area
         -> __do_user_fault
            -> force_sig_fault
Since commit

  02fe2845d6a83 ("ARM: entry: avoid enabling interrupts in prefetch/data abort handlers")

that path is carried out with disabled interrupts. Page/alignment fault
do enable interrupts but data abort has been left out.

On -RT the siglock is a sleeping spinlock and requires interrupts to be
enabled in order to acquire it.

Enable interrupts in the DataAbort handler if the parent context had
interrupts enabled. Move harden_branch_predictor() before interrupts are
enabled.

Reported-by: <Bernd Edlinger <bernd.edlinger@hotmail.de>
Signed-off-by: Yadi.hu <yadi.hu@windriver.com>
[bigeasy: rewrote patch description, reordered patch]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
I though that the "interrupt enable part" has already been posted and
then Bernd complained about a warning from harden_branch_predictor() on
-RT so here it is.

 arch/arm/mm/fault.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 58f69fa07df95..da82967865836 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -161,8 +161,6 @@ __do_user_fault(struct task_struct *tsk, unsigned long addr,
 		unsigned int fsr, unsigned int sig, int code,
 		struct pt_regs *regs)
 {
-	if (addr > TASK_SIZE)
-		harden_branch_predictor();
 
 #ifdef CONFIG_DEBUG_USER
 	if (((user_debug & UDBG_SEGV) && (sig == SIGSEGV)) ||
@@ -191,6 +189,11 @@ void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	struct task_struct *tsk = current;
 	struct mm_struct *mm = tsk->active_mm;
 
+	if (addr > TASK_SIZE && user_mode(regs))
+		harden_branch_predictor();
+
+	if (interrupts_enabled(regs))
+		local_irq_enable();
 	/*
 	 * If we are in kernel mode at this point, we
 	 * have no context to handle this fault with.
-- 
2.20.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
