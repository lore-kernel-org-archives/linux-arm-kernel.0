Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7F4C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:49:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C8382084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o8mWSLoA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8382084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=N/t8gj+gyB5c1Ydohn+FUUaX9IuP0VDqoKlZ/pdeink=; b=o8mWSLoAcsvfNl7aaLcdC7VKR
	Z5mTuhzyKz7SKFf/V4lyOE0Mz9EbTqxtJPP81XiZe+y9MtT/KFuSLFPow5BXzSEx/tMWsE7NzXmNs
	IEBYdgBHlKs5mzePUSRVXLAVpBBgHniYz3Gl764tU5L84FapyNdWXA3ubPh1N3AkTqXtI5PaZk2K7
	gSo1niSKxIzeYkAOkCpcWmUZ1wgLyDkAV3S5l3wfVReyu441wnCcQkHajQQiETOD7vJQNKGBj+BG7
	dslOUTlRBSBstj0/HsnIKgK3clW1p6Q1rXRAi9GQGv16gnkz0p12IAhnrkfj2cw4cB8Eztk2Hti3m
	Ixuf03xHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX31H-0006vt-41; Wed, 12 Dec 2018 11:49:39 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX31E-0006vC-Ir
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 11:49:38 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17F4CA78;
 Wed, 12 Dec 2018 03:49:26 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 858543F575;
 Wed, 12 Dec 2018 03:49:24 -0800 (PST)
Subject: Re: [PATCH v2] arm64: Add memory hotplug support
To: Jonathan Cameron <jonathan.cameron@huawei.com>
References: <331db1485b4c8c3466217e16a1e1f05618e9bae8.1544553902.git.robin.murphy@arm.com>
 <20181212114236.000030c9@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <0dc6de46-0b9f-9b0b-f967-e29804279631@arm.com>
Date: Wed, 12 Dec 2018 11:49:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181212114236.000030c9@huawei.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_034936_631767_B606E751 
X-CRM114-Status: GOOD (  23.97  )
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
Cc: anshuman.khandual@arm.com, catalin.marinas@arm.com, cyrilc@xilinx.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 james.morse@arm.com, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/12/2018 11:42, Jonathan Cameron wrote:
> On Tue, 11 Dec 2018 18:48:48 +0000
> Robin Murphy <robin.murphy@arm.com> wrote:
> 
>> Wire up the basic support for hot-adding memory. Since memory hotplug
>> is fairly tightly coupled to sparsemem, we tweak pfn_valid() to also
>> cross-check the presence of a section in the manner of the generic
>> implementation, before falling back to memblock to check for no-map
>> regions within a present section as before. By having arch_add_memory(()
>> create the linear mapping first, this then makes everything work in the
>> way that __add_section() expects.
>>
>> We expect hotplug to be ACPI-driven, so the swapper_pg_dir updates
>> should be safe from races by virtue of the global device hotplug lock.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Hi Robin,
> 
> What tree is this against?
> 
> rodata_full doesn't seem be exist for me on 4.20-rc6.

Sorry, this is now based on the arm64 for-next/core branch - I was 
similarly confused when Will first mentioned rodata_full on v1 ;)

> With v1 I did the 'new node' test and it looked good except for an
> old cgroups warning that has always been there (and has been on my list
> to track down for a long time).

Great, thanks for testing!

Robin.

> 
> Jonathan
>> ---
>>
>> v2: Handle page-mappings-only cases appropriately
>>
>>   arch/arm64/Kconfig   |  3 +++
>>   arch/arm64/mm/init.c |  8 ++++++++
>>   arch/arm64/mm/mmu.c  | 17 +++++++++++++++++
>>   arch/arm64/mm/numa.c | 10 ++++++++++
>>   4 files changed, 38 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 4dbef530cf58..be423fda5cec 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -261,6 +261,9 @@ config ZONE_DMA32
>>   config HAVE_GENERIC_GUP
>>   	def_bool y
>>   
>> +config ARCH_ENABLE_MEMORY_HOTPLUG
>> +	def_bool y
>> +
>>   config SMP
>>   	def_bool y
>>   
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 6cde00554e9b..4bfe0fc9edac 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -291,6 +291,14 @@ int pfn_valid(unsigned long pfn)
>>   
>>   	if ((addr >> PAGE_SHIFT) != pfn)
>>   		return 0;
>> +
>> +#ifdef CONFIG_SPARSEMEM
>> +	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
>> +		return 0;
>> +
>> +	if (!valid_section(__nr_to_section(pfn_to_section_nr(pfn))))
>> +		return 0;
>> +#endif
>>   	return memblock_is_map_memory(addr);
>>   }
>>   EXPORT_SYMBOL(pfn_valid);
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 674c409a8ce4..da513a1facf4 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1046,3 +1046,20 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
>>   	pmd_free(NULL, table);
>>   	return 1;
>>   }
>> +
>> +#ifdef CONFIG_MEMORY_HOTPLUG
>> +int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
>> +		    bool want_memblock)
>> +{
>> +	int flags = 0;
>> +
>> +	if (rodata_full || debug_pagealloc_enabled())
>> +		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>> +
>> +	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
>> +			     size, PAGE_KERNEL, pgd_pgtable_alloc, flags);
>> +
>> +	return __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,
>> +			   altmap, want_memblock);
>> +}
>> +#endif
>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
>> index 27a31efd9e8e..ae34e3a1cef1 100644
>> --- a/arch/arm64/mm/numa.c
>> +++ b/arch/arm64/mm/numa.c
>> @@ -466,3 +466,13 @@ void __init arm64_numa_init(void)
>>   
>>   	numa_init(dummy_numa_init);
>>   }
>> +
>> +/*
>> + * We hope that we will be hotplugging memory on nodes we already know about,
>> + * such that acpi_get_node() succeeds and we never fall back to this...
>> + */
>> +int memory_add_physaddr_to_nid(u64 addr)
>> +{
>> +	pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n", addr);
>> +	return 0;
>> +}
> 
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
