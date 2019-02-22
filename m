Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C18C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:42:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF3632075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZCB6+Au6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3632075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T8XWqXAIyXVfF8fYsqmOboZA+54FkZ7FD/14giDXYwE=; b=ZCB6+Au6zS9K5J
	3w6AOoZm3Wnic52ADX9fhPAIexNVmlkaXSXySxGtEEYGgwOumGRMDFbtMF59/S23qyIr8/lMcRYV1
	FpH+woZLUABTDgx1rdL9TsZCB1o7dTvLltxgtoy7DxgHwyzNXQLDjP43MoGBS4yhBqfAxO/zfEtEa
	S9LjS9aF4DYJL07cr3VQTAylafiVPu8zQprAts3Y4sryyHhYhAbra95PjED4DUE+WL35tRTPUfGru
	vG8wq1mYLQqCZp8dYAGbhFwswilOHHgJy6X2dFFx5E/sy15dtCA0dZ8DjI3KhePhuOLjDs0pkAZu9
	5RCOYfCgasgmmJQyt9Ng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxB5v-0002SH-Vu; Fri, 22 Feb 2019 13:42:27 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxB5t-0002RM-32
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 13:42:26 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92274A78;
 Fri, 22 Feb 2019 05:42:24 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E30EE3F690;
 Fri, 22 Feb 2019 05:42:21 -0800 (PST)
Date: Fri, 22 Feb 2019 13:42:19 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v5 04/23] arm64: Substitute gettimeofday with C
 implementation
Message-ID: <20190222134219.GH42419@lakrids.cambridge.arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-5-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190222122430.21180-5-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_054225_134215_952A5A6A 
X-CRM114-Status: GOOD (  13.17  )
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
Cc: linux-arch@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>,
 Dmitry Safonov <0x7f454c46@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 12:24:11PM +0000, Vincenzo Frascino wrote:
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> index 8cd4707f832a..c904b2a9b255 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -6,16 +6,31 @@
>  # Heavily based on the vDSO Makefiles for other archs.
>  #
>  
> -obj-vdso := gettimeofday.o note.o sigreturn.o
> +# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
> +# the inclusion of generic Makefile.
> +ARCH_REL_TYPE_ABS := R_AARCH64_JUMP_SLOT|R_AARCH64_GLOB_DAT|R_AARCH64_ABS64
> +include $(srctree)/lib/vdso/Makefile
> +
> +obj-vdso := vgettimeofday.o note.o sigreturn.o
>  
>  # Build rules
>  targets := $(obj-vdso) vdso.so vdso.so.dbg
>  obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
>  
> -ccflags-y := -shared -fno-common -fno-builtin -ffixed-x18
> +ccflags-y := -shared -fno-common -fno-builtin -ffixed-x18 -fno-stack-protector
> +ccflags-y += -DDISABLE_BRANCH_PROFILING
>  ccflags-y += -nostdlib -Wl,-soname=linux-vdso.so.1 \
>  		$(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
>  
> +VDSO_LDFLAGS := -Bsymbolic
> +
> +CFLAGS_REMOVE_vgettimeofday.o = -pg -Os

Please use CC_FLAGS_FTRACE rather than '-pg'

What said, wouldn't it be better to come up with the VDSO cflags
entirely separately from what the main kernel uses?

That way we're unlikely to have any surprises in future with
instrumentation etc.

I strongly suspect you need to disable more things here, e.g. UBSAN,
KASAN, KCOV. Have you tried compiling a kernel with those features
enabled?

VDSO files probably also need to be marked as OBJECT_FILES_NON_STANDARD.

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
