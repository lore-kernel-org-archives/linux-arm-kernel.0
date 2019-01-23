Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D28C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:36:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D60E2184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hSLlqd4K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D60E2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=cE539oD5G3tcykrbxcNujwA586I2gs2ROFWItNkj9Tg=; b=hSL
	lqd4KR17DwiFHbYvFnARstoJDxLxtDNrljMD8bPNtVCuWRgbxS6YrVpFNePxnZdxi4RKIQgFNZzke
	FNF/sIy1TFfAXbSzpaYaCdnNyehMkYEQureF5VHmrYS6VX7sEq3stRK1ItSuxP6co25nDkMnGwYKd
	GACNaYNS0zUtfDqFwuFeZtCqmytiToq6HIvxN211pY5nFcLM1EbFUlAoQj90eW9ZwjodNOf3MAWhV
	4qhPdfsYmOBNd/7N0aZLOIb8a39BTewco4E1lnI3nGIYs415hdGzkYc1Shd013CgEjBb2rY/aQjTe
	n0+iUcaM4Rg4wyCakKwpnVS+2h5AERg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmKZL-0006cU-EN; Wed, 23 Jan 2019 15:35:59 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmKZI-0006c3-1G
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 15:35:57 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C647AA78;
 Wed, 23 Jan 2019 07:35:54 -0800 (PST)
Received: from moonbear.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91CB83F5C1;
 Wed, 23 Jan 2019 07:35:53 -0800 (PST)
From: Kristina Martsenko <kristina.martsenko@arm.com>
To: linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH v3] arm64: add ptrace regsets for ptrauth key management
Date: Wed, 23 Jan 2019 15:35:19 +0000
Message-Id: <20190123153519.7874-1-kristina.martsenko@arm.com>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_073556_092557_FA3CC832 
X-CRM114-Status: GOOD (  16.87  )
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
 Dave P Martin <dave.martin@arm.com>
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
CONFIG_CHECKPOINT_RESTORE=y, as the only intended use case is
checkpointing and restoring processes that are using pointer
authentication. (This can be changed later if there are other use
cases.)

Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---

Changes in v3:
 - 128-bit keys in uapi struct, conversions to/from ptrauth_keys fields
 - Commit message tweaks

 Documentation/arm64/pointer-authentication.txt |   5 +
 arch/arm64/include/uapi/asm/ptrace.h           |  13 +++
 arch/arm64/kernel/ptrace.c                     | 139 +++++++++++++++++++++++++
 include/uapi/linux/elf.h                       |   2 +
 4 files changed, 159 insertions(+)

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
index 28d77c9ed531..d78623acb649 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -233,6 +233,19 @@ struct user_pac_mask {
 	__u64		insn_mask;
 };
 
+/* pointer authentication keys (NT_ARM_PACA_KEYS, NT_ARM_PACG_KEYS) */
+
+struct user_pac_address_keys {
+	__uint128_t	apiakey;
+	__uint128_t	apibkey;
+	__uint128_t	apdakey;
+	__uint128_t	apdbkey;
+};
+
+struct user_pac_generic_keys {
+	__uint128_t	apgakey;
+};
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _UAPI__ASM_PTRACE_H */
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 9dce33b0e260..102f71fe0288 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -979,6 +979,123 @@ static int pac_mask_get(struct task_struct *target,
 
 	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, &uregs, 0, -1);
 }
+
+#ifdef CONFIG_CHECKPOINT_RESTORE
+static void pac_address_keys_to_user(struct user_pac_address_keys *ukeys,
+				     struct ptrauth_keys *keys)
+{
+	ukeys->apiakey = ((__uint128_t)keys->apia.hi << 64) | keys->apia.lo;
+	ukeys->apibkey = ((__uint128_t)keys->apib.hi << 64) | keys->apib.lo;
+	ukeys->apdakey = ((__uint128_t)keys->apda.hi << 64) | keys->apda.lo;
+	ukeys->apdbkey = ((__uint128_t)keys->apdb.hi << 64) | keys->apdb.lo;
+}
+
+static void pac_address_keys_from_user(struct user_pac_address_keys *ukeys,
+				       struct ptrauth_keys *keys)
+{
+	keys->apia.lo = (unsigned long)ukeys->apiakey;
+	keys->apia.hi = (unsigned long)(ukeys->apiakey >> 64);
+	keys->apib.lo = (unsigned long)ukeys->apibkey;
+	keys->apib.hi = (unsigned long)(ukeys->apibkey >> 64);
+	keys->apda.lo = (unsigned long)ukeys->apdakey;
+	keys->apda.hi = (unsigned long)(ukeys->apdakey >> 64);
+	keys->apdb.lo = (unsigned long)ukeys->apdbkey;
+	keys->apdb.hi = (unsigned long)(ukeys->apdbkey >> 64);
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
+	ukeys->apgakey = ((__uint128_t)keys->apga.hi << 64) | keys->apga.lo;
+}
+
+static void pac_generic_keys_from_user(struct user_pac_generic_keys *ukeys,
+				       struct ptrauth_keys *keys)
+{
+	keys->apga.lo = (unsigned long)ukeys->apgakey;
+	keys->apga.hi = (unsigned long)(ukeys->apgakey >> 64);
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
@@ -995,6 +1112,10 @@ enum aarch64_regset {
 #endif
 #ifdef CONFIG_ARM64_PTR_AUTH
 	REGSET_PAC_MASK,
+#ifdef CONFIG_CHECKPOINT_RESTORE
+	REGSET_PACA_KEYS,
+	REGSET_PACG_KEYS,
+#endif
 #endif
 };
 
@@ -1074,6 +1195,24 @@ static const struct user_regset aarch64_regsets[] = {
 		.get = pac_mask_get,
 		/* this cannot be set dynamically */
 	},
+#ifdef CONFIG_CHECKPOINT_RESTORE
+	[REGSET_PACA_KEYS] = {
+		.core_note_type = NT_ARM_PACA_KEYS,
+		.n = sizeof(struct user_pac_address_keys) / sizeof(__uint128_t),
+		.size = sizeof(__uint128_t),
+		.align = sizeof(__uint128_t),
+		.get = pac_address_keys_get,
+		.set = pac_address_keys_set,
+	},
+	[REGSET_PACG_KEYS] = {
+		.core_note_type = NT_ARM_PACG_KEYS,
+		.n = sizeof(struct user_pac_generic_keys) / sizeof(__uint128_t),
+		.size = sizeof(__uint128_t),
+		.align = sizeof(__uint128_t),
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
