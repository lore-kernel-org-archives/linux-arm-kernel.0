From: mina86@mina86.com (Michal Nazarewicz)
Date: Wed, 18 Jan 2012 02:44:57 +0100
Subject: [Linaro-mm-sig] [PATCH 04/11] mm: page_alloc: introduce
 alloc_contig_range()
In-Reply-To: <CA+K6fF64hjVBjx6NPspQSud2hkJQWzeXkceLAChPrO-k7eCF+g@mail.gmail.com>
References: <1325162352-24709-1-git-send-email-m.szyprowski@samsung.com>
 <1325162352-24709-5-git-send-email-m.szyprowski@samsung.com>
 <CA+K6fF6A1kPUW-2Mw5+W_QaTuLfU0_m0aMYRLOg98mFKwZOhtQ@mail.gmail.com>
 <op.v781mqwl3l0zgt@mpn-glaptop>
 <CA+K6fF64hjVBjx6NPspQSud2hkJQWzeXkceLAChPrO-k7eCF+g@mail.gmail.com>
Message-ID: <op.v79a47ve3l0zgt@mpn-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> My understanding of that situation is that the page is on pcp list in which
>> cases it's page_private is not updated.  Draining and the first patch in
>> the series (and also the commit I've pointed to above) are designed to fix
>> that but I'm unsure why they don't work all the time.

On Wed, 18 Jan 2012 01:46:37 +0100, sandeep patil <psandeep.s@gmail.com> wrote:
> Will verify this if the page is found on the pcp list as well .

I was wondering in general if ?!PageBuddy(page) && !page_count(page)? means
page is on PCP.  From what I've seen in page_isolate.c it seems to be the case.

>>> I've also had a test case where it failed because (page_count() != 0)

> With this, when it failed the page_count() returned a value of 2.  I am not
> sure why, but I will try and see If I can reproduce this.

If I'm not mistaken, page_count() != 0 means the page is allocated.  I can see
the following scenarios which can lead to page being allocated in when
test_pages_isolated() is called:

1. The page failed to migrate.  In this case however, the code would abort earlier.

2. The page was migrated but then allocated.  This is not possible since
    migrated pages are freed which puts the page on MIGRATE_ISOLATE freelist which
    guarantees that the page will not be migrated.

3. The page was removed from PCP list but with migratetype == MIGRATE_CMA.  This
    is something the first patch in the series as well as the commit I've mentioned tries
    to address so hopefully it won't be an issue any more.

4. The page was allocated from PCP list.  This may happen because draining of PCP
    list happens after IRQs are enabled in set_migratetype_isolate().  I don't have
    a solution for that just yet.  One is to alter update_pcp_isolate_block() to
    remove page from the PCP list.  I haven't looked at specifics of how to implement
    this just yet.

>> Moving the check outside of __alloc_contig_migrate_range() after outer_start
>> is calculated in alloc_contig_range() could help.
>
> I was going to suggest that, moving the check until after outer_start
> is calculated will definitely help IMO. I am sure I've seen a case where
>
>   page_count(page) = page->private = 0 and PageBuddy(page) was false.

Yep, I've pushed new content to my branch (git://github.com/mina86/linux-2.6.git cma)
and will try to get Marek to test it some time soon (I'm currently swamped with
non-Linux related work myself).

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
