Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D37BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:07:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF02121916
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C6hSlg0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF02121916
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=S/FApACIWLQguhOrL78qG3euxtpyEd710mYYdMEDtCE=; b=C6hSlg0c6+JJJ3IQTjV9deCtv
	i8EDYSCKhzYy3rtDJo3mcK9SK6kDT7ZTzN/3lF+HHFD5Gya4YnQMjgnFN/T5ipa/O72itopcNpPXC
	GsvFMDuTCY9YV8N5WhDNEAyzQ+dYcGrbMbIy3la5/1vR9uQGzdRu99a+5Z1yq+XwFI9bMlIPcbPHS
	DS9V2YtoI+s0ps54HZ46wiBGLRz5OjnBSBPYWepv4SBqgxTvKPvkDqsRCqXtLQys6YwM/PWEEHJ2S
	NuFOszxDhZmEw9TtSFTiYg4T0/+zYueMIFPg4RorHfrNelonlRrxxA3oRvLGvPJ7Bps+KCnRjEm1Q
	d2jbsuutA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvjaG-0000eR-3x; Mon, 18 Feb 2019 14:07:48 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvjaC-0000dI-PA
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 14:07:46 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 084E7A78;
 Mon, 18 Feb 2019 06:07:34 -0800 (PST)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A6C33F720;
 Mon, 18 Feb 2019 06:07:27 -0800 (PST)
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
To: Julia Cartwright <julia@ni.com>
References: <20190208165513.8435-1-julien.grall@arm.com>
 <20190212171350.GB1002@jcartwri.amer.corp.natinst.com>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <7671d868-9d33-dfe1-851a-b72271f12d5f@arm.com>
Date: Mon, 18 Feb 2019 14:07:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212171350.GB1002@jcartwri.amer.corp.natinst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_060745_146841_F0DB645F 
X-CRM114-Status: GOOD (  23.72  )
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
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/02/2019 17:13, Julia Cartwright wrote:
> Hello Julien-

Hello Julien,

> 
> On Fri, Feb 08, 2019 at 04:55:13PM +0000, Julien Grall wrote:
>> When the kernel is compiled with CONFIG_KERNEL_MODE_NEON, some part of
>> the kernel may be able to use FPSIMD/SVE. This is for instance the case
>> for crypto code.
>>
>> Any use of FPSIMD/SVE in the kernel are clearly marked by using the
>> function kernel_neon_{begin, end}. Furthermore, this can only be used
>> when may_use_simd() returns true.
>>
>> The current implementation of may_use_simd() allows softirq to use
>> FPSIMD/SVE unless it is currently in used (i.e kernel_neon_busy is true).
>> When in used, softirqs usually fallback to a software method.
>>
>> At the moment, as a softirq may use FPSIMD/SVE, softirqs are disabled
>> when touching the FPSIMD/SVE context. This has the drawback to disable
>> all softirqs even if they are not using FPSIMD/SVE.
>>
>> As a softirq should not rely on been able to use simd at a given time,
>> there are limited reason to keep softirq disabled when touching the
>> FPSIMD/SVE context. Instead, we can only disable preemption and tell
>> the NEON unit is currently in use.
>>
>> This patch introduces two new helpers kernel_neon_{disable, enable} to
>> mark the area using FPSIMD/SVE context and use them in replacement of
>> local_bh_{disable, enable}. The functions kernel_neon_{begin, end} are
>> also re-implemented to use the new helpers.
>>
>> Signed-off-by: Julien Grall <julien.grall@arm.com>
>>
>> ---
>>
>> I have been exploring this solution as an alternative approach to the RT
>> patch "arm64: fpsimd: use preemp_disable in addition to local_bh_disable()".
>>
>> So far, the patch has only been lightly tested.
>>
>> For RT-linux, it might be possible to use migrate_{enable, disable}. I
>> am quite new with RT and have some trouble to understand the semantics
>> of migrate_{enable, disable}. So far, I am still unsure if it is possible
>> to run another userspace task on the same CPU while getting preempted
>> when the migration is disabled.
> 
> Yes, a thread in a migrate_disable()-protected critical section can be
> preempted, and another thread on the same CPU may enter the critical
> section.
> 
> If it's necessary to prevent this from happening, then you need to also
> make use of a per-CPU mutex.  On RT, this would do the right thing
> w.r.t. priority inheritance.

Thank you for the explanation, I now understand better the concept of 
migrate_disable.

Best regards,

-- 
Julien Grall

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
