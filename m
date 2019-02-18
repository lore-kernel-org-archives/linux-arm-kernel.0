Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92876C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:08:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63969217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MBF8N32L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63969217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OzCaELSfI2Tp35h4LR2lcxCnPGVNruwCCtwDST/6PBo=; b=MBF8N32LLke4wFN6EIo8FvOp7
	i9lNaPASxVYBdynhCgOFMnStJLCADyEAKH5IU3dnLKW2XOfaUfCYf63jHd2dgdRaSZRDN3zvxruYr
	h2e+XUFX0P29Pjq77xT00xp8CSXCjE4MLTt62Q6uMFgK9xRCJNw80z8d0MfB+w8fN/o1V3Da6tRjR
	iNQUJEPmMBmyAtNM5sJj7npoq0oGnps8t9WfLWZgU3ZpTFyDbT8N9/eQFvZ7P30ZYk7Pn4tffUUEp
	qGBEdNvI7j1YMUT6syeKXo0bLvf4W215HqeQlSDDC6My7Ofc3Wa+rNnBkwOHXJLi5+ZyKcqcpcZrN
	wwzRz/iEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvkWa-0005FY-QU; Mon, 18 Feb 2019 15:08:04 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvkWW-0005EY-4b
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 15:08:02 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 377B515AB;
 Mon, 18 Feb 2019 07:07:54 -0800 (PST)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC51E3F675;
 Mon, 18 Feb 2019 07:07:52 -0800 (PST)
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
To: Dave Martin <Dave.Martin@arm.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20190208165513.8435-1-julien.grall@arm.com>
 <20190213143029.ad2kzg7vtuo3zpjk@linutronix.de>
 <20190213153630.GK3567@e103592.cambridge.arm.com>
 <CAKv+Gu__0uy6Y-EJGSygSYH4RqpLDWMMNFE3yauF_x7-UNcgFQ@mail.gmail.com>
 <20190213165227.7ekekkxazhbaqxoe@linutronix.de>
 <20190214103449.GN3567@e103592.cambridge.arm.com>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <32ba7e1e-37ce-c904-15e4-9c908e873479@arm.com>
Date: Mon, 18 Feb 2019 15:07:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214103449.GN3567@e103592.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_070800_186927_C0DA776B 
X-CRM114-Status: GOOD (  16.91  )
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
Cc: linux-rt-users@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 14/02/2019 10:34, Dave Martin wrote:
> On Wed, Feb 13, 2019 at 05:52:27PM +0100, Sebastian Andrzej Siewior wrote:
>> On 2019-02-13 16:40:00 [+0100], Ard Biesheuvel wrote:
>>>>> This is equal what x86 is currently doing. The naming is slightly
>>>>> different, there is irq_fpu_usable().
>>>>
>>>> Yes, I think it's basically the same idea.
>>>>
>>>> It's been evolving a bit on both sides, but is quite similar now.
>>>>
>>>
>>> may_use_simd() only exists because we have a generic crypto SIMD
>>> helper, and so we needed something arch agnostic to wrap around
>>> irq_fpu_usable()
>>
>> My question was more if this is helpful and we want to keep or if
>> it would be better to remove it and always disable BH as part of SIMD
>> operations.
> 
> Wouldn't this arbitrarily increase softirq latency?  Unconditionally
> forbidding SIMD in softirq might make more sense.  It depends on how
> important the use cases are...

Looking at the commit message from cb84d11e1625 "arm64: neon: Remove support for 
nested or hardirq kernel-mode NEON", one of the use case for crypto in softirq 
is certain mac80211 drivers.

Is there any other use case for use crypto in softirqs?

Cheers,

-- 
Julien Grall

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
