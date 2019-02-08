Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464C9C4151A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:22:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B9E12146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XiHpiL63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B9E12146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:From:Date:
	Message-Id:References:In-Reply-To:Subject:To:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=9I92omHbe+5uLY+HpHTE4yvogK1YuqjWvs0jeRJBe0s=; b=XiHpiL63bskidnHWurC+rv/Qvg
	HEb1tXPy2ZLW7H80kTyhDNL4GUnIAcY1QkDsP8lVN3U0ZbVGD/yCJ8Ap3CZ2mWdoOK4Bt45uaHZ4p
	wvl7sJuZnTjKsESUtzn3rLDvb/fBCPJh4v684POsdq3PITwIAxiXe3l41azYgj7aTQCFVeYxxjY2c
	T1mY9m4L2vXivRrvdUXVWQtdxfXAj6dfBNXSFr4ZfrcQzQmCnE/ymJoZHb8EUFkBaxZPh2H0ty9Gh
	6UfRSERrK85a6ePWl0O7cczdw1eavtYZyLfJrYfM7ZDpIdaFjEykafu//TGaxlpHNC/ZqwIEyuPKj
	2hE6mSew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs7z6-00008E-Lg; Fri, 08 Feb 2019 15:22:32 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs7nA-00014E-GX
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 15:10:46 +0000
Received: by newverein.lst.de (Postfix, from userid 2005)
 id 0807668DD3; Fri,  8 Feb 2019 16:10:11 +0100 (CET)
To: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Julien Thierry <julien.thierry@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: [PATCH v8 2/5] arm64: replace -pg with CC_FLAGS_FTRACE in efi
 Makefiles
In-Reply-To: <20190208150826.44EBC68DD2@newverein.lst.de>
References: <20190208150826.44EBC68DD2@newverein.lst.de>
Message-Id: <20190208151011.0807668DD3@newverein.lst.de>
Date: Fri,  8 Feb 2019 16:10:11 +0100 (CET)
From: duwe@lst.de (Torsten Duwe)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_071013_334485_8132869A 
X-CRM114-Status: UNSURE (   6.80  )
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
Cc: live-patching@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

  In preparation for arm64 supporting ftrace built on other compiler
  options, let's have makefiles remove the $(CC_FLAGS_FTRACE)
  flags, whatever these may be, rather than assuming '-pg'.
  While at it, fix arm32 as well.

  There should be no functional change as a result of this patch.

Signed-off-by: Torsten Duwe <duwe@suse.de>

---
 drivers/firmware/efi/libstub/Makefile |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -16,9 +16,9 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__K
 
 # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
 # disable the stackleak plugin
-cflags-$(CONFIG_ARM64)		:= $(subst -pg,,$(KBUILD_CFLAGS)) -fpie \
-				   $(DISABLE_STACKLEAK_PLUGIN)
-cflags-$(CONFIG_ARM)		:= $(subst -pg,,$(KBUILD_CFLAGS)) \
+cflags-$(CONFIG_ARM64)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
+				   -fpie $(DISABLE_STACKLEAK_PLUGIN)
+cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 				   -fno-builtin -fpic \
 				   $(call cc-option,-mno-single-pic-base)
 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
