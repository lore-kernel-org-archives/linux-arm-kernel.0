Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309E9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:39:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02CE620823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g4cfckjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02CE620823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:From:Date:
	Message-Id:References:In-Reply-To:Subject:To:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ShNewrHCpZcG2RS1UqUIx7fM8wvYbGQiTitJLBoHRVM=; b=g4cfckjNDhmdeET+R9YoZlBRnP
	09Zz4Z2YqEOtbrzUeaTYzrUjT+yeMtYMDxFObP/BC1d1rkqVKnwbBT8aYXF4NqAsPRv9eKYs4YaRP
	zjbGHDn3xTZvRy5SnyEf84xkwiVBFpMJ1JJDRTH+n43WM+qhd6xmNe1h0byZsb1FTFSv3X50JjJ5F
	TEK/OZSvTYVOhEUn4FAtEclqo9YMaCzNqok+6HQAltNnbuVzENq6cC6b8UM0Fc9d7F2vAT8hMiebx
	futGgNSi7w78Rpk6MJWP6cprS4mVvcCmrFvOLtr1dYk8XU/f6UXU0QQvyXVy0unCSwQ6ix3/Z6TsR
	/zMsQLag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXBE-0003NC-CV; Fri, 18 Jan 2019 16:39:40 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXAo-00030t-8x
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:39:21 +0000
Received: by newverein.lst.de (Postfix, from userid 2005)
 id 0414868DCF; Fri, 18 Jan 2019 17:39:13 +0100 (CET)
To: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Julien Thierry <julien.thierry@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: [PATCH v7 3/3] arm64: use -fpatchable-function-entry if available
In-Reply-To: <20190118163736.6A99268CEB@newverein.lst.de>
References: <20190118163736.6A99268CEB@newverein.lst.de>
Message-Id: <20190118163913.0414868DCF@newverein.lst.de>
Date: Fri, 18 Jan 2019 17:39:13 +0100 (CET)
From: duwe@lst.de (Torsten Duwe)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_083915_455041_974FB960 
X-CRM114-Status: UNSURE (   8.24  )
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
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Test whether gcc supports -fpatchable-function-entry and use it to promote
DYNAMIC_FTRACE to DYNAMIC_FTRACE_WITH_REGS. Amend support for the new object
section that holds the locations (__patchable_function_entries) and define
a proper "notrace" attribute to switch it off.

Signed-off-by: Torsten Duwe <duwe@suse.de>

---
 arch/arm64/Kconfig                |    2 ++
 arch/arm64/Makefile               |    5 +++++
 include/asm-generic/vmlinux.lds.h |    1 +
 include/linux/compiler_types.h    |    2 ++
 4 files changed, 10 insertions(+)
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -132,6 +132,8 @@ config ARM64
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
+	select HAVE_DYNAMIC_FTRACE_WITH_REGS \
+		if $(cc-option,-fpatchable-function-entry=2)
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_TRACER
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -89,6 +89,11 @@ ifeq ($(CONFIG_ARM64_MODULE_PLTS),y)
 KBUILD_LDFLAGS_MODULE	+= -T $(srctree)/arch/arm64/kernel/module.lds
 endif
 
+ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_REGS),y)
+  KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FENTRY
+  CC_FLAGS_FTRACE := -fpatchable-function-entry=2
+endif
+
 # Default value
 head-y		:= arch/arm64/kernel/head.o
 
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -113,6 +113,7 @@
 #define MCOUNT_REC()	. = ALIGN(8);				\
 			__start_mcount_loc = .;			\
 			KEEP(*(__mcount_loc))			\
+			KEEP(*(__patchable_function_entries))	\
 			__stop_mcount_loc = .;
 #else
 #define MCOUNT_REC()
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -112,6 +112,8 @@ struct ftrace_likely_data {
 
 #if defined(CC_USING_HOTPATCH)
 #define notrace			__attribute__((hotpatch(0, 0)))
+#elif defined(CC_USING_PATCHABLE_FENTRY)
+#define notrace			__attribute__((patchable_function_entry(0)))
 #else
 #define notrace			__attribute__((__no_instrument_function__))
 #endif

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
