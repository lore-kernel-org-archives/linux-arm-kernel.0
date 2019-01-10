Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE509C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:35:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D98B206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AbkW0gMs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D98B206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=Tz68QupRjf1Tr0xbEHjEAOGdHKhTymtHrPRPjhtJAII=; b=Abk
	W0gMs4YRWQY7rf9aFz92jiPQzkh/Av/qGEzeCBEEN/rCfQzE6Q7O/hHN3tSaUA0SgDpBaBiCMjStk
	UTt6G2OLqQrXct/41urN0vilA+lDLuWqcCMBrkI3tHeK0ZbDTUmJsVMhN9tgceWPqb/oNynNoCHxm
	/2qAlFHoY8zTwH/QPkJiKI+lqbLjBmXvP9sV1DqaDnuDgdgFkOfwoDDIFIQ075CdXyj1sXLtjgw2T
	6iLGFwhSm5qN/9q9GWTiJxRPI7jQt4yYNiUghU13gjMEG3dJf4bGTYNPcPsDTGTrTUgyv10AVLOJN
	/L+MdhC0KhQC3SyjkZ5wdaMfsABktbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghg7L-0006UJ-Rm; Thu, 10 Jan 2019 19:35:51 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghg7H-0006Tr-Ow
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 19:35:49 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD4AB1596;
 Thu, 10 Jan 2019 11:35:43 -0800 (PST)
Received: from moonbear.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8485E3F6CF;
 Thu, 10 Jan 2019 11:35:42 -0800 (PST)
From: Kristina Martsenko <kristina.martsenko@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Dave P Martin <dave.martin@arm.com>
Subject: [PATCH v2] arm64: add ptrace regsets for ptrauth key management
Date: Thu, 10 Jan 2019 19:35:08 +0000
Message-Id: <20190110193508.31888-1-kristina.martsenko@arm.com>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_113547_819884_858164DF 
X-CRM114-Status: GOOD (  18.43  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Amit Kachhap <amit.kachhap@arm.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add two new ptrace regsets, which can be used to request and change the
pointer authentication keys of a thread. NT_ARM_PACA_KEYS gives access
to the instruction/data address keys, and NT_ARM_PACG_KEYS to the
generic authentication key. The keys are also part of the core dump file
of the process.

The regsets are only exposed if the kernel is compiled with
CONFIG_CHECKPOINT_RESTORE=y, as the intended use case is checkpointing
and restoring processes that are using pointer authentication. Normally
applications or debuggers should not need to know the keys (and exposing
the keys is a security risk), so the regsets are not exposed by default.

Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---

The previous version of this patch was:
  https://lore.kernel.org/lkml/20181207183931.4285-12-kristina.martsenko@arm.com/

Changes in v2:
 - Convert each field individually between ptrauth_keys and
   user_pac_address_keys/user_pac_generic_keys

 Documentation/arm64/pointer-authentication.txt |   5 +
 arch/arm64/include/uapi/asm/ptrace.h           |  18 ++++
 arch/arm64/kernel/ptrace.c                     | 144 +++++++++++++++++++++++++
 include/uapi/linux/elf.h                       |   2 +
 4 files changed, 169 insertions(+)

diff --git a/Documentation/arm64/pointer-authentication.txt b/Documentation/arm64/pointer-authentication.txt
index a25cd21290e9..5baca42ba146 100644
--- a/Documentation/arm64/pointer-authentication.txt
+++ b/Documentation/arm64/pointer-authentication.txt
@@ -78,6 +78,11 @@ bits can vary between the two. Note that the masks apply to TTBR0
 addresses, and are not valid to apply to TTBR1 addresses (e.g. kernel
 pointers).
 
+Additionally, when CONFIG_CHECKPOINT_RESTORE is also set, the kernel
+will expose the NT_ARM_PACA_KEYS and NT_ARM_PACG_KEYS regsets (struct
+user_pac_address_keys and struct user_pac_generic_keys). These can be
+used to get and set the keys for a thread.
+
 
 Virtualization
 --------------
diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index 28d77c9ed531..0affa43602a5 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -233,6 +233,24 @@ struct user_pac_mask {
 	__u64		insn_mask;
 };
 
+/* pointer authentication keys (NT_ARM_PACA_KEYS, NT_ARM_PACG_KEYS) */
+
+struct user_pac_address_keys {
+	__u64		apiakey_lo;
+	__u64		apiakey_hi;
+	__u64		apibkey_lo;
+	__u64		apibkey_hi;
+	__u64		apdakey_lo;
+	__u64		apdakey_hi;
+	__u64		apdbkey_lo;
+	__u64		apdbkey_hi;
+};
+
+struct user_pac_generic_keys {
+	__u64		apgakey_lo;
+	__u64		apgakey_hi;
+};
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _UAPI__ASM_PTRACE_H */
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 9dce33b0e260..a5f9f07e9eac 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -979,6 +979,128 @@ static int pac_mask_get(struct task_struct *target,
 
 	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, &uregs, 0, -1);
 }
+
+#ifdef CONFIG_CHECKPOINT_RESTORE
+static void pac_address_keys_to_user(struct user_pac_address_keys *ukeys,
+				     struct ptrauth_keys *keys)
+{
+	ukeys->apiakey_lo = keys->apia.lo;
+	ukeys->apiakey_hi = keys->apia.hi;
+	ukeys->apibkey_lo = keys->apib.lo;
+	ukeys->apibkey_hi = keys->apib.hi;
+	ukeys->apdakey_lo = keys->apda.lo;
+	ukeys->apdakey_hi = keys->apda.hi;
+	ukeys->apdbkey_lo = keys->apdb.lo;
+	ukeys->apdbkey_hi = keys->apdb.hi;
+}
+
+static void pac_address_keys_from_user(struct user_pac_address_keys *ukeys,
+				       struct ptrauth_keys *keys)
+{
+	keys->apia.lo = ukeys->apiakey_lo;
+	keys->apia.hi = ukeys->apiakey_hi;
+	keys->apib.lo = ukeys->apibkey_lo;
+	keys->apib.hi = ukeys->apibkey_hi;
+	keys->apda.lo = ukeys->apdakey_lo;
+	keys->apda.hi = ukeys->apdakey_hi;
+	keys->apdb.lo = ukeys->apdbkey_lo;
+	keys->apdb.hi = ukeys->apdbkey_hi;
+}
+
+static int pac_address_keys_get(struct task_struct *target,
+				const struct user_regset *regset,
+				unsigned int pos, unsigned int count,
+				void *kbuf, void __user *ubuf)
+{
+	struct ptrauth_keys *keys = &target->thread.keys_user;
+	struct user_pac_address_keys user_keys;
+
+	if (!system_supports_address_auth())
+		return -EINVAL;
+
+	memset(&user_keys, 0, sizeof(user_keys));
+	pac_address_keys_to_user(&user_keys, keys);
+
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				   &user_keys, 0, -1);
+}
+
+static int pac_address_keys_set(struct task_struct *target,
+				const struct user_regset *regset,
+				unsigned int pos, unsigned int count,
+				const void *kbuf, const void __user *ubuf)
+{
+	struct ptrauth_keys *keys = &target->thread.keys_user;
+	struct user_pac_address_keys user_keys;
+	int ret;
+
+	if (!system_supports_address_auth())
+		return -EINVAL;
+
+	pac_address_keys_to_user(&user_keys, keys);
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 &user_keys, 0, -1);
+	if (ret)
+		return ret;
+	pac_address_keys_from_user(&user_keys, keys);
+
+	return 0;
+}
+
+static void pac_generic_keys_to_user(struct user_pac_generic_keys *ukeys,
+				     struct ptrauth_keys *keys)
+{
+	ukeys->apgakey_lo = keys->apga.lo;
+	ukeys->apgakey_hi = keys->apga.hi;
+}
+
+static void pac_generic_keys_from_user(struct user_pac_generic_keys *ukeys,
+				       struct ptrauth_keys *keys)
+{
+	keys->apga.lo = ukeys->apgakey_lo;
+	keys->apga.hi = ukeys->apgakey_hi;
+}
+
+static int pac_generic_keys_get(struct task_struct *target,
+				const struct user_regset *regset,
+				unsigned int pos, unsigned int count,
+				void *kbuf, void __user *ubuf)
+{
+	struct ptrauth_keys *keys = &target->thread.keys_user;
+	struct user_pac_generic_keys user_keys;
+
+	if (!system_supports_generic_auth())
+		return -EINVAL;
+
+	memset(&user_keys, 0, sizeof(user_keys));
+	pac_generic_keys_to_user(&user_keys, keys);
+
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				   &user_keys, 0, -1);
+}
+
+static int pac_generic_keys_set(struct task_struct *target,
+				const struct user_regset *regset,
+				unsigned int pos, unsigned int count,
+				const void *kbuf, const void __user *ubuf)
+{
+	struct ptrauth_keys *keys = &target->thread.keys_user;
+	struct user_pac_generic_keys user_keys;
+	int ret;
+
+	if (!system_supports_generic_auth())
+		return -EINVAL;
+
+	pac_generic_keys_to_user(&user_keys, keys);
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 &user_keys, 0, -1);
+	if (ret)
+		return ret;
+	pac_generic_keys_from_user(&user_keys, keys);
+
+	return 0;
+}
+#endif /* CONFIG_CHECKPOINT_RESTORE */
 #endif /* CONFIG_ARM64_PTR_AUTH */
 
 enum aarch64_regset {
@@ -995,6 +1117,10 @@ enum aarch64_regset {
 #endif
 #ifdef CONFIG_ARM64_PTR_AUTH
 	REGSET_PAC_MASK,
+#ifdef CONFIG_CHECKPOINT_RESTORE
+	REGSET_PACA_KEYS,
+	REGSET_PACG_KEYS,
+#endif
 #endif
 };
 
@@ -1074,6 +1200,24 @@ static const struct user_regset aarch64_regsets[] = {
 		.get = pac_mask_get,
 		/* this cannot be set dynamically */
 	},
+#ifdef CONFIG_CHECKPOINT_RESTORE
+	[REGSET_PACA_KEYS] = {
+		.core_note_type = NT_ARM_PACA_KEYS,
+		.n = sizeof(struct user_pac_address_keys) / sizeof(u64),
+		.size = sizeof(u64),
+		.align = sizeof(u64),
+		.get = pac_address_keys_get,
+		.set = pac_address_keys_set,
+	},
+	[REGSET_PACG_KEYS] = {
+		.core_note_type = NT_ARM_PACG_KEYS,
+		.n = sizeof(struct user_pac_generic_keys) / sizeof(u64),
+		.size = sizeof(u64),
+		.align = sizeof(u64),
+		.get = pac_generic_keys_get,
+		.set = pac_generic_keys_set,
+	},
+#endif
 #endif
 };
 
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index e4d6ddd93567..34c02e4290fe 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -421,6 +421,8 @@ typedef struct elf64_shdr {
 #define NT_ARM_SYSTEM_CALL	0x404	/* ARM system call number */
 #define NT_ARM_SVE	0x405		/* ARM Scalable Vector Extension registers */
 #define NT_ARM_PAC_MASK		0x406	/* ARM pointer authentication code masks */
+#define NT_ARM_PACA_KEYS	0x407	/* ARM pointer authentication address keys */
+#define NT_ARM_PACG_KEYS	0x408	/* ARM pointer authentication generic key */
 #define NT_ARC_V2	0x600		/* ARCv2 accumulator/extra registers */
 #define NT_VMCOREDD	0x700		/* Vmcore Device Dump Note */
 #define NT_MIPS_DSP	0x800		/* MIPS DSP ASE registers */
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
