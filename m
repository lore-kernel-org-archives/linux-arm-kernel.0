Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D198BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:36:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E2F820C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nuNoeUQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E2F820C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I+p2VtK9RjqneBbg3PYOQvamP7/yRIsCaFqSZqOsPUs=; b=nuNoeUQ34DcR5p
	vz9FJBi1Xo4hxGh5E76Jr8M5dLz6F2UzdH5Aons0rKb9wQyc1YcDjFbQJhY98RWRxk4KZlSErfAec
	7jOoJk3+h7KO270AATFn52UmHuiz6XQ5kL/eF1ew4n4LLHRAiDxYhDI2Sz0e4ewONe0B9S7pV/6Nk
	P27DmnAj1yqNrPjTCmrHNPjvNHA4aYBCEDsc75kh3Z6ZeDq6+vd9YdOGSKu0QZX/lIeyPvQ5waTQO
	W8vQy535q7ujVCYuf9c1JExFgj6HyGK46owTNxpM7wrjZgqgLf5emqQzqrNezw4PdfW/13bYAq9xN
	V6WI+RE6TeXJupgAstLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyIIV-0004TG-En; Mon, 25 Feb 2019 15:36:03 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyIIR-0004Sr-Qy
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 15:36:01 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F420D80D;
 Mon, 25 Feb 2019 07:35:57 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55C703F703;
 Mon, 25 Feb 2019 07:35:56 -0800 (PST)
Date: Mon, 25 Feb 2019 15:35:53 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V2 5/6] arm64/mm: Enable page table page accounting for
 user space
Message-ID: <20190225153553.GI26236@lakrids.cambridge.arm.com>
References: <1551071039-20192-1-git-send-email-anshuman.khandual@arm.com>
 <1551071039-20192-6-git-send-email-anshuman.khandual@arm.com>
 <20190225111108.GD26236@lakrids.cambridge.arm.com>
 <d6c62e0d-f890-a60d-517c-c0ba1e56e48c@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d6c62e0d-f890-a60d-517c-c0ba1e56e48c@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_073559_879708_D1D975E3 
X-CRM114-Status: GOOD (  11.86  )
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
Cc: yuzhao@google.com, Steve.Capper@arm.com, marc.zyngier@arm.com,
 Catalin.Marinas@arm.com, suzuki.poulose@arm.com, will.deacon@arm.com,
 james.morse@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 25, 2019 at 08:19:53PM +0530, Anshuman Khandual wrote:
> 
> 
> On 02/25/2019 04:41 PM, Mark Rutland wrote:
> > On Mon, Feb 25, 2019 at 10:33:58AM +0530, Anshuman Khandual wrote:
> >> Page table pages created for user space processes must be accounted against
> >> their memory control groups if initialized. This just introduces a helper
> >> function pgtable_gfp_flags() which returns PGALLOC_GFP for all kernel page
> >> table page allocations but adds __GFP_ACCOUNT for user page table pages.
> > 
> > Can't we have pte_alloc_one_kernel() and pte_alloc_one() explicitly pass
> > the GFP flags down to a __pte_alloc_one() helper, and consistently use
> > pte_alloc_one_kernel() for kernel mappings?
> > 
> > That would seem less surprising than hiding that detail in another
> > function.
> 
> Yes that will work as well. But its better to have this mm_struct based GFP switch
> which is used in other archs as well to create generic MM helper functions going
> forward.

I don't follow -- if we can make pte_alloc_one() generic, then we can
*also* make pte_alloc_one_kernel() generic.

Looking at x86, I see:

pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
{
        return (pte_t *)__get_free_page(PGALLOC_GFP & ~__GFP_ACCOUNT);
}

... which arhitectures do you see which look at the mm struct to decide
the flags?

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
