Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43156C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:28:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13F5620838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QwxgxON6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F5620838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=26iPzxoJC9eqt3g43t/xQ7QX2/ftKND8PGSqfSLhDm8=; b=QwxgxON6ZSC8V4
	K9V/clRqasXxcEscIx5FyYmm9pwt6/91VXdHyDHKMkT4Ls8gvozjg9Ohp+alLxfIZTWUSG2ElWxsG
	pj1XJVO7pHuF7+AskT6hkHXNFQwPawNV3Pl4gh4XsZ8jrsfuTkJGKG7mQ9Mbt6k+uKzzdXYo0fdHc
	heDYMhLBJJgJKrJ82l1xwbToKRv010VfoWvHhMwizasYCo1IY1hKZFr2qdG8BhGjUsuixK3J7KMU5
	tTlM0fbGoKDR+IIk7ySN9wrhemV0b752AXxeE3ap4ROMK9J6UyJpzfsaqCPYJe4JNtMQVEAYIgcge
	Z2EQC0+04f4iu8ut/4Lg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVDN9-0003Sl-Gb; Fri, 07 Dec 2018 10:28:39 +0000
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVDMt-00033Q-2J
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 10:28:29 +0000
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
 by Galois.linutronix.de with esmtp (Exim 4.80)
 (envelope-from <bigeasy@linutronix.de>)
 id 1gVDMg-00054t-Dy; Fri, 07 Dec 2018 11:28:10 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/3] arm: use a raw_spinlock_t in unwind
Date: Fri,  7 Dec 2018 11:27:49 +0100
Message-Id: <20181207102749.15205-4-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.0.rc2
In-Reply-To: <20181207102749.15205-1-bigeasy@linutronix.de>
References: <20181207102749.15205-1-bigeasy@linutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_022823_756501_398077F1 
X-CRM114-Status: UNSURE (   9.45  )
X-CRM114-Notice: Please train this message.
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
Cc: tglx@linutronix.de, Russell King <linux@armlinux.org.uk>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Mostly unwind is done with irqs enabled however SLUB may call it with
irqs disabled while creating a new SLUB cache.

I had system freeze while loading a module which called
kmem_cache_create() on init. That means SLUB's __slab_alloc() disabled
interrupts and then

->new_slab_objects()
 ->new_slab()
  ->setup_object()
   ->setup_object_debug()
    ->init_tracking()
     ->set_track()
      ->save_stack_trace()
       ->save_stack_trace_tsk()
        ->walk_stackframe()
         ->unwind_frame()
          ->unwind_find_idx()
           =>spin_lock_irqsave(&unwind_lock);

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/kernel/unwind.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index 0bee233fef9a3..314cfb232a635 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -93,7 +93,7 @@ extern const struct unwind_idx __start_unwind_idx[];
 static const struct unwind_idx *__origin_unwind_idx;
 extern const struct unwind_idx __stop_unwind_idx[];
 
-static DEFINE_SPINLOCK(unwind_lock);
+static DEFINE_RAW_SPINLOCK(unwind_lock);
 static LIST_HEAD(unwind_tables);
 
 /* Convert a prel31 symbol to an absolute address */
@@ -201,7 +201,7 @@ static const struct unwind_idx *unwind_find_idx(unsigned long addr)
 		/* module unwind tables */
 		struct unwind_table *table;
 
-		spin_lock_irqsave(&unwind_lock, flags);
+		raw_spin_lock_irqsave(&unwind_lock, flags);
 		list_for_each_entry(table, &unwind_tables, list) {
 			if (addr >= table->begin_addr &&
 			    addr < table->end_addr) {
@@ -213,7 +213,7 @@ static const struct unwind_idx *unwind_find_idx(unsigned long addr)
 				break;
 			}
 		}
-		spin_unlock_irqrestore(&unwind_lock, flags);
+		raw_spin_unlock_irqrestore(&unwind_lock, flags);
 	}
 
 	pr_debug("%s: idx = %p\n", __func__, idx);
@@ -529,9 +529,9 @@ struct unwind_table *unwind_table_add(unsigned long start, unsigned long size,
 	tab->begin_addr = text_addr;
 	tab->end_addr = text_addr + text_size;
 
-	spin_lock_irqsave(&unwind_lock, flags);
+	raw_spin_lock_irqsave(&unwind_lock, flags);
 	list_add_tail(&tab->list, &unwind_tables);
-	spin_unlock_irqrestore(&unwind_lock, flags);
+	raw_spin_unlock_irqrestore(&unwind_lock, flags);
 
 	return tab;
 }
@@ -543,9 +543,9 @@ void unwind_table_del(struct unwind_table *tab)
 	if (!tab)
 		return;
 
-	spin_lock_irqsave(&unwind_lock, flags);
+	raw_spin_lock_irqsave(&unwind_lock, flags);
 	list_del(&tab->list);
-	spin_unlock_irqrestore(&unwind_lock, flags);
+	raw_spin_unlock_irqrestore(&unwind_lock, flags);
 
 	kfree(tab);
 }
-- 
2.20.0.rc2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
