From: mina86@mina86.com (Michal Nazarewicz)
Date: Sun, 05 Feb 2012 15:33:08 +0100
Subject: [PATCH 12/15] drivers: add Contiguous Memory Allocator
In-Reply-To: <CAJd=RBBPOwftZJUfe3xc6y24=T8un5hPk0wEOT_5v6WMCbDSag@mail.gmail.com>
References: <1328271538-14502-1-git-send-email-m.szyprowski@samsung.com>
 <1328271538-14502-13-git-send-email-m.szyprowski@samsung.com>
 <CAJd=RBBPOwftZJUfe3xc6y24=T8un5hPk0wEOT_5v6WMCbDSag@mail.gmail.com>
Message-ID: <op.v87mpive3l0zgt@mpn-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 05 Feb 2012 05:25:40 +0100, Hillf Danton <dhillf@gmail.com> wrote:
> Without boot mem reservation, what is the successful rate of CMA to
> serve requests of 1MiB, 2MiB, 4MiB and 8MiB chunks?

CMA will work as long as you manage to get some pageblocks marked as
MIGRATE_CMA and move all non-movable pages away.  You might try and get it
done after system has booted but we have not tried nor tested it.
Reservation at boot time lets us make sure that the portion of memory we
are grabbing has no unmovable pages.

You might still and use alloc_contig_pages() on its own (even without
MIGRATE_CMA) but that would require additional code which would look for
a region of memory that could be used (ie. that does not have unmovable
pages in it).  That in fact was what Kamezawa's code was doing.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
