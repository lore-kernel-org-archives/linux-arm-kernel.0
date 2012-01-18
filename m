From: psandeep.s@gmail.com (sandeep patil)
Date: Tue, 17 Jan 2012 16:46:37 -0800
Subject: [Linaro-mm-sig] [PATCH 04/11] mm: page_alloc: introduce
 alloc_contig_range()
In-Reply-To: <op.v781mqwl3l0zgt@mpn-glaptop>
References: <1325162352-24709-1-git-send-email-m.szyprowski@samsung.com>
 <1325162352-24709-5-git-send-email-m.szyprowski@samsung.com>
 <CA+K6fF6A1kPUW-2Mw5+W_QaTuLfU0_m0aMYRLOg98mFKwZOhtQ@mail.gmail.com>
 <op.v781mqwl3l0zgt@mpn-glaptop>
Message-ID: <CA+K6fF64hjVBjx6NPspQSud2hkJQWzeXkceLAChPrO-k7eCF+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Yeah, we are wondering ourselves about that. ?Could you try cherry-picking
> commit ad10eb079c97e27b4d27bc755c605226ce1625de (update migrate type on pcp
> when isolating) from git://github.com/mina86/linux-2.6.git? ?It probably
> won't
> apply cleanly but resolving the conflicts should not be hard (alternatively
> you can try branch cma from the same repo but it is a work in progress at
> the
> moment).
>

I'll try this patch and report back ,,


>> is set to MIGRATE_CMA instead of MIGRATE_ISOLATED.
>
>
> My understanding of that situation is that the page is on pcp list in which
> cases it's page_private is not updated. ?Draining and the first patch in
> the series (and also the commit I've pointed to above) are designed to fix
> that but I'm unsure why they don't work all the time.
>
>

Will verify this if the page is found on the pcp list as well .

>> I've also had a test case where it failed because (page_count() != 0)

With this, when it failed the page_count()
returned a value of 2. I am not sure why, but I will try and see If I can
reproduce this.

>
>
>> Have you or anyone else seen this during the CMA testing?
>>
>> Also, could this be because we are finding a page within (start, end)
>> that actually belongs to a higher order Buddy block ?
>
>
> Higher order free buddy blocks are skipped in the ?if (PageBuddy(page))?
> path of __test_page_isolated_in_pageblock(). ?Then again, now that I think
> of it, something fishy may be happening on the edges. ?Moving the check
> outside of __alloc_contig_migrate_range() after outer_start is calculated
> in alloc_contig_range() could help. ?I'll take a look at it.

I was going to suggest that, moving the check until after outer_start
is calculated
will definitely help IMO. I am sure I've seen a case where

  page_count(page) = page->private = 0 and PageBuddy(page) was false.

I will try and reproduce this as well.

Thanks,
Sandeep
