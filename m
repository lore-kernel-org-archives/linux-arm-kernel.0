Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C64C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:08:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5C1A20656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mzAiwXoC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C1A20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gP23O3SePF2A2tnvOkANeNxntzNH3iLuFVEp9VzpYmo=; b=mzAiwXoCiP2JSme1sUiHWm1Mz
	MQJ+WxjB/DF10eWf/8AMMX9h/13t9xpWlrQib4sIcvVJW/3uEtkUrfWtGLH58HP54L31N1Zw4UZ0+
	9SSd3N6AZS7kbsE35F5Zp/Hr+KP7Z3sDcdV8AgoDhWiZUteK1UlWMdcBm9c9iF6ts3F58ZmsRgKkw
	lyaA4aPgCukpzQ82AWnig80p6oaiQx3r7KhQrwTyWGnOM8zNTY3svTwyLVNO8lzAMQuyuKduJl6rB
	aMiZy9k0+LQIWop6Klb4Wdgnn8+E7XSSimB90WBaoP6LxKqvzQaSW19vla8oqILu7CcMnd/TCHt60
	yXlK7w7dg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj12A-0008G3-C5; Mon, 14 Jan 2019 12:08:02 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj127-0008FN-Jf
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 12:08:00 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1621D80D;
 Mon, 14 Jan 2019 04:07:58 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EE183F5BD;
 Mon, 14 Jan 2019 04:07:56 -0800 (PST)
Subject: Re: [PATCH v9 2/5] arm64: KVM: encapsulate kvm_cpu_context in
 kvm_host_data
To: andrew.murray@arm.com
References: <1546872089-56278-1-git-send-email-andrew.murray@arm.com>
 <1546872089-56278-3-git-send-email-andrew.murray@arm.com>
 <a5ff581b-5cfb-fea2-74b8-aa4dc3403518@arm.com>
 <20190110151605.GJ56789@e119886-lin.cambridge.arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <ff3cc5d4-061a-cabc-3c40-6f41fceb5ac2@arm.com>
Date: Mon, 14 Jan 2019 12:07:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190110151605.GJ56789@e119886-lin.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_040759_661711_FE66A02E 
X-CRM114-Status: GOOD (  17.02  )
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
Cc: mark.rutland@arm.com, julien.thierry@arm.com, marc.zyngier@arm.com,
 catalin.marinas@arm.com, will.deacon@arm.com, christoffer.dall@arm.com,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 10/01/2019 15:16, Andrew Murray wrote:
> On Thu, Jan 10, 2019 at 11:36:01AM +0000, Suzuki K Poulose wrote:
>> Hi Andrew,
>>
>> On 07/01/2019 14:41, Andrew Murray wrote:
>>> The virt/arm core allocates a kvm_cpu_context_t percpu, at present this is
>>> a typedef to kvm_cpu_context and is used to store host cpu context. The
>>> kvm_cpu_context structure is also used elsewhere to hold vcpu context.
>>> In order to use the percpu to hold additional future host information we
>>> encapsulate kvm_cpu_context in a new structure and rename the typedef and
>>> percpu to match.
>>>
>>> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
>>> ---
>>>    arch/arm/include/asm/kvm_host.h   |  8 ++++++--
>>>    arch/arm64/include/asm/kvm_asm.h  |  4 ++--
>>>    arch/arm64/include/asm/kvm_host.h | 14 +++++++++-----
>>>    arch/arm64/kernel/asm-offsets.c   |  2 +-
>>>    virt/kvm/arm/arm.c                | 12 +++++++-----
>>>    5 files changed, 25 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
>>> index 79906ce..71645ba 100644
>>> --- a/arch/arm/include/asm/kvm_host.h
>>> +++ b/arch/arm/include/asm/kvm_host.h
>>> @@ -145,7 +145,11 @@ struct kvm_cpu_context {
>>>    	u32 cp15[NR_CP15_REGS];
>>>    };
>>> -typedef struct kvm_cpu_context kvm_cpu_context_t;
>>> +struct kvm_host_data {
>>> +	struct kvm_cpu_context host_ctxt;
>>> +};
>>> +
>>> +typedef struct kvm_host_data kvm_host_data_t;
>>>    struct kvm_vcpu_arch {
>>>    	struct kvm_cpu_context ctxt;
>>> @@ -163,7 +167,7 @@ struct kvm_vcpu_arch {
>>>    	struct kvm_vcpu_fault_info fault;
>>>    	/* Host FP context */
>>> -	kvm_cpu_context_t *host_cpu_context;
>>> +	struct kvm_cpu_context *host_cpu_context;
>>>    	/* VGIC state */
>>>    	struct vgic_cpu vgic_cpu;
>>> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
>>> index 102b5a5..6a9bfd4 100644
>>> --- a/arch/arm64/include/asm/kvm_asm.h
>>> +++ b/arch/arm64/include/asm/kvm_asm.h
>>> @@ -102,12 +102,12 @@ extern u32 __init_stage2_translation(void);
>>>    .endm
>>>    .macro get_host_ctxt reg, tmp
>>> -	hyp_adr_this_cpu \reg, kvm_host_cpu_state, \tmp
>>> +	hyp_adr_this_cpu \reg, kvm_host_data, \tmp
>>>    .endm
>>
>> minor nit: We now load "kvm_host_data" instead of the host_ctxt here,
>> even though they both are same. Do we need to make this explicitly load
>> the address of the host_ctxt member to make sure this doesn't break
>> with future changes to the structure ?
>> i.e,
>> 	add	\reg, \reg, #HOST_DATA_CONTEXT
>>
>> Otherwise,
>>
>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Thanks for spotting this.
> 
> Are you happy for me to add the Reviewed-by tag if I squash in the following?

Yes, that looks fine to me.

Cheers
Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
