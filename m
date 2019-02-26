Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA18C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:00:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F030D20652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jE9BvsKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F030D20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TN6WegHlrdCOinz/ApIqizVjQxJTlSjt7KSh9NH8dwE=; b=jE9BvsKmlPZ6LXufF9c6yScmI
	KS8nsg6cd3EWvE+HPTTX2J8OCS1vfYGAt9sXHMMOxbQPPA7NQKV9pabdsQeavhBanszsluwmdORcR
	UFCWOxhRwX20QPMpZjzEBBaehNSr1l+xH5Vzwr8MkFHg4Yte+w3mZ74XRw012pKHmzZlLeKn2LRPt
	3An/HvAiz+2otwkAW2VUCsu0zBg/QunTV+aC5WnTm3Orj5sAL0igUEA3i6BRftoXYytU1J645AuTb
	86LgSQUxvHrSFv/2isljLL7Zda0a4V0N06PAPJIx2oD7TkRc/VqHG3JwH1MDg8BRjlFY97jweSBqw
	phF+iIsYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyf9Q-0007pv-Ex; Tue, 26 Feb 2019 16:00:12 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyf8y-00076z-Ip
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 15:59:50 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61D3480D;
 Tue, 26 Feb 2019 07:59:44 -0800 (PST)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A1BD3F575;
 Tue, 26 Feb 2019 07:59:42 -0800 (PST)
Subject: Re: [PATCH v5 08/26] arm64/sve: Enable SVE state tracking for
 non-task contexts
To: Dave Martin <Dave.Martin@arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-9-git-send-email-Dave.Martin@arm.com>
 <dc379691-ab3a-79a6-b760-59a02aa40717@arm.com>
 <20190226120713.GL3567@e103592.cambridge.arm.com>
 <b1d64e84-1c59-d1a6-7893-212b5cd3a7ac@arm.com>
 <20190226155815.GZ3567@e103592.cambridge.arm.com>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <1c665ce8-1334-6d74-fe93-eead9383970d@arm.com>
Date: Tue, 26 Feb 2019 15:59:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190226155815.GZ3567@e103592.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_075945_467013_21A5CB75 
X-CRM114-Status: GOOD (  17.49  )
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
Cc: Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Zhang Lei <zhang.lei@jp.fujitsu.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Dave,

On 26/02/2019 15:58, Dave Martin wrote:
> On Tue, Feb 26, 2019 at 03:49:00PM +0000, Julien Grall wrote:
>> Hi Dave,
>>
>> On 26/02/2019 12:07, Dave Martin wrote:
>>> On Fri, Feb 22, 2019 at 03:26:51PM +0000, Julien Grall wrote:
>>>> Hi Dave,
>>>>
>>>> On 18/02/2019 19:52, Dave Martin wrote:
>>>>> The current FPSIMD/SVE context handling support for non-task (i.e.,
>>>>> KVM vcpu) contexts does not take SVE into account.  This means that
>>>>
>>>> NIT: Double-space before "This".
>>>
>>> See patch 2...
>>>
>>> [...]
>>>
>>> Does the code look reasonable to you?  This interacts with FPSIMD/SVE
>>> context switch in the host, so it would be good to have your view on it.
>>
>> I wanted to look at the rest before giving my reviewed-by tag.
>> FWIW, this patch looks reasonable to me.
> 
> OK, does that amount to a Reviewed-by, or do you have other comments?

I have no further comments on this patch.

Reviewed-by: Julien Grall <julien.grall@arm.com>

Cheers,

-- 
Julien Grall

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
