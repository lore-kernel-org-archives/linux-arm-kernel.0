Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352B3C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:52:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F398420989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N2zNkIwB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F398420989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1xtS3CNxbeoEPZ4n9d3vDx3yruGpEhXCE380zVk4G+I=; b=N2zNkIwBzWs6rB
	fu878KU0AIvHeODZKzJEnPKbdsNoO6eSNudCBE/GDPEj3L9t2lWrLeMXNUnzeATDS0+FkLqla3dk3
	W6MPgUFfEfvqiRW4rEOHQGYrssD1Ksh3Vywa0p/QakGOyCHe0hJwgKEXKlyrOcaYCKvBUtolnTMQv
	QROwsTlp3FoBN5obb2S+2jhbzBEpl9fu0oN8NOqi7gOj1wDFtj3WrScqiduJEqUoRbMDMyhztKBKe
	6GHdRt/JiN7n2W8dP1kVbG/4sf1kfRdRJbGV6dlQwb8YdxMKr0edCuHJGV4DRd5Lol5SfI9AF6xCX
	Vhp3Y6o9Y09wa9zKx+Uw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV2VD-0002mu-Lw; Thu, 06 Dec 2018 22:52:15 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV2UI-0001nf-E1
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:51:24 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B844E15AD;
 Thu,  6 Dec 2018 14:51:15 -0800 (PST)
Received: from capper-debian.arm.com (unknown [10.37.12.92])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2DED23F5AF;
 Thu,  6 Dec 2018 14:51:14 -0800 (PST)
From: Steve Capper <steve.capper@arm.com>
To: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V5 7/7] arm64: mm: Allow forcing all userspace addresses to
 52-bit
Date: Thu,  6 Dec 2018 22:50:42 +0000
Message-Id: <20181206225042.11548-8-steve.capper@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206225042.11548-1-steve.capper@arm.com>
References: <20181206225042.11548-1-steve.capper@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_145119_037522_16107731 
X-CRM114-Status: GOOD (  13.23  )
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
Cc: ard.biesheuvel@linaro.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
 Steve Capper <steve.capper@arm.com>, will.deacon@arm.com, jcm@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On arm64 52-bit VAs are provided to userspace when a hint is supplied to
mmap. This helps maintain compatibility with software that expects at
most 48-bit VAs to be returned.

In order to help identify software that has 48-bit VA assumptions, this
patch allows one to compile a kernel where 52-bit VAs are returned by
default on HW that supports it.

This feature is intended to be for development systems only.

Signed-off-by: Steve Capper <steve.capper@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig                 | 13 +++++++++++++
 arch/arm64/include/asm/elf.h       |  4 ++++
 arch/arm64/include/asm/processor.h |  9 ++++++++-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6a93d5bc7f76..12658f05bb41 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1165,6 +1165,19 @@ config ARM64_CNP
 	  at runtime, and does not affect PEs that do not implement
 	  this feature.
 
+config ARM64_FORCE_52BIT
+	bool "Force 52-bit virtual addresses for userspace"
+	depends on ARM64_52BIT_VA && EXPERT
+	help
+	  For systems with 52-bit userspace VAs enabled, the kernel will attempt
+	  to maintain compatibility with older software by providing 48-bit VAs
+	  unless a hint is supplied to mmap.
+
+	  This configuration option disables the 48-bit compatibility logic, and
+	  forces all userspace addresses to be 52-bit on HW that supports it. One
+	  should only enable this configuration option for stress testing userspace
+	  memory management code. If unsure say N here.
+
 endmenu
 
 config ARM64_SVE
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index bc9bd9e77d9d..6adc1a90e7e6 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -117,7 +117,11 @@
  * 64-bit, this is above 4GB to leave the entire 32-bit address
  * space open for things that want to use the area for 32-bit pointers.
  */
+#ifdef CONFIG_ARM64_FORCE_52BIT
+#define ELF_ET_DYN_BASE		(2 * TASK_SIZE_64 / 3)
+#else
 #define ELF_ET_DYN_BASE		(2 * DEFAULT_MAP_WINDOW_64 / 3)
+#endif /* CONFIG_ARM64_FORCE_52BIT */
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index b363fc705be4..9abd91570b5b 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -65,8 +65,13 @@ extern u64 vabits_user;
 #define DEFAULT_MAP_WINDOW	DEFAULT_MAP_WINDOW_64
 #endif /* CONFIG_COMPAT */
 
-#define TASK_UNMAPPED_BASE	(PAGE_ALIGN(DEFAULT_MAP_WINDOW / 4))
+#ifdef CONFIG_ARM64_FORCE_52BIT
+#define STACK_TOP_MAX		TASK_SIZE_64
+#define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 4))
+#else
 #define STACK_TOP_MAX		DEFAULT_MAP_WINDOW_64
+#define TASK_UNMAPPED_BASE	(PAGE_ALIGN(DEFAULT_MAP_WINDOW / 4))
+#endif /* CONFIG_ARM64_FORCE_52BIT */
 
 #ifdef CONFIG_COMPAT
 #define AARCH32_VECTORS_BASE	0xffff0000
@@ -76,12 +81,14 @@ extern u64 vabits_user;
 #define STACK_TOP		STACK_TOP_MAX
 #endif /* CONFIG_COMPAT */
 
+#ifndef CONFIG_ARM64_FORCE_52BIT
 #define arch_get_mmap_end(addr) ((addr > DEFAULT_MAP_WINDOW) ? TASK_SIZE :\
 				DEFAULT_MAP_WINDOW)
 
 #define arch_get_mmap_base(addr, base) ((addr > DEFAULT_MAP_WINDOW) ? \
 					base + TASK_SIZE - DEFAULT_MAP_WINDOW :\
 					base)
+#endif /* CONFIG_ARM64_FORCE_52BIT */
 
 extern phys_addr_t arm64_dma_phys_limit;
 #define ARCH_LOW_ADDRESS_LIMIT	(arm64_dma_phys_limit - 1)
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
