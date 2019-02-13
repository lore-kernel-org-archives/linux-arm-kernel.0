Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5C9C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:30:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A3302190A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="afrfOSzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3302190A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ku9WVsaQurQ0jh+7n1c3OLciML9dIrhTCutfFur/K2s=; b=afrfOSzs37n/bG
	viwMTi1e7SYeWdvlsFQflIOvDlVGzDhVAGpCQiQ3R8UJzNOF3AY4mTSHA5w4JaWQ2a5s/0MJeVczR
	F7FqAyFklCjmnwmRV7A6Qs3Bw9lV+zAQxENuEmzSeFEzNQk/qJ+HApw+rCGgd2dZFyCbFBB4WOfFR
	xcF67xaI5pRnTTXWD0Mu3YABWYHTruGE2SWXXnLRcLzlzPVUIiBOWgzgCWPJ/0Wj5aS02zlJKeSiM
	7+o160AU7j0FHkA/VLlHsLhIlUnzELkj3da8lInSlHjTBeQAf+avYTIaomXEUx6A3C+ECHF7vuWX5
	RsJEGQVtdpT9Bels/c/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtro8-0007WO-9L; Wed, 13 Feb 2019 10:30:24 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtro4-0007Vb-BR
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 10:30:22 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2725A78;
 Wed, 13 Feb 2019 02:30:16 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 795B53F575;
 Wed, 13 Feb 2019 02:30:14 -0800 (PST)
Subject: Re: [PATCH v8 4/5] arm64: implement ftrace with regs
To: Torsten Duwe <duwe@lst.de>, Mark Rutland <mark.rutland@arm.com>,
 Will Deacon <will.deacon@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>
References: <20190208150826.44EBC68DD2@newverein.lst.de>
 <20190208151019.9E7A968DDD@newverein.lst.de>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <c6a24572-84d5-bf0f-f70c-8580a83834a1@arm.com>
Date: Wed, 13 Feb 2019 10:30:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190208151019.9E7A968DDD@newverein.lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_023020_692595_DBF41734 
X-CRM114-Status: GOOD (  19.24  )
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

On 08/02/2019 15:10, Torsten Duwe wrote:
> Implement ftrace with regs, based on the new gcc flag
> -fpatchable-function-entry (=2)
> 
> Now that gcc8 added 2 NOPs at the beginning of each function, replace
> the first NOP thus generated with a quick LR saver (move it to scratch
> reg x9), so the 2nd replacement insn, the call to ftrace, does not
> clobber the value. Ftrace will then generate the standard stack
> frames.
> 
> Note that patchable-function-entry in GCC disables IPA-RA, which means
> ABI register calling conventions are obeyed and scratch registers such
> as x9 are available.
> 
> Introduce and handle an ftrace_regs_trampoline for module PLTs, right
> after ftrace_trampoline in an ftrace_trampolines[2] array, and double
> the size of the corresponding special section.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> 
> ---
>  arch/arm64/include/asm/ftrace.h  |   16 ++++
>  arch/arm64/include/asm/module.h  |    3 
>  arch/arm64/kernel/entry-ftrace.S |  125 +++++++++++++++++++++++++++++++++++++--
>  arch/arm64/kernel/ftrace.c       |  117 ++++++++++++++++++++++++++++--------
>  arch/arm64/kernel/module-plts.c  |    3 
>  arch/arm64/kernel/module.c       |    2 
>  6 files changed, 231 insertions(+), 35 deletions(-)

[...]

> --- a/arch/arm64/include/asm/module.h
> +++ b/arch/arm64/include/asm/module.h
> @@ -32,7 +32,8 @@ struct mod_arch_specific {
>  	struct mod_plt_sec	init;
>  
>  	/* for CONFIG_DYNAMIC_FTRACE */
> -	struct plt_entry 	*ftrace_trampoline;
> +	struct plt_entry	*ftrace_trampolines;
> +#define MOD_ARCH_NR_FTRACE_TRAMPOLINES	2

Nit: I'd define this outside of the struct, just below
MODULE_ARCH_VERMAGIC, and use the prefix "MODULE_ARCH" instead of
"MOD_ARCH" as this seem to be already in use for a few other defines.

Otherwise things look good to me:

Reviewed-by: Julien Thierry <julien.thierry@arm.com>

Cheers,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
