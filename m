Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78C2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:17:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A462A21903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NVuADeOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A462A21903
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FNBNMabKgMxeT0W99hpGrjHFp4i47LKyDHqQpsTYoCs=; b=NVuADeORIep/I/
	M9hMJMltvKeFi17HZZM/OvtWljbxidmErHouaW6ysWYDUfTQfeHAFUl3VwzzvTXo6A99ofl9N9SVp
	CeKc6zOjcgpldPehU28kDIByueePX91ca1n/r6Aym5YY6kRXbp85WwBUUGkBcGtAgqI9UIJLN0CIs
	K5fLlLbw6Z1dwG2SpDFnnd/+H/BGLFwxbBp+OFXs61Co4LOBax9al03sTAxtIRBfRrfl8+hMGYgZp
	PeacsEwzE2gmnKL76YOLgTz/cfaVyOZ/U6OUmla/F9JWqe2dEg0FMpp/pm43EhEX5V5EZ6PVh/nbO
	3BygxJSoUaCvE/lmWrPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvyif-00037q-90; Tue, 19 Feb 2019 06:17:29 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvyia-00036c-Dw
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 06:17:27 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFFB1EBD;
 Mon, 18 Feb 2019 22:17:15 -0800 (PST)
Received: from [10.162.40.139] (p8cg001049571a15.blr.arm.com [10.162.40.139])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 3CF8E3F575; Mon, 18 Feb 2019 22:17:09 -0800 (PST)
Subject: Re: [PATCH v2 1/3] arm64: mm: use appropriate ctors for page tables
To: Yu Zhao <yuzhao@google.com>
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218231319.178224-1-yuzhao@google.com>
 <863acc9a-53fb-86ad-4521-828ee8d9c222@arm.com>
 <20190219053205.GA124985@google.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <8f9b0bfb-b787-fa3e-7322-73a56a618aa8@arm.com>
Date: Tue, 19 Feb 2019 11:47:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190219053205.GA124985@google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_221726_164442_47A1B368 
X-CRM114-Status: GOOD (  22.99  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Nick Piggin <npiggin@gmail.com>,
 Jun Yao <yaojun8558363@gmail.com>, linux-mm@kvack.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Chintan Pandya <cpandya@codeaurora.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 "Kirill A . Shutemov" <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>, Laura Abbott <labbott@redhat.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

+ Matthew Wilcox

On 02/19/2019 11:02 AM, Yu Zhao wrote:
> On Tue, Feb 19, 2019 at 09:51:01AM +0530, Anshuman Khandual wrote:
>>
>>
>> On 02/19/2019 04:43 AM, Yu Zhao wrote:
>>> For pte page, use pgtable_page_ctor(); for pmd page, use
>>> pgtable_pmd_page_ctor() if not folded; and for the rest (pud,
>>> p4d and pgd), don't use any.
>> pgtable_page_ctor()/dtor() is not optional for any level page table page
>> as it determines the struct page state and zone statistics.
> 
> This is not true. pgtable_page_ctor() is only meant for user pte
> page. The name isn't perfect (we named it this way before we had
> split pmd page table lock, and never bothered to change it).
> 
> The commit cccd843f54be ("mm: mark pages in use for page tables")
> clearly states so:
>   Note that only pages currently accounted as NR_PAGETABLES are
>   tracked as PageTable; this does not include pgd/p4d/pud/pmd pages.

I think the commit is the following one and it does say so. But what is
the rationale of tagging only PTE page as PageTable and updating the zone
stat but not doing so for higher level page table pages ? Are not they
used as page table pages ? Should not they count towards NR_PAGETABLE ?

1d40a5ea01d53251c ("mm: mark pages in use for page tables")
> 
> I'm sure if we go back further, we can find similar stories: we
> don't set PageTable on page tables other than pte; and we don't
> account page tables other than pte. I don't have any objection if
> you want change these two. But please make sure they are consistent
> across all archs.

pgtable_page_ctor/dtor() use across arch is not consistent and there is a need
for generalization which has been already acknowledged earlier. But for now we
can atleast fix this on arm64.

https://lore.kernel.org/lkml/1547619692-7946-1-git-send-email-anshuman.khandual@arm.com/

> 
>> We should not skip it for any page table page.
> 
> In fact, calling it on pmd/pud/p4d is peculiar, and may even be
> considered wrong. AFAIK, no other arch does so.

Why would it be considered wrong ? IIUC archs have their own understanding
of this and there are different implementations. But doing something for
PTE page and skipping for others is plain inconsistent.

> 
>> As stated before pgtable_pmd_page_ctor() is not a replacement for
>> pgtable_page_ctor().
> 
> pgtable_pmd_page_ctor() must be used on user pmd. For kernel pmd,
> it's okay to use pgtable_page_ctor() instead only because kernel
> doesn't have thp.

The only extra thing to be done for THP is initializing page->pmd_huge_pte
apart from calling pgtable_page_ctor(). Right not it just works on arm64
may be because page->pmd_huge_pte never gets accessed before it's init and
no path checks for it when not THP. Its better to init/reset pmd_huge_pte.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
