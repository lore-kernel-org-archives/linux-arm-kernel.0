Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DCBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:12:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FB4B20827
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PuMcFFyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB4B20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=SfqJiMlwrkW191iOF7UjBqvAddHEmDAM+qzjD7NAYLQ=; b=PuMcFFyZ9PAPk8+KqhiMwLAznx
	BG2vDl1U0k3Q1Ma1YQq5PI3giCjDS3NyKOdiI9A6ko2CsXYb7bpwoyjF9rp0XAD9gNHmu0V3I28pu
	2NPYM7QTaQHOqlOZh4DMMmNLdt/W4UazsPU+7Zfx31i5kkRj9wpni8FzcxOqY1cx0DvAZJPvtjyro
	bTSEtqfJ+3WC1v58BXvv/Pn8lvnhir0UbRHul1dByFg8ZKArMVZCUKXX0b13cTsmJs0alIbLjJNqS
	UHufwucgC0RGKCMbRgiIFPTKJz5Bpz+vTptoShSAYD7uME+x6fTG2IM75Y0sJOiWZEKM3wWa2OvYZ
	1XKXs8iQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggs7E-0004g7-8w; Tue, 08 Jan 2019 14:12:24 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggs3L-0007Ky-Ke
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 14:08:52 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8705E15AB;
 Tue,  8 Jan 2019 06:08:23 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8B0D23F70D;
 Tue,  8 Jan 2019 06:08:21 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 11/26] efi: Let architectures decide the flags that should
 be saved/restored
Date: Tue,  8 Jan 2019 14:07:29 +0000
Message-Id: <1546956464-48825-12-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_060823_867932_E78E39AC 
X-CRM114-Status: UNSURE (   9.67  )
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
Cc: mark.rutland@arm.com, daniel.thompson@linaro.org,
 Julien Thierry <julien.thierry@arm.com>, marc.zyngier@arm.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 christoffer.dall@arm.com, james.morse@arm.com, joel@joelfernandes.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Currently, irqflags are saved before calling runtime services and
checked for mismatch on return.

Provide a pair of overridable macros to save and restore (if needed) the
state that need to be preserved on return from a runtime service.
This allows to check for flags that are not necesarly related to
irqflags.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
---
 drivers/firmware/efi/runtime-wrappers.c | 17 +++++++++++++++--
 include/linux/efi.h                     |  5 +++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index 8903b9c..2f4b68b 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -89,11 +89,24 @@
 	efi_rts_work.status;						\
 })
 
+#ifndef arch_efi_save_flags
+#define arch_efi_save_flags(state_flags)	local_save_flags(state_flags)
+#define arch_efi_restore_flags(state_flags)	local_irq_restore(state_flags)
+#endif
+
+inline unsigned long efi_call_virt_save_flags(void)
+{
+	unsigned long flags;
+
+	arch_efi_save_flags(flags);
+	return flags;
+}
+
 void efi_call_virt_check_flags(unsigned long flags, const char *call)
 {
 	unsigned long cur_flags, mismatch;
 
-	local_save_flags(cur_flags);
+	cur_flags = efi_call_virt_save_flags();
 
 	mismatch = flags ^ cur_flags;
 	if (!WARN_ON_ONCE(mismatch & ARCH_EFI_IRQ_FLAGS_MASK))
@@ -102,7 +115,7 @@ void efi_call_virt_check_flags(unsigned long flags, const char *call)
 	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_NOW_UNRELIABLE);
 	pr_err_ratelimited(FW_BUG "IRQ flags corrupted (0x%08lx=>0x%08lx) by EFI %s\n",
 			   flags, cur_flags, call);
-	local_irq_restore(flags);
+	arch_efi_restore_flags(flags);
 }
 
 /*
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 45ff763..bd80b7e 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1607,6 +1607,7 @@ efi_status_t efi_setup_gop(efi_system_table_t *sys_table_arg,
 
 bool efi_runtime_disabled(void);
 extern void efi_call_virt_check_flags(unsigned long flags, const char *call);
+extern unsigned long efi_call_virt_save_flags(void);
 
 enum efi_secureboot_mode {
 	efi_secureboot_mode_unset,
@@ -1652,7 +1653,7 @@ enum efi_secureboot_mode {
 									\
 	arch_efi_call_virt_setup();					\
 									\
-	local_save_flags(__flags);					\
+	__flags = efi_call_virt_save_flags();				\
 	__s = arch_efi_call_virt(p, f, args);				\
 	efi_call_virt_check_flags(__flags, __stringify(f));		\
 									\
@@ -1667,7 +1668,7 @@ enum efi_secureboot_mode {
 									\
 	arch_efi_call_virt_setup();					\
 									\
-	local_save_flags(__flags);					\
+	__flags = efi_call_virt_save_flags();				\
 	arch_efi_call_virt(p, f, args);					\
 	efi_call_virt_check_flags(__flags, __stringify(f));		\
 									\
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
