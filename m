Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1399C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:59:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80AC121904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PbziapkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80AC121904
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BkGZcuTrf4cUftFJ5NmVmDsmbG/83efmU45e9hRsgdM=; b=PbziapkJa0AFlh
	PXNSenEH3f93dA2mQYDD3cUScYtE8T9M6guOuNToeaKzdUDCHVU3OobRAlv32eWBttzevgcXdnVxK
	fUyBQr3RPzZkr1YuEvk8aQvMkaHMRtCT8P41vuQa+GwQRedeBdxA2wN3PQzLj9EJxnF5MRs75ZMC1
	urlnt1WGoXttOP/oF4/VSbpNi/4/yCqWJGwZN1VziwpoSzPMFFZEcN/AkpOiK/qSg4AYGEvvbPC8B
	v6AVOR58iDegkmgk94Ql+lGsnwuezfa4odPo//zl71F/IU33ytPKugoCacnj6/EYS/+5TB/7grOpB
	xn9QVdka4bNgXloyGXqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grl8r-00068X-J6; Thu, 07 Feb 2019 14:59:05 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grl8p-00067y-CM
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 14:59:04 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D6C0EBD;
 Thu,  7 Feb 2019 06:59:02 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA5433F719;
 Thu,  7 Feb 2019 06:58:59 -0800 (PST)
Subject: Re: [PATCH v7 2/3] arm64: implement ftrace with regs
To: Steven Rostedt <rostedt@goodmis.org>
References: <20190118163736.6A99268CEB@newverein.lst.de>
 <20190118163908.E338E68D93@newverein.lst.de>
 <e206e229-7813-2d37-d5c6-7a9785e311c9@arm.com>
 <20190206150524.GA28892@lst.de>
 <198550d8-78d4-6e30-0179-b5e07dd140f8@arm.com>
 <20190207095157.3dea1086@gandalf.local.home>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <5efd27b1-81b5-267a-9fe8-67bb084d56eb@arm.com>
Date: Thu, 7 Feb 2019 14:58:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190207095157.3dea1086@gandalf.local.home>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_065903_420557_16559B14 
X-CRM114-Status: GOOD (  26.23  )
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
 linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Ingo Molnar <mingo@redhat.com>, Torsten Duwe <duwe@lst.de>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>, live-patching@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 07/02/2019 14:51, Steven Rostedt wrote:
> On Thu, 7 Feb 2019 10:33:50 +0000
> Julien Thierry <julien.thierry@arm.com> wrote:
> 
>> I don't see really much documentation on that function. As far as I can
>> tell it is only called once for each site (and if it didn't, we'd always
>> be placing the same instruction, but I agree it wouldn't be nice). It
>> could depend on how far you can expand the notion of "adjusting" :) .
>>
>> Steven, do you have an opinion on whether it would be acceptable to
>> modify function entry code in ftrace_call_adjust() ?
> 
> Just to make sure I'm on the same page as you are. You want to modify
> the function entry code at the time of the ftrace_call_adjust()?
> 

Yes, that was the intention, the reason being that we want to have an
instruction that is just patched once on each entry for initialization.

> I would update the rec->ip to the offset you want at
> ftrace_call_adjust() but not do any modifications. It really isn't safe
> to do it there. But right after that is called, you will have the arch
> specific call of ftrace_make_nop() called with MCOUNT_ADDR as the
> second parameter to let you know that this is the first time the call
> is made at this address. This is where you can do that initial
> modifications.

Yes, this is was the current version of this patch is doing, I was just
wondering whether we could clean things up a little (i.e. have
ftrace_make_nop() not generate a non-nop instruction :) ).

But we're not going to hack through the API if this is definitely not
what it's intended for. We'll keep it as is and just update the rec->ip
with ftrace_call_adjust().

If we really want to clean things up, we could look into patching this
at instruction at build time. But if it's not trivial I guess we can
keep that for a later time.

Thanks,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
