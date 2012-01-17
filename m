From: mina86@mina86.com (Michal Nazarewicz)
Date: Tue, 17 Jan 2012 23:19:28 +0100
Subject: [Linaro-mm-sig] [PATCH 04/11] mm: page_alloc: introduce
 alloc_contig_range()
In-Reply-To: <CA+K6fF6A1kPUW-2Mw5+W_QaTuLfU0_m0aMYRLOg98mFKwZOhtQ@mail.gmail.com>
References: <1325162352-24709-1-git-send-email-m.szyprowski@samsung.com>
 <1325162352-24709-5-git-send-email-m.szyprowski@samsung.com>
 <CA+K6fF6A1kPUW-2Mw5+W_QaTuLfU0_m0aMYRLOg98mFKwZOhtQ@mail.gmail.com>
Message-ID: <op.v781mqwl3l0zgt@mpn-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jan 2012 22:54:28 +0100, sandeep patil <psandeep.s@gmail.com> wrote:

> Marek,
>
> I am running a CMA test where I keep allocating from a CMA region as long
> as the allocation fails due to lack of space.
>
> However, I am seeing failures much before I expect them to happen.
> When the allocation fails, I see a warning coming from __alloc_contig_range(),
> because test_pages_isolated() returned "true".

Yeah, we are wondering ourselves about that.  Could you try cherry-picking
commit ad10eb079c97e27b4d27bc755c605226ce1625de (update migrate type on pcp
when isolating) from git://github.com/mina86/linux-2.6.git?  It probably won't
apply cleanly but resolving the conflicts should not be hard (alternatively
you can try branch cma from the same repo but it is a work in progress at the
moment).

> I tried to find out why this happened and added in a debug print inside
> __test_page_isolated_in_pageblock(). Here's the resulting log ..

[...]

> From the log it looks like the warning showed up because page->private
> is set to MIGRATE_CMA instead of MIGRATE_ISOLATED.

My understanding of that situation is that the page is on pcp list in which
cases it's page_private is not updated.  Draining and the first patch in
the series (and also the commit I've pointed to above) are designed to fix
that but I'm unsure why they don't work all the time.

> I've also had a test case where it failed because (page_count() != 0)



> Have you or anyone else seen this during the CMA testing?
>
> Also, could this be because we are finding a page within (start, end)
> that actually belongs to a higher order Buddy block ?

Higher order free buddy blocks are skipped in the ?if (PageBuddy(page))?
path of __test_page_isolated_in_pageblock().  Then again, now that I think
of it, something fishy may be happening on the edges.  Moving the check
outside of __alloc_contig_migrate_range() after outer_start is calculated
in alloc_contig_range() could help.  I'll take a look at it.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
