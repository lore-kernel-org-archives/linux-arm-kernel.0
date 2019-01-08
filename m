Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC4EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:13:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 427EA2070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iN+Hn9+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427EA2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7Mm59o2fvS6bqarnhG/NHd50HPdqplo24XVC+36AXvE=; b=iN+Hn9+rlCpYYc
	GjVRQyYhZfcXPUdqQlc6B//N8KDyt5msJEarLXMUyHVD7A1bJgPqykoYd7bWFfDoSGyUDiX2gTBco
	NG3R749GlR4PX/m/tDmm+6w6CpHdPOxVJRta7SHlCITTuTUckzvzRTcAzZxj40w5zcCmHRslEw7OU
	8O8rV7Vjycbob9ODsbz7TuR35iOC1HDZHHcjsoYRdkLnb6tu1U0OrUKGiX6f9S1l0DQhXA4z4PBPk
	XxLylHF0ne2gM1FqxFkhY6NoAgs8NIOIAw5wN8BuGJ6fgxki/jqmhPni+xqt9XsGa1UjysjWhtmuw
	SkpRP1ITytTJEVNJ8IXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gguwh-0004CU-Ty; Tue, 08 Jan 2019 17:13:43 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gguwe-0004Bp-OY
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 17:13:42 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D36DBA78;
 Tue,  8 Jan 2019 09:13:38 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B7F13F5AF;
 Tue,  8 Jan 2019 09:13:37 -0800 (PST)
Subject: Re: [PATCH 1/3] arm64: kprobes: Move extable address check into
 arch_prepare_kprobe()
To: Masami Hiramatsu <mhiramat@kernel.org>
References: <154502881646.30629.9938335052821665530.stgit@devbox>
 <154502884653.30629.3172839440883293817.stgit@devbox>
 <aec51c10-d744-df0f-1216-d3372e779cb1@arm.com>
 <20190108113953.8bc0cc7d196ddba370377217@kernel.org>
From: James Morse <james.morse@arm.com>
Message-ID: <b4109104-c438-f4c2-352a-d8b0ec47db37@arm.com>
Date: Tue, 8 Jan 2019 17:13:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190108113953.8bc0cc7d196ddba370377217@kernel.org>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_091340_802430_FD214A83 
X-CRM114-Status: GOOD (  16.31  )
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

On 08/01/2019 02:39, Masami Hiramatsu wrote:
> On Thu, 3 Jan 2019 17:05:18 +0000
> James Morse <james.morse@arm.com> wrote:
>> On 17/12/2018 06:40, Masami Hiramatsu wrote:
>>> Move extable address check into arch_prepare_kprobe() from
>>> arch_within_kprobe_blacklist().
>>
>> I'm trying to work out the pattern for what should go in the blacklist, and what
>> should be rejected by the arch code.
>>
>> It seems address-ranges should be blacklisted as the contents don't matter.
>> easy-example: the idmap text.
> 
> Yes, more precisely, the code smaller than a function (symbol), it must be
> rejected by arch_prepare_kprobe(), since blacklist is poplated based on
> kallsyms.

Ah, okay, so the pattern is the blacklist should only be for whole symbols,
(which explains why its usually based on sections).

I see kprobe_add_ksym_blacklist() would go wrong if you give it something like:
platform_drv_probe+0x50/0xb0, as it will log platform_drv_probe+0x50 as the
start_addr and platform_drv_probe+0x50+0xb0 as the end.

But how does anything from the arch code's blacklist get into the
kprobe_blacklist list?

We don't have an arch_populate_kprobe_blacklist(), so rely on
within_kprobe_blacklist() calling arch_within_kprobe_blacklist() with the
address, as well as walking kprobe_blacklist.

Is this cleanup ahead of a series that does away with
arch_within_kprobe_blacklist() so that debugfs list is always complete?


> As I pointed, the exception_table contains some range of code which inside
> functions, must be smaller than function.
> Since those instructions are expected to cause exception (that is main reason
> why it can not be probed on arm64), I thought such situation was similar to
> the limitation of instruction.
> 
> So I think below will be better.
> ----
> Please do not blacklisting instructions on exception_table,
> since those are smaller than one function.
> ----

I keep tripping over this because the exception_table lists addresses that are
allowed to fault. Nothing looks at the instruction, and we happily kprobe the
same instruction elsewhere.

(based on my assumptions about where you are going next!,), How about:
| The blacklist is exposed via debugfs as a list of symbols. extable entries are
| smaller, so must be filtered out by arch_prepare_kprobe().

(only we currently have more than one blacklist...)


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
