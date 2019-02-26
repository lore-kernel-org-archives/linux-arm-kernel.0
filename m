Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E235CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:06:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFDEF2173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E8TDWLBS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFDEF2173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BMNJEfGaUrhklmo0/rOHK7lU5HqpYiIxZhpO8PtF/vw=; b=E8TDWLBSC1Xvbx
	pZYzjVFUJjZoQ/2eRGaVHBOC9ZokHtdwRTeTABZG4WBw4UTX/Wir47aGOI/y9ZJbhCQo9BvhfR47F
	KrKf4PCI5/OSCp4NAwKT1fhUoz9zioc5eoNRbi3GB9CXmfmzuNOBqVbnyjzb/0n5PNafoszyaQHxx
	wtstHpWRd1kiS2fotgbduxEHYvyrBDK5zjlj6XzRyEofB6sZXnZ9DVBhdbTsWvfscimOH8RQVntSL
	LRErZ6/Um0vIsgu8ixRLqshm3r75ouUqT7K1AktcegKMf2gdAKM4TszGoRpgm6uS0WqTUBtOUJ5xI
	1aVZInqUaxCbHBTLndCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyZcw-0000PX-JO; Tue, 26 Feb 2019 10:06:18 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyZct-0000PA-Da
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 10:06:16 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 500CB80D;
 Tue, 26 Feb 2019 02:06:14 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CEDE3F71D;
 Tue, 26 Feb 2019 02:06:11 -0800 (PST)
Subject: Re: [PATCH v6 1/6] arm64/kvm: preserve host HCR_EL2 value
From: James Morse <james.morse@arm.com>
To: Amit Daniel Kachhap <amit.kachhap@arm.com>
References: <1550568271-5319-1-git-send-email-amit.kachhap@arm.com>
 <1550568271-5319-2-git-send-email-amit.kachhap@arm.com>
 <ba023672-92f5-41dd-1194-4ab4f647b204@arm.com>
Message-ID: <65651349-e505-bc58-85b0-e6d2b2a2a533@arm.com>
Date: Tue, 26 Feb 2019 10:06:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <ba023672-92f5-41dd-1194-4ab4f647b204@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_020615_471926_78AA3C3B 
X-CRM114-Status: GOOD (  17.00  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Jones <drjones@redhat.com>,
 linux-kernel@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>, kvmarm@lists.cs.columbia.edu,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Amit,

On 25/02/2019 17:39, James Morse wrote:
> On 19/02/2019 09:24, Amit Daniel Kachhap wrote:
>> From: Mark Rutland <mark.rutland@arm.com>
>> When restoring HCR_EL2 for the host, KVM uses HCR_HOST_VHE_FLAGS, which
>> is a constant value. This works today, as the host HCR_EL2 value is
>> always the same, but this will get in the way of supporting extensions
>> that require HCR_EL2 bits to be set conditionally for the host.
>>
>> To allow such features to work without KVM having to explicitly handle
>> every possible host feature combination, this patch has KVM save/restore
>> for the host HCR when switching to/from a guest HCR. The saving of the
>> register is done once during cpu hypervisor initialization state and is
>> just restored after switch from guest.
>>
>> For fetching HCR_EL2 during kvm initialisation, a hyp call is made using
>> kvm_call_hyp and is helpful in NHVE case.
>>
>> For the hyp TLB maintenance code, __tlb_switch_to_host_vhe() is updated
>> to toggle the TGE bit with a RMW sequence, as we already do in
>> __tlb_switch_to_guest_vhe().
>>
>> The value of hcr_el2 is now stored in struct kvm_cpu_context as both host
>> and guest can now use this field in a common way.

>> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
>> index 9e350fd3..8e18f7f 100644
>> --- a/virt/kvm/arm/arm.c
>> +++ b/virt/kvm/arm/arm.c
>> @@ -1328,6 +1328,7 @@ static void cpu_hyp_reinit(void)
>>  		cpu_init_hyp_mode(NULL);
>>  
>>  	kvm_arm_init_debug();
>> +	__cpu_copy_hyp_conf();
> 
> Your commit message says:
> | The saving of the register is done once during cpu hypervisor initialization state
> 
> But cpu_hyp_reinit() is called each time secondary CPUs come online. Its also called as
> part of the cpu-idle mechanism via hyp_init_cpu_pm_notifier(). cpu-idle can ask the
> firmware to power-off the CPU until an interrupt becomes pending for it. KVM's EL2 state
> disappears when this happens, these calls take care of setting it back up again. On Juno,
> this can happen tens of times a second, and this adds an extra call to EL2.

The bit I missed was the MDCR_EL2 copy is behind kvm_arm_init_debug(), so we already have
an unnecessary EL2 call here, so its nothing new.

Assuming the deactivate_traps_vhe_put() vcpu isn't needed, and with Mark's comments addressed:
Reviewed-by: James Morse <james.morse@arm.com>


If we can avoid repeated calls to EL2 once we've got HCR_EL2+MDCR_EL2, even better!


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
