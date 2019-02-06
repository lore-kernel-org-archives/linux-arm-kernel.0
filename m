Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F147C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:00:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC1120823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ge3ogCGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC1120823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7tHwPQ3VsFI6Dl3/NhcKWYW+omIwCfEloXDGvJWrklo=; b=ge3ogCGjFQ72zA
	9nlxW6i2MOh105TOKRqjz7LoQMXdo1kxPJXECbFZyKlCQ5Horio7c/gDlYkdX8QZDsYAP9PfoJf9c
	0sfN/xBw6q6gV6B/tf5LQkOXUWmgu3j/2j9JvOSyO5zuy/C9F09RVEB7/nOg7DHBDq5EdZfqoh0wF
	E1A8AOPlwkqr38MSO5/aFF2XtzatlGuAYuwQny3sf3MHgNGCj7XcoC6K8KhVIFlmeHjTZOA9zMCo2
	nsdCYj4SafZZgxA/x7Kqe+wGAwG8XV9sQUPJqYIB4pveHnR1iQBh/jhbFm1vYxh9vxZfe9kSU3KxF
	v0iiT8ZHNGoMYaRePybQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grJ3g-00035J-Ub; Wed, 06 Feb 2019 08:59:52 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grJ3e-00034r-6A
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 08:59:51 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C36EA78;
 Wed,  6 Feb 2019 00:59:49 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FD463F719;
 Wed,  6 Feb 2019 00:59:46 -0800 (PST)
Subject: Re: [PATCH v7 2/3] arm64: implement ftrace with regs
To: Torsten Duwe <duwe@lst.de>, Mark Rutland <mark.rutland@arm.com>,
 Will Deacon <will.deacon@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>
References: <20190118163736.6A99268CEB@newverein.lst.de>
 <20190118163908.E338E68D93@newverein.lst.de>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <e206e229-7813-2d37-d5c6-7a9785e311c9@arm.com>
Date: Wed, 6 Feb 2019 08:59:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190118163908.E338E68D93@newverein.lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_005950_233270_FF7A5036 
X-CRM114-Status: GOOD (  23.51  )
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

On 18/01/2019 16:39, Torsten Duwe wrote:
> Once gcc8 adds 2 NOPs at the beginning of each function, replace the
> first NOP thus generated with a quick LR saver (move it to scratch reg
> x9), so the 2nd replacement insn, the call to ftrace, does not clobber
> the value. Ftrace will then generate the standard stack frames.
> 
> Note that patchable-function-entry in GCC disables IPA-RA, which means
> ABI register calling conventions are obeyed *and* scratch registers
> such as x9 are available.
> 
> Introduce and handle an ftrace_regs_trampoline for module PLTs, right
> after ftrace_trampoline, and double the size of this special section.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> 
> ---
> 
> Mark, if you see your ftrace entry macro code being represented correctly
> here, please add your sign-off, As I've initially copied it from your mail.
> 
> ---
>  arch/arm64/include/asm/ftrace.h  |   17 ++++-
>  arch/arm64/include/asm/module.h  |    3 
>  arch/arm64/kernel/entry-ftrace.S |  125 +++++++++++++++++++++++++++++++++++++--
>  arch/arm64/kernel/ftrace.c       |  114 ++++++++++++++++++++++++++---------
>  arch/arm64/kernel/module-plts.c  |    3 
>  arch/arm64/kernel/module.c       |    2 
>  6 files changed, 227 insertions(+), 37 deletions(-)

[...]

> --- a/arch/arm64/kernel/ftrace.c
> +++ b/arch/arm64/kernel/ftrace.c
> @@ -133,17 +163,45 @@ int ftrace_make_call(struct dyn_ftrace *
>  	return ftrace_modify_code(pc, old, new, true);
>  }
>  
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
> +			unsigned long addr)
> +{
> +	unsigned long pc = rec->ip + REC_IP_BRANCH_OFFSET;
> +	u32 old, new;
> +
> +	old = aarch64_insn_gen_branch_imm(pc, old_addr, true);
> +	new = aarch64_insn_gen_branch_imm(pc, addr, true);
> +
> +	return ftrace_modify_code(pc, old, new, true);
> +}
> +#endif
> +
>  /*
>   * Turn off the call to ftrace_caller() in instrumented function
>   */
>  int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
>  		    unsigned long addr)
>  {
> -	unsigned long pc = rec->ip;
> +	unsigned long pc = rec->ip + REC_IP_BRANCH_OFFSET;

Sorry to come back on this patch again, but I was looking at the ftrace
code a bit, and I see that when processing the ftrace call locations,
ftrace calls ftrace_call_adjust() on every ip registered as mcount
caller (or in our case patchable entries). This ftrace_call_adjust() is
arch specific, so I was thinking we could place the offset in here once
and for all so we don't have to worry about it in the future.

Also, I'm unsure whether it would be safe, but we could patch the "mov
x9, lr" there as well. In theory, this would be called at init time
(before secondary CPUs are brought up) and when loading a module (so I'd
expect no-one is executing that code *yet*.

If this is possible, I think it would make things a bit cleaner.

Let me know if that would work.

Thanks,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
