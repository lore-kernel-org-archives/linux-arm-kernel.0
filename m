Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19559C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:22:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA87E21841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JMAPRm9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA87E21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hTgE6XxfKGC5PQUeR6VN/Mlt2x8OcIMZQTkM/SOuYRI=; b=JMAPRm9VX9h/jE
	jLAIclviaLWY07g4clTVRK3OXsejRiLgGt3qYrqWa8RkxC8eqcAa+rceChe9uptNGGNXoy2ekGoWh
	XT1Tkd2+giWWjRLV0O2MIcfntt2+/Fj2Vs5pWgTwcYCn20km9e3Y4fCCHBoHQnDLbHM5PcQ2z3GaK
	NOJ3LVCVTZB6m90R1R36FhYG+1DhPA3XEiRMUGUx0xe9jS1nk3FyWqiEirbzTqgrzjoU7L/tU2Pyb
	STDjgZwfhvIuSvQL2jEgU7qDj7++Pf6NijPHBhWukamfxbppo9gkhY8Pel0ka6feFdKv/zoyqOjDL
	xgjkIwk3cvEW6F2g8MzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi1SC-00043s-OI; Fri, 11 Jan 2019 18:22:48 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi1S8-00043G-QJ
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 18:22:46 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 145BC80D;
 Fri, 11 Jan 2019 10:22:42 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 760CD3F6CF;
 Fri, 11 Jan 2019 10:22:40 -0800 (PST)
Subject: Re: [PATCH 1/3] arm64: kprobes: Move extable address check into
 arch_prepare_kprobe()
To: Masami Hiramatsu <mhiramat@kernel.org>
References: <154502881646.30629.9938335052821665530.stgit@devbox>
 <154502884653.30629.3172839440883293817.stgit@devbox>
 <aec51c10-d744-df0f-1216-d3372e779cb1@arm.com>
 <20190108113953.8bc0cc7d196ddba370377217@kernel.org>
 <b4109104-c438-f4c2-352a-d8b0ec47db37@arm.com>
 <20190109110500.b4b5049f4c67dfc85b9ced4e@kernel.org>
From: James Morse <james.morse@arm.com>
Message-ID: <92c160a8-7627-0c64-ed73-df616e9c057d@arm.com>
Date: Fri, 11 Jan 2019 18:22:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190109110500.b4b5049f4c67dfc85b9ced4e@kernel.org>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_102244_854584_9D99D246 
X-CRM114-Status: GOOD (  15.76  )
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

Hi,

On 09/01/2019 02:05, Masami Hiramatsu wrote:
> On Tue, 8 Jan 2019 17:13:36 +0000
> James Morse <james.morse@arm.com> wrote:
>> On 08/01/2019 02:39, Masami Hiramatsu wrote:
>>> On Thu, 3 Jan 2019 17:05:18 +0000
>>> James Morse <james.morse@arm.com> wrote:
>>>> On 17/12/2018 06:40, Masami Hiramatsu wrote:
>>>>> Move extable address check into arch_prepare_kprobe() from
>>>>> arch_within_kprobe_blacklist().
>>>>
>>>> I'm trying to work out the pattern for what should go in the blacklist, and what
>>>> should be rejected by the arch code.
>>>>
>>>> It seems address-ranges should be blacklisted as the contents don't matter.
>>>> easy-example: the idmap text.
>>>
>>> Yes, more precisely, the code smaller than a function (symbol), it must be
>>> rejected by arch_prepare_kprobe(), since blacklist is poplated based on
>>> kallsyms.
>>
>> Ah, okay, so the pattern is the blacklist should only be for whole symbols,
>> (which explains why its usually based on sections).
> 
> Correct. Actually, the blacklist is generated based on the symbol info
> from symbol address.
> 
>> I see kprobe_add_ksym_blacklist() would go wrong if you give it something like:
>> platform_drv_probe+0x50/0xb0, as it will log platform_drv_probe+0x50 as the
>> start_addr and platform_drv_probe+0x50+0xb0 as the end.
> 
> Yes, it expects given address is the entry of a symbol.

>> But how does anything from the arch code's blacklist get into the
>> kprobe_blacklist list?
> 
> It should be done via arch_populate_kprobe_blacklist().

>> We don't have an arch_populate_kprobe_blacklist(), so rely on
>> within_kprobe_blacklist() calling arch_within_kprobe_blacklist() with the
>> address, as well as walking kprobe_blacklist.
>>
>> Is this cleanup ahead of a series that does away with
>> arch_within_kprobe_blacklist() so that debugfs list is always complete?
> 
> Right, after this cleanup, I will send arch_populate_kprobe_blacklist()
> patch for arm64 and others. My plan is to move all arch_within_kprobe_blacklist()
> to arch_populate_kprobe_blacklist() so that user can get more precise blacklist
> via debugfs.

Thanks, now it all makes sense!

Reviewed-by: James Morse <james.morse@arm.com>


Could you include a paragraph like that in the cover-letter or commit-message?
The 'fix' in the cover-letter subject had me looking for the bug!


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
