Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0C9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:49:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84811217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nRQTfQos"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84811217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KcNY4piydtKLlLUQ0rIl8F99acih7FM68Wfanpl7baQ=; b=nRQTfQosOdQNOE
	813EcD/M/85/WPaAmeWRIq4qfbVTBXKRh3GG4B1j14jGe+yQuHFqGfoLb4yesv18qEhFkUm3wNvSX
	GpCJSX2Jd6Qdq5T5PLlR6naj9xCHuMTgkJN1Z8OwQx7GfUzmucu7nDjp3xzoK7lm/ORlxZGV1XxXK
	p0c6UoJEvMsmGWaYiNnr7LSnmYVYOoP5HP/vrsiI0DFCjpG911zyVwQvxJTRhTYPA9pH9gy6Bj9f4
	p9mhFs0ejP/5149zQRdjGhPOItsTx/cLI2AbSwFqwHjGn3gUOykKk18xTL7vs9Tx/m8ZBLbllTrj+
	3mpNykIzVJXyZO1q7OOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvxLK-00010T-1c; Tue, 19 Feb 2019 04:49:18 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvxLG-000108-KE
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 04:49:16 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5986F80D;
 Mon, 18 Feb 2019 20:49:13 -0800 (PST)
Received: from [10.162.40.139] (p8cg001049571a15.blr.arm.com [10.162.40.139])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 EEFCB3F675; Mon, 18 Feb 2019 20:49:10 -0800 (PST)
Subject: Re: [PATCH 6/6] arm64/mm: Enable page table page accounting for user
 space
To: Will Deacon <will.deacon@arm.com>
References: <1548307220-19756-1-git-send-email-anshuman.khandual@arm.com>
 <1548307220-19756-7-git-send-email-anshuman.khandual@arm.com>
 <20190214171116.GF2475@fuggles.cambridge.arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <31acd62e-46cc-1c09-7e99-05257ee525e2@arm.com>
Date: Tue, 19 Feb 2019 10:19:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190214171116.GF2475@fuggles.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_204914_666274_5012C0DA 
X-CRM114-Status: GOOD (  15.72  )
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
Cc: mark.rutland@arm.com, Steve.Capper@arm.com, marc.zyngier@arm.com,
 Catalin.Marinas@arm.com, suzuki.poulose@arm.com, james.morse@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 02/14/2019 10:41 PM, Will Deacon wrote:
> On Thu, Jan 24, 2019 at 10:50:20AM +0530, Anshuman Khandual wrote:
>> Page table pages created for user space processes must be accounted against
>> their memory control groups if initialized. This just introduces a helper
>> function pgtable_gfp_flags() which returns PGALLOC_GFP for all kernel page
>> table page allocations but adds __GFP_ACCOUNT for user page table pages.
>>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/include/asm/pgalloc.h | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
>> index 076764f..775cde9 100644
>> --- a/arch/arm64/include/asm/pgalloc.h
>> +++ b/arch/arm64/include/asm/pgalloc.h
>> @@ -100,12 +100,22 @@ pte_alloc_one_kernel(struct mm_struct *mm)
>>  	return (pte_t *)pte_alloc_one_virt(mm);
>>  }
>>  
>> +static inline gfp_t pgtable_gfp_flags(struct mm_struct *mm)
>> +{
>> +	if (unlikely(mm == &init_mm))
>> +		return PGALLOC_GFP;
>> +	else
>> +		return PGALLOC_GFP | __GFP_ACCOUNT;
>> +}
> 
> Hmm, what about things like the efi mm?


EFI mappings are created with

efi_virtmap_init() -> efi_create_mapping() -> create_pgd_mapping()

which calls into pgd_pgtable_alloc(). Sure will add check for efi_mm along
with init_mm not to use __GFP_ACCOUNT.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
