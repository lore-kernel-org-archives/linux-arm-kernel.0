Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48169C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:05:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 199562070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lwmx6s2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199562070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QjQgrcrfRFs3btoegVwzbg0gs6B5GJWG2tvBSOaqkog=; b=Lwmx6s2LLCMd89
	4i9vo2KB/5wrIGbUM3Y4vnyykQAwv7i779NnITYU2ZebGFE8skk4pGJS8AHbpVBfpMJkayNJkYCHj
	EJzQT7cFAq6VsP1yL88g9lJrWAmZgMRjod6zs/jyKV8bAL7HwmwGZaYyEL8EzYhDXMER50oPrRcC+
	04Qf5q3jKQnb1l6NBNIaxJeZWjKqjM1kqSg3DhG7tuOoaMpsYWWw/jMeWjXFnT1w1HS+9EVKuRyzf
	jdGQy9Qw4I1J98JHH8RzzQvgWeoHw/Y81S8yz0nmKs88gOW7MfGbaDRYDJVVGHazxzd6+SBgTvpcl
	G0BxvL4d8QQuQewhU1JA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf6Qy-0005lo-01; Thu, 03 Jan 2019 17:05:28 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf6Qu-0005kz-De
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 17:05:25 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5A8615AD;
 Thu,  3 Jan 2019 09:05:21 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B8AB3F5D4;
 Thu,  3 Jan 2019 09:05:20 -0800 (PST)
Subject: Re: [PATCH 1/3] arm64: kprobes: Move extable address check into
 arch_prepare_kprobe()
To: Masami Hiramatsu <mhiramat@kernel.org>
References: <154502881646.30629.9938335052821665530.stgit@devbox>
 <154502884653.30629.3172839440883293817.stgit@devbox>
From: James Morse <james.morse@arm.com>
Message-ID: <aec51c10-d744-df0f-1216-d3372e779cb1@arm.com>
Date: Thu, 3 Jan 2019 17:05:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <154502884653.30629.3172839440883293817.stgit@devbox>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_090524_466187_9EC1F24A 
X-CRM114-Status: GOOD (  15.34  )
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
Cc: Pratyush Anand <panand@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "David A . Long" <dave.long@linaro.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi!

On 17/12/2018 06:40, Masami Hiramatsu wrote:
> Move extable address check into arch_prepare_kprobe() from
> arch_within_kprobe_blacklist().

I'm trying to work out the pattern for what should go in the blacklist, and what
should be rejected by the arch code.

It seems address-ranges should be blacklisted as the contents don't matter.
easy-example: the idmap text.

The arch code should also reject instructions that can't be probed from
arch_prepare_kprobe(). easy-example: exclusive load or store.


> Please do not blacklisting instructions on exception_table,
> since it is a kind of architectural unsupported instruction.

This doesn't fit the pattern, ... what should it be?

The instructions in the exception_table don't matter, its the address that
indicates there is a fixup for page-faults that occur here. We don't need to
look at the instruction to determine this, why can't we treated these as a
blacklisted range?


Thanks,

James


> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index 2a5b338b2542..b2d4b7428ebc 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -102,6 +102,10 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  
>  	if (in_exception_text(probe_addr))
>  		return -EINVAL;
> +
> +	if (search_exception_tables(probe_addr))
> +		return -EINVAL;
> +
>  	if (probe_addr >= (unsigned long) __start_rodata &&
>  	    probe_addr <= (unsigned long) __end_rodata)
>  		return -EINVAL;
> @@ -477,8 +481,7 @@ bool arch_within_kprobe_blacklist(unsigned long addr)
>  	    (addr >= (unsigned long)__entry_text_start &&
>  	    addr < (unsigned long)__entry_text_end) ||
>  	    (addr >= (unsigned long)__idmap_text_start &&
> -	    addr < (unsigned long)__idmap_text_end) ||
> -	    !!search_exception_tables(addr))
> +	    addr < (unsigned long)__idmap_text_end))
>  		return true;
>  
>  	if (!is_kernel_in_hyp_mode()) {
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
