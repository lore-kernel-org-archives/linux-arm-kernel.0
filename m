Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC83DC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:59:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1392184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ifOhcZDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1392184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=jH3Lc4YHq9H5o4KWA3aEAUP2DJFUpq+/ijXvgbMgpyk=; b=ifOhcZDRpQ8y0FCYL7UwdQaBK4
	gsRR/+yuPFrMQc8dFq7WpdiaHy071q1DNOlqo2KbzkGVqdD9tblykLfF5S10YmGqN7r9o0ZfkglWD
	q8UXyleifbaXmk/klMLpg4TWUWzlpX4mwDyZR+/8L5qKW/kNiDBCAlI/xA6QhmFAZL4aMjeyja9pb
	guY/2eFf538Ry/aXyDK0YrIzJ9ic40NMhVhBg58mIwqu4fXmYJjMXLWBFo81GLV21S/HcIgswnK3m
	MtTYDC/SsBPOgjnv9RtqjWQMhDW9J4jp9LWYXq89IB3P0BbQP/21Z65JxyvZOaPsm2kV2J8e2T7eQ
	wfnF2Cjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go0tN-00031R-NV; Mon, 28 Jan 2019 06:59:37 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go0t4-0002ki-PU
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 06:59:20 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDF731596;
 Sun, 27 Jan 2019 22:59:17 -0800 (PST)
Received: from a075553-lin.blr.arm.com (a075553-lin.blr.arm.com [10.162.0.39])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 199BF3F5AF; Sun, 27 Jan 2019 22:59:13 -0800 (PST)
From: Amit Daniel Kachhap <amit.kachhap@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 1/5] arm64: Add utilities to save restore pointer
 authentication keys
Date: Mon, 28 Jan 2019 12:28:42 +0530
Message-Id: <1548658727-14271-2-git-send-email-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548658727-14271-1-git-send-email-amit.kachhap@arm.com>
References: <1548658727-14271-1-git-send-email-amit.kachhap@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_225918_833467_CA030D8B 
X-CRM114-Status: GOOD (  13.27  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Jones <drjones@redhat.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>, kvmarm@lists.cs.columbia.edu,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>, Dave Martin <Dave.Martin@arm.com>,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The keys can be switched either inside an assembly or such
functions which do not have pointer authentication checks, so a GCC
attribute is added to enable it.

A function ptrauth_keys_store is added which is similar to existing
function ptrauth_keys_switch but saves the key values in memory.
This may be useful for save/restore scenarios when CPU changes
privilege levels, suspend/resume etc.

Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Kristina Martsenko <kristina.martsenko@arm.com>
Cc: kvmarm@lists.cs.columbia.edu
Cc: Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/pointer_auth.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
index 15d4951..98441ce 100644
--- a/arch/arm64/include/asm/pointer_auth.h
+++ b/arch/arm64/include/asm/pointer_auth.h
@@ -11,6 +11,13 @@
 
 #ifdef CONFIG_ARM64_PTR_AUTH
 /*
+ * Compile the function without pointer authentication instructions. This
+ * allows pointer authentication to be enabled/disabled within the function
+ * (but leaves the function unprotected by pointer authentication).
+ */
+#define __no_ptrauth	__attribute__((target("sign-return-address=none")))
+
+/*
  * Each key is a 128-bit quantity which is split across a pair of 64-bit
  * registers (Lo and Hi).
  */
@@ -50,6 +57,13 @@ do {								\
 	write_sysreg_s(__pki_v.hi, SYS_ ## k ## KEYHI_EL1);	\
 } while (0)
 
+#define __ptrauth_key_save(k, v)				\
+do {								\
+	struct ptrauth_key __pki_v = (v);			\
+	__pki_v.lo = read_sysreg_s(SYS_ ## k ## KEYLO_EL1);	\
+	__pki_v.hi = read_sysreg_s(SYS_ ## k ## KEYHI_EL1);	\
+} while (0)
+
 static inline void ptrauth_keys_switch(struct ptrauth_keys *keys)
 {
 	if (system_supports_address_auth()) {
@@ -63,6 +77,19 @@ static inline void ptrauth_keys_switch(struct ptrauth_keys *keys)
 		__ptrauth_key_install(APGA, keys->apga);
 }
 
+static inline void ptrauth_keys_store(struct ptrauth_keys *keys)
+{
+	if (system_supports_address_auth()) {
+		__ptrauth_key_save(APIA, keys->apia);
+		__ptrauth_key_save(APIB, keys->apib);
+		__ptrauth_key_save(APDA, keys->apda);
+		__ptrauth_key_save(APDB, keys->apdb);
+	}
+
+	if (system_supports_generic_auth())
+		__ptrauth_key_save(APGA, keys->apga);
+}
+
 extern int ptrauth_prctl_reset_keys(struct task_struct *tsk, unsigned long arg);
 
 /*
@@ -88,6 +115,7 @@ do {									\
 	ptrauth_keys_switch(&(tsk)->thread.keys_user)
 
 #else /* CONFIG_ARM64_PTR_AUTH */
+#define __no_ptrauth
 #define ptrauth_prctl_reset_keys(tsk, arg)	(-EINVAL)
 #define ptrauth_strip_insn_pac(lr)	(lr)
 #define ptrauth_thread_init_user(tsk)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
