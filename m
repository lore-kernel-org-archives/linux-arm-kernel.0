Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC322C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:53:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABCA02133D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cvnZCmSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABCA02133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=bAKnUe+9smhQclpSErIPpWtO9ihv8Sb+9aTPvP6NqY4=; b=cvn
	ZCmSjyJ4uYGCYVVIRd4YQbD3QvjMoMT6Fu4ZJ6qo/LoM0VH/uXWkUYqLTlJkQgphNK200S8JnV3/2
	stHoom6z1VLf0Fq4PQ9eI1C2f7+H1rtA87NVSvyl/WRaVyITnZ0TFvxy7KumF4AEEdWiVE4Z0GibV
	mMg+hLbN7CmJ7Chw7lb9D1qTmn27E19sZ2jesDA9tAfQVb7EEkJe41ru1U12OD57wIoWrf21Cee2Q
	ZCg8gIk3w2a/QwmbUOgZpYMUhrcnuZmJQx+r2UYcSQoHvb6rr+FxnFLmrhmFsACT4HzKZDfdVa1/e
	1bYcLLrHggfjzYUmJa9ynI3TuuPWuEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj3c3-0007Cu-7c; Mon, 14 Jan 2019 14:53:15 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj3by-0007CR-T1
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 14:53:13 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B7F480D;
 Mon, 14 Jan 2019 06:53:08 -0800 (PST)
Received: from login2.euhpc.arm.com (login2.euhpc.arm.com [10.6.27.34])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3F2323F70D;
 Mon, 14 Jan 2019 06:53:07 -0800 (PST)
From: Vladimir Murzin <vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH] ARM: NOMMU: Toggle only bits in EXC_RETURN we are
 really care of
Date: Mon, 14 Jan 2019 14:52:45 +0000
Message-Id: <1547477565-3327-1-git-send-email-vladimir.murzin@arm.com>
X-Mailer: git-send-email 2.0.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_065310_942720_6564422D 
X-CRM114-Status: GOOD (  12.24  )
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
Cc: kbuild-all@01.org, alexandre.torgue@st.com, sza@esh.hu
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

ARMv8M introduces support for Security extension to M class, among
other things it affects exception handling, especially, encoding of
EXC_RETURN.

The new bits have been added:

Bit [6]	Secure or Non-secure stack
Bit [5]	Default callee register stacking
Bit [0]	Exception Secure

which conflicts with hard-coded value of EXC_RETURN:

In fact, we only care of few bits:

Bit [3]	 Mode (0 - Handler, 1 - Thread)
Bit [2]	 Stack pointer selection (0 - Main, 1 - Process)

We can toggle only those bits and left other bits as they were on
exception entry.

It is basically, what patch does - saves EXC_RETURN when we do
transition form Thread to Handler mode (it is first svc), so later
saved value is used instead of EXC_RET_THREADMODE_PROCESSSTACK.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---

Kernel Version: v5.0-rc2

 arch/arm/include/asm/v7m.h     | 2 +-
 arch/arm/kernel/entry-header.S | 3 ++-
 arch/arm/kernel/entry-v7m.S    | 4 ++++
 arch/arm/mm/proc-v7m.S         | 3 +++
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/v7m.h b/arch/arm/include/asm/v7m.h
index 187ccf6..2cb00d1 100644
--- a/arch/arm/include/asm/v7m.h
+++ b/arch/arm/include/asm/v7m.h
@@ -49,7 +49,7 @@
  * (0 -> msp; 1 -> psp). Bits [1:0] are fixed to 0b01.
  */
 #define EXC_RET_STACK_MASK			0x00000004
-#define EXC_RET_THREADMODE_PROCESSSTACK		0xfffffffd
+#define EXC_RET_THREADMODE_PROCESSSTACK		(3 << 2)
 
 /* Cache related definitions */
 
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 7734248..62db1c9 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -127,7 +127,8 @@
          */
 	.macro	v7m_exception_slow_exit ret_r0
 	cpsid	i
-	ldr	lr, =EXC_RET_THREADMODE_PROCESSSTACK
+	ldr	lr, =exc_ret
+	ldr	lr, [lr]
 
 	@ read original r12, sp, lr, pc and xPSR
 	add	r12, sp, #S_IP
diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
index abcf478..19d2dcd 100644
--- a/arch/arm/kernel/entry-v7m.S
+++ b/arch/arm/kernel/entry-v7m.S
@@ -146,3 +146,7 @@ ENTRY(vector_table)
 	.rept	CONFIG_CPU_V7M_NUM_IRQ
 	.long	__irq_entry		@ External Interrupts
 	.endr
+	.align	2
+	.globl	exc_ret
+exc_ret:
+	.space	4
diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
index 47a5acc..92e8418 100644
--- a/arch/arm/mm/proc-v7m.S
+++ b/arch/arm/mm/proc-v7m.S
@@ -139,6 +139,9 @@ __v7m_setup_cont:
 	cpsie	i
 	svc	#0
 1:	cpsid	i
+	ldr	r0, =exc_ret
+	orr	lr, lr, #EXC_RET_THREADMODE_PROCESSSTACK
+	str	lr, [r0]
 	ldmia	sp, {r0-r3, r12}
 	str	r5, [r12, #11 * 4]	@ restore the original SVC vector entry
 	mov	lr, r6			@ restore LR
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
