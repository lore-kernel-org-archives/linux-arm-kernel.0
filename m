Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0067CC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:02:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB33E2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AvyMMENH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB33E2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VOrRQQA42b6d60tq/CD4k6MULAXkkJ63V6ZFEeCYtSQ=; b=AvyMMENHodHXIt
	JPWMDx2IPdSRJg3GNJDGUzx7TTpHRT2xgRzATQWkgXzaVEDsmeQXDf4ZDkZqRDn551pJQn3vOLAuX
	HfwbuKx9a3sI7wocxQ2FSAMuBYfwb68RqqC8R+ZLyuhEOdgGXX7lpZw45cnsNcpqm8JwWkvvcpuT1
	Fx3ZMkc1BvbS2xXj94baAYGqznnR8toRTSCUK8vhQQjG08oRDo2TFuX7RtT18+eDrkafJPh/REyXf
	q3ES6DMyxBBvUJXdtfnt3DvaTsTRKAE2ga1ZTx4PSTQm5KK5gd74DJH5WI5REJUEeoR3G0EDx9Yf3
	xkUZw64Cfz1LOPntxcMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXUNI-0003Li-7N; Thu, 13 Dec 2018 17:02:12 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXUKg-0007ZJ-Pa
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 16:59:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4830EBD;
 Thu, 13 Dec 2018 08:59:30 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com
 [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1A243F614;
 Thu, 13 Dec 2018 08:59:28 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 16/24] arm64: elf: vDSO code page discovery
Date: Thu, 13 Dec 2018 16:57:38 +0000
Message-Id: <20181213165746.56930-17-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181213165746.56930-1-vincenzo.frascino@arm.com>
References: <20181213165746.56930-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_085931_337806_0158987D 
X-CRM114-Status: GOOD (  12.41  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Like in normal vDSOs, when compat vDSOs are enabled the auxiliary
vector symbol AT_SYSINFO_EHDR needs to point at the address of the
vDSO code, to allow the dynamic linker to find it.

This patch adds the necessary code to the elf arm64 module to make this
possible.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/elf.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index f2b6b486deb7..3fb46968da6a 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -209,7 +209,21 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
 ({									\
 	set_thread_flag(TIF_32BIT);					\
  })
+#ifdef CONFIG_GENERIC_COMPAT_VDSO
+#define COMPAT_ARCH_DLINFO						\
+do {									\
+	/*								\
+	 * Note that we use Elf64_Off instead of elf_addr_t because	\
+	 * elf_addr_t in compat is defined as Elf32_Addr and casting	\
+	 * current->mm->context.vdso to it triggers a cast warning of	\
+	 * cast from pointer to integer of different size.		\
+	 */								\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
+			(Elf64_Off)current->mm->context.vdso);		\
+} while (0)
+#else
 #define COMPAT_ARCH_DLINFO
+#endif
 extern int aarch32_setup_additional_pages(struct linux_binprm *bprm,
 					  int uses_interp);
 #define compat_arch_setup_additional_pages \
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
