Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956BBC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:11:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63ECF222B2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="frUJLvJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63ECF222B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G4I/Y65AxBAiZhvVw1Ixt12KNhNVra6/XPzxI5uxOfo=; b=frUJLvJrc0xAap
	5008FnbMh8BmGvkSqrCgiOQc2hOhUVmAb07ESy0G1D2fuRN7IO5kkn+DTJDY+3oqRLz2MD0ipgDoW
	J5EBeGCKca/dpWEKTgMIwEBk1NXMjX5h37cFQqjLNcmszJXbzEZDKsqd3B/wIBOjA9RTz2W9OktVH
	mnPRD+xLTVxG20W9+Um+Cxwyoc0KjZJi50VDmhC5gDCvhyRoZsQcG4bUWxtZD6YnYTs5KD5WAVGKr
	aCuVP1m8E3n1d9JiIDCgBdLce8gahfeNb8e/I9eQfgRPZBX9NpcTiI1I4U6iujlIrfnOn89gQ/kh6
	ztoUulSE3jICobEoER5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtsRe-0005mZ-5q; Wed, 13 Feb 2019 11:11:14 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtsRb-0005lr-MC
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 11:11:13 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F58BA78;
 Wed, 13 Feb 2019 03:11:11 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 176FB3F557;
 Wed, 13 Feb 2019 03:11:06 -0800 (PST)
Subject: Re: [PATCH v8 0/5] arm64: ftrace with regs
To: Torsten Duwe <duwe@lst.de>, Mark Rutland <mark.rutland@arm.com>,
 Will Deacon <will.deacon@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>
References: <20190208150826.44EBC68DD2@newverein.lst.de>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <0f8d2e77-7e51-fba8-b179-102318d9ff84@arm.com>
Date: Wed, 13 Feb 2019 11:11:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190208150826.44EBC68DD2@newverein.lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_031111_731311_56AC9DB8 
X-CRM114-Status: GOOD (  16.86  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Torsten,

On 08/02/2019 15:08, Torsten Duwe wrote:
> Patch series v8, as discussed.
> The whole series applies cleanly on 5.0-rc5
> 

For this series:

Tested-by: Julien Thierry <julien.thierry@arm.com>

> ---
>  arch/arm64/Kconfig                    |    4 +
>  arch/arm64/Makefile                   |   10 ++
>  arch/arm64/include/asm/ftrace.h       |   16 ++++
>  arch/arm64/include/asm/module.h       |    3 
>  arch/arm64/kernel/Makefile            |   12 +--
>  arch/arm64/kernel/entry-ftrace.S      |  125 ++++++++++++++++++++++++++++++++--
>  arch/arm64/kernel/ftrace.c            |  117 ++++++++++++++++++++++++-------
>  arch/arm64/kernel/module-plts.c       |    3 
>  arch/arm64/kernel/module.c            |    2 
>  arch/arm64/lib/Makefile               |    4 -
>  drivers/firmware/efi/libstub/Makefile |   12 +--
>  include/asm-generic/vmlinux.lds.h     |    2 
>  include/linux/compiler_types.h        |    4 +
>  kernel/module.c                       |   14 +++
>  mm/kasan/Makefile                     |    8 +-
>  15 files changed, 281 insertions(+), 55 deletions(-)
> ---
> changes since v7:
> 
> * -pg -> $(CC_FLAGS_FTRACE) cleanup now split according to subtree
>   maintainership.
> 
> * REC_IP_BRANCH_OFFSET is gone, the functionality went into
>   ftrace_call_adjust(), where it belongs.
> 
> * MOV_X9_X30 macro is gone (why did we argue about its name anyway?);
>   it is only used once now in the initial ftrace_make_nop new helper
>   function ftrace_setup_lr_saver(), suggested by Julien.
> 
> * call site processing was missing for modules. Fixed.
> 
> changes since v6:
> 
> * change the stack layout once more; I hope I have it the "standard" way now.
>   And yes, it looks simpler and cleaner; thanks, Mark, for nagging.
> 
> * split out the independent Kconfig and Makefile changes
> 
> * fixed style issues
> 
> * s/fp/x29/g
> 
> * MCOUNT_ADDR is now merely a 64-bit magic, as this is totally sufficient.
> 
> * QUICK_LR_SAVE renamed back to MOV_X9_X30.
> 
> * place MOV_X9_X30 insns on bootup, and only flip b <-> nop at runtime
> 
> * graph tracer "ifdeffery" reshuffle
> 
> 	Torsten
>   
> 

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
