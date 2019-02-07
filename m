Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4542C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:47:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1E9521904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bUMrX/mR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E9521904
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Kxp7jdI2pyZyYRbnhF/pC2AKql8/dfp6Q/+xwic7qIg=; b=bUMrX/mR6qmniZ
	duiwK1x50zUqTiP0Iv8kt2XUu3WBYN0sbKeE+fLh9R4dTxwbZBrgRx1AHU2LnQEF0hGks72RW08v9
	xQSg57GFSZi3cLPow9ysM9HV6HXJ82UXD43S6zN6ub2Nb8QY7DduU1swGU442jAVxqzLHNhZOMPpj
	uRna1yY45ZRi08BWwShC6aj83MhvbuIVPv5pY5I5jxLm0WycCd9aSSRoz+LsSLhFUD4kk/+xQRuDi
	8GZ1EFASmG4qWp9kMnnu9lTx148XwjT2KbqfdntGYZdc/3GzCuxPLQuyH4GUorNodVMyweLbJ9V+9
	JT0AvKg8Je9dZTX4ZbKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grk1l-0001In-6m; Thu, 07 Feb 2019 13:47:41 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grk1i-0001IH-44
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 13:47:39 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77871EBD;
 Thu,  7 Feb 2019 05:47:37 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3573F3F675;
 Thu,  7 Feb 2019 05:47:33 -0800 (PST)
Subject: Re: [PATCH v7 2/3] arm64: implement ftrace with regs
To: Torsten Duwe <duwe@lst.de>
References: <20190118163736.6A99268CEB@newverein.lst.de>
 <20190118163908.E338E68D93@newverein.lst.de>
 <e206e229-7813-2d37-d5c6-7a9785e311c9@arm.com>
 <20190206150524.GA28892@lst.de>
 <198550d8-78d4-6e30-0179-b5e07dd140f8@arm.com>
 <20190207125159.GA19818@lst.de>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <9bfb0506-5e8e-98d8-1946-9b6eaa4084b9@arm.com>
Date: Thu, 7 Feb 2019 13:47:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190207125159.GA19818@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_054738_274649_7A3FB909 
X-CRM114-Status: GOOD (  25.93  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Ingo Molnar <mingo@redhat.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>, live-patching@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 07/02/2019 12:51, Torsten Duwe wrote:
> On Thu, Feb 07, 2019 at 10:33:50AM +0000, Julien Thierry wrote:
>>
>>
>> On 06/02/2019 15:05, Torsten Duwe wrote:
>>> On Wed, Feb 06, 2019 at 08:59:44AM +0000, Julien Thierry wrote:
>>>> Hi Torsten,
>>>>
>>>> On 18/01/2019 16:39, Torsten Duwe wrote:
>>>>
>>>>> --- a/arch/arm64/kernel/ftrace.c
>>>>> +++ b/arch/arm64/kernel/ftrace.c
>>>>> @@ -133,17 +163,45 @@ int ftrace_make_call(struct dyn_ftrace *
>>>>>  	return ftrace_modify_code(pc, old, new, true);
>>>>>  }
>>>>>  
>>>>> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>>>>> +int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
>>>>> +			unsigned long addr)
>>>>> +{
>>>>> +	unsigned long pc = rec->ip + REC_IP_BRANCH_OFFSET;
>>>>> +	u32 old, new;
>>>>> +
>>>>> +	old = aarch64_insn_gen_branch_imm(pc, old_addr, true);
>>>>> +	new = aarch64_insn_gen_branch_imm(pc, addr, true);
>>>>> +
>>>>> +	return ftrace_modify_code(pc, old, new, true);
>>>>> +}
>>>>> +#endif
>>>>> +
>>>>>  /*
>>>>>   * Turn off the call to ftrace_caller() in instrumented function
>>>>>   */
>>>>>  int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
>>>>>  		    unsigned long addr)
>>>>>  {
>>>>> -	unsigned long pc = rec->ip;
>>>>> +	unsigned long pc = rec->ip + REC_IP_BRANCH_OFFSET;
>>>>
>>>> Sorry to come back on this patch again, but I was looking at the ftrace
>>>> code a bit, and I see that when processing the ftrace call locations,
>>>> ftrace calls ftrace_call_adjust() on every ip registered as mcount
>>>> caller (or in our case patchable entries). This ftrace_call_adjust() is
>>>> arch specific, so I was thinking we could place the offset in here once
>>>> and for all so we don't have to worry about it in the future.
>>>
>>> Now that you mention it - yes indeed that's the correct facility to fix
>>> the deviating address, as Steve has also confirmed. I had totally forgotten
>>> about this hook.
>>>
>>>> Also, I'm unsure whether it would be safe, but we could patch the "mov
>>>> x9, lr" there as well. In theory, this would be called at init time
>>>> (before secondary CPUs are brought up) and when loading a module (so I'd
>>>> expect no-one is executing that code *yet*.
>>>>
>>>> If this is possible, I think it would make things a bit cleaner.
>>>
>>> This is in fact very tempting, but it will introduce a nasty side effect
>>> to ftrace_call_adjust. Is there any obvious documentation that specifies
>>> guarantees about ftrace_call_adjust being called exactly once for each site?
>>>
>>
>> I don't see really much documentation on that function. As far as I can
>> tell it is only called once for each site (and if it didn't, we'd always
>> be placing the same instruction, but I agree it wouldn't be nice). It
>> could depend on how far you can expand the notion of "adjusting" :) .
> 
> I've been thinking this over and I'm considering to make an ftrace_modify_code
> with verify and warn_once if it fails. Then read the insn back and bug_on
> should it not be the lr saver. Any objections?
> 

Hmmm, I'm not really convinced the read back + bug part would really be
useful right after patching this instruction in. ftrace_modify_code()
should already return an error if the instruction patching failed.

A real issue would be if ftrace_call_adjust() would be called on a
location where we shouldn't patch the instruction (i.e. a location that
is not the first instruction of a patchable entry). But to me, it
doesn't look like this function is intended to be called on something
else than the "mcount callsites" (which in our case is that first
patchable instruction).

Cheers,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
