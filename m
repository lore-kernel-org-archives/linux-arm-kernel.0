Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C748C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 05:00:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30C1F218D2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 05:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nFf4zFnp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C1F218D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+M7lAO25jdJWHrT3ZLfzMPoydQAFrWyI8gNv2pYM/Ag=; b=nFf4zFnpCPkgs5
	0X0j99BN66xi+TXlbz+VYj60oLEhhhHGzfKgQtf0ydJuKOocfZyWUp/eB7gNk/M3DpOPNHLQ6WzKP
	TnToY3hj3aslG2eeA0GVMy6i320xb2w26sbe9lkmPUoOXJW7ot+k6OH18XzOWnxzjfzV/VDY8+3RJ
	CoZEo1JsuT31Mzwow7mZ3qMdsbx4OdIZcloPN5H5oGEUCn8/lBMEqvYuijHMf4WBOEbrbqtXpqkEU
	6wHJWvAnW6CMcA3K+BhRuDRAyWUvNCUPezWqnMJa2XtaEN4gJsrdC6rLcfblO4mU2kL2tQKtlAFE7
	g8JwWkfIdAiJ7zihCUnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmtas-0007q8-TC; Fri, 25 Jan 2019 04:59:54 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmtaq-0007pP-Hf
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 04:59:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6ED915AB;
 Thu, 24 Jan 2019 20:59:47 -0800 (PST)
Received: from [10.163.1.93] (unknown [10.163.1.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FDAC3F589;
 Thu, 24 Jan 2019 20:59:44 -0800 (PST)
Subject: Re: [PATCH 2/6] arm64/mm: Ensure PGD kmem cache object is actually
 allocated
To: Catalin Marinas <catalin.marinas@arm.com>
References: <1548307220-19756-1-git-send-email-anshuman.khandual@arm.com>
 <1548307220-19756-3-git-send-email-anshuman.khandual@arm.com>
 <20190124151655.GH253679@arrakis.emea.arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <30550513-697f-1fd1-70c9-03d376368a67@arm.com>
Date: Fri, 25 Jan 2019 10:29:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190124151655.GH253679@arrakis.emea.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_205952_595322_ECDAC0BF 
X-CRM114-Status: GOOD (  14.12  )
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
Cc: mark.rutland@arm.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
 Steve.Capper@arm.com, will.deacon@arm.com, james.morse@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 01/24/2019 08:46 PM, Catalin Marinas wrote:
> On Thu, Jan 24, 2019 at 10:50:16AM +0530, Anshuman Khandual wrote:
>> 'pgd_cache' is created for allocating non PAGE_SIZE based PGD pointers. In
>> such cases ensure that the kmem cache object is allocated before proceeding
>> further with boot.
>>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/mm/pgd.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
>> index 289f911..8cb4e39 100644
>> --- a/arch/arm64/mm/pgd.c
>> +++ b/arch/arm64/mm/pgd.c
>> @@ -62,4 +62,5 @@ void __init pgd_cache_init(void)
>>  	 */
>>  	pgd_cache = kmem_cache_create("pgd_cache", PGD_SIZE, PGD_SIZE,
>>  				      SLAB_PANIC, NULL);
>> +	BUG_ON(!pgd_cache);
> 
> Isn't SLAB_PANIC sufficient here?

It should be sufficient as it calls panic(). Please drop this patch from consideration.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
