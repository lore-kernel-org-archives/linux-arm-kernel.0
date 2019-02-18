Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C63C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:42:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5BFA2176F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bXiPk3NQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5BFA2176F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z90CHYN9OLog2dvb0pdC64S64VUPoLen/MpzcI59rMs=; b=bXiPk3NQd4ua0q
	D+a2Uua0HDtK1X6rExcO94qQ8YJhL1t+wnarCF31i5FgAWKTV4g91QFfq1WHBGhswF5/xl0pYFiGp
	FozuBMR+qKNhpnY/air2nQCSXvmt/laX5qgNvzfTSeTDak3ZtuHrj02cDkUZ1DaE6Mg4rWkEFrlZb
	GC5II/ayHysPYBuHBlQogTximNMClTu1TXgyBO5gL2b/gjJehgGSjdeurFfSdlNRxVykAi5Mj/RA4
	od8G216WmV0mRV2YIf4z06v8W+tutucQy5xmw611nD+3H5jQy/a62C2VjBR9HNzzky3kqkuOQ3X3I
	qjOvWJNYNFw1ykabVGCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvk7u-0001z7-Hs; Mon, 18 Feb 2019 14:42:34 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvk7q-0001yn-8q
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 14:42:32 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6CD61684;
 Mon, 18 Feb 2019 06:30:22 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF7563F589;
 Mon, 18 Feb 2019 06:29:59 -0800 (PST)
Date: Mon, 18 Feb 2019 14:29:52 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH 01/13] arm64: mm: Add p?d_large() definitions
Message-ID: <20190218142951.GA10145@lakrids.cambridge.arm.com>
References: <20190215170235.23360-1-steven.price@arm.com>
 <20190215170235.23360-2-steven.price@arm.com>
 <20190218112922.GT32477@hirez.programming.kicks-ass.net>
 <fe36ed1c-b90d-8062-f7a9-e52d940733c4@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fe36ed1c-b90d-8062-f7a9-e52d940733c4@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_064230_533560_7946D64F 
X-CRM114-Status: GOOD (  19.42  )
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
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 James Morse <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 18, 2019 at 02:11:40PM +0000, Steven Price wrote:
> On 18/02/2019 11:29, Peter Zijlstra wrote:
> > On Fri, Feb 15, 2019 at 05:02:22PM +0000, Steven Price wrote:
> > 
> >> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> >> index de70c1eabf33..09d308921625 100644
> >> --- a/arch/arm64/include/asm/pgtable.h
> >> +++ b/arch/arm64/include/asm/pgtable.h
> >> @@ -428,6 +428,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
> >>  				 PMD_TYPE_TABLE)
> >>  #define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
> >>  				 PMD_TYPE_SECT)
> >> +#define pmd_large(x)		pmd_sect(x)
> >>  
> >>  #if defined(CONFIG_ARM64_64K_PAGES) || CONFIG_PGTABLE_LEVELS < 3
> >>  #define pud_sect(pud)		(0)
> >> @@ -435,6 +436,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
> >>  #else
> >>  #define pud_sect(pud)		((pud_val(pud) & PUD_TYPE_MASK) == \
> >>  				 PUD_TYPE_SECT)
> >> +#define pud_large(x)		pud_sect(x)
> >>  #define pud_table(pud)		((pud_val(pud) & PUD_TYPE_MASK) == \
> >>  				 PUD_TYPE_TABLE)
> >>  #endif
> > 
> > So on x86 p*d_large() also matches p*d_huge() and thp, But it is not
> > clear to me this p*d_sect() thing does so, given your definitions.
> > 
> > See here why I care:
> > 
> >   http://lkml.kernel.org/r/20190201124741.GE31552@hirez.programming.kicks-ass.net
> > 
> 
> pmd_huge()/pud_huge() unfortunately are currently defined as '0' if
> !CONFIG_HUGETLB_PAGE and for this reason I was avoiding using them.

I think that Peter means p?d_huge(x) should imply p?d_large(x), e.g.

#define pmd_large(x) \
	(pmd_sect(x) || pmd_huge(x) || pmd_trans_huge(x))

... which should work regardless of CONFIG_HUGETLB_PAGE.

> While most code would reasonably not care about huge pages in that build
> configuration, the likes of the debugfs page table dump code needs to be
> able to recognise them in all build configurations. I believe the
> situation is the same on arm64 and x86.

There's a very important distinction here between:

* section mappings, which are an archtiectural construct used in
  arm64-specific code (e.g. the kernel's own page tables).

* huge mappings, which are Linux logical construct for mapping
  userspace memory. These are buillt using section mappings.

The existing arm64 debugfs pagetable dump code cares about section
mappings specifically in all cases, since it is not used to dump
userspace page tables.

The existing generic code doesn't care about section mappings
specifically, because they are not generic.

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
