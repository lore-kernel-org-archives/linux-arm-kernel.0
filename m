Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6197AC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:29:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 226992081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kNb4m0Ig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226992081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UMczIxtYI7Sh7i3sBUqwZDj+vvr1anGVA8rYFPRO4Sw=; b=kNb4m0Igv+A5nDoSKzbxrrMPM
	rTKYgOUghS9hpOqovcdbJ5AGRjt+sZrxbBLIZmqs+54P1IBaZI9wDs20ZJuQ4qQ3SgB6FLvV7/XI5
	2VIqLkeF6RR3rbLlA/fDK/N1ttsTeMZq+KAVNGjTcTy4XGGhIUs6/GnkZvTYVU54/lJ+01piWSAc6
	/+KJH2CAa3tvMjoIl6JXAKYjdy7c8mhBL2GjP2Yjz3tXSWJN+xtLlUFpoycWtBwG3UKUyhihFdLJR
	G0dKkNEI4k96MmztsFUJBS14abYQsHG52F4Cjcrd/Tin7bxbM4YrhqetDkGE1tTwIXqfNDblkzwTu
	0eoQ6+PMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVJwD-00072t-Az; Fri, 07 Dec 2018 17:29:17 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVJwA-000728-7P
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 17:29:15 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41F5515AB;
 Fri,  7 Dec 2018 09:29:01 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E24483F5AF;
 Fri,  7 Dec 2018 09:28:59 -0800 (PST)
Subject: Re: [PATCH V5 5/7] arm64: mm: Prevent mismatched 52-bit VA support
To: Will Deacon <will.deacon@arm.com>
References: <20181206225042.11548-1-steve.capper@arm.com>
 <20181206225042.11548-6-steve.capper@arm.com>
 <81860712-ff5f-5a51-d39e-9db9e3d31a26@arm.com>
 <20181207152529.GB2682@edgewater-inn.cambridge.arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <be06b735-c6b4-1520-73f6-02a3a8e8af45@arm.com>
Date: Fri, 7 Dec 2018 17:28:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181207152529.GB2682@edgewater-inn.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_092914_276182_96D84357 
X-CRM114-Status: GOOD (  20.32  )
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
Cc: ard.biesheuvel@linaro.org, catalin.marinas@arm.com,
 Steve Capper <steve.capper@arm.com>, linux-mm@kvack.org, jcm@redhat.com,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 07/12/2018 15:26, Will Deacon wrote:
> On Fri, Dec 07, 2018 at 10:47:57AM +0000, Suzuki K Poulose wrote:
>> On 12/06/2018 10:50 PM, Steve Capper wrote:
>>> For cases where there is a mismatch in ARMv8.2-LVA support between CPUs
>>> we have to be careful in allowing secondary CPUs to boot if 52-bit
>>> virtual addresses have already been enabled on the boot CPU.
>>>
>>> This patch adds code to the secondary startup path. If the boot CPU has
>>> enabled 52-bit VAs then ID_AA64MMFR2_EL1 is checked to see if the
>>> secondary can also enable 52-bit support. If not, the secondary is
>>> prevented from booting and an error message is displayed indicating why.
>>>
>>> Technically this patch could be implemented using the cpufeature code
>>> when considering 52-bit userspace support. However, we employ low level
>>> checks here as the cpufeature code won't be able to run if we have
>>> mismatched 52-bit kernel va support.
>>>
>>> Signed-off-by: Steve Capper <steve.capper@arm.com>
>>>
>>
>> The patch looks good to me, except for one comment below.
>>
>>> ---
>>>
>>> Patch is new in V5 of the series
>>> ---
>>>    arch/arm64/kernel/head.S | 26 ++++++++++++++++++++++++++
>>>    arch/arm64/kernel/smp.c  |  5 +++++
>>>    2 files changed, 31 insertions(+)
>>>
>>> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
>>> index f60081be9a1b..58fcc1edd852 100644
>>> --- a/arch/arm64/kernel/head.S
>>> +++ b/arch/arm64/kernel/head.S
>>> @@ -707,6 +707,7 @@ secondary_startup:
>>>    	/*
>>>    	 * Common entry point for secondary CPUs.
>>>    	 */
>>> +	bl	__cpu_secondary_check52bitva
>>>    	bl	__cpu_setup			// initialise processor
>>>    	adrp	x1, swapper_pg_dir
>>>    	bl	__enable_mmu
>>> @@ -785,6 +786,31 @@ ENTRY(__enable_mmu)
>>>    	ret
>>>    ENDPROC(__enable_mmu)
>>> +ENTRY(__cpu_secondary_check52bitva)
>>> +#ifdef CONFIG_ARM64_52BIT_VA
>>> +	ldr_l	x0, vabits_user
>>> +	cmp	x0, #52
>>> +	b.ne	2f > +
>>> +	mrs_s	x0, SYS_ID_AA64MMFR2_EL1
>>> +	and	x0, x0, #(0xf << ID_AA64MMFR2_LVA_SHIFT)
>>> +	cbnz	x0, 2f
>>> +
>>> +	adr_l	x0, va52mismatch
>>> +	mov	w1, #1
>>> +	strb	w1, [x0]
>>> +	dmb	sy
>>> +	dc	ivac, x0	// Invalidate potentially stale cache line
>>
>> You may have to clear this variable before a CPU is brought up to avoid
>> raising a false error message when another secondary CPU doesn't boot
>> for some other reason (say granule support) after a CPU failed with lack
>> of 52bitva. It is really a crazy corner case.
> 
> Can't we just follow the example set by the EL2 setup in the way that is
> uses __boot_cpu_mode? In that case, we only need one variable and you can
> detect a problem by comparing the two halves.

The only difference here is, the support is bolted at boot CPU time and hence
we need to verify each and every CPU, unlike the __boot_cpu_mode where we
check for mismatch after the SMP CPUs are brought up. If we decide to make
the choice later, something like that could work. The only caveat is the 52bit
kernel VA will have to do something like the above.

Cheers
Suzuki




> 
> Will
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
