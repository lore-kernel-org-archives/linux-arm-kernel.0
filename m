Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB30C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:10:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C0862082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="soAEdhH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C0862082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qKF23M341nJLLE1rzpDOsflURv/6nqpoRQCFGlTo+RY=; b=soAEdhH8AhoxGIuw6+aAssnQl
	Yf/s+fnHP6V5fHWUkb1Zwdps5fO5Fd+YkVAJ8lwnVE6lR9yFyRrZFNF0nbkrIUXFJ/v7pEu+EhhAI
	NpxkDGbghTRB0jsSWAPd9QpzOloXZ5QuD68Iqcd+32/SPS0cDaaBTi6ejHRieK7cgHUmo+anUwqVj
	6sB5cIZ9JgLnDOn8IYJhCvIwGaAI28zkRlJlLUEOhjsAWkTanDKnQzmDcQSm2dA8mchwUxb5tFsxa
	Kjl5cLrz34sqrJ57nBHomGRo1hBdO7TRFpbsG2+o1e0rvVWeUupme2t+MtO6yZGvPrSSm208JqOJO
	9wscQw9Fg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVNOH-0007uN-T6; Fri, 07 Dec 2018 21:10:29 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVNOE-0007sv-Rv; Fri, 07 Dec 2018 21:10:28 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8ADFD15AB;
 Fri,  7 Dec 2018 13:10:15 -0800 (PST)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 152E83F614;
 Fri,  7 Dec 2018 13:10:06 -0800 (PST)
Subject: Re: [PATCH v3 1/9] mm: Introduce new vm_insert_range API
To: Souptick Joarder <jrdr.linux@gmail.com>,
 Matthew Wilcox <willy@infradead.org>
References: <20181206183945.GA20932@jordon-HP-15-Notebook-PC>
 <53bbc095-c9f5-5d6a-6e50-6e060d17eb68@arm.com>
 <20181207171116.GA29923@bombadil.infradead.org>
 <CAFqt6zYCWOK-uS85GqCzcgT=+YKn1nBrRPq+M9y6eJjmXEKH+g@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <67495f8f-2092-e42d-321e-5216c346513f@arm.com>
Date: Fri, 7 Dec 2018 21:10:00 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <CAFqt6zYCWOK-uS85GqCzcgT=+YKn1nBrRPq+M9y6eJjmXEKH+g@mail.gmail.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_131026_910463_C76A40E2 
X-CRM114-Status: GOOD (  18.16  )
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
Cc: Michal Hocko <mhocko@suse.com>, Heiko Stuebner <heiko@sntech.de>,
 Peter Zijlstra <peterz@infradead.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
 linux1394-devel@lists.sourceforge.net,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, oleksandr_andrushchenko@epam.com,
 joro@8bytes.org, Russell King - ARM Linux <linux@armlinux.org.uk>,
 iommu@lists.linux-foundation.org, airlied@linux.ie,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 treding@nvidia.com, linux-media@vger.kernel.org,
 Kees Cook <keescook@chromium.org>, pawel@osciak.com,
 Rik van Riel <riel@surriel.com>, rppt@linux.vnet.ibm.com,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, mchehab@kernel.org,
 iamjoonsoo.kim@lge.com, vbabka@suse.cz, Juergen Gross <jgross@suse.com>,
 hjc@rock-chips.com, xen-devel@lists.xen.org,
 Kyungmin Park <kyungmin.park@samsung.com>, stefanr@s5r6.in-berlin.de,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2018-12-07 7:28 pm, Souptick Joarder wrote:
> On Fri, Dec 7, 2018 at 10:41 PM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Fri, Dec 07, 2018 at 03:34:56PM +0000, Robin Murphy wrote:
>>>> +int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
>>>> +                   struct page **pages, unsigned long page_count)
>>>> +{
>>>> +   unsigned long uaddr = addr;
>>>> +   int ret = 0, i;
>>>
>>> Some of the sites being replaced were effectively ensuring that vma and
>>> pages were mutually compatible as an initial condition - would it be worth
>>> adding something here for robustness, e.g.:
>>>
>>> +     if (page_count != vma_pages(vma))
>>> +             return -ENXIO;
>>
>> I think we want to allow this to be used to populate part of a VMA.
>> So perhaps:
>>
>>          if (page_count > vma_pages(vma))
>>                  return -ENXIO;
> 
> Ok, This can be added.
> 
> I think Patch [2/9] is the only leftover place where this
> check could be removed.

Right, 9/9 could also have relied on my stricter check here, but since 
it's really testing whether it actually managed to allocate vma_pages() 
worth of pages earlier, Matthew's more lenient version won't help for 
that one. (Why privcmd_buf_mmap() doesn't clean up and return an error 
as soon as that allocation loop fails, without taking the mutex under 
which it still does a bunch more pointless work to only undo it again, 
is a mind-boggling mystery, but that's not our problem here...)

Robin.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
