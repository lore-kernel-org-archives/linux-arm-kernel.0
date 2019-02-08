Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA36BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:12:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 995EB2146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bAqPXiEX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995EB2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:From:Date:
	Message-Id:References:In-Reply-To:Subject:To:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=vcGBQKst9alI0xYfS47ItXgKAddCunJ4q9KrJPiIjLo=; b=bAqPXiEX2nnelv+Q1VDgp7blMJ
	5rLwg/rIwaIiJAy7c4eC0MHRF25ZdnYxdQDuNgHUYTRSURZe2lEJcFWZwxv/hz+KPSLcxAhKwDp4f
	GxgG7OTIz/Mxc5zfz27Fh9EaDFt/u3M8VNAswiNSJlzQDObQiPj8jg4eEM1D+kWA2jZuzcxVIygSS
	swfbHvmBXfYByUJK5W91bjaiYAzLniaXUVDEnmp3qK93RmIE5IySNCoKhrZu6cbSdWaNgTNFaNJyU
	DBwpJtf+Jd151AzY6EhI0S0CxVryQh3BtK/lrqU3O6qzLZwTpzk00nb9sB5Gu6rf8TxpLL6/GHDxX
	Q2rA0GEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs7pI-0004A0-Kh; Fri, 08 Feb 2019 15:12:24 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs7n8-0000wN-76
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 15:10:42 +0000
Received: by newverein.lst.de (Postfix, from userid 2005)
 id 276E968DD2; Fri,  8 Feb 2019 16:10:07 +0100 (CET)
To: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Julien Thierry <julien.thierry@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: [PATCH v8 1/5] arm64: replace -pg with CC_FLAGS_FTRACE in arm64
 Makefiles
In-Reply-To: <20190208150826.44EBC68DD2@newverein.lst.de>
References: <20190208150826.44EBC68DD2@newverein.lst.de>
Message-Id: <20190208151007.276E968DD2@newverein.lst.de>
Date: Fri,  8 Feb 2019 16:10:07 +0100 (CET)
From: duwe@lst.de (Torsten Duwe)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_071011_025307_A9CDCE34 
X-CRM114-Status: UNSURE (   6.09  )
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

  In preparation for arm64 supporting ftrace built on other compiler
  options, let's have the arm64 makefiles remove the $(CC_FLAGS_FTRACE)
  flags, whatever these may be, rather than assuming '-pg'.

  There should be no functional change as a result of this patch.

Signed-off-by: Torsten Duwe <duwe@suse.de>

---
 arch/arm64/kernel/Makefile |    6 +++---
 arch/arm64/lib/Makefile    |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -7,9 +7,9 @@ CPPFLAGS_vmlinux.lds	:= -DTEXT_OFFSET=$(
 AFLAGS_head.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 CFLAGS_armv8_deprecated.o := -I$(src)
 
-CFLAGS_REMOVE_ftrace.o = -pg
-CFLAGS_REMOVE_insn.o = -pg
-CFLAGS_REMOVE_return_address.o = -pg
+CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_insn.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_return_address.o = $(CC_FLAGS_FTRACE)
 
 # Object file lists.
 obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -24,7 +24,7 @@ CFLAGS_atomic_ll_sc.o	:= -ffixed-x1 -ffi
 		   -fcall-saved-x10 -fcall-saved-x11 -fcall-saved-x12	\
 		   -fcall-saved-x13 -fcall-saved-x14 -fcall-saved-x15	\
 		   -fcall-saved-x18 -fomit-frame-pointer
-CFLAGS_REMOVE_atomic_ll_sc.o := -pg
+CFLAGS_REMOVE_atomic_ll_sc.o := $(CC_FLAGS_FTRACE)
 GCOV_PROFILE_atomic_ll_sc.o	:= n
 KASAN_SANITIZE_atomic_ll_sc.o	:= n
 KCOV_INSTRUMENT_atomic_ll_sc.o	:= n

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
