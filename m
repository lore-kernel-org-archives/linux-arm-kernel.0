From: mina86@mina86.com (Michal Nazarewicz)
Date: Thu, 27 Oct 2011 11:10:42 +0200
Subject: [PATCH 4/9] mm: MIGRATE_CMA migration type added
In-Reply-To: <op.v3ve8vbl3l0zgt@mpn-glaptop>
References: <1317909290-29832-1-git-send-email-m.szyprowski@samsung.com>
	<1317909290-29832-5-git-send-email-m.szyprowski@samsung.com>
	<20111018130826.GD6660@csn.ul.ie> <op.v3ve8vbl3l0zgt@mpn-glaptop>
Message-ID: <op.v3z6f4173l0zgt@mpn-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Tue, 18 Oct 2011 06:08:26 -0700, Mel Gorman <mel@csn.ul.ie> wrote:
>> This does mean that MIGRATE_CMA also does not have a per-cpu list.
>> I don't know if that matters to you but all allocations using
>> MIGRATE_CMA will take the zone lock.

On Mon, 24 Oct 2011 21:32:45 +0200, Michal Nazarewicz <mina86@mina86.com> wrote:
> This is sort of an artefact of my misunderstanding of pcp lists in the
> past.  I'll have to re-evaluate the decision not to include CMA on pcp
> list.

Actually sorry.  My comment above is somehow invalid.

The CMA does not need to be on pcp list because CMA pages are never allocated
via standard kmalloc() and friends.  Because of the fallbacks in rmqueue_bulk()
the CMA pages end up being added to a pcp list of the MOVABLE type and so when
kmallec() allocates an MOVABLE page it can end up grabbing a CMA page.

So it's quite OK that CMA does not have its own pcp list as the list would
not be used anyway.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
