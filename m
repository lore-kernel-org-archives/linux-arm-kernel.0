Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D52C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:15:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAA632086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DG2vqIaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA632086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=reBbt2JjppDe+3CcUrVnvzZsTWIMOXOJCB9QoDsK8eo=; b=DG2vqIaADJ2a/K
	dP6fRCvaiOFBNoVm4UBgU+LXtNRRALNi8A2BqMsJojYlEpzaUWWiDgk8eAiMYTq6S+uvVwJ2bHXvQ
	iYSl/x83SrAWWuypBNDZcXzB4ZqkN4gmqkfUeda4jsTiNd9BHohBonwMu4JIetddxS1580S6sq8j2
	hAqemkQxt4lAJWdY2eRwKqqVEJGzG2lL235/V5gD6MvupXkYlEuvNcWLMax4LuXPy4aHTgrPHAdVU
	RyaRT8oiiVv2OI8231RGveXwxU4pdcr6av0pSBwifjY9Px9a8ES2DARgtjhrtJYqKbmqgPsDyg+si
	AEXJP9+5PmP4OJV+O3Ew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWJWy-00063X-3L; Mon, 10 Dec 2018 11:15:20 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWJWu-0004ug-RC
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 11:15:18 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68E3D1596;
 Mon, 10 Dec 2018 03:15:04 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE3F03F6A8;
 Mon, 10 Dec 2018 03:15:02 -0800 (PST)
Subject: Re: [PATCH v3 7/8] arm64: KVM: Handle ARM erratum 1165522 in TLB
 invalidation
To: Marc Zyngier <marc.zyngier@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>
References: <20181206173126.139877-1-marc.zyngier@arm.com>
 <20181206173126.139877-8-marc.zyngier@arm.com>
 <20181210101912.GK30263@e113682-lin.lund.arm.com>
 <50e6a07d-868b-db43-fd4e-4b6359a5128e@arm.com>
From: James Morse <james.morse@arm.com>
Message-ID: <c71d902b-c748-770a-5e6e-f33a204dcb8d@arm.com>
Date: Mon, 10 Dec 2018 11:15:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <50e6a07d-868b-db43-fd4e-4b6359a5128e@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_031516_939163_C9FD6506 
X-CRM114-Status: GOOD (  14.66  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Marc, Christoffer,

On 10/12/2018 10:46, Marc Zyngier wrote:
> On 10/12/2018 10:19, Christoffer Dall wrote:
>> On Thu, Dec 06, 2018 at 05:31:25PM +0000, Marc Zyngier wrote:
>>> In order to avoid TLB corruption whilst invalidating TLBs on CPUs
>>> affected by erratum 1165522, we need to prevent S1 page tables
>>> from being usable.
>>>
>>> For this, we set the EL1 S1 MMU on, and also disable the page table
>>> walker (by setting the TCR_EL1.EPD* bits to 1).
>>>
>>> This ensures that once we switch to the EL1/EL0 translation regime,
>>> speculated AT instructions won't be able to parse the page tables.

>>> @@ -64,11 +93,18 @@ static void __hyp_text __tlb_switch_to_host_vhe(struct kvm *kvm,
>>>  	write_sysreg(0, vttbr_el2);
>>>  	write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
>>>  	isb();
>>> -	local_irq_restore(flags);
>>> +
>>> +	if (cpus_have_const_cap(ARM64_WORKAROUND_1165522)) {
>>> +		/* Restore the guest's registers to what they were */
>>
>> host's ?
> 
> Hum... Yes, silly thinko.

I thought these were the guests registers because they are EL1 registers and
this is a VHE-only path.
'interrupted guest' was how I read this. This stuff can get called if memory is
allocated for guest-A while a vcpu is loaded, and reclaims memory from guest-B
causing an mmu-notifier call for stage2. This is why we have to put guest-A's
registers back as we weren't pre-empted, and we expect EL1 to be untouched.

I agree they could belong to no-guest if a vcpu isn't loaded at all... is host
the term used here?


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
