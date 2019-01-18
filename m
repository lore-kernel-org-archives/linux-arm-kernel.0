Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66C8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:39:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D2C208E4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="taId1pRp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D2C208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:From:Date:
	Message-Id:References:In-Reply-To:Subject:To:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=iHONHSxIQpLNnuh4LBHm/MSYMSzTNA0w49LaxPl06I0=; b=taId1pRpjxvgnPW41FydIKgeU2
	EbmSm7zHZeFN09EocmQfcH4Rc5KGxd3gXAA8OVv2uhmzyIZqCrNl+TwS9WzhTtGUroC0dAbEqnrcx
	1ofKrCxxiQFEdSgI/wRmqx5mQpp4mgHujuQqklwNfS5XQFy8M4nylkSb4kPcRdZU4toDpM+RV/NS9
	Df0mmNDFA3+PdBlp5otHVCwkq3KgZXwx9M7HfTeRrIGxNqKATwD+jbLsepHPfH8s8I5bYCaBfW7Nj
	O5MtmyQWk/MjEaeQS9D3s5sX/pqoXaDJUBNeATiPEJw+mKlEDRkm74b5qvY6PhzFf/vvQV6KksNCy
	pSuis5cg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXAj-0002wT-9c; Fri, 18 Jan 2019 16:39:09 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXAg-0002wA-1t
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:39:07 +0000
Received: by newverein.lst.de (Postfix, from userid 2005)
 id CD7BA68CEB; Fri, 18 Jan 2019 17:39:04 +0100 (CET)
To: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Julien Thierry <julien.thierry@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: [PATCH v7 1/3] arm64: replace -pg with CC_FLAGS_FTRACE in Makefiles
In-Reply-To: <20190118163736.6A99268CEB@newverein.lst.de>
References: <20190118163736.6A99268CEB@newverein.lst.de>
Message-Id: <20190118163904.CD7BA68CEB@newverein.lst.de>
Date: Fri, 18 Jan 2019 17:39:04 +0100 (CET)
From: duwe@lst.de (Torsten Duwe)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_083906_267374_3CB0CC90 
X-CRM114-Status: UNSURE (   7.22  )
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

Ftrace instrumentation might also be introduced by
-fpatchable-function-entry, not only -pg. Ensure the Makefiles are
flexible to filter out the respective flags in "notrace" directories.

Signed-off-by: Torsten Duwe <duwe@suse.de>

---
 arch/arm64/kernel/Makefile            |    6 +++---
 drivers/firmware/efi/libstub/Makefile |    3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)
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
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -16,7 +16,8 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__K
 
 # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
 # disable the stackleak plugin
-cflags-$(CONFIG_ARM64)		:= $(subst -pg,,$(KBUILD_CFLAGS)) -fpie \
+cflags-$(CONFIG_ARM64)		:= $(filter-out $(CC_FLAGS_FTRACE)\
+				  ,$(KBUILD_CFLAGS)) -fpie \
 				   $(DISABLE_STACKLEAK_PLUGIN)
 cflags-$(CONFIG_ARM)		:= $(subst -pg,,$(KBUILD_CFLAGS)) \
 				   -fno-builtin -fpic \

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
