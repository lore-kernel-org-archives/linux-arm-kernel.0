Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B98C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:31:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F6C218A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mRLeNlpv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F6C218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cxbsxnpakII4zNXwBWA/ntH+GQ/cl0kSpcSxjgbEgJk=; b=mRLeNlpvhUQqk+
	oXTOQmNGe0ulAqB1iJdNtUVdsWQ3vbwLQt9baKHgCU2VJFq9GaTNZp0/7QHQpL3jJMm9u5/+tGftb
	8bn+oprVOljmDmWStnBfcLJVMf+uRgFLODxHrfKtjrlmaN2YoW4xyKLQd7ZkeslQgo14s8tyRZc17
	hrauTzS2/lHzev4qkpGLMj8Eay7F2e46iJQ6i05sko2pFvQR246ubjb+kqUDv1tb5DMUvp9mJkjUE
	pJzKItfrf4Lv01xlfucpdcYq+uNe12eBt2pDKccUeIw6Wpdjnd7iqeIuTul1rRKZI35HYR6HxlzV+
	CZbQZyuIEmElPLev7SkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grJXy-0008Tb-Cd; Wed, 06 Feb 2019 09:31:10 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grJXu-0008TF-TJ
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 09:31:08 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0DF1A78;
 Wed,  6 Feb 2019 01:31:05 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E24503F719;
 Wed,  6 Feb 2019 01:31:02 -0800 (PST)
Subject: Re: [PATCH v7 2/3] arm64: implement ftrace with regs
From: Julien Thierry <julien.thierry@arm.com>
To: Torsten Duwe <duwe@lst.de>, Mark Rutland <mark.rutland@arm.com>,
 Will Deacon <will.deacon@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>
References: <20190118163736.6A99268CEB@newverein.lst.de>
 <20190118163908.E338E68D93@newverein.lst.de>
 <e206e229-7813-2d37-d5c6-7a9785e311c9@arm.com>
Message-ID: <22289b8e-bfdf-37cb-0234-2233a528ef61@arm.com>
Date: Wed, 6 Feb 2019 09:30:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <e206e229-7813-2d37-d5c6-7a9785e311c9@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_013106_959002_C8BF5593 
X-CRM114-Status: GOOD (  24.74  )
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



On 06/02/2019 08:59, Julien Thierry wrote:
> Hi Torsten,
> 
> On 18/01/2019 16:39, Torsten Duwe wrote:
>> Once gcc8 adds 2 NOPs at the beginning of each function, replace the
>> first NOP thus generated with a quick LR saver (move it to scratch reg
>> x9), so the 2nd replacement insn, the call to ftrace, does not clobber
>> the value. Ftrace will then generate the standard stack frames.
>>
>> Note that patchable-function-entry in GCC disables IPA-RA, which means
>> ABI register calling conventions are obeyed *and* scratch registers
>> such as x9 are available.
>>
>> Introduce and handle an ftrace_regs_trampoline for module PLTs, right
>> after ftrace_trampoline, and double the size of this special section.
>>
>> Signed-off-by: Torsten Duwe <duwe@suse.de>
>>
>> ---
>>
>> Mark, if you see your ftrace entry macro code being represented correctly
>> here, please add your sign-off, As I've initially copied it from your mail.
>>
>> ---
>>  arch/arm64/include/asm/ftrace.h  |   17 ++++-
>>  arch/arm64/include/asm/module.h  |    3 
>>  arch/arm64/kernel/entry-ftrace.S |  125 +++++++++++++++++++++++++++++++++++++--
>>  arch/arm64/kernel/ftrace.c       |  114 ++++++++++++++++++++++++++---------
>>  arch/arm64/kernel/module-plts.c  |    3 
>>  arch/arm64/kernel/module.c       |    2 
>>  6 files changed, 227 insertions(+), 37 deletions(-)
> 
> [...]
> 
>> --- a/arch/arm64/kernel/ftrace.c
>> +++ b/arch/arm64/kernel/ftrace.c
>> @@ -133,17 +163,45 @@ int ftrace_make_call(struct dyn_ftrace *
>>  	return ftrace_modify_code(pc, old, new, true);
>>  }
>>  
>> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>> +int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
>> +			unsigned long addr)
>> +{
>> +	unsigned long pc = rec->ip + REC_IP_BRANCH_OFFSET;
>> +	u32 old, new;
>> +
>> +	old = aarch64_insn_gen_branch_imm(pc, old_addr, true);
>> +	new = aarch64_insn_gen_branch_imm(pc, addr, true);
>> +
>> +	return ftrace_modify_code(pc, old, new, true);
>> +}
>> +#endif
>> +
>>  /*
>>   * Turn off the call to ftrace_caller() in instrumented function
>>   */
>>  int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
>>  		    unsigned long addr)
>>  {
>> -	unsigned long pc = rec->ip;
>> +	unsigned long pc = rec->ip + REC_IP_BRANCH_OFFSET;
> 
> Sorry to come back on this patch again, but I was looking at the ftrace
> code a bit, and I see that when processing the ftrace call locations,
> ftrace calls ftrace_call_adjust() on every ip registered as mcount
> caller (or in our case patchable entries). This ftrace_call_adjust() is
> arch specific, so I was thinking we could place the offset in here once
> and for all so we don't have to worry about it in the future.
> 
> Also, I'm unsure whether it would be safe, but we could patch the "mov
> x9, lr" there as well. In theory, this would be called at init time
> (before secondary CPUs are brought up) and when loading a module (so I'd
> expect no-one is executing that code *yet*.
> 

And if the above works, we could also define CC_HAVE_NOP_MCOUNT (when we
have the patchable entry) and then we just not have to worry about the
initial ftrace_make_nop() with MCOUNT_ADDR.

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
