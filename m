Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A021EC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:28:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63CD220838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gUe1HyWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63CD220838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jSvoPtwvm+YeX3BEYlINNFdf8FgDRzLaEB1y3KA26ZY=; b=gUe1HyWPOryqoK
	z96apV1VFpdtDsj4CDTK6+P1Kl8aRdPnzfjXLOs6d71VAFFEDq5519SvRLBK/vw+SUM4yqB3/FrVS
	w2IWwJQmBW2sn/E4nKVYhaO43LLfJ2m81HL98TQPSiTe7EUl9K1HgVOQi8T4EG2QYBAY8SWJg05Mv
	/PlQx9Y80RsbPiJGtHzfUrZJeYG7CWcfryIIBXW/ww9iai+mRkDyExJTbNT0RDM7qaBEnv9i5g8g8
	cRM4gAl2z2lnuWPszr5ojlJDE/PsZEvYDwET6CZZntpJIK3iTwoRhNixmA65PTzDcO7Ng4UPr3QDR
	CaaTqOnmEse5w4ZKChiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVDMw-0003D6-IM; Fri, 07 Dec 2018 10:28:26 +0000
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVDMk-00033E-Tg
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 10:28:16 +0000
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
 by Galois.linutronix.de with esmtp (Exim 4.80)
 (envelope-from <bigeasy@linutronix.de>)
 id 1gVDMe-00054t-BQ; Fri, 07 Dec 2018 11:28:08 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/3] arm: kprobe: make patch_lock a raw_spinlock_t
Date: Fri,  7 Dec 2018 11:27:48 +0100
Message-Id: <20181207102749.15205-3-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.0.rc2
In-Reply-To: <20181207102749.15205-1-bigeasy@linutronix.de>
References: <20181207102749.15205-1-bigeasy@linutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_022815_095031_DE753AF6 
X-CRM114-Status: GOOD (  10.31  )
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
Cc: Yang Shi <yang.shi@linaro.org>, tglx@linutronix.de,
 Russell King <linux@armlinux.org.uk>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Yang Shi <yang.shi@linaro.org>

When running kprobe on -rt kernel, the below bug is caught:

|BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:931
|in_atomic(): 1, irqs_disabled(): 128, pid: 14, name: migration/0
|Preemption disabled at:[<802f2b98>] cpu_stopper_thread+0xc0/0x140
|CPU: 0 PID: 14 Comm: migration/0 Tainted: G O 4.8.3-rt2 #1
|Hardware name: Freescale LS1021A
|[<8025a43c>] (___might_sleep)
|[<80b5b324>] (rt_spin_lock)
|[<80b5c31c>] (__patch_text_real)
|[<80b5c3ac>] (patch_text_stop_machine)
|[<802f2920>] (multi_cpu_stop)

Since patch_text_stop_machine() is called in stop_machine() which
disables IRQ, sleepable lock should be not used in this atomic context,
 so replace patch_lock to raw lock.

Signed-off-by: Yang Shi <yang.shi@linaro.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/kernel/patch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/patch.c b/arch/arm/kernel/patch.c
index a50dc00d79a27..d0a05a3bdb965 100644
--- a/arch/arm/kernel/patch.c
+++ b/arch/arm/kernel/patch.c
@@ -16,7 +16,7 @@ struct patch {
 	unsigned int insn;
 };
 
-static DEFINE_SPINLOCK(patch_lock);
+static DEFINE_RAW_SPINLOCK(patch_lock);
 
 static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
 	__acquires(&patch_lock)
@@ -33,7 +33,7 @@ static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
 		return addr;
 
 	if (flags)
-		spin_lock_irqsave(&patch_lock, *flags);
+		raw_spin_lock_irqsave(&patch_lock, *flags);
 	else
 		__acquire(&patch_lock);
 
@@ -48,7 +48,7 @@ static void __kprobes patch_unmap(int fixmap, unsigned long *flags)
 	clear_fixmap(fixmap);
 
 	if (flags)
-		spin_unlock_irqrestore(&patch_lock, *flags);
+		raw_spin_unlock_irqrestore(&patch_lock, *flags);
 	else
 		__release(&patch_lock);
 }
-- 
2.20.0.rc2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
