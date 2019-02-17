Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2DFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 17:06:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE02921934
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 17:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OYzbuVJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE02921934
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:Subject:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FXO8JLTRk5GnrbYuiskSSHkOJFpMTQFOAGA3UH0uH6M=; b=OYzbuVJXcCZd2jVc1JLui9Zpz
	gxW9yTxQsbNtnRCZFP58rD+fxefpEL5UhmtXQlqrzwTf5XmA8XaOypCHCJdK6rhBcs2TiKFWLfpWM
	xT+BEHDvxLNnXSFZ7b5Uqc73vLx9j5DTYtkNR29+KRzktlsvHooam3gVsJL/6Fl2MDb7IuAOjsjyP
	yjT6zJ0Wm3wg1P2O9mJP9YI9IJAlBjyvys20wys6IESyJ/2iTGtEh975iz2mESKNe7FlKibg5xaOT
	DNXo/chZJv124U8bFZSXlbHVoJQUD0RahvVbuLGdkJ5qw83Q3f0TIQlsjDiveaIeEwHMvGhG+bz9R
	EnqXEGe+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvPtt-00083O-BQ; Sun, 17 Feb 2019 17:06:45 +0000
Received: from relay9-d.mail.gandi.net ([217.70.183.199])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvPtp-00082j-1k
 for linux-arm-kernel@lists.infradead.org; Sun, 17 Feb 2019 17:06:43 +0000
X-Originating-IP: 79.86.19.127
Received: from [192.168.0.11] (127.19.86.79.rev.sfr.net [79.86.19.127])
 (Authenticated sender: alex@ghiti.fr)
 by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id A9E19FF802;
 Sun, 17 Feb 2019 17:06:26 +0000 (UTC)
From: Alex Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH v3] hugetlb: allow to free gigantic pages regardless of
 the configuration
To: Dave Hansen <dave.hansen@intel.com>, Vlastimil Babka <vbabka@suse.cz>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20190214193100.3529-1-alex@ghiti.fr>
 <c6d9be5f-3b3a-c95b-0045-9f98ea52a5c4@intel.com>
Message-ID: <37046a52-a0eb-cb1a-0a72-601cdee45917@ghiti.fr>
Date: Sun, 17 Feb 2019 12:06:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <c6d9be5f-3b3a-c95b-0045-9f98ea52a5c4@intel.com>
Content-Language: sv-FI
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_090641_384229_06DB7555 
X-CRM114-Status: GOOD (  31.17  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/15/19 12:34 PM, Dave Hansen wrote:
>> -#if (defined(CONFIG_MEMORY_ISOLATION) && defined(CONFIG_COMPACTION)) || defined(CONFIG_CMA)
>> +#ifdef CONFIG_CONTIG_ALLOC
>>   /* The below functions must be run on a range from a single zone. */
>>   extern int alloc_contig_range(unsigned long start, unsigned long end,
>>   			      unsigned migratetype, gfp_t gfp_mask);
>> -extern void free_contig_range(unsigned long pfn, unsigned nr_pages);
>>   #endif
>> +extern void free_contig_range(unsigned long pfn, unsigned int nr_pages);
> There's a lot of stuff going on in this patch.  Adding/removing config
> options.  Please get rid of these superfluous changes or at least break
> them out.


I agree that this patch does a lot of things. I am going at least to 
split it
into 2 separate patches, one suggested-by Vlastimil regarding the renaming
of MEMORY_ISOLATION && COMPACTION || CMA, and another that indeed
does what was primarily intended.


>>   #ifdef CONFIG_CMA
>>   /* CMA stuff */
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 25c71eb8a7db..138a8df9b813 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -252,12 +252,17 @@ config MIGRATION
>>   	  pages as migration can relocate pages to satisfy a huge page
>>   	  allocation instead of reclaiming.
>>   
>> +
>>   config ARCH_ENABLE_HUGEPAGE_MIGRATION
>>   	bool
> Like this. :)


My apologies for that.


>>   config ARCH_ENABLE_THP_MIGRATION
>>   	bool
>>   
>> +config CONTIG_ALLOC
>> +	def_bool y
>> +	depends on (MEMORY_ISOLATION && COMPACTION) || CMA
>> +
>>   config PHYS_ADDR_T_64BIT
>>   	def_bool 64BIT
> Please think carefully though the Kconfig dependencies.  'select' is
> *not* the same as 'depends on'.
>
> This replaces a bunch of arch-specific "select ARCH_HAS_GIGANTIC_PAGE"
> with a 'depends on'.  I *think* that ends up being OK, but it absolutely
> needs to be addressed in the changelog about why *you* think it is OK
> and why it doesn't change the functionality of any of the patched
> architetures.


Ok.


>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index afef61656c1e..e686c92212e9 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1035,7 +1035,6 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
>>   		((node = hstate_next_node_to_free(hs, mask)) || 1);	\
>>   		nr_nodes--)
>>   
>> -#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
>>   static void destroy_compound_gigantic_page(struct page *page,
>>   					unsigned int order)
>>   {
> Whats the result of this #ifdef removal?  A universally larger kernel
> even for architectures that do not support runtime gigantic page
> alloc/free?  That doesn't seem like a good thing.


Ok, I agree, now that we removed the "wrong" definition of 
ARCH_HAS_GIGANTIC_PAGE,
we can actually use this define for architectures to show they support 
gigantic pages
and avoid the problem you mention. Thanks.


>> @@ -1058,6 +1057,12 @@ static void free_gigantic_page(struct page *page, unsigned int order)
>>   	free_contig_range(page_to_pfn(page), 1 << order);
>>   }
>>   
>> +static inline bool gigantic_page_runtime_allocation_supported(void)
>> +{
>> +	return IS_ENABLED(CONFIG_CONTIG_ALLOC);
>> +}
> Why bother having this function?  Why don't the callers just check the
> config option directly?


Ok, this function is only used once in set_max_huge_pages where you
mention the need for a comment, so I can get rid of it. Thanks.


>> +#ifdef CONFIG_CONTIG_ALLOC
>>   static int __alloc_gigantic_page(unsigned long start_pfn,
>>   				unsigned long nr_pages, gfp_t gfp_mask)
>>   {
>> @@ -1143,22 +1148,15 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
>>   static void prep_new_huge_page(struct hstate *h, struct page *page, int nid);
>>   static void prep_compound_gigantic_page(struct page *page, unsigned int order);
>>   
>> -#else /* !CONFIG_ARCH_HAS_GIGANTIC_PAGE */
>> -static inline bool gigantic_page_supported(void) { return false; }
>> +#else /* !CONFIG_CONTIG_ALLOC */
>>   static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
>>   		int nid, nodemask_t *nodemask) { return NULL; }
>> -static inline void free_gigantic_page(struct page *page, unsigned int order) { }
>> -static inline void destroy_compound_gigantic_page(struct page *page,
>> -						unsigned int order) { }
>>   #endif
>>   
>>   static void update_and_free_page(struct hstate *h, struct page *page)
>>   {
>>   	int i;
>>   
>> -	if (hstate_is_gigantic(h) && !gigantic_page_supported())
>> -		return;
> I don't get the point of removing this check.  Logically, this reads as
> checking if the architecture supports gigantic hstates and has nothing
> to do with allocation.

I think this check was wrong from the beginning: gigantic_page_supported()
was only checking (MEMORY_ISOLATION && COMPACTION) || CMA, which has
nothing to do with the capability to free gigantic pages.

But then I went through all the architectures to see if removing this 
test could
affect any of them. And I noticed that if an architecture supports gigantic
page without advertising it with ARCH_HAS_GIGANTIC_PAGE, then it would
decrement the number of free huge page but would not actually free the 
pages.

I found at least 2 archs that have gigantic pages, but do not allow
runtime allocation nor freeing of those pages because they do not define
the (wrong) ARCH_HAS_GIGANTIC_PAGE:

- ia64 has HPAGE_SHIFT_DEFAULT = 28, with PAGE_SHIFT = 14
- sh has max HPAGE_SHIFT = 29 and max PAGE_SHIFT = 16

with default MAX_ORDER = 11, both architectures support gigantic pages.

So I'm going to propose a patch that selects the (right) 
ARCH_HAS_GIGANTIC_PAGE
for those archs, because I think they should be able to free their boottime
gigantic pages.

Regarding this check, we can either remove it if we are sure that
every architecture that has gigantic pages selects ARCH_HAS_GIGANTIC_PAGE,
or leaving it in case some future archs forget to select it.

I'd rather patch all archs so that they can at least free gigantic pages and
then remove the test since hstate_is_gigantic would imply 
gigantic_page_supported.
I will propose something like that if you agree.


>>   	h->nr_huge_pages--;
>>   	h->nr_huge_pages_node[page_to_nid(page)]--;
>>   	for (i = 0; i < pages_per_huge_page(h); i++) {
>> @@ -2276,13 +2274,20 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
>>   }
>>   
>>   #define persistent_huge_pages(h) (h->nr_huge_pages - h->surplus_huge_pages)
>> -static unsigned long set_max_huge_pages(struct hstate *h, unsigned long count,
>> +static int set_max_huge_pages(struct hstate *h, unsigned long count,
>>   						nodemask_t *nodes_allowed)
>>   {
>>   	unsigned long min_count, ret;
>>   
>> -	if (hstate_is_gigantic(h) && !gigantic_page_supported())
>> -		return h->max_huge_pages;
>> +	if (hstate_is_gigantic(h) &&
>> +		!gigantic_page_runtime_allocation_supported()) {
> The indentation here is wrong and reduces readability.  Needs to be like
> this:
>
> 	if (hstate_is_gigantic(h) &&
> 	    !gigantic_page_runtime_allocation_supported()) {


This will disappear with your previous remark, thanks.


>> +		spin_lock(&hugetlb_lock);
>> +		if (count > persistent_huge_pages(h)) {
>> +			spin_unlock(&hugetlb_lock);
>> +			return -EINVAL;
>> +		}
>> +		goto decrease_pool;
>> +	}
> Needs comments.
>
> 	/* Gigantic pages can be freed but not allocated */
>
> or something.
>

Ok, I agree, I'll add that and another sentence regarding the removal
of gigantic_page_runtime_allocation_supported.

Thank you Dave for your comments !

Alex


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
